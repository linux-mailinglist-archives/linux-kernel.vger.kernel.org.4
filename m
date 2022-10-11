Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5119D5FBAD3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiJKS4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiJKS43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:56:29 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B9382870;
        Tue, 11 Oct 2022 11:56:27 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29BGs34F018400;
        Tue, 11 Oct 2022 18:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=7M5weptjsCIYnz77TwPaKOTuYrir2azWofVKGceRMkQ=;
 b=bld7rqEBYTSPeyP1iHM9UR6GrMDKKU6eR7aUwmlf/eGPXkZcQTUNlXvlA49xE0Dk6Fwr
 qKDliSJbaysWLfWOP1CPEP1ilwt2Y2wUb9bi5nTCNU1R++TmlcSk4WBBSzVsGb7tVOJz
 +A6AmwsxJFWWnyXzAnHDdbYSYI25HdeX4TAsHc6sBZGUNeKKDuON/OD4tW50B/WGCRZq
 unpoPDRsJPABGEwLZOSf5GRg/zWWizye/wK8l5VFmYp0+qb6Am5ZRwQXjhBdjHEebSSx
 3ToVxAwfZmVKXv57CMEFPkOaSiemQVw0Kcxekun/Wj+v+1NO3OMTVQGCBzQ+4HSrCh7a YQ== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k5cdgh07d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 18:56:02 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id CEF8D13943;
        Tue, 11 Oct 2022 18:56:01 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 7071A8032BC;
        Tue, 11 Oct 2022 18:56:01 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux@armlinux.org.uk,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 3/5] ARM: dts: hpe: Add PLREG/SPI Support
Date:   Tue, 11 Oct 2022 13:55:23 -0500
Message-Id: <20221011185525.94210-4-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011185525.94210-1-nick.hawkins@hpe.com>
References: <20221011185525.94210-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: xb0o_b1zfXxOFEh7ivBWi31-iRLmWGq_
X-Proofpoint-ORIG-GUID: xb0o_b1zfXxOFEh7ivBWi31-iRLmWGq_
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-11_08,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=939 lowpriorityscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210110110
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Adding support for the Programmable Logic Register driver in the HPE GXP
SoC. Additionally adding support for the SPI driver that has already
been committed to linux (See: drivers/spi/spi-gxp.c).

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 arch/arm/boot/dts/hpe-bmc-dl360gen10.dts | 275 +++++++++++++++++++++++
 arch/arm/boot/dts/hpe-gxp.dtsi           |  28 ++-
 2 files changed, 302 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts b/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
