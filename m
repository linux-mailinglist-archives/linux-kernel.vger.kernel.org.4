Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186545BABC1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 12:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiIPKy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 06:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiIPKxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 06:53:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639CFAFAFB;
        Fri, 16 Sep 2022 03:37:10 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28G8bVhi028492;
        Fri, 16 Sep 2022 10:37:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=HyD12T7zjG6PCjjrxNxgo53Etc25WGrL9tn9njuoOYw=;
 b=GEMgNyLEwaB5E2qj1DV3WiF5sB2izY+Jw1YBBkLtsOH1OmY58YJxBrn4Ixnff7HRcVeL
 Ozz9jobx1N+HeFgDkLz6LtsRJJOQInYiqcC4Gg9r6RpIwg1U3iUJXPePrfYqK/irl4Jl
 aNlWty0K7RFzfp0lMAOpTk+jYePycTU0vsqmcbSnMDsfeTl2jBp3rI27S7b+ZeaNqIpk
 OFM8pTvjNljAoJYYm0xuwdQUl7s0BsIxmSlhcHdL/AZcdlHzpfhbjVlqMvkF5dCPhdq5
 PbycOukDtUFdtNLsOdy6xxhEu9lIvcHmR+ks89cLjC2Ne78ZsFFPEw012HdC5QUCb3wl 4Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jm9m1ajfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 10:37:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28GAW2x9001112
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 10:32:02 GMT
Received: from blr-ubuntu-173.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 16 Sep 2022 03:31:57 -0700
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@somainline.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sboyd@kernel.org>,
        <mka@chromium.org>, <johan+linaro@kernel.org>,
        <quic_kriskura@quicinc.com>, <dianders@chromium.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [Patch v2] arm64: dts: qcom: sc7280: Add required-opps for USB
Date:   Fri, 16 Sep 2022 16:01:24 +0530
Message-ID: <20220916103124.30581-1-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: N6JHHHjtRD7MeJfYAdVAvCuUdIDfAA1G
X-Proofpoint-GUID: N6JHHHjtRD7MeJfYAdVAvCuUdIDfAA1G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209160078
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB has a requirement to put a performance state vote on 'cx'
while active. Use 'required-opps' to pass this information from
device tree, and since all the GDSCs in GCC (including USB) are
sub-domains of cx, we also add cx as a power-domain for GCC.
Now when any of the consumers of the GDSCs (in this case USB)
votes on a perforamance state, genpd framework can identify that
the GDSC itself does not support a performance state and it
then propogates the vote to the parent, which in this case is cx.

This change would also mean that any GDSC in GCC thats left enabled
during low power state (perhaps because its marked with a
ALWAYS_ON flag) can prevent the system from entering low power
since that would prevent cx from transitioning to low power.
Ideally any consumers that would need to have their devices
(partially) powered to support wakeups should look at making the
resp. GDSCs transtion to a Retention (PWRSTS_RET) state instead
of leaving them ALWAYS_ON.

Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
---
v2:
* Updated the required-opps to nom instead of svs
* Also added required-opps for sec usb device

* This patch is a follow up based on the discussion on the previously
  posted version to support USB performance state voting [1]

* Another patch that this approach depends on is the one to fix the
  handling of PWRSTS_RET in the GDSC driver [2] so we can have USB
  GDSC transtion to a RET state instead of marking it ALWAYS_ON

[1] https://lore.kernel.org/linux-usb/YTduDqCO9aUyAsw1@ripper/
[2] https://lore.kernel.org/all/20220901101756.28164-1-quic_rjendra@quicinc.com/#t

 arch/arm64/boot/dts/qcom/sc7280.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 13d7f267b289..623cb1f78b55 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -828,6 +828,7 @@
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
+			power-domains = <&rpmhpd SC7280_CX>;
 		};
 
 		ipcc: mailbox@408000 {
@@ -3181,6 +3182,7 @@
 					  "dm_hs_phy_irq";
 
 			power-domains = <&gcc GCC_USB30_SEC_GDSC>;
+			required-opps = <&rpmhpd_opp_nom>;
 
 			resets = <&gcc GCC_USB30_SEC_BCR>;
 
@@ -3367,6 +3369,7 @@
 					  "ss_phy_irq";
 
 			power-domains = <&gcc GCC_USB30_PRIM_GDSC>;
+			required-opps = <&rpmhpd_opp_nom>;
 
 			resets = <&gcc GCC_USB30_PRIM_BCR>;
 
-- 
2.17.1

