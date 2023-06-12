Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4AE72D418
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 00:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238598AbjFLWFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 18:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238594AbjFLWFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 18:05:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB1910CC;
        Mon, 12 Jun 2023 15:05:42 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CM04GX024046;
        Mon, 12 Jun 2023 22:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=azN8Lkw63ogXwhly46gTYcFAoMgGzgpwlR+0Gf7RzZg=;
 b=mRR9uaz9+lMbcvWtKVU2zhauD0Q4IUwaY7fFSVeJ1RQ106mYZK4V2kSKxJ+PgYWMYxw8
 L9Vg3dxD89hxg7iOxgBrapyMi/jDObnPmwIY4NTroiBz6jlHTWN2Pd17NVA56fV6n66a
 WVNSqJyFVX2baGFrcgBaTTFRiuzdbj1GV9w+/dK3sosQGX3WXD4PIFVzLd2WfgCsbNl7
 3Z6IaZw3nd15PoGmajyEg/BVyufJ/Jr9d7c1jlRaoe9kYdN6xrIyOemTCPrV9eF5Mg5u
 aNAhFNLcLlvUvhGqT6fRQerx4lvI85UnKGf9AZ+0RauhuyJSw36Uu5Vba3zF0rxCNR4S VQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r6a8yr4x3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 22:05:39 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35CM5cgw011782
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 22:05:38 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 12 Jun 2023 15:05:38 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: qcom: sc8180x: Fix adreno smmu compatible
Date:   Mon, 12 Jun 2023 15:05:32 -0700
Message-ID: <20230612220532.1884860-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: djudHNlTX0vQYnvUxUhpUn_nNRmQU5kI
X-Proofpoint-ORIG-GUID: djudHNlTX0vQYnvUxUhpUn_nNRmQU5kI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 malwarescore=0 impostorscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1011
 mlxlogscore=722 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120189
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The adreno smmu should be compatible with qcom,adreno-smmu as well for
per-process page tables to work.

Fixes: 8575f197b077 ("arm64: dts: qcom: Introduce the SC8180x platform")
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index e8613a00fcab..88015742315b 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -2310,7 +2310,8 @@ gpucc: clock-controller@2c90000 {
 		};
 
 		adreno_smmu: iommu@2ca0000 {
-			compatible = "qcom,sc8180x-smmu-500", "arm,mmu-500";
+			compatible = "qcom,sc8180x-smmu-500", "qcom,adreno-smmu",
+				     "qcom,smmu-500", "arm,mmu-500";
 			reg = <0 0x02ca0000 0 0x10000>;
 			#iommu-cells = <2>;
 			#global-interrupts = <1>;
-- 
2.25.1

