Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FC4689FEA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbjBCRFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbjBCRF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:05:28 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEB9A9D61;
        Fri,  3 Feb 2023 09:05:20 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 313FlcUa025752;
        Fri, 3 Feb 2023 17:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=r2i2OCiO4MFIdD7cN0ixy2GNVRxJWKfCGhBkmngxhTo=;
 b=nJNheWXjnxiSB/b9wjexTs6tTEn0ldgWu6HZt1sNYEtAwlM/qpICLezzDyuXRDS10L59
 q58OyvK3nOVwmSJnBTct77a3fE+UYMa5vLV4UIytdgGINjdrOgh/hS/MeMFwk+fPZyu/
 LV5MV2oirjkUCoOwnRDpaBgQFXT/MfsclhdGTZmVTtnGe6n5Z/smc6mg+gWqPzGGoSo7
 cw2Ret5jXAvYBhBlm96MBJF9yX4G4pt2pSmRukeBM/JgRqay6M/oMU5fEQGWVGaY02ez
 yG7MskF/TxmypIoD8j8dBMBknQeoFzgPttr6eTdqunBihUYaNb3nwcIhgIEQ7VPmnCJC tQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ngns4j3e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 17:05:17 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 313H5GMA011929
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Feb 2023 17:05:16 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 3 Feb 2023 09:05:13 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH 2/2] arm64: dts: qcom: sm8450: Add IMEM and PIL info region
Date:   Fri, 3 Feb 2023 22:34:51 +0530
Message-ID: <1675443891-31709-2-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1675443891-31709-1-git-send-email-quic_mojha@quicinc.com>
References: <1675443891-31709-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9YWmJjhztRu76f9ClKfcESc0UVUOAvwt
X-Proofpoint-ORIG-GUID: 9YWmJjhztRu76f9ClKfcESc0UVUOAvwt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_15,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=648 impostorscore=0 malwarescore=0
 adultscore=0 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030157
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple-mfd representing IMEM on SM8450 and define the PIL
relocation info region, so that post mortem tools will be able
to locate the loaded remoteprocs.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 5704750..474ea1b 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -3536,6 +3536,21 @@
 			};
 		};
 
+		sram@146aa000 {
+			compatible = "qcom,sm8450-imem", "syscon", "simple-mfd";
+			reg = <0 0x146aa000 0 0x1000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			ranges = <0 0 0x146aa000 0x1000>;
+
+			pil-reloc@94c {
+				compatible = "qcom,pil-reloc-info";
+				reg = <0x94c 0xc8>;
+			};
+		};
+
 		apps_rsc: rsc@17a00000 {
 			label = "apps_rsc";
 			compatible = "qcom,rpmh-rsc";
-- 
2.7.4

