Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265635F1947
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 05:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbiJADK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 23:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbiJADHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 23:07:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FF72BE36;
        Fri, 30 Sep 2022 20:07:16 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 291358bo026961;
        Sat, 1 Oct 2022 03:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=aeCe/JslE/ib54A1KNHM7zUmrMI5rfrsC5UMfW5ZKM0=;
 b=nOkmM5aubuU6GsMm19j0NQZmEMfn0aNQnNV4Qz4jeL0n2i98jHZ4u3jOkzQJGaY3+6XF
 9+/wWelySRDJAxb3Ogo0r02rHCyqDAJE8KKnP2yvhsRdceJx8sIANJJOFiEfcXnJ50iD
 wNSqwHm2vFV8m4LDXyfMJoBjueLIyZyHyotqmaS5q+/KxIkOVgBlvW8fMc4yJy/dLJnw
 Fy/g3P5xvtPa6ZbuEcIqKhHaBUDQaHUgPM4cRdcD8GxGlVt2M8vywu0RuYp9bKpb3Twv
 QklaYvb2TTKpza9fYHxAsQT003kwOo5gHPw30qIDHGUYdsZPtY6ZlUNnar5Vg885Dt2I PQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jxch0r20d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 01 Oct 2022 03:07:14 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29137D0k009836
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 1 Oct 2022 03:07:13 GMT
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 30 Sep 2022 20:07:13 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH 04/19] arm64: dts: qcom: qdu1000: Add reserved memory nodes
Date:   Fri, 30 Sep 2022 20:06:41 -0700
Message-ID: <20221001030656.29365-5-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001030656.29365-1-quic_molvera@quicinc.com>
References: <20221001030656.29365-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: woe-2964Vy1CLNxpnx_y5SubLNxFdfaj
X-Proofpoint-GUID: woe-2964Vy1CLNxpnx_y5SubLNxFdfaj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-01_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 mlxlogscore=737 lowpriorityscore=0 impostorscore=0
 phishscore=0 suspectscore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210010016
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reserved memory nodes for QDU1000 SoCs based on downstream
documentation.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qdu1000.dtsi | 150 ++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
index ba195e7ffc38..e836b2c1b8df 100644
--- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
+++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
@@ -7,4 +7,154 @@
 
 / {
 	qcom,msm-id = <545 0x10000>, <587 0x10000>;
+
+	reserved_memory: reserved-memory {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	ranges;
+
+		hyp_mem: memory@80000000 {
+			no-map;
+			reg = <0x0 0x80000000 0x0 0x600000>;
+		};
+
+		xbl_dt_log_mem: memory@80600000 {
+			no-map;
+			reg = <0x0 0x80600000 0x0 0x40000>;
+		};
+
+		xbl_ramdump_mem: memory@80640000 {
+			no-map;
+			reg = <0x0 0x80640000 0x0 0x1c0000>;
+		};
+
+		aop_image_mem: memory@80800000 {
+			no-map;
+			reg = <0x0 0x80800000 0x0 0x60000>;
+		};
+
+		aop_cmd_db_mem: memory@80860000 {
+			compatible = "qcom,cmd-db";
+			no-map;
+			reg = <0x0 0x80860000 0x0 0x20000>;
+		};
+
+		aop_config_mem: memory@80880000 {
+			no-map;
+			reg = <0x0 0x80880000 0x0 0x20000>;
+		};
+
+		tme_crash_dump_mem: memory@808a0000 {
+			no-map;
+			reg = <0x0 0x808a0000 0x0 0x40000>;
+		};
+
+		tme_log_mem: memory@808e0000 {
+			no-map;
+			reg = <0x0 0x808e0000 0x0 0x4000>;
+		};
+
+		uefi_log_mem: memory@808e4000 {
+			no-map;
+			reg = <0x0 0x808e4000 0x0 0x10000>;
+		};
+
+		/* secdata region can be reused by apps */
+
+		smem_mem: memory@80900000 {
+			compatible = "qcom,smem";
+			no-map;
+			reg = <0x0 0x80900000 0x0 0x200000>;
+			hwlocks = <&tcsr_mutex 3>;
+		};
+
+		cpucp_fw_mem: memory@80b00000 {
+			no-map;
+			reg = <0x0 0x80b00000 0x0 0x100000>;
+		};
+
+		xbl_sc_mem: memory@80c00000 {
+			no-map;
+			reg = <0x0 0x80c00000 0x0 0x40000>;
+		};
+
+		/* uefi region can be reused by apps */
+
+		tz_stat_mem: memory@81d00000 {
+			no-map;
+			reg = <0x0 0x81d00000 0x0 0x100000>;
+		};
+
+		tags_mem: memory@81e00000 {
+			no-map;
+			reg = <0x0 0x81e00000 0x0 0x500000>;
+		};
+
+		qtee_mem: memory@82300000 {
+			no-map;
+			reg = <0x0 0x82300000 0x0 0x500000>;
+		};
+
+		ta_mem: memory@82800000 {
+			no-map;
+			reg = <0x0 0x82800000 0x0 0xa00000>;
+		};
+
+		fs1_mem: memory@83200000 {
+			no-map;
+			reg = <0x0 0x83200000 0x0 0x400000>;
+		};
+
+		fs2_mem: memory@83600000 {
+			no-map;
+			reg = <0x0 0x83600000 0x0 0x400000>;
+		};
+
+		fs3_mem: memory@83a00000 {
+			no-map;
+			reg = <0x0 0x83a00000 0x0 0x400000>;
+		};
+
+		/* Linux kernel image is loaded at 0x83e00000 */
+
+		ipa_fw_mem: memory@8be00000 {
+			no-map;
+			reg = <0x0 0x8be00000 0x0 0x10000>;
+		};
+
+		ipa_gsi_mem: memory@8be10000 {
+			no-map;
+			reg = <0x0 0x8be10000 0x0 0x14000>;
+		};
+
+		mpss_mem: memory@8c000000 {
+			no-map;
+			reg = <0x0 0x8c000000 0x0 0x12c00000>;
+		};
+
+		q6_mpss_dtb_mem: memory@9ec00000 {
+			no-map;
+			reg = <0x0 0x9ec00000 0x0 0x80000>;
+		};
+
+		tenx_mem: memory@a0000000 {
+			no-map;
+			reg = <0x0 0xa0000000 0x0 0x19600000>;
+		};
+
+		oem_tenx_mem: memory@b9600000 {
+			no-map;
+			reg = <0x0 0xb9600000 0x0 0x6a00000>;
+		};
+
+		tenx_q6_buffer_mem: memory@c0000000 {
+			no-map;
+			reg = <0x0 0xc0000000 0x0 0x3200000>;
+		};
+
+		ipa_buffer_mem: memory@c3200000 {
+			no-map;
+			reg = <0x0 0xc3200000 0x0 0x12c00000>;
+		};
+	};
 };
-- 
2.37.3

