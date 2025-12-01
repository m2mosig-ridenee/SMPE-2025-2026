
OUTPUT_DIRECTORY=data/`hostname`_`date +%F`
mkdir -p $OUTPUT_DIRECTORY
OUTPUT_FILE=$OUTPUT_DIRECTORY/measurements_`date +%R`.txt

touch $OUTPUT_FILE
# Add more array sizes
sizes="100 500 1000 5000 10000 50000 100000 200000 500000 1000000 2000000 5000000"
# Randomize the order of the runs
shuf_sizes=$(echo $sizes | tr ' ' '\n' | shuf)
for i in $shuf_sizes; do
# Increase the number of repetitions
    for rep in `seq 1 30`; do
        echo "Size: $i" >> $OUTPUT_FILE;
        ./src/parallelQuicksort $i >> $OUTPUT_FILE;
    done ;
done
