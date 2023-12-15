<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>     
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>상품 판매글 수정</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
  </head>
  <body>
    <div id="sale-wrap">
      <h2 style="text-align: center; padding: 10px 0">상품 판매글 수정</h2>
      <form action="/item/write/${sale.id}" method="post" id="ajaxForm" enctype="multipart/form-data" autocomplete="off">
        <table>
          <tr>
            <th>판매글 제목</th>
            <td>
              <input type="text" name="saleDTO.title" value="${sale.title}" id="" />
            </td>
          </tr>
          <tr>
            <th>판매글 상세 설명</th>
            <td>
              <textarea rows="5" cols="30" name="saleDTO.content" placeholder="상품설명을 작성해주세요.">${sale.content}</textarea>
            </td>
          </tr>
          <tr>
            <th>카테고리 코드 유형</th>
            <td>
              <select name="saleDTO.category_code">
                <option>선택</option>
			    <option value="10000" ${sale.category_code == 10000 ? 'selected' : ''}>과일/견과</option>
			    <option value="20000" ${sale.category_code == 20000 ? 'selected' : ''}>채소</option>
			    <option value="30000" ${sale.category_code == 30000 ? 'selected' : ''}>쌀/잡곡</option>
			    <option value="40000" ${sale.category_code == 40000 ? 'selected' : ''}>축산물</option>
			    <option value="50000" ${sale.category_code == 50000 ? 'selected' : ''}>수산물</option>
			    <option value="60000" ${sale.category_code == 60000 ? 'selected' : ''}>가공식품</option>
              </select>
            </td>
          </tr>
          <tr>
            <th>지역 코드 유형</th>
            <td>
              <select name="saleDTO.region_code">
                <option selected="selected">선택</option>
                <option value="1000" ${sale.region_code == 1000 ? 'selected' : ''}>수도권</option>
			    <option value="2000" ${sale.region_code == 2000 ? 'selected' : ''}>강원도</option>
			    <option value="3000" ${sale.region_code == 3000 ? 'selected' : ''}>충청도</option>
			    <option value="4000" ${sale.region_code == 4000 ? 'selected' : ''}>경상도</option>
			    <option value="5000" ${sale.region_code == 5000 ? 'selected' : ''}>전라도</option>
			    <option value="6000" ${sale.region_code == 6000 ? 'selected' : ''}>제주도</option>
              </select>
            </td>
          </tr>
          <tr>
            <th>판매글에 상품 추가</th>
            <td class="product">
                <c:choose>
                  <c:when test="${fn:length(productList)>0}">
                    <div id="product_container" class="w-100">
                      <c:forEach var="saleProduct" items="${saleProductList}" varStatus="m">
                      <div class="saleProductDTO d-flex flex-row" id="">
                        <select name="saleProductDTOList[${m.index}].product_id" id="product_id">
                          <c:forEach var="product" items="${productList}" varStatus="i">
                            <option value="${product.id}" ${saleProduct.product_id == product.id ? 'selected' : ''}>${product.name}</option>
                          </c:forEach>
                        </select>
                        <input type="text" name="saleProductDTOList[${m.index}].name" value="${saleProduct.name}" placeholder="설정하실 상품명">
                        <!-- <input type="text" name="saleProductDTOList[0].sale_option" placeholder="상품을 묶을 대제목, ex) 색상,사이즈,무게"> -->
                        <select name="saleProductDTOList[${m.index}].sale_type" value="${saleProduct.sale_type}" id="sale_type">
                          <option value="MAIN">메인상품</option>
                          <option value="SUB">추가상품</option>
                        </select>
                      </div>
                      </c:forEach>
                    </div>
                    
                  </c:when>
                  <c:when test="${fn:length(productList) == 0}">
                    <p>등록 하신 상품이 없습니다. 상품 등록 후에 판매글을 작성해주세요.</p>
                  </c:when>
                </c:choose>
                <button type="button" id="add_product">상품 추가</button>
                <button type="button" id="remove_product">상품 삭제</button>
            </td>
           
          </tr>
          <tr>
            <th>상태</th>
            <td class="sale_flex">
			    <label class="sale-type-label">
			        <input type="radio" id="status_PREPARED" name="saleDTO.status" value="PREPARE" ${sale.status eq 'PREPARE' ? 'checked' : '' } />
			        <span>판매 대기</span>
			    </label>
			    <label class="sale-type-label">
			        <input type="radio" id="status_SALE" name="saleDTO.status" value="READY" ${sale.status eq 'READY' ? 'checked' : '' }/>
			        <span>판매중</span>
			    </label>
			    <label class="sale-type-label">
			        <input type="radio" id="status_SOLD_OUT" name="saleDTO.status" value="CLOSE" ${sale.status eq 'CLOSE' ? 'checked' : '' }/>
			        <span>판매 종료</span>
			    </label>
			</td>
          </tr>
           <tr>
            <th>배송료</th>
            <td class="sale_flex">
             <input type="number" placeholder="숫자만 입력" value="${sale.delivery_fee}" name="saleDTO.delivery_fee" class="sale-discount-text" />&nbsp;원
            </td>
          </tr>
          <tr>
            <th>할인</th>
            <td>
              <div class="sale_flex">
                <input type="radio" id="sale-discount-yes" class="discount-public" name="sale-discount" />
                <label for="sale-discount-yes" class="discount-public"><span>설정함</span></label>
                <input type="radio" id="sale-discount-none" class="discount-public" name="sale-discount" checked="checked" />
                <label for="sale-discount-none" class="discount-public"><span>설정안함</span></label>
              </div>
              <div id="sale-discount-text" style="display: none">
                <br />
                <input type="number" placeholder="숫자만 입력" value="0" name="saleDTO.discount" class="sale-discount-text" />&nbsp;%
              </div>
              <div id="sale-discount-total" style="display: none">
                <br />
                <input type="text" placeholder="총 금액" class="sale-discount-text" />&nbsp;원(총 금액)
              </div>
            </td>
          </tr>
          <tr>
            <th>판매 시작시간</th>
            <td>
              <input type="datetime-local" name="saleDTO.started_at" class="datetime" value="${sale.started_at}" />
            </td>
          </tr>
          <tr>
            <th>판매 종료시간</th>
            <td>
              <input type="datetime-local" name="saleDTO.ended_at" class="datetime" value="${sale.ended_at}"/>
            </td>
          </tr>
          <tr>
            <th>상품 설명 이미지</th>
            <td>
              <input type="file" name="fileList" multiple />
              <br />
              <small>*(여러개 선택 가능합니다.)</small>
            </td>
          </tr>
        </table>
        <div class="sale_flex" id="submit-data-div">
          <button type="reset" id="sale_reset">다시쓰기</button>
          <button class="submit-data" type="button" id="imgur_push" >상품 수정하기</button>
          <input type="hidden" name="saleDTO.merchant_id" value="${ssKey.id}" />
          <input type="hidden" name="image_group_id" value="${sale.image_group_id}">
          <input type="hidden" name="saleDTO.id" value="${sale.id}" />
          <input type="hidden" id="url" value="/imgur/update/${sale.image_group_id}" />
        </div>
      </form>
    </div>
  </body>
  

  <script>
   
</script>

</html>
