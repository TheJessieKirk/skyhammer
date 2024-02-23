

set -ex



cmake -DCMAKE_BUILD_TYPE=Release -S examples/test_all/fibonacci -B test-bld
cmake --build test-bld --config release
cmake -E env test-bld/fibonacci
exit 0
