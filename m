Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31394691840
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 07:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjBJGEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 01:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjBJGE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 01:04:29 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B863F7432C;
        Thu,  9 Feb 2023 22:04:28 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31A5lBUF000309;
        Fri, 10 Feb 2023 06:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Z8/AxlOkjppv1TSdokIqO5jushzt4DUAvl8M0oRz24g=;
 b=WJsVp9XacImKGXUezHgtFNIuHABq2DPtMHXVeEp1iGlTZ7WgJJTKy1WMtJFM3tpNYXiK
 qwWF1B4z0Tpu0WdNaEMSqMus2Cso+w8nSOEhE/YTvGhsNozNoeRNzCOte9XGXYx9MPJb
 LFC4EahmqS1Y172McIu73b4vepaOA19Tuzf7dj4of92qGlYmbY5IodvB5Ge5SCkDIFu5
 eJ2wsY4gZPhGWi6mkXM10jNM9F0G2VrIPyigc20ZtQwbXm9Cwf6rvcObpFNEnlVqmj7L
 gHzIYRj5AyPXVJlCL2ooHRvLPDVPmAv91T4ys5voeoLiWBRYl+UIOS/KbYRvKjLdGDVb Zg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nn5ek98qg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 06:04:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31A64OZk017505
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 06:04:24 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 9 Feb 2023 22:04:20 -0800
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH V2 1/2] arm64: dts: qcom: ipq5332: enable the download mode support
Date:   Fri, 10 Feb 2023 11:34:00 +0530
Message-ID: <20230210060401.24383-2-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230210060401.24383-1-quic_kathirav@quicinc.com>
References: <20230210060401.24383-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: h4AC4g9aG6Z60jxbE544cixghnLzJAL2
X-Proofpoint-GUID: h4AC4g9aG6Z60jxbE544cixghnLzJAL2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_01,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=756 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100052
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the support for download mode to collect the RAM dumps if
system crashes, to perform the post mortem analysis.

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
Changes in V2:
	- Mapped the entire TCSR_REGS region and updated the offset in
	  qcom,dload-mode property

 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index bdf33ef30e10..ad6481dd57ba 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -70,6 +70,7 @@
 	firmware {
 		scm {
 			compatible = "qcom,scm-ipq5332", "qcom,scm";
+			qcom,dload-mode = <&tcsr 0x6100>;
 		};
 	};
 
@@ -142,6 +143,11 @@
 				 <0>;
 		};
 
+		tcsr: syscon@1937000 {
+			compatible = "qcom,tcsr-ipq5332", "syscon";
+			reg = <0x01937000 0x21000>;
+		};
+
 		sdhc: mmc@7804000 {
 			compatible = "qcom,ipq5332-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x07804000 0x1000>, <0x07805000 0x1000>;
-- 
2.17.1

