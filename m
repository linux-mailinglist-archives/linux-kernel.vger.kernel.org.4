Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7C0729868
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238906AbjFILry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjFILrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:47:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC188358B;
        Fri,  9 Jun 2023 04:47:47 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359BlfNJ014975;
        Fri, 9 Jun 2023 11:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=Y06W5WNngjeaxdoeQNezzLbdGHA3R0xfALFtsH4ppog=;
 b=dDxmedaYWe4/bYSspA9QJhAM0YjAOV/bLQ31U3zNKw1+pqi8kdSBbnUfpX7MyDCWrhoC
 2sv3Ik5UJi2V050yO+mdw65A6tGLug+lXTs/L6qdLEFWjIGZ/HQW7ygRKVHg6RFmEshH
 kXA/7Zh5Ms3Nh3LLgdWhWKnzA66SsW8t2l0yxdRD0WsIkhp/WLwYXtmYY021f8yMMQUr
 KqKe3V9/O42Di095VOh3mMSPIY49KJb7NB+9pjSZUXd7zwS5BZE/w6VhA/Ipdkb0i/C7
 W9nH2YMqJCNhn9NK+N96gO7uEyCkRET2Wnal4nyzg/o19XWRG3f6Ee6ZYoroT+eYNcMp Lw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r3yfngf71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 11:47:41 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 359Blctm004158;
        Fri, 9 Jun 2023 11:47:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3qyxkmeq38-1;
        Fri, 09 Jun 2023 11:47:38 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 359BlZ9X004097;
        Fri, 9 Jun 2023 11:47:38 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 359Blb4b004113;
        Fri, 09 Jun 2023 11:47:38 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 3427C3395; Fri,  9 Jun 2023 17:17:37 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        linux-arm-msm@vger.kernel.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/3] arm: dts: qcom: sdx55: Add interconnect path
Date:   Fri,  9 Jun 2023 17:17:27 +0530
Message-Id: <1686311249-6857-3-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1686311249-6857-1-git-send-email-quic_krichai@quicinc.com>
References: <1686311249-6857-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: liZtX-UV09yn0QKmqduuVmu9buD1YR9d
X-Proofpoint-GUID: liZtX-UV09yn0QKmqduuVmu9buD1YR9d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_08,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=833 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306090099
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pcie-mem interconnect path to sdx55 target.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 342c3d1..38943d4 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -421,6 +421,10 @@
 				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "global",
 					  "doorbell";
+
+			interconnects = <&system_noc MASTER_PCIE_0 &mc_virt SLAVE_EBI1>;
+			interconnect-names = "pci-mem";
+
 			resets = <&gcc GCC_PCIE_BCR>;
 			reset-names = "core";
 			power-domains = <&gcc PCIE_GDSC>;
-- 
2.7.4

