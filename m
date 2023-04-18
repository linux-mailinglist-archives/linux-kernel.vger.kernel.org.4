Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13E86E6854
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjDRPcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjDRPca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:32:30 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B58713879;
        Tue, 18 Apr 2023 08:32:17 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IB27OJ022227;
        Tue, 18 Apr 2023 15:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=FR9/nYvdx9UuYorCT0XIOqfxpevH7D7WKcKXu1Y6aRg=;
 b=HMuOCwcBKvUWOu7QYxV/mItLxzoRDl80LvctxmBMQbx91MtDBlDmaWUfYesVBRMWiTLe
 Ol11UfcuJwP//ghGFopEk5E9BNmvaNLPyVkGmUZPTsPcf2m55ggzqZhnVrsbXgJzLfcg
 X7Vdl5n6xYO4FeqQUbBOXe8OjHgDxiJOTu3OgVLPH3xMNW4u4wfIVKeCIioTMZE/yQG9
 XWtgbIU9tvSmnEy3X+e0Mlp/TTtFqirsfV16SyBDoapDQG8XaZMAQhNtWxEzITWwYV1S
 fVrKknoa5RG8h7qeom3NQdUuE8u2Uy1pQ0WWbCPklpYdQbtFv1HTS9ZP05PLkyHwxqQl bg== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3q1ca10469-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 15:31:40 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id D417B800386;
        Tue, 18 Apr 2023 15:31:39 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 2F53E81733A;
        Tue, 18 Apr 2023 15:31:39 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, linux@armlinux.org.uk,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 7/9] ARM: dts: gxp: add psu, i2c, gpio
Date:   Tue, 18 Apr 2023 10:28:22 -0500
Message-Id: <20230418152824.110823-8-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230418152824.110823-1-nick.hawkins@hpe.com>
References: <20230418152824.110823-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: jzlnY3bNHyLJihobDT4oF8pW9MGrW95V
X-Proofpoint-ORIG-GUID: jzlnY3bNHyLJihobDT4oF8pW9MGrW95V
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_11,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=963 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180132
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Add support for the GXP I2C, PSU, and GPIO
drivers. As well as adjust register ranges to be
correct.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 arch/arm/boot/dts/hpe-bmc-dl360gen10.dts | 161 ++++++++++++++++++
 arch/arm/boot/dts/hpe-gxp.dtsi           | 197 ++++++++++++++++++++---
 2 files changed, 338 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts b/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
index 3a7382ce40ef..487b6485a832 100644
--- a/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
+++ b/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
@@ -23,4 +23,165 @@
 		device_type = "memory";
 		reg = <0x40000000 0x20000000>;
 	};
