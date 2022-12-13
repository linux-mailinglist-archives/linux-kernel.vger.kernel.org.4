Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E95B64B495
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 12:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbiLML5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 06:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbiLML4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 06:56:52 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DED1DF0D;
        Tue, 13 Dec 2022 03:56:37 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD7iPmC027980;
        Tue, 13 Dec 2022 11:56:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=TwzU1aVJf1r5ToNcJf2LumGC0kISUfWKBLvdMRAg81U=;
 b=Tc+6Yl5ZOGwo2uMgYqQMYZ0eFLGFgiVQCuNn3XP7g0HTSSjNUJ4NQgK3OiQ9b76LgUDs
 OanNAkglGUkbtTqyW9LSi9dzQUBBHcGanRCzQ/KfxxbRMjfEd8pHrgcxm5Cb9wds7me6
 TClz2Q6WiHIPtLW3VHuCiSy+WjXhkNTl5mIkbbmXjg5Ym5DC8nuCgSvj5ehfwvaACLcx
 Qe3peUQxNnyOuhoNdjTBSHiu1PpWfDZARfmbmjuShg9+E7CicHoRbCDhkTbMkPG1WCLE
 4R6es1hWw04qWnAuXRQYPzXjBoQ0MgRoM+BVExeejdPBfQLoSaTaRwg2KoIbZPgDBxdh vg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mehj8h67m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 11:56:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BDBuRtQ018338
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 11:56:27 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 13 Dec 2022 03:56:23 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rohkumar@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <dianders@chromium.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <quic_rjendra@quicinc.com>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH] arm64: dts: qcom: sc7180: Set performance state for audio
Date:   Tue, 13 Dec 2022 17:26:06 +0530
Message-ID: <1670932566-22923-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RDr4lqsyjGmFqwIcjf9Qj4O6GEC42B7W
X-Proofpoint-ORIG-GUID: RDr4lqsyjGmFqwIcjf9Qj4O6GEC42B7W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1011 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212130106
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set a performance state for audio clks so that the minimally
correct corner voltage is picked when audio is active.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index f71cf21..3367e52 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -3625,6 +3625,7 @@
 				<&apps_smmu 0x1032 0>;
 
 			power-domains = <&lpass_hm LPASS_CORE_HM_GDSCR>;
+			required-opps = <&rpmhpd_opp_nom>;
 
 			status = "disabled";
 
@@ -3655,6 +3656,8 @@
 			clocks = <&gcc GCC_LPASS_CFG_NOC_SWAY_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "iface", "bi_tcxo";
+			power-domains = <&rpmhpd SC7180_CX>;
+
 			#clock-cells = <1>;
 			#power-domain-cells = <1>;
 		};
-- 
2.7.4

