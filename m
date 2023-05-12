Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF357007AE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240936AbjELMWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240916AbjELMWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:22:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4C812E93;
        Fri, 12 May 2023 05:22:06 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CBCH8Y032122;
        Fri, 12 May 2023 12:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=Xdu1Nrl/DwnYQMx6pWiwGivntSC3e8l4SpNSipETt0E=;
 b=khZBMSMZXicaub3V9s1cQVVqxTlJLk3b2nANsD+AuMRQoiktR/wxSs61GHqN5ZXLWUCa
 9LTvQMphwC49QH7KZSL25ApnD7orKR0s2ul9KG/EpE61I+Gddmv+ydHHRkLLNLt3t2i4
 v+nmGjt5+u8kxsT5mIyyNrRFYPQ9nkhR3zbxUQfdbU1d04fSTR30L8xBurUpurXEw5Uj
 aPnKAhhVMWcCk9iULsTVCjNcoYJ5yUkppm06EVsnA+V4ZYo/nPp8la//QBQ5w+2llRfd
 Tr9xBFKSV5uCOUofaEOCj9MQtb+Q6eVunVZAOJFGblJJ4tHbDftJ2xSAWuoClprdkRbl BA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qh24h2fuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 12:22:02 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34CCLhu4028973;
        Fri, 12 May 2023 12:21:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3qdy59u1uu-1;
        Fri, 12 May 2023 12:21:46 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34CCLi9a028984;
        Fri, 12 May 2023 12:21:46 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-kbajaj-hyd.qualcomm.com [10.147.247.189])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 34CCLj0n029012;
        Fri, 12 May 2023 12:21:46 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2340697)
        id 4A5F652974D; Fri, 12 May 2023 17:51:45 +0530 (+0530)
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 02/10] dt-bindings: nvmem: qfprom: Add compatible for QDU1000/QRU1000
Date:   Fri, 12 May 2023 17:51:26 +0530
Message-Id: <20230512122134.24339-3-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230512122134.24339-1-quic_kbajaj@quicinc.com>
References: <20230512122134.24339-1-quic_kbajaj@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2H2ZZ47ebpnFrQWaEw2Etjh7uGV8oAUu
X-Proofpoint-ORIG-GUID: 2H2ZZ47ebpnFrQWaEw2Etjh7uGV8oAUu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=742 adultscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120103
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the QFPROM on QDU1000/QRU1000 SOCs.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 8d8503dd934b..59082f6e8c9f 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -26,6 +26,7 @@ properties:
           - qcom,msm8996-qfprom
           - qcom,msm8998-qfprom
           - qcom,qcs404-qfprom
+          - qcom,qdu1000-qfprom
           - qcom,sc7180-qfprom
           - qcom,sc7280-qfprom
           - qcom,sdm630-qfprom
--
2.17.1

