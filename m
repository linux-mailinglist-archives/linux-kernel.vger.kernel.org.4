Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714B266D918
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbjAQJBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbjAQJAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:00:52 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72CD2F7B9;
        Tue, 17 Jan 2023 00:59:58 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H7O95h004215;
        Tue, 17 Jan 2023 08:59:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=5n4SkHoyjUuc3yCfzwjUyMMVHwhy4yRi2qkySrQajlY=;
 b=aZts1T0cVWj9KiLRYA0cFcIxKkHhrTq6+2YQQgp209vElSTwiZzqTwB/ZsgLDiVz6mqm
 Q1qU8zD0w01B6q57usUNGD3gGi5i1Z3/FJWFkiPOJucbUjcJBXWxc4VrIAjTkYgPTiw3
 ixf65UfkrUQAkewXEdp/IiPX4odO011xmplc7mYmiU/ZnKCwMrTUo7J7+waFcxCjOe18
 YkQk9dAYv13onRAQ3cNQKv4LCtTt5Gf4rgsuGzL5uWyIL1VBSBUhTWh3afFzBaeTT3vx
 +oiM9Zpz63UIcAtg8+VebYcoXeZrVCSXEWnAUCFean8uPdN2I+qGJ0UcfyJfsYNd65f9 FA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n3j3nn850-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 08:59:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30H8xicS031459
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 08:59:44 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 17 Jan 2023 00:59:40 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <manivannan.sadhasivam@linaro.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <konrad.dybcio@somainline.org>, <amit.pundir@linaro.org>,
        <regressions@leemhuis.info>, <sumit.semwal@linaro.org>,
        <will@kernel.org>, <catalin.marinas@arm.com>,
        <robin.murphy@arm.com>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V4 09/11] arm64: dts: qcom: sdm845: Add a carveout for modem metadata
Date:   Tue, 17 Jan 2023 14:28:38 +0530
Message-ID: <20230117085840.32356-10-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230117085840.32356-1-quic_sibis@quicinc.com>
References: <20230117085840.32356-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: a6zrRJWpA8dsiGXQDEZPQ37r590q90SE
X-Proofpoint-ORIG-GUID: a6zrRJWpA8dsiGXQDEZPQ37r590q90SE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_04,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=963 phishscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170075
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new carveout for modem metadata on SDM845 SoCs.

Tested-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v4:
 * Use size/alloc-ranges instead of a specific address [Bjorn]

v2:
 * Split dt/bindings per SoC [Krzysztof]

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0f1cb2c8addd..18b9245879de 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -864,6 +864,12 @@
 			reg = <0 0x97b00000 0 0x100000>;
 			no-map;
 		};
+
+		mdata_mem: mpss-metadata {
+			alloc-ranges = <0 0xa0000000 0 0x20000000>;
+			size = <0 0x4000>;
+			no-map;
+		};
 	};
 
 	adsp_pas: remoteproc-adsp {
@@ -3282,6 +3288,10 @@
 				memory-region = <&mpss_region>;
 			};
 
+			metadata {
+				memory-region = <&mdata_mem>;
+			};
+
 			glink-edge {
 				interrupts = <GIC_SPI 449 IRQ_TYPE_EDGE_RISING>;
 				label = "modem";
-- 
2.17.1

