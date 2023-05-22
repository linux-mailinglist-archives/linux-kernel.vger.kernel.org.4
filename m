Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E96E70B6ED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbjEVHrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbjEVHqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:46:35 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2052.outbound.protection.outlook.com [40.107.14.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AE3E6E;
        Mon, 22 May 2023 00:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kok0HA2ok9KO6TpUM9a0VhNJDyDE623iKyoRkFItEy8=;
 b=SsJpIz7WmVEtlxMKttpwIk/xHWyKdzKqepgY2d1tjQZ7PSKfX2pHVmjfbE/b1YybsJNWNWZ/C9hj5M9XQK3YGLYc8akyu1gUeagwQu7oE4Nr0UQiKETttU+GORQH5g0x+6wISDO49mycb2tT/pDWdCe1LX2fTM+zO/VWKBfv/Nw3bqd1kTHHTncqNfWnpT8M9BqchstfNnsZuyMkJtO/1VyVlM6cCNyh0vyGk6kyssrqfhIsLnNHU4Bedaou5fsPEk1j+1B6GJ6+FxEz1C8vxsxI3bgKLLozc+3nVYgm8HGsbw2UyxjEOxLjJBKe4z63YLBqR5txPj6DjvaOjdDuAQ==
Received: from FR0P281CA0258.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:b5::10)
 by AS1PR04MB9240.eurprd04.prod.outlook.com (2603:10a6:20b:4c4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 07:45:24 +0000
Received: from VE1EUR01FT061.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:b5:cafe::fe) by FR0P281CA0258.outlook.office365.com
 (2603:10a6:d10:b5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.13 via Frontend
 Transport; Mon, 22 May 2023 07:45:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 VE1EUR01FT061.mail.protection.outlook.com (10.152.3.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.14 via Frontend Transport; Mon, 22 May 2023 07:45:23 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (104.47.17.169) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 22 May 2023 07:45:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbBYoE0GJ12bjMKNSSgXUXPKKQ3vKwhKCDURUbX0KZFgKEeilnrgEicAroS6WW7ORjPGMD2pMiclYZxkuwCbGTuQHqih9iJwYgpjYjhkFSheIeN1vcXiAbJ3eggF5nYRcekceWPLZOu9Dve7GepwHWWztLXQ+CUn7x1uU6+1o6JZUkEw3UXdcdgx+iVVizn+dfIpygIts3PyLAA1k0eZQBCw8zKe6Ta4g8UgkEGzgZva7pC5UO85dRVM1g08E83vxRI9wWTKwMPJEVx4bmYcfY7yTvL6by18FEz/fOISnazaTXZ8cgyziH33Jjx29VQK5sAJAQpjgJ794yWUaORT3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKKU658ScgDBUjH3U4OBrZROwPjqjI9oUKripqflm6A=;
 b=aRS/FKQFw++iDzn1Ix2iAr+GzrX1DayGP+qDK5H9KTvfPMw/nFQrZWunfts5HLp4h61REHizzy8bruqqvdronpEKPqOCcxQwgI/O/1tj/qIDP25sk47EOAMQTcvgIEy7eU25S7trKL+JPbMHRXHP67+p0t/HYm/vlTICSPcSzTNDAhOCcwYJrQ7GfT3hhKofVe3fsFM0oLjyxEVJYLwYWivBg4EJ2AKVeEMzOjiw/o1x/F+xAzch4sadb8zSfAwxUstT2yF95n4CmwCMLCzvPgck1WqLZdhiv7xrd2jXRy28ODIja6YbOMc9ovAlz4EWTG16PVkt6hytrgKsI3DZaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Mon, 22 May
 2023 07:45:17 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696%5]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 07:45:17 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org
CC:     Mike Looijmans <mike.looijmans@topic.nl>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean Delvare <jdelvare@suse.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] usb: misc: usb5807: Add driver
Date:   Mon, 22 May 2023 09:45:10 +0200
Message-ID: <20230522074510.16367-2-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230522074510.16367-1-mike.looijmans@topic.nl>
References: <20230522074510.16367-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.6bd20433-e21f-423b-bdd5-c30faf9d0dc2@emailsignatures365.codetwo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0118.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::23) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|DB9PR04MB9626:EE_|VE1EUR01FT061:EE_|AS1PR04MB9240:EE_
X-MS-Office365-Filtering-Correlation-Id: 95a33614-cc39-44e8-cc1b-08db5a98805a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: yheoEfOpNan8dsM8myXhvCZr/tb8gm5/rU8QCtBtfFBNUxiUlRZA3oJIDuKCYgSInjX4BcMgQrfF6tJEL64FRNskMt2rdfhZJQbKekDW+z+9U1eaVJkE00pCJwnP3aA5JKj6ajb1YERM7ulmUcNsDhB+SwTFtKvRe44SdDd9OJ3G+hvrLdhjYThjd9Z+R7YcAKlO2qm8DdBX5uZ2QcDRx9lNbTwBOVbT1ReWkh2Z/Q1SfZKEdgTgFfM9QQffBj5vshCSf5en9xKrecfNyiY/+yYNwwWUrT21PYqyYxeFXE0YwYKRaw+oWzTRYVDK7hg5tOvUeIjxy/Y71Rgx5Ak/fWBV3jJtMeNdyvoUxIyo+xr1liArxVlKQYVpdPr7nP7RTGdgYWllIXJh8k32jcU3E3QV8vmXOuyLMeeB8FF1YF4pZ3bihEjvLbIfmDr1VsYOtHQJ1gz5ktiO47QL6Fjiau/Uxh5Lmp8k4Zo0cnBcv/ReT3hTaHuWeG7BX9wycMDVe8QiL7yB4QztUHXwEfHdAPDpgAntrKWlhHum3XK0FxwAVOOxg00Nlpi5qQlEqz/oSq2fvuxZ7sx0Wq2xXPBu8BPqJk6rWUh4FWxn84pmUnRSXEcOM16Mn0vw96Kuxpv6
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39840400004)(396003)(346002)(451199021)(83170400001)(38350700002)(38100700002)(36756003)(44832011)(6512007)(6506007)(1076003)(8936002)(8676002)(7416002)(42882007)(2616005)(2906002)(54906003)(478600001)(186003)(316002)(4326008)(26005)(41300700001)(5660300002)(66476007)(6666004)(6486002)(52116002)(66556008)(66946007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9626
X-CodeTwo-MessageID: 386875b0-ec7b-4676-8efe-c3d3960cd23d.20230522074522@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT061.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6ba58456-da13-4cd9-a152-08db5a987c95
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +AvXnndnQ1xcgtUUt/QGnSvx7M7B8OvBt5dDjzYlkd7hkohurebLRAM6rV3sr9M20lc9Sp/aIBLf9QkQJKNyhOEmY9CYWwQE9pIdcbgcaFYiTTmp2++USZzFYO32D6H0cMsEg9nydvlDgKEEgZvsZ88rXnvi1Y2wF/D0peuk1ilTIJNAJI80TfHK0DQMWfkgR6ILIT5NnujjqbG/yRMaPnO+TX+BFEQiT8WfADReZGJoaS4NeR+NosKRM83Lu3a4HJzv6ttV27DxPq3MMqESZ8TgHB8Rda3LOBna/tJptft9hEWF/Bg6b3FIXlvugROdrkz9hlh0xYUpT1tVK9GkSJNxJQC4RlR58KQJRs/IRYq/Tq9L7Q+0hkl6fZ2QGhFWi+U0Lr+XSDFaa8y3zPdwbJs/K2kFvVe8g5Pe/aAAgPo1r7nMrAlrvMPWSTRaJr6pnlH4jMKOG6mXb0t2XxKWK4ESKAF2v9k+3J1uNsmG3jn/jIsgTcAffeakMqZWplnFqKAYPjTESYYhbP921HHuPyig/apGQ34mIAztHy3Cdj1x3l5WF2MfyGkozR1kf4WRs+P8/KaaFJBK5VOQPmd0nigXDFPHGDODX1WyfFpx0gIxrpiBbJ1LsOHcS68/zj3Zwie2N24D8XR32A621rjT5pmspjGqDua4VpNEU14MNclbA+VJEJzX44v6tMOAh4I0arN8EKwneFlwWMKNlz8IIg==
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39840400004)(376002)(451199021)(46966006)(36840700001)(8676002)(8936002)(5660300002)(7416002)(44832011)(36860700001)(82310400005)(47076005)(186003)(26005)(1076003)(6512007)(6506007)(42882007)(83380400001)(336012)(2616005)(7636003)(7596003)(356005)(83170400001)(41300700001)(6666004)(6486002)(40480700001)(15974865002)(70206006)(70586007)(316002)(36756003)(4326008)(478600001)(54906003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 07:45:23.5207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a33614-cc39-44e8-cc1b-08db5a98805a
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT061.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9240
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB5807 is a 7-port USB 3.1 hub that can be configured by I2C.
This drivers resets the chip, optionally allows D+/D- lines to be
swapped in the devicetree config, and then sends an ATTACH command to
put the device in operational mode.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

(no changes since v2)

Changes in v2:
Add regulator support for vddXX supplies

 drivers/usb/misc/Kconfig   |   9 ++
 drivers/usb/misc/Makefile  |   1 +
 drivers/usb/misc/usb5807.c | 184 +++++++++++++++++++++++++++++++++++++
 3 files changed, 194 insertions(+)
 create mode 100644 drivers/usb/misc/usb5807.c

diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index 99b15b77dfd5..6659e917ea26 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -251,6 +251,15 @@ config USB_EZUSB_FX2
 	  Say Y here if you need EZUSB device support.
 	  (Cypress FX/FX2/FX2LP microcontrollers)
=20
+config USB_HUB_USB5807
+	tristate "USB5807 Hub Controller Configuration Driver"
+	depends on I2C
+	help
+	  This option enables support for configuration via SMBus of the
+	  Microchip USB5807 USB 3.1 Hub Controller. Configuration parameters may
+	  be set in devicetree.
+	  Say Y or M here if you need to configure such a device via SMBus.
+
 config USB_HUB_USB251XB
 	tristate "USB251XB Hub Controller Configuration Driver"
 	depends on I2C
diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
index 1992cc284d8a..e827ed251fa5 100644
--- a/drivers/usb/misc/Makefile
+++ b/drivers/usb/misc/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_USB_USS720)		+=3D uss720.o
 obj-$(CONFIG_USB_SEVSEG)		+=3D usbsevseg.o
 obj-$(CONFIG_USB_YUREX)			+=3D yurex.o
 obj-$(CONFIG_USB_HUB_USB251XB)		+=3D usb251xb.o
