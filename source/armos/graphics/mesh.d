module armos.graphics.mesh;
import armos.types;
import armos.math;
import armos.graphics;

/++
    ポリゴンで構成された形状を表すclassです．
+/
class Mesh {
    public{
        alias int IndexType;

        bool isVertsChanged   = false;
        bool isFaceDirty      = false;
        bool isIndicesChanged = false;

        Vector4f[]    vertices;
        Vector3f[]    normals;
        Vector3f[]    tangents;
        Vector4f[]    texCoords0;
        Vector4f[]    texCoords1;
        alias texCoords0         texCoords; 
        armos.types.FloatColor[] colors;
        IndexType[]              indices;

        /// テクスチャ座標の数を表します．
        size_t numTexCoords()const{
            return texCoords.length;
        }

        /// 頂点座標の数を表します．
        size_t numVertices()const{
            return vertices.length;
        }

        /// 法線ベクトルの数を表します．
        size_t numNormals()const{
            return normals.length;
        }

        /// 頂点インデックスの数を表します．
        size_t numIndices()const{
            return indices.length;
        }

        /// meshの描画モードを返します．
        PrimitiveMode primitiveMode()const{
            return primitiveMode_;
        }

        /// meshの描画モードを指定します．
        void primitiveMode(in PrimitiveMode mode){
            primitiveMode_ = mode;
        }

        /++
            テクスチャ座標を追加します．
        +/
        void addTexCoord(in Vector2f vec){
            addTexCoord(vec[0], vec[1]);
        }

        /++
            テクスチャ座標を追加します．
        +/
        void addTexCoord(in float u, in float v){
            texCoords ~= Vector4f(u, v, 0f, 1f);
        }

        /++
            頂点座標を追加します．
        +/
        void addVertex(in Vector3f vec){
            vertices ~= Vector4f(vec[0], vec[1], vec[2], 1);
            isVertsChanged = true;
            isFaceDirty = true;
        };
        unittest{
            auto mesh = new Mesh;
            mesh.addVertex(Vector3f(0, 1, 2));
            mesh.addVertex(Vector3f(3, 4, 5));
            mesh.addVertex(Vector3f(6, 7, 8));
            assert(mesh.vertices[1][1] == 4.0);
            assert(mesh.isFaceDirty);
            assert(mesh.isVertsChanged);
        }

        /++
            頂点座標を追加します．
        +/
        void addVertex(in float x, in float y, in float z){
            addVertex(Vector3f(x, y, z));
        }

        /++
            法線ベクトルを追加します．
        +/
        void addNormal(in Vector3f vec){
            normals ~= vec;
        }

        /++
            法線ベクトルを追加します．
        +/
        void addNormal(in float x, in float y, in float z){
            addNormal(Vector3f(x, y, z));
        }

        /++
            頂点インデックスを追加します．
        +/
        void addIndex(in IndexType index){
            indices ~= index;
            isIndicesChanged = true;
            isFaceDirty = true;
        };
        unittest{
            auto mesh = new Mesh;
            mesh.addIndex(1);
            mesh.addIndex(2);
            mesh.addIndex(3);
            assert(mesh.indices[1] == 2);
            assert(mesh.isIndicesChanged);
            assert(mesh.isFaceDirty);
        }

        /++
            meshを描画します．
            Params:
            renderMode = 面，線，点のどれを描画するか指定します．
        +/
        void draw(in PolyRenderMode renderMode){
            currentRenderer.draw(this, renderMode, false, false, false);
        };

        /++
            meshをワイヤフレームで描画します．
        +/
        void drawWireFrame(){
            draw(PolyRenderMode.WireFrame);
        };

        /++
            meshの頂点を点で描画します．
        +/
        void drawVertices(){
            draw(PolyRenderMode.Points);
        };

        /++
            meshの面を塗りつぶして描画します．
        +/
        void drawFill(){
            draw(PolyRenderMode.Fill);
        };
    }//public

    private{
        PrimitiveMode primitiveMode_ = PrimitiveMode.Triangles;
    }//private
}//class Mesh
