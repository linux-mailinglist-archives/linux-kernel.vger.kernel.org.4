Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555486B7829
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjCMM5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjCMM5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:57:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B48569067;
        Mon, 13 Mar 2023 05:57:41 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DCkT7U002659;
        Mon, 13 Mar 2023 12:57:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=qcppdkim1; bh=HDQp2b5uqh7ehDZreaIYJ+Damoh+IwYWk+HSjpcxgkY=;
 b=oLzgmbv1taKJKIfdE62I+hpuLEnXOCSodAkPA8VVFDtgxG8rzw0ctdRqbitE0v1JDoFz
 cmrxAdFCy/+ihSBPHgZ7OoR4iIoj+qgcONaeG1045e6+5X1HDAFbKzpS1yKkUO04kNew
 wtrOG399aDG+SsOBcL/3xZMk7b+dS/wlEvJzx+71zGq0CFMWuQfCfhPVXICSJYE9kXrY
 G+pXf5CdiprqE0xhVeALIEK2nrd/X11mK16Aor/B1a6GkakwbSCdGCsilUx31N8/3C4J
 //all9+e68feqxXL6zf2095EC2rMo+m+Qs0naTtykWXgJf9AWeYmVGRI0HfjSAd5D/ji jA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pa44br103-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 12:57:38 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32DCvYgM006563;
        Mon, 13 Mar 2023 12:57:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3p8jqknch7-1;
        Mon, 13 Mar 2023 12:57:34 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32DCvY80006558;
        Mon, 13 Mar 2023 12:57:34 GMT
Received: from kbajaj-linux.qualcomm.com (kbajaj-linux.qualcomm.com [10.214.66.129])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 32DCvYXc006557;
        Mon, 13 Mar 2023 12:57:34 +0000
Received: from kbajaj-linux.qualcomm.com (localhost [127.0.0.1])
        by kbajaj-linux.qualcomm.com (Postfix) with ESMTP id 15BD02B7;
        Mon, 13 Mar 2023 18:27:33 +0530 (IST)
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: qcom: qdu1000: Add LLCC/system-cache-controller
Date:   Mon, 13 Mar 2023 18:27:31 +0530
Message-Id: <20230313125731.17745-1-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: k0A4yOtqILDURNgY9cWkIvJJqxSgYfKs
X-Proofpoint-ORIG-GUID: k0A4yOtqILDURNgY9cWkIvJJqxSgYfKs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_05,2023-03-13_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=785 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303130105
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a DT node for Last level cache (aka. system cache) controller
which provides control over the last level cache present on QDU1000
and QRU1000 SoCs.

Changes in v2:
  - Addressing comments from Konrad.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qdu1000.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
index f234159d2060..911ade2faa19 100644
--- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
+++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
@@ -1320,6 +1320,18 @@ gem_noc: interconnect@19100000 {
 			qcom,bcm-voters = <&apps_bcm_voter>;
 			#interconnect-cells = <2>;
 		};
+
+		system-cache-controller@19200000 {
+			compatible = "qcom,qdu1000-llcc";
+			reg = <0 0x19200000 0 0xd80000>,
+			      <0 0x1a200000 0 0x80000>,
+			      <0 0x221c8128 0 0x4>;
+			reg-names = "llcc_base",
+				    "llcc_broadcast_base",
+				    "multi_channel_register";
+			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
+			multi-ch-bit-off = <24 2>;
+		};
 	};
 
 	timer {
-- 
2.39.1