+obj-$(CONFIG_USB_HUB_USB5807)		+=3D usb5807.o
 obj-$(CONFIG_USB_HSIC_USB3503)		+=3D usb3503.o
 obj-$(CONFIG_USB_HSIC_USB4604)		+=3D usb4604.o
 obj-$(CONFIG_USB_CHAOSKEY)		+=3D chaoskey.o
diff --git a/drivers/usb/misc/usb5807.c b/drivers/usb/misc/usb5807.c
new file mode 100644
index 000000000000..c617f3371fa1
--- /dev/null
+++ b/drivers/usb/misc/usb5807.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Driver for Microchip USB5807 USB 3.1 Hub
+ * Configuration via SMBus.
+ *
+ * Copyright (c) 2023 Topic Embedded Products
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regulator/consumer.h>
+
+#define USB5807_CMD_ATTACH 0xAA55
+#define USB5807_CMD_CONFIG 0x9937
+
+#define USB5807_REG_LANE_SWAP 0x30FA
+
+#define USB5807_NUM_PORTS 7
+
+
+static int usb5807_write(struct i2c_client *i2c, void *buf, u8 len)
+{
+	int ret;
+	struct i2c_msg msg =3D {
+		.addr	=3D i2c->addr,
+		.flags  =3D 0x0,
+		.len	=3D len,
+		.buf	=3D buf,
+	};
+
+	ret =3D i2c_transfer(i2c->adapter, &msg, 1);
+	return ret < 0 ? ret : 0;
+}
+
+/*
+ * Send a command sequence, which is an I2C write transaction, with the co=
mmand
+ * word in big endian and a terminating "0" byte.
+ */
+static int usb5807_command(struct i2c_client *i2c, u16 cmd)
+{
+	u8 buf[3] =3D {cmd >> 8, cmd & 0xff, 0};
+
+	return usb5807_write(i2c, buf, sizeof(buf));
+}
+
+static int usb5807_prepare_reg_u8(struct i2c_client *i2c, u16 reg, u8 valu=
e)
+{
+	u8 buf[] =3D {
+		0x00,
+		0x00,		/* Memory offset */
+		1 + 4,		/* Transaction size */
+		0x00,		/* 0 =3D Register write operation */
+		1,		/* Size of register data */
+		(reg >> 8) & 0xff,
+		reg & 0xff,	/* Register offset */
+		value,		/* Register data */
+		0		/* Terminating zero */
+	};
+
+	return usb5807_write(i2c, buf, sizeof(buf));
+}
+
+/*
+ * Write an 8-bit register. First we must write the "set register" operati=
on to
+ * the chip's internal memory at offset 0, then issue a command to execute=
 said
+ * operation.
+ */
+static int usb5807_write_reg_u8(struct i2c_client *i2c, u16 reg, u8 value)
+{
+	int ret;
+
+	ret =3D usb5807_prepare_reg_u8(i2c, reg, value);
+	if (ret)
+		return ret;
+
+	return usb5807_command(i2c, USB5807_CMD_CONFIG);
+}
+
+/* Decode array of port numbers property into bit mask */
+static u8 usb5807_get_ports_field(struct device *dev, const char *prop_nam=
e)
+{
+	struct property *prop;
+	const __be32 *p;
+	u32 port;
+	u8 result =3D 0;
+
+	of_property_for_each_u32(dev->of_node, prop_name, prop, p, port) {
+		if (port < USB5807_NUM_PORTS)
+			result |=3D BIT(port);
+		else
+			dev_warn(dev, "%s: port %u doesn't exist\n", prop_name,
+				 port);
+	}
+	return result;
+}
+
+static int usb5807_i2c_probe(struct i2c_client *i2c)
+{
+	struct gpio_desc *reset_gpio;
+	int ret;
+	u8 val;
+
+	/* Reset the chip to bring it into configuration mode */
+	reset_gpio =3D devm_gpiod_get_optional(&i2c->dev, "reset",
+					     GPIOD_OUT_HIGH);
+	if (IS_ERR(reset_gpio)) {
+		return dev_err_probe(&i2c->dev, PTR_ERR(reset_gpio),
+				     "Failed to request reset GPIO\n");
+	}
+
+	/* Enable power supplies while chip is held in reset */
+	ret =3D devm_regulator_get_enable(&i2c->dev, "vdd12");
+	if (ret)
+		return ret;
+
+	ret =3D devm_regulator_get_enable(&i2c->dev, "vdd33");
+	if (ret)
+		return ret;
+
+	/* Reset timing: Assert for >=3D 5 us */
+	usleep_range(5, 10);
+
+	/* Lock the bus for >=3D 1ms while the hub reads the I2C strapping */
+	i2c_lock_bus(i2c->adapter, I2C_LOCK_SEGMENT);
+
+	gpiod_set_value_cansleep(reset_gpio, 0);
+	usleep_range(1000, 2000);
+
+	i2c_unlock_bus(i2c->adapter, I2C_LOCK_SEGMENT);
+
+	/* The hub device needs additional time to boot up */
+	msleep(20);
+
+	val =3D usb5807_get_ports_field(&i2c->dev, "swap-dx-lanes");
+	if (val) {
+		ret =3D usb5807_write_reg_u8(i2c, USB5807_REG_LANE_SWAP, val);
+		if (ret < 0)
+			dev_err(&i2c->dev, "Failed writing config: %d\n", ret);
+	}
+
+	/*
+	 * Send the "Attach" command which makes the device disappear from the
+	 * I2C bus and starts USB enumeration.
+	 */
+	ret =3D usb5807_command(i2c, USB5807_CMD_ATTACH);
+	if (ret) {
+		dev_err(&i2c->dev, "Failed sending ATTACH command: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id usb5807_of_match[] =3D {
+	{ .compatible =3D "microchip,usb5807" },
+	{ } /* sentinel */
+};
+MODULE_DEVICE_TABLE(of, usb5807_of_match);
+
+static const struct i2c_device_id usb5807_id[] =3D {
+	{ "usb5807", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(i2c, usb5807_id);
+
+static struct i2c_driver usb5807_i2c_driver =3D {
+	.driver =3D {
+		.name =3D "usb5807",
+		.of_match_table =3D of_match_ptr(usb5807_of_match),
+	},
+	.probe_new =3D usb5807_i2c_probe,
+	.id_table =3D usb5807_id,
+};
+
+module_i2c_driver(usb5807_i2c_driver);
+
+MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
+MODULE_DESCRIPTION("USB5807 USB 3.1 Hub Controller Driver");
+MODULE_LICENSE("GPL");
--=20
2.17.1


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topicproducts.com=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
