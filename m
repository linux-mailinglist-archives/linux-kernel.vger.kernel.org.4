Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3544A5B952E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiIOHXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiIOHXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:23:30 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2048.outbound.protection.outlook.com [40.107.117.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66A58C014;
        Thu, 15 Sep 2022 00:23:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jpv67A5a7YdBKD7kropn3xwwf6M+uBW+EucWEe5ZJxNS5R5DTPr9RoGqSUIzb70h66Pxq6sbCaFx7D9bADKEpdqdCEWCnn+Ktb4X2XERoELiDS9b/cSa2CSPVzPAgV6JdRcGt/cuTK5ieIkIvhLDSRRcr2tCSro8ojtk+vta5628Pr/fWp5sidrqXu4Py49GrWtLiRMJKycpiFfVFGPElG+r3CEg2f/Do1bFRhgdTeagsQx/F/2Fs2IXgNSwFVeypEnnOaDjIjwbHOaAvdUgZwjMr7ArSe1/+7mD8Yx0M6NSw3RVaDfBWWKdWbRvb4OnSeeOV6Fs1nvchZhjIZdHHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+z1e7n5JOifjvSboUY6E5tkv149Juo9RHerviOzW+A=;
 b=hdhUtHXOC2wMmDtOMjyi8ypemUMhEVT0GjnIx8yPyGzQi+Vx74Aztyr4uTXEEtX053BYSSL6Df5aTfkqj3taeW2xqINlbEn/i9Jmy/eNekqHyTBS4JoF6a3cMO6YJHJTazodPBHZEpsNTcBnHpUIbCznsxootvqrRFxkz9yvN9c+JSajWdANyPiTDHXmdjaqpG08/xYWriXpqJI8CmRn7OZHhX0yUmZuyU1TNuflFBdrlpZ8/OJXODdl//NjvQ/1eyKCL5le44QF1UONCMK+YgETeeUchk8eY380Ij9agD+CwacNMOW+H3RFjfZbGjZlVuNyExynMUoLjTUizLPayg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=jms.id.au smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+z1e7n5JOifjvSboUY6E5tkv149Juo9RHerviOzW+A=;
 b=YOWsndCF9M8fTrTP2whpOri0lpmJlZL7CThoAYZ/0n5Zz4o0gU1/uVG9YVefAeStsPeSFvMlP7aAkb55CC+9hH0+Otpu4cfSe6hf2qAt3lM4/w3n9Xy9/0N3J2WrmH4+6jUMO7lA5eFIl5mI31LMNZgusW0qPWXwz4imGvPFjEGYOI9WFG98VRwkKnakPZUi8IU66oYj6K7hYwAZL0hSKDpyq9f9o3G4Ee8bHN/muNRSdSJsQCI5IReeDPVw4gfPpmqu9eabNk16YPl1ZHZOYq1Xoq9XrNGmJYrbZWvdzzmJvC7PBNZKdnc40dAx6gMJAvUhNM7EG0qdJRuCWpeZcg==
Received: from SG2PR02CA0050.apcprd02.prod.outlook.com (2603:1096:4:54::14) by
 KL1PR0401MB4273.apcprd04.prod.outlook.com (2603:1096:820:2a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.14; Thu, 15 Sep
 2022 07:23:23 +0000
Received: from SG2APC01FT0019.eop-APC01.prod.protection.outlook.com
 (2603:1096:4:54:cafe::9b) by SG2PR02CA0050.outlook.office365.com
 (2603:1096:4:54::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Thu, 15 Sep 2022 07:23:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=Wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=Wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of Wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2APC01FT0019.mail.protection.outlook.com (10.13.36.86) with Microsoft SMTP
 Server id 15.20.5632.12 via Frontend Transport; Thu, 15 Sep 2022 07:23:21
 +0000
From:   Bonnie Lo <Bonnie_Lo@Wiwynn.com>
To:     joel@jms.id.au
Cc:     patrickw3@fb.com, garnermic@fb.com, Delphine_Chiu@Wiwynn.com,
        Bonnie_Lo@Wiwynn.com, Bonnie Lo <Bonnie_Lo@wiwynn.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: [PATCH] greatlakes: dts: Add Facebook greatlakes (AST2600) BMC
Date:   Thu, 15 Sep 2022 15:23:02 +0800
Message-Id: <20220915072304.1438-1-Bonnie_Lo@Wiwynn.com>
X-Mailer: git-send-email 2.17.1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2APC01FT0019:EE_|KL1PR0401MB4273:EE_
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7edeb20a-d248-48c8-73f4-08da96eb2c2a
Content-Transfer-Encoding: quoted-printable
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JSl4ik627xYFOn/NOZKuIX44pZpoDt1PYNxRZYuKoQEu8S0+sBAnthT5fsOp3YuDA85Ve1qCGEiUocF8XGXgLsOoZlVUDDze/k252w3r2SOc9oNVwBjVPufY0bd3qLv8PFyCcrhOMnlA4hw7Z+eKYG4cvN6saCXW1Dc1bTkqOifDto3a8y9JoPwfKFlXeeq3kNtaIlrpff1e3IhSphRCykDH9IfLnEOsMQBb3jrPrJFr19jVsWCmc/zhAmtuuSZ//R441rjLBHHbh9YhWCwhongSjvm6ZkEygBQYr+X6q+tRSHJTMQfWRe/UWYSYjkhOtBXnALzQYY8GRZ3RjUovhI8LEPQ1+LbaLx5aQvpRROTg47EO7C/izfZrHlskb4O6OhMshRQz1aYkTVKD8R9QCpVmxHO0jv93UA+TGpwODoycyrcfAtxidJtRQUULma5kjz8w7sqHH3fPbsg8xuTjxoc7zq6FxKEimMYLbc0XTE18PanjuErlLo30OBqpLJ8wyjoc3HCs8FBdnovuKj2gaF7Gfe7lRxsWJrsaJh+QH2cAwcGfQH8vzgEehuBJVPCHqXSRxIHQ/MwJX+IkR5ELJsFwUDHklGl/7ht7gMPT73hMPImcreF873dAKS24tFNI6jkMZ5XpzdY4V1tt27tqUQsACzNTmLWc9jVWNWrBXTGISfegbyTm3hI3V80HSmXkt2Mq1UoQwBUq6SfGqchgWdbYBEHxPy8wGIbHDH6ZgL1JxD6Ew7OSdWwlnJP2ApMq
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230022)(6069001)(4636009)(346002)(396003)(136003)(39860400002)(376002)(47680400002)(451199015)(46966006)(36840700001)(82740400003)(1076003)(70206006)(70586007)(36860700001)(4326008)(40480700001)(8676002)(6506007)(956004)(26005)(356005)(81166007)(478600001)(41300700001)(6666004)(36736006)(36906005)(6916009)(54906003)(6512007)(6486002)(316002)(83380400001)(336012)(2616005)(186003)(47076005)(8936002)(7416002)(36756003)(86362001)(82310400005)(5660300002)(2906002)(9316004);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 07:23:21.9901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7edeb20a-d248-48c8-73f4-08da96eb2c2a
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT0019.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB4273
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bonnie Lo <Bonnie_Lo@wiwynn.com>

Add linux device tree entry related to
greatlakes specific devices connected to BMC SoC.

Signed-off-by: Bonnie Lo <Bonnie_Lo@wiwynn.com>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/aspeed-bmc-facebook-greatlakes.dts    | 248 ++++++++++++++++++
 2 files changed, 249 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 05d8aef6e5d2..40fa906ab17f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1580,6 +1580,7 @@ dtb-$(CONFIG_ARCH_ASPEED) +=3D \
        aspeed-bmc-asrock-e3c246d4i.dtb \
        aspeed-bmc-asrock-romed8hm3.dtb \
        aspeed-bmc-bytedance-g220a.dtb \
+       aspeed-bmc-facebook-greatlakes.dtb \
        aspeed-bmc-facebook-bletchley.dtb \
        aspeed-bmc-facebook-cloudripper.dtb \
        aspeed-bmc-facebook-cmm.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts b/arch/ar=
m/boot/dts/aspeed-bmc-facebook-greatlakes.dts
new file mode 100644
index 000000000000..f011cc4d370f
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2022 Facebook Inc.
+
+/dts-v1/;
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/i2c/i2c.h>
+#include <dt-bindings/leds/leds-pca955x.h>
+
+/ {
+       model =3D "AST2600 EVB";
+       compatible =3D "aspeed,ast2600";
+
+       aliases {
+               serial4 =3D &uart5;
+       };
+
+       chosen {
+               stdout-path =3D &uart5;
+               bootargs =3D "console=3DttyS4,57600n8 root=3D/dev/ram rw vm=
alloc=3D384M";
+       };
+
+       memory@80000000 {
+               device_type =3D "memory";
+               reg =3D <0x80000000 0x80000000>;
+       };
+
+       iio-hwmon {
+               compatible =3D "iio-hwmon";
+               io-channels =3D <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
+                               <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
+                               <&adc1 0>, <&adc1 2>, <&adc1 3>, <&adc1 4>,
+                               <&adc1 5>, <&adc1 6>;
+       };
+};
+
+&uart1 {
+       status =3D "okay";
+};
+
+&uart2 {
+       status =3D "okay";
+};
+
+&uart3 {
+       status =3D "okay";
+};
+
+&uart4 {
+       status =3D "okay";
+};
+
+&uart5 {
+       status =3D "okay";
+};
+
+&wdt1 {
+       status =3D "okay";
+       pinctrl-names =3D "default";
+       pinctrl-0 =3D <&pinctrl_wdtrst1_default>;
+       aspeed,reset-type =3D "soc";
+       aspeed,external-signal;
+       aspeed,ext-push-pull;
+       aspeed,ext-active-high;
+       aspeed,ext-pulse-duration =3D <256>;
+};
+
+&mac3 {
+       status =3D "okay";
+       pinctrl-names =3D "default";
+       pinctrl-0 =3D <&pinctrl_rmii4_default>;
+       no-hw-checksum;
+       use-ncsi;
+       mlx,multi-host;
+       ncsi-ctrl,start-redo-probe;
+       ncsi-ctrl,no-channel-monitor;
+       ncsi-package =3D <1>;
+       ncsi-channel =3D <1>;
+       ncsi-rexmit =3D <1>;
+       ncsi-timeout =3D <2>;
+};
+
+&rtc {
+       status =3D "okay";
+};
+
+&fmc {
+       status =3D "okay";
+       flash@0 {
+               status =3D "okay";
+               m25p,fast-read;
+               label =3D "bmc";
+               spi-rx-bus-width =3D <4>;
+               spi-max-frequency =3D <50000000>;
+#include "openbmc-flash-layout-64.dtsi"
+       };
+       flash@1 {
+               status =3D "okay";
+               m25p,fast-read;
+               label =3D "bmc2";
+               spi-rx-bus-width =3D <4>;
+               spi-max-frequency =3D <50000000>;
+       };
+};
+
+&i2c0 {
+       status =3D "okay";
+       multi-master;
+       ipmb0@10 {
+               compatible =3D "ipmb-dev";
+               reg =3D <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+               i2c-protocol;
+       };
+};
+
+&i2c1 {
+       status =3D "okay";
+       multi-master;
+       ipmb1@10 {
+               compatible =3D "ipmb-dev";
+               reg =3D <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+               i2c-protocol;
+       };
+};
+
+&i2c2 {
+       status =3D "okay";
+       multi-master;
+       ipmb2@10 {
+               compatible =3D "ipmb-dev";
+               reg =3D <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+               i2c-protocol;
+       };
+};
+
+&i2c3 {
+       status =3D "okay";
+       multi-master;
+       ipmb3@10 {
+               compatible =3D "ipmb-dev";
+               reg =3D <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+               i2c-protocol;
+       };
+};
+
+&i2c4 {
+       status =3D "okay";
+};
+
+&i2c5 {
+       status =3D "okay";
+};
+
+&i2c6 {
+       status =3D "okay";
+};
+
+&i2c7 {
+       status =3D "okay";
+};
+
+&i2c8 {
+       status =3D "okay";
+       tmp421@1f {
+               compatible =3D "ti,tmp421";
+               reg =3D <0x1f>;
+       };
+       // NIC EEPROM
+       eeprom@50 {
+               compatible =3D "st,24c32";
+               reg =3D <0x50>;
+       };
+};
+
+&i2c9 {
+       status =3D "okay";
+       multi-master;
+       ipmb9@10 {
+               compatible =3D "ipmb-dev";
+               reg =3D <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+               i2c-protocol;
+       };
+};
+
+&i2c10 {
+       status =3D "okay";
+};
+
+&i2c11 {
+       status =3D "okay";
+       eeprom@51 {
+               compatible =3D "atmel,24c128";
+               reg =3D <0x51>;
+       };
+       eeprom@54 {
+               compatible =3D "atmel,24c128";
+               reg =3D <0x54>;
+       };
+};
+
+&i2c12 {
+       status =3D "okay";
+       lm75@4f {
+               compatible =3D "lm75";
+               reg =3D <0x4f>;
+       };
+};
+
+&i2c13 {
+       status =3D "okay";
+};
+
+&adc0 {
+       ref_voltage =3D <2500>;
+       status =3D "okay";
+       pinctrl-0 =3D <&pinctrl_adc0_default &pinctrl_adc1_default
+                       &pinctrl_adc2_default &pinctrl_adc3_default
+                       &pinctrl_adc4_default &pinctrl_adc5_default
+                       &pinctrl_adc6_default &pinctrl_adc7_default>;
+};
+
+&adc1 {
+       ref_voltage =3D <2500>;
+       status =3D "okay";
+       pinctrl-0 =3D <&pinctrl_adc8_default &pinctrl_adc10_default
+                       &pinctrl_adc11_default &pinctrl_adc12_default
+                       &pinctrl_adc13_default &pinctrl_adc14_default>;
+};
+
+
+&ehci0 {
+       status =3D "okay";
+};
+
+&ehci1 {
+       status =3D "okay";
+};
+
+&uhci {
+       status =3D "okay";
+};
+
+&gpio0 {
+       pinctrl-names =3D "default";
+       pinctrl-0 =3D <&pinctrl_gpiu1_default &pinctrl_gpiu7_default>;
+};
+
+
--
2.17.1

WIWYNN PROPRIETARY This email (and any attachments) contains proprietary or=
 confidential information and is for the sole use of its intended recipient=
. Any unauthorized review, use, copying or distribution of this email or th=
e content of this email is strictly prohibited. If you are not the intended=
 recipient, please notify the sender and delete this email immediately.