index 3a7382ce40ef..c97b052c4868 100644
--- a/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
+++ b/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
@@ -23,4 +23,279 @@
 		device_type = "memory";
 		reg = <0x40000000 0x20000000>;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-power {
+			gpios = <&plreg 6 0>;
+			default_state = "off";
+		};
+
+		led-heartbeat {
+			gpios = <&plreg 7 0>;
+			default_state = "off";
+		};
+
+		led-identify {
+			gpios = <&plreg 56 0>;
+			default-state = "off";
+		};
+
+		led-health_red {
+			gpios = <&plreg 57 0>;
+			default_state = "off";
+		};
+
+		led-health_amber {
+			gpios = <&plreg 58 0>;
+			default-state = "off";
+		};
+	};
+};
+
+&spifi {
+	status = "okay";
+	flash@0 {
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			u-boot@0 {
+				label = "u-boot";
+				reg = <0x0 0x60000>;
+			};
+
+			u-boot-env@60000 {
+				label = "u-boot-env";
+				reg = <0x60000 0x20000>;
+			};
+
+			kernel@80000 {
+				label = "kernel";
+				reg = <0x80000 0x4c0000>;
+			};
+
+			rofs@540000 {
+				label = "rofs";
+				reg = <0x540000 0x1740000>;
+			};
+
+			rwfs@1c80000 {
+				label = "rwfs";
+				reg = <0x1c80000 0x250000>;
+			};
+
+			section@1ed0000{
+				label = "section";
+				reg = <0x1ed0000 0x130000>;
+			};
+		};
+	};
+	flash@1 {
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			host-prime@0 {
+				label = "host-prime";
+				reg = <0x0 0x02000000>;
+			};
+
+			host-second@2000000 {
+				label = "host-second";
+				reg = <0x02000000 0x02000000>;
+			};
+		};
+	};
+};
+
+&plreg {
+	gpio-controller;
+	#gpio-cells = <2>;
+	gpio-line-names =
+	"", "", "", "", "",
+	"", "POWER", "HEARTBEAT", "FAN1_INST", "FAN2_INST",
+	"FAN3_INST", "FAN4_INST", "FAN5_INST", "FAN6_INST", "FAN7_INST",
+	"FAN8_INST", "FAN9_INST", "FAN10_INST", "FAN11_INST", "FAN12_INST",
+	"FAN13_INST", "FAN14_INST", "FAN15_INST", "FAN16_INST", "FAN1_FAIL",
+	"FAN2_FAIL", "FAN3_FAIL", "FAN4_FAIL", "FAN5_FAIL", "FAN6_FAIL",
+	"FAN7_FAIL", "FAN8_FAIL", "FAN9_FAIL", "FAN10_FAIL", "FAN11_FAIL",
+	"FAN12_FAIL", "FAN13_FAIL", "FAN14_FAIL", "FAN15_FAIL", "FAN16_FAIL",
+	"", "", "", "", "",
+	"", "", "", "", "",
+	"", "", "", "", "",
+	"", "IDENTIFY", "HEALTH_RED", "HEALTH_AMBER", "POWER_BUTTON",
+	"", "SIO_POWER_GOOD", "NMI_BUTTON", "RESET_BUTTON", "SIO_S5",
+	"SIO_ONCONTROL", "", "", "", "",
+	"", "", "", "", "",
+	"", "", "", "", "",
+	"", "", "", "", "",
+	"", "", "", "", "",
+	"", "", "", "", "",
+	"", "", "", "", "";
+	fan1 {
+		inst = <0x27>;
+		fail = <0x29>;
+		id = <0x2B>;
+		bit = <0x01>;
+	};
+	fan2 {
+		inst = <0x27>;
+		fail = <0x29>;
+		id = <0x2B>;
+		bit = <0x02>;
+	};
+	fan3 {
+		inst = <0x27>;
+		fail = <0x29>;
+		id = <0x2B>;
+		bit = <0x04>;
+	};
+	fan4 {
+		inst = <0x27>;
+		fail = <0x29>;
+		id = <0x2B>;
+		bit = <0x08>;
+	};
+	fan5 {
+		inst = <0x27>;
+		fail = <0x29>;
+		id = <0x2B>;
+		bit = <0x10>;
+	};
+	fan6 {
+		inst = <0x27>;
+		fail = <0x29>;
+		id = <0x2B>;
+		bit = <0x40>;
+	};
+	fan7 {
+		inst = <0x27>;
+		fail = <0x29>;
+		id = <0x2B>;
+		bit = <0x40>;
+	};
+	fan8 {
+		inst = <0x27>;
+		fail = <0x29>;
+		id = <0x2B>;
+		bit = <0x80>;
+	};
+	fan9 {
+		inst = <0x28>;
+		fail = <0x2A>;
+		id = <0x2C>;
+		bit = <0x01>;
+	};
+	fan10 {
+		inst = <0x28>;
+		fail = <0x2A>;
+		id = <0x2C>;
+		bit = <0x02>;
+	};
+	fan11 {
+		inst = <0x28>;
+		fail = <0x2A>;
+		id = <0x2C>;
+		bit = <0x04>;
+	};
+	fan12 {
+		inst = <0x28>;
+		fail = <0x2A>;
+		id = <0x2C>;
+		bit = <0x08>;
+	};
+	fan13 {
+		inst = <0x28>;
+		fail = <0x2A>;
+		id = <0x2C>;
+		bit = <0x10>;
+	};
+	fan14 {
+		inst = <0x28>;
+		fail = <0x2A>;
+		id = <0x2C>;
+		bit = <0x20>;
+	};
+	fan15 {
+		inst = <0x28>;
+		fail = <0x2A>;
+		id = <0x2C>;
+		bit = <0x40>;
+	};
+	fan16 {
+		inst = <0x28>;
+		fail = <0x2A>;
+		id = <0x2C>;
+		bit = <0x80>;
+	};
+	healthled {
+		red = <0x0D 0x20>;
+		amber = <0x0D 0x30>;
+		green = <0x0D 0x10>;
+	};
+	iopled1 {
+		on = <0x04 0x01>;
+	};
+	iopled2 {
+		on = <0x04 0x02>;
+	};
+	iopled3 {
+		on = <0x04 0x04>;
+	};
+	iopled4 {
+		on = <0x04 0x08>;
+	};
+	iopled5 {
+		on = <0x04 0x10>;
+	};
+	iopled6 {
+		on = <0x04 0x20>;
+	};
+	iopled7 {
+		on = <0x04 0x40>;
+	};
+	iopled8 {
+		on = <0x04 0x80>;
+	};
+	identifyled {
+		on = <0x05 0xC0>;
+		off = <0x05 0x40>;
+	};
+	acm {
+		forceoff = <0x0A 0x01>;
+		removed = <0x0A 0x02>;
+		unlatchreq = <0x0A 0x04>;
+	};
+	serverid {
+		lower = <0x01 0xFF>;
+		upper = <0x02 0xFF>;
+	};
+	sideband {
+		disabled = <0x40 0x03>;
+		embedded = <0x40 0x02>;
+		adaptive = <0x40 0x01>;
+	};
+	grp5intflag {
+		ack = <0xB0 0xFF>;
+		pwrbtn = <0xB0 0x01>;
+		uidpress = <0xB0 0x02>;
+		slpint = <0xB0 0x04>;
+	};
+	grp5intmask {
+		pwrbtn = <0xB1 0x01>;
+		slpint = <0xB1 0x40>;
+	};
+	grpintsmasks {
+		grp5 = <0x88 0x10>;
+	};
+	grpintsflags {
+		grp5 = <0x8C 0x10>;
+	};
+	pwrbtn {
+		latch = <0x0F 0xFF 0x04>;
+	};
 };
