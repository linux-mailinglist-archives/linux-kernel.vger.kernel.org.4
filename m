Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59E15B8DC6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 19:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiINRDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 13:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiINRCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 13:02:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0CD82751;
        Wed, 14 Sep 2022 10:02:44 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EGV0gm005108;
        Wed, 14 Sep 2022 17:02:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=jgWfAwXuuu0RIdbapJx7yHndhKxVFwzMF8fPwOYRIh4=;
 b=jj9eq0TOV95lxsbBpmchO7xo4z9CGzzjl0A5lUbz5dTHSx/9Wk8E1VYsBEXt+MdjMNAH
 myV90CsKbx5dae0SPewyrSvwjxtS60aYhFRqH2Ydjf4bI0BdQAANK7+Jx2w1hcxA2DDN
 zZfc073dOI3dCv0oD338Wjb5/ji2cotOkIkzIPF+kEmUNHNcNdp9gSnptdMLPOatCQO7
 YvLSWmAYrZJYKG205uPEzppGNHCoG+69PEfeesQaZzxUD4VtZx93+ibhGeTZ/6igbZKm
 g6kZdih9kNWeEdP4FMAn8ilc/3JY1R+oImFDvblJErUJgzxviRoOoPuGHcxymCeqx0Rq bA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjy0capce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 17:02:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28EH2ae0008987
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 17:02:36 GMT
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 14 Sep 2022 10:02:32 -0700
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, <vkoul@kernel.org>,
        "Souradeep Chowdhury" <quic_schowdhu@quicinc.com>
Subject: [PATCH V9 7/7] arm64: dts: qcom: sdm845: Add Data Capture and Compare(DCC) support node
Date:   Wed, 14 Sep 2022 22:31:17 +0530
Message-ID: <1792d487657672fd183cceba575809cb5b3478e7.1663173478.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1663173477.git.quic_schowdhu@quicinc.com>
References: <cover.1663173477.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EF4b2zq2q1968945kbGSpPqDOI3tOBLx
X-Proofpoint-GUID: EF4b2zq2q1968945kbGSpPqDOI3tOBLx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_08,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=833 priorityscore=1501
 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0 impostorscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140083
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DCC(Data Capture and Compare) device tree node entry along with
the address of the register region.

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index ff6bda1..ee13b5f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1968,6 +1968,12 @@
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		dma@10a2000 {
+			compatible = "qcom,sdm845-dcc", "qcom,dcc";
+			reg = <0x0 0x010a2000 0x0 0x1000>,
+			      <0x0 0x010ae000 0x0 0x2000>;
+		};
+
 		pcie0: pci@1c00000 {
 			compatible = "qcom,pcie-sdm845", "snps,dw-pcie";
 			reg = <0 0x01c00000 0 0x2000>,
-- 
2.7.4

