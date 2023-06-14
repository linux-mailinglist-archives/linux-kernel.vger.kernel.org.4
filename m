Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D64D7301D1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245589AbjFNO0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236151AbjFNOYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:24:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3099E2100;
        Wed, 14 Jun 2023 07:24:36 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EDZini029291;
        Wed, 14 Jun 2023 14:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=l+DmECPvam7jTA1uK1KbKH+WUJhOhCB0OK3Dr8/pCnI=;
 b=OMeLqLNB7ip1lLii0VHgTvmPYVsCwghSxpW0bCY5y7FsOHU+qmWYP+Cq7lxcHGKeDToX
 9paaHLJulz9JVxNA22GQzVHTCNhbiilzcL7fOD1ZXFMlKPArOwRO3Q9anx55JjnXapuW
 +nfFYZr+DRvfocSEliULfj5AYrkwmineuwubrAkQH7atcXImqYjyrUliH/FJgWjz85o3
 1l9xflD4rAsaJTLhcBZnuQ3bEOc6cEe+mOsHHSgJIcOe5ozVLQ62/c3Yp0BoVzdF4lnM
 AYZyieBNTQctMw+VwJhBZ4Oj0X71uWr+3aath/BBRQ6dOP36ll4Te/AYZmkKL0qbzlvc ww== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r7b818mrx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 14:24:33 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 35EEOS6H027280;
        Wed, 14 Jun 2023 14:24:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3r4j8m2a8u-1;
        Wed, 14 Jun 2023 14:24:29 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35EEOTDk027286;
        Wed, 14 Jun 2023 14:24:29 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 35EEOSe3027276;
        Wed, 14 Jun 2023 14:24:29 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 3FEC54A09; Wed, 14 Jun 2023 19:54:28 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 2/3] arm: dts: qcom: sdx55: Add interconnect path
Date:   Wed, 14 Jun 2023 19:54:25 +0530
Message-Id: <1686752666-13426-3-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1686752666-13426-1-git-send-email-quic_krichai@quicinc.com>
References: <1686752666-13426-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NmHYQB7VlpzEHa-3EV2xg9VxV-mQK_KO
X-Proofpoint-GUID: NmHYQB7VlpzEHa-3EV2xg9VxV-mQK_KO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_10,2023-06-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 mlxlogscore=835 mlxscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140125
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 342c3d1..acc79eb 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -421,6 +421,10 @@
 				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "global",
 					  "doorbell";
+
+			interconnects = <&system_noc MASTER_PCIE &mc_virt SLAVE_EBI_CH0>;
+			interconnect-names = "pcie-mem";
+
 			resets = <&gcc GCC_PCIE_BCR>;
 			reset-names = "core";
 			power-domains = <&gcc PCIE_GDSC>;
-- 
2.7.4

