Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1B773103A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244672AbjFOHKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244639AbjFOHJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:09:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7D32736;
        Thu, 15 Jun 2023 00:08:24 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F5Or3K008747;
        Thu, 15 Jun 2023 07:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=iA+g0Exh95uR6rgyJEEppHxewQydtb728NCDTYCmTFQ=;
 b=UjLoHPtxWAmWywT/UzaybX7s3sVQNDQ+RI4BdqAXpO+7ESAMijvNc+aRpqcabZSqh45+
 9PuZAhuon+7FYutyz7LhMB+YFZjwy5PGqPek6PcJQbDq8yL+N8sXedt8okf7/8gdZPyr
 VVjNgplOOIHmF+8iqhgUJirUHx77E+dfnQXfo+/JoVfJxzlef5CoNXmdjeoEwWPaq3z+
 VFMVXKYQTDmhi3Mdo9pQLmPsSznzoubu7a6O1XjEJFdUQJxmNLPqBeHEHYI+HH5Fc1f1
 WtX3kX1AuBTWEmcAxb9IupIjtsKdUXGXVtQ9BAUK0cZK7s1yTx3sOkz2hgq8FG5KbSyU +w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r7ebt9ud5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 07:08:21 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35F78Ke9027827
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 07:08:20 GMT
Received: from hu-ptalari-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 15 Jun 2023 00:08:13 -0700
From:   Praveen Talari <quic_ptalari@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>,
        <quic_vnivarth@quicinc.com>, <quic_arandive@quicinc.com>,
        Praveen Talari <quic_ptalari@quicinc.com>
Subject: [PATCH v2 2/3] spi: dt-bindings: qcom,spi-geni-qcom: Add SPI SLAVE mode support for GENI based QuPv3
Date:   Thu, 15 Jun 2023 12:37:05 +0530
Message-ID: <20230615070706.18322-3-quic_ptalari@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230615070706.18322-1-quic_ptalari@quicinc.com>
References: <20230615070706.18322-1-quic_ptalari@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5CExKcrIZJrZ0vbJC2bQo4Cqe5nVby8H
X-Proofpoint-ORIG-GUID: 5CExKcrIZJrZ0vbJC2bQo4Cqe5nVby8H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_03,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=931 impostorscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306150058
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set this property to configure QUPV3 as SPI slave controller.

Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
---
 Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
index 2e20ca313ec1..cdd6d19876d3 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
@@ -66,6 +66,8 @@ properties:
   reg:
     maxItems: 1
 
+  qcom,slv-ctrl:
+
 required:
   - compatible
   - clocks
-- 
2.17.1

