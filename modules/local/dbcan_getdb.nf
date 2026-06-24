process DBCAN_GETDB {

    tag "DBCan v5-2_9-13-2025"

    container "${ workflow.containerEngine in ['singularity', 'apptainer'] ?
        'https://depot.galaxyproject.org/singularity/dbcan%3A5.1.2--pyhdfd78af_0' :
        'biocontainers/dbcan-5.1.2--pyhdfd78af_0' }"

    publishDir "${params.dbs}", mode: 'copy'

    output:
    tuple path("dbcan/", type: "dir"), val("v5-2_9-13-2025"), emit: dbcan_db


    script:
    """
    # Use the tool's own downloader against the pinned AWS S3 release. The previous
    # bcb.unl.edu URL is dead (302-redirects to the dbCAN homepage), and S3 only serves
    # XML listings, so wget -r cannot crawl it. run_dbcan also names the files exactly
    # as the tool expects (e.g. dbCAN-sub.hmm), so no manual renaming is needed.
    run_dbcan database \\
        --db_dir dbcan \\
        --aws_s3

    echo 'v5-2_9-13-2025' > dbcan/VERSION.txt
    """
}