diff --git a/arch/arm/boot/dts/hpe-gxp.dtsi b/arch/arm/boot/dts/hpe-gxp.dtsi
index cf735b3c4f35..96003667bebe 100644
--- a/arch/arm/boot/dts/hpe-gxp.dtsi
+++ b/arch/arm/boot/dts/hpe-gxp.dtsi
@@ -56,9 +56,28 @@
 			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x0 0xc0000000 0x30000000>;
+			ranges = <0x0 0xc0000000 0x40000000>;
 			dma-ranges;
 
+			spifi: spi@200 {
+				compatible = "hpe,gxp-spifi";
+				reg = <0x200 0x80>, <0xc000 0x100>, <0x38000000 0x8000000>;
+				interrupts = <20>;
+				interrupt-parent = <&vic0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+				flash@0 {
+					reg = <0>;
+					compatible = "jedec,spi-nor";
+				};
+
+				flash@1 {
+					reg = <1>;
+					compatible = "jedec,spi-nor";
+				};
+			};
+
 			vic0: interrupt-controller@eff0000 {
 				compatible = "arm,pl192-vic";
 				reg = <0xeff0000 0x1000>;
@@ -122,6 +141,13 @@
 				interrupts = <6>;
 				interrupt-parent = <&vic0>;
 			};
+
+			plreg: plreg@d1000000 {
+				compatible = "hpe,gxp-plreg", "simple-mfd", "syscon";
+				reg = <0xd1000000 0xff>;
+				interrupts = <26>;
+				interrupt-parent = <&vic0>;
+			};
 		};
 	};
 };
-- 
2.17.1

