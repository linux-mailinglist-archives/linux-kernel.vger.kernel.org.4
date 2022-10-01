Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06305F1948
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 05:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbiJADKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 23:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbiJADHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 23:07:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4805DCEE95;
        Fri, 30 Sep 2022 20:07:17 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2912eaC0005418;
        Sat, 1 Oct 2022 03:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=iyJGAfSzQng2YcIokV9oTsPkc6xTjns9yUnu/h51qaA=;
 b=GL7ds0q0cEWPHWzRf+QWwuiK0zqBorq5pOZvADxhj5uneapHd8KM2tblqvNR3S4sTNq0
 HVy6ci+XbypJQ6VjeEQ5I7R5fhgV27vcwsZYFg/sXpCvk3apt4C0lVRQ6+0sKlYflN1X
 hnyTdIAL0632HCBIOEKoUxsl0AlDJMmbOgyfWqDEi+BULY1FzSyBN89xWXWQ+HsrwtPE
 7cZRyo+GFS7xEavTX3/vBuslTf0OfL25QQuj2tI5KPtdBaX5axqTolqiCbo47rYy78zb
 EhLDSNP2t3rQbTG1FLPAMfSU6Oml4EEZPnUj70518GfJ6dOeizd7fRlKucqUhcwUnQvo Cw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jx70grpjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 01 Oct 2022 03:07:14 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29137DoT009839
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
Subject: [PATCH 05/19] arm64: dts: qcom: qru1000: Add reserved memory nodes
Date:   Fri, 30 Sep 2022 20:06:42 -0700
Message-ID: <20221001030656.29365-6-quic_molvera@quicinc.com>
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
X-Proofpoint-GUID: gDgFBaSCng6g957E273jzm8Wr3UaJyFi
X-Proofpoint-ORIG-GUID: gDgFBaSCng6g957E273jzm8Wr3UaJyFi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-01_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=765 adultscore=0 impostorscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210010016
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reserved memory nodes for QRU1000 SoCs based on downstream
documentation.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qru1000.dtsi | 145 ++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qru1000.dtsi b/arch/arm64/boot/dts/qcom/qru1000.dtsi
index 1639a4b3c1fb..be74be4bee4b 100644
--- a/arch/arm64/boot/dts/qcom/qru1000.dtsi
+++ b/arch/arm64/boot/dts/qcom/qru1000.dtsi
@@ -7,4 +7,149 @@
 
 / {
 	qcom,msm-id = <539 0x10000>, <588 0x10000>, <589 0x10000>, <590 0x10000>;
+
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
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
+		truested_apps_mem: memory@82800000 {
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
+		oem_tenx_mem: memory@a0000000 {
+			no-map;
+			reg = <0x0 0xa0000000 0x0 0x6400000>;
+		};
+
+		mpss_diag_buffer_mem: memory@aea00000 {
+			no-map;
+			reg = <0x0 0xaea00000 0x0 0x6400000>;
+		};
+
+		tenx_q6_buffer_mem: memory@b4e00000 {
+			no-map;
+			reg = <0x0 0xb4e00000 0x0 0x3200000>;
+		};
+	};
 };
-- 
2.37.3

