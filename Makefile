

all: clean proto.c Proto.cpp proto.py Proto.java 

clean:
	rm proto.[ch]* proto.py Proto.java Proto.[ch]pp || true

proto.c:
	protoc --plugin=$$(which protoc-gen-nanopb) --nanopb_out=. -o mindspy.pb mindspy.proto
	mv mindspy.pb.h proto.h
	mv mindspy.pb.c proto.c
	rm mindspy.pb || true
	sed -i 's/mindspy[.]pb[.]h/proto.h/g' proto.[hc]

Proto.cpp:
	protoc --cpp_out=. mindspy.proto
	mv mindspy.pb.h Proto.hpp
	mv mindspy.pb.cc Proto.cpp
	sed -i 's/mindspy[.]pb[.]h/Proto.hpp/' Proto.[hc]pp

proto.py:
	protoc  --python_out=. mindspy.proto
	mv mindspy_pb2.py proto.py
	rm mindspy.pyc || true

Proto.java:
	protoc  --java_out=. mindspy.proto
	mv org/mindspy/protobufs/Proto.java ./
	rm org -fr