+
+	i2cmux@4 {
+		compatible = "i2c-mux-reg";
+		i2c-parent = <&i2c4>;
+		reg = <0xd1000374 0x1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
+	i2cmux@6 {
+		compatible = "i2c-mux-reg";
+		i2c-parent = <&i2c6>;
+		reg = <0xd1000376 0x1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+	eeprom@50 {
+		compatible = "atmel,24c02";
+		pagesize = <8>;
+		reg = <0x50>;
+	};
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&i2c6 {
+	status = "okay";
+};
+
+&i2c7 {
+	status = "okay";
+	psu@58 {
+		compatible = "hpe,gxp-psu";
+		reg = <0x58>;
+		hpe,sysreg = <&sysreg_system_controller2>;
+	};
+
+	psu@59 {
+		compatible = "hpe,gxp-psu";
+		reg = <0x59>;
+		hpe,sysreg = <&sysreg_system_controller2>;
+	};
+};
+
+&i2c8 {
+	status = "okay";
+};
+
+&i2c9 {
+	status = "okay";
+};
+
+&gpio {
+	gpio-line-names =
+	"", "", "", "", "", "", "", "", "", "", /*0 - 9*/
+	"", "", "", "", "", "", "", "", "", "", /*10 - 19*/
+	"", "", "", "", "", "", "", "", "", "", /*20 - 29*/
+	"", "", "", "", "", "", "", "", "", "", /*30 - 39*/
+	"", "", "", "", "", "", "", "", "", "", /*40 - 49*/
+	"", "", "", "", "", "", "", "", "", "", /*50 - 59*/
+	"", "", "", "", "", "", "", "", "", "", /*60 - 69*/
+	"", "", "", "", "", "", "", "", "", "", /*70 - 79*/
+	"", "", "", "", "", "", "", "", "", "", /*80 - 89*/
+	"", "", "", "", "", "", "", "", "", "", /*90 - 99*/
+	"", "", "", "", "", "", "", "", "", "", /*100 - 109*/
+	"", "", "", "", "", "", "", "", "", "", /*110 - 119*/
+	"", "", "", "", "", "", "", "", "", "", /*120 - 129*/
+	"", "", "", "", "", "", "", "", "", "", /*130 - 139*/
+	"", "", "", "", "", "", "", "", "", "", /*140 - 149*/
+	"", "", "", "", "", "", "", "", "", "", /*150 - 159*/
+	"", "", "", "", "", "", "", "", "", "", /*160 - 169*/
+	"", "", "", "", "", "", "", "", "", "", /*170 - 179*/
+	"", "", "", "", "", "", "", "", "", "", /*180 - 189*/
+	"", "", "RESET_OUT", "NMI_OUT", "", "", "", "", "", "", /*190 - 199*//*GPIO*/
+	"", "", "", "", "", "", "", "", "", "", /*Vuhc 200-209*/
+	"POWER_OUT", "PS_PWROK", "PCIERST", "POST_COMPLETE", "", "", "", "", "", ""; /*210 - 219*/
+};
+
+&gpio1 {
+	gpio-line-names =
+	"IOP_LED1", "IOP_LED2", "IOP_LED3", "IOP_LED4", "IOP_LED5", "IOP_LED6", "IOP_LED7",
+	"IOP_LED8", "FAN1_INST", "FAN2_INST", "FAN3_INST", "FAN4_INST", "FAN5_INST", "FAN6_INST",
+	"FAN7_INST", "FAN8_INST", "FAN1_FAIL", "FAN2_FAIL", "FAN3_FAIL", "FAN4_FAIL", "FAN5_FAIL",
+	"FAN6_FAIL", "FAN7_FAIL", "FAN8_FAIL", "FAN1_ID", "FAN2_ID", "FAN3_ID", "FAN4_ID",
+	"FAN5_ID", "FAN6_ID", "FAN7_ID", "FAN8_ID", "IDENTIFY", "HEALTH_RED", "HEALTH_AMBER",
+	"POWER_BUTTON", "UID_PRESS", "SLP", "NMI_BUTTON", "RESET_BUTTON", "SIO_S5",
+	"SO_ON_CONTROL", "PSU1_INST", "PSU2_INST", "PSU3_INST", "PSU4_INST", "PSU5_INST",
+	"PSU6_INST", "PSU7_INST", "PSU8_INST", "PSU1_AC", "PSU2_AC", "PSU3_AC", "PSU4_AC",
+	"PSU5_AC", "PSU6_AC", "PSU7_AC", "PSU8_AC", "PSU1_DC", "PSU2_DC", "PSU3_DC", "PSU4_DC",
+	"PSU5_DC", "PSU6_DC", "PSU7_DC", "PSU8_DC", "", "", "", "",
+	"", "", "", "", "", "", "", "", "", "";
 };
diff --git a/arch/arm/boot/dts/hpe-gxp.dtsi b/arch/arm/boot/dts/hpe-gxp.dtsi
index cf735b3c4f35..8a8faf7fbd60 100644
--- a/arch/arm/boot/dts/hpe-gxp.dtsi
+++ b/arch/arm/boot/dts/hpe-gxp.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree file for HPE GXP
+ * Device Tree for HPE GXP
  */
 
 /dts-v1/;
@@ -52,76 +52,233 @@
 			cache-level = <2>;
 		};
 
-		ahb@c0000000 {
+		ahb@80000000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x0 0xc0000000 0x30000000>;
-			dma-ranges;
+			ranges = <0x0 0x80000000 0x20000000>,
+			<0x40000000 0xc0000000 0x3fff0000>;
 
-			vic0: interrupt-controller@eff0000 {
+			vic0: interrupt-controller@4eff0000 {
 				compatible = "arm,pl192-vic";
-				reg = <0xeff0000 0x1000>;
+				reg = <0x4eff0000 0x1000>;
 				interrupt-controller;
 				#interrupt-cells = <1>;
 			};
 
-			vic1: interrupt-controller@80f00000 {
+			vic1: interrupt-controller@f00000 {
 				compatible = "arm,pl192-vic";
-				reg = <0x80f00000 0x1000>;
+				reg = <0xf00000 0x1000>;
 				interrupt-controller;
 				#interrupt-cells = <1>;
 			};
 
-			uarta: serial@e0 {
+			uarta: serial@400000e0 {
 				compatible = "ns16550a";
-				reg = <0xe0 0x8>;
+				reg = <0x400000e0 0x8>;
 				interrupts = <17>;
 				interrupt-parent = <&vic0>;
 				clock-frequency = <1846153>;
 				reg-shift = <0>;
 			};
 
-			uartb: serial@e8 {
+			uartb: serial@400000e8 {
 				compatible = "ns16550a";
-				reg = <0xe8 0x8>;
+				reg = <0x400000e8 0x8>;
 				interrupts = <18>;
 				interrupt-parent = <&vic0>;
 				clock-frequency = <1846153>;
 				reg-shift = <0>;
 			};
 
-			uartc: serial@f0 {
+			uartc: serial@400000f0 {
 				compatible = "ns16550a";
-				reg = <0xf0 0x8>;
+				reg = <0x400000f0 0x8>;
 				interrupts = <19>;
 				interrupt-parent = <&vic0>;
 				clock-frequency = <1846153>;
 				reg-shift = <0>;
 			};
 
-			usb0: usb@efe0000 {
+			usb0: usb@4efe0000 {
 				compatible = "hpe,gxp-ehci", "generic-ehci";
-				reg = <0xefe0000 0x100>;
+				reg = <0x4efe0000 0x100>;
 				interrupts = <7>;
 				interrupt-parent = <&vic0>;
 			};
 
-			st: timer@80 {
+			st: timer@40000080 {
 				compatible = "hpe,gxp-timer";
-				reg = <0x80 0x16>;
+				reg = <0x40000080 0x16>;
 				interrupts = <0>;
 				interrupt-parent = <&vic0>;
 				clocks = <&iopclk>;
 				clock-names = "iop";
 			};
 
-			usb1: usb@efe0100 {
+			usb1: usb@4efe0100 {
 				compatible = "hpe,gxp-ohci", "generic-ohci";
-				reg = <0xefe0100 0x110>;
+				reg = <0x4efe0100 0x110>;
 				interrupts = <6>;
 				interrupt-parent = <&vic0>;
 			};
+
+			sysreg_system_controller: syscon@400000f8 {
+				compatible = "hpe,gxp-sysreg", "syscon";
+				reg = <0x400000f8 0x8>;
+			};
+
+			sysreg_system_controller2: syscon@51000319 {
+				compatible = "hpe,gxp-sysreg", "syscon";
+				reg = <0x51000319 0x4>;
+			};
+
+			i2c0: i2c@40002000 {
+				compatible = "hpe,gxp-i2c";
+				reg = <0x40002000 0x70>;
+				interrupts = <9>;
+				interrupt-parent = <&vic0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+				hpe,sysreg = <&sysreg_system_controller>;
+				clock-frequency = <100000>;
+			};
+
+			i2c1: i2c@40002100 {
+				compatible = "hpe,gxp-i2c";
+				reg = <0x40002100 0x70>;
+				interrupts = <9>;
+				interrupt-parent = <&vic0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+				hpe,sysreg = <&sysreg_system_controller>;
+				clock-frequency = <100000>;
+			};
+
+			i2c2: i2c@40002200 {
+				compatible = "hpe,gxp-i2c";
+				reg = <0x40002200 0x70>;
+				interrupts = <9>;
+				interrupt-parent = <&vic0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+				hpe,sysreg = <&sysreg_system_controller>;
+				clock-frequency = <100000>;
+			};
+
+			i2c3: i2c@40002300 {
+				compatible = "hpe,gxp-i2c";
+				reg = <0x40002300 0x70>;
+				interrupts = <9>;
+				interrupt-parent = <&vic0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+				hpe,sysreg = <&sysreg_system_controller>;
+				clock-frequency = <100000>;
+			};
+
+			i2c4: i2c@40002400 {
+				compatible = "hpe,gxp-i2c";
+				reg = <0x40002400 0x70>;
+				interrupts = <9>;
+				interrupt-parent = <&vic0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+				hpe,sysreg = <&sysreg_system_controller>;
+				clock-frequency = <100000>;
+			};
+
+			i2c5: i2c@40002500 {
+				compatible = "hpe,gxp-i2c";
+				reg = <0x40002500 0x70>;
+				interrupts = <9>;
+				interrupt-parent = <&vic0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+				hpe,sysreg = <&sysreg_system_controller>;
+				clock-frequency = <100000>;
+			};
+
+			i2c6: i2c@40002600 {
+				compatible = "hpe,gxp-i2c";
+				reg = <0x40002600 0x70>;
+				interrupts = <9>;
+				interrupt-parent = <&vic0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+				hpe,sysreg = <&sysreg_system_controller>;
+				clock-frequency = <100000>;
+			};
+
+			i2c7: i2c@40002700 {
+				compatible = "hpe,gxp-i2c";
+				reg = <0x40002700 0x70>;
+				interrupts = <9>;
+				interrupt-parent = <&vic0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+				hpe,sysreg = <&sysreg_system_controller>;
+				clock-frequency = <100000>;
+			};
+
+			i2c8: i2c@40002800 {
+				compatible = "hpe,gxp-i2c";
+				reg = <0x40002800 0x70>;
+				interrupts = <9>;
+				interrupt-parent = <&vic0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+				hpe,sysreg = <&sysreg_system_controller>;
+				clock-frequency = <100000>;
+			};
+
+			i2c9: i2c@40002900 {
+				compatible = "hpe,gxp-i2c";
+				reg = <0x40002900 0x70>;
+				interrupts = <9>;
+				interrupt-parent = <&vic0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+				hpe,sysreg = <&sysreg_system_controller>;
+				clock-frequency = <100000>;
+			};
+
+			fan-controller@40000c10 { /* 0xc0000c10 */
+				compatible = "hpe,gxp-fan-ctrl";
+				reg = <0x40000c10 0x8>, <0x51000327 0x06>;
+				reg-names = "base", "pl";
+			};
+
+			gpio: gpio@0 {
+				compatible = "hpe,gxp-gpio";
+				reg = <0x0 0x400>, <0x200046 0x1>, <0x200070 0x08>,
+				<0x400064 0x80>, <0x5100030f 0x1>;
+				reg-names = "csm", "fn2-vbtn", "fn2-stat", "vuhc", "vbtn";
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupts = <0>;
+				interrupt-parent = <&vic1>;
+			};
+
+			gpio1: gpio@51000304 {
+				compatible = "hpe,gxp-gpio-pl";
+				reg = <0x51000304 0x2>, <0x5100030d 0x01>, <0x51000380 0x7f>;
+				reg-names = "pl-led", "pl-health", "pl-int";
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupts = <26>;
+				interrupt-parent = <&vic0>;
+			};
 		};
 	};
 };
-- 
2.17.1

