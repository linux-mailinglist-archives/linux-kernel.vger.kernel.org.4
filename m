Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669E3702499
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239720AbjEOGZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239320AbjEOGZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:25:32 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2071.outbound.protection.outlook.com [40.107.14.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA7E2690;
        Sun, 14 May 2023 23:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6557tR+hHIlapExyQlMWrJH/UKBc/ErpmbvcWFXP7pE=;
 b=vEpqSxyIpU5Td+/0s0m1dG+KtXiiDgNxiITEG+i+kHElvt2yw5GWBIKVRUyVc3f7lT6Ek4x0qF4FAzYoyuJLqPFwvg8dlJfBRa9G51fRXaAjVV0g2ZG+VEMk+6DFZaCiTaovM49teYwkPreyHMIE5aAcYQv5Jr9hJPap9y1uC8jvlL1oOAXMYLx6Z3l6T3C5gE9dO+5dJqiTO+pNxUV9HnyVrbnulDSdb6MimJDKLw3rPg791TjEAGuBjSdXhKW9G0MjwVLSv/VFmSLmYojYsAk/n5/xsDRNlljRRpBnWEGLTI8ycSxNwPzufcEN09lpCKsLQaVYcPBQ7mzq9zhTQA==
Received: from DB3PR06CA0007.eurprd06.prod.outlook.com (2603:10a6:8:1::20) by
 PAXPR04MB8109.eurprd04.prod.outlook.com (2603:10a6:102:1c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 06:25:15 +0000
Received: from DB5EUR01FT064.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:8:1:cafe::f1) by DB3PR06CA0007.outlook.office365.com
 (2603:10a6:8:1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Mon, 15 May 2023 06:25:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB5EUR01FT064.mail.protection.outlook.com (10.152.5.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.25 via Frontend Transport; Mon, 15 May 2023 06:25:14 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (104.47.51.177) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 15 May 2023 06:25:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0z7jv0fhEmOsjtj75pnKRKJXL1eQ6Iy+CcZFCowu+Ff6yJrz8DfP0z5CIvNSVL9gQlsK2fbZZkOXmVcp77Jmr61AJrcvAq/nkUlW11ONXm7Vyf5LU0ufyrW3DXCviRuedVIxN1hNsfBYobfj2hHuHf6tamgFfGi1YIuMn7Avq5vf6XiBFBeNcXe/jzKDxs7hRhgg9lNy3duUk0+MOO4Y6K8ANdTVbnp8e0lAnS4QY/w28zeHJKJxQebHEJanRbS11m9lX1441h4ySTykHgvRrN1TArrjO40HPCTrwcB1Vtvo4xngWKJuNrbmf8yDy3RCn+3ggNaeGospkUaG3YAmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GfSDL9NVZfDQCs0UoZLxZaJWDM2jvctnXHOTPUYylc=;
 b=KMCVncEvNL4z0mtZU9lTWl2VqmmXK6QV4Vl6GO09pmPHjXNslCXMPJ4wQE/VKxT7xRcuMXlJSd7x7qnkGqgof9pIDv46hwl4rWWK1V4XT4MCVXJPFtRDOU9w/xxghBsM2N3OGEnAmCRq/CrH6nHqL9y0KwIZfTRsJwXQpj+UeO+5p/EuxPUJO3iZnNATtD3trsekuDH1rcgdlBeM5R1j2b0rYZkym8705yOfx7dVuP2Bmnn0joAxhGcW3tAmO4REf/+ViBOn3QEEQdqQjeBVr96u5UWndAI8jKNdyWh7mmVrBhig7fIFNCmCPGyfoqQBPrnJR0N1Aa8RU6kAmOTdRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by AM9PR04MB8795.eurprd04.prod.outlook.com (2603:10a6:20b:40a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 06:25:10 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::f4fa:8429:9de2:41c3]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::f4fa:8429:9de2:41c3%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 06:25:10 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org
CC:     Mike Looijmans <mike.looijmans@topic.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean Delvare <jdelvare@suse.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] usb: misc: usb5807: Add driver
Date:   Mon, 15 May 2023 08:25:02 +0200
Message-ID: <20230515062502.29273-2-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230515062502.29273-1-mike.looijmans@topic.nl>
References: <20230515062502.29273-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.10e3aa89-d7f2-4182-9838-42342e94a83d@emailsignatures365.codetwo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0005.eurprd07.prod.outlook.com
 (2603:10a6:205:1::18) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|AM9PR04MB8795:EE_|DB5EUR01FT064:EE_|PAXPR04MB8109:EE_
X-MS-Office365-Filtering-Correlation-Id: a13a646d-a02b-4352-f0f0-08db550d2524
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: BeQnt/17MtKYiO0c9ZoD5yki7Yx4NU6DhrT68L9fgaR2tUFLqHoDZNq/4wJSTto3TERodAlD2vueyMeNQI+lRp95HEAwuJZQYhYbZ3+lUROIDfRU7A3E+EdLB0kosfYFPzzb5R/cCvZcEpvyreJQ7wKWI2UqmIuifxql5EZNsURUzuIssBerIpLjSm0TUuyVCsgbYlT6UTpzyauWoCDkwdWTRS9ZmZZLD3dBjKguMy8jsuTW46BwvjZ7+9rb6Nna/2d3zJwGREnwxLDk08QkMclnTWlUByFT5zUf3cDCm9Q8D/ULIU0jBPYE79jeqYQ5tvFpD0gbfJLP/xA2zUUZdCX28pURsUo3xUCrYZ6prLdlmOzgXwPdfeTMO9Lsqe4PE+UBcu3MYlb/WKeB6l7ZzZOcKUXPjzak3fgSKTjrSC6GIrsssPbVuqG8+7oPgRK2DsDIdzTOo3wu9sqg5OzJVXTiZ5o8uoq62lIo284DRyTVjyj8Y+lYmwUsWIFplJUT4c7n7DoYOYmUJlzWzorPSE8eLY/krZqKLg/wMOIv9XYIZuL5+K/qw4WGeLQRmkzsSuRCQr+nQXhWeng8Cy/GT3393tWH3wU3iMaT1BvKdzXN+9owigLsVYOE3DMrzItx
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(366004)(39830400003)(451199021)(316002)(4326008)(66946007)(2906002)(5660300002)(44832011)(8936002)(8676002)(66476007)(66556008)(41300700001)(42882007)(54906003)(478600001)(2616005)(52116002)(36756003)(6666004)(6486002)(26005)(6512007)(1076003)(186003)(6506007)(83380400001)(83170400001)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8795
X-CodeTwo-MessageID: 6cd021b1-1d54-4f88-b4ad-e5c65cfeaa9c.20230515062513@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT064.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4d299981-9816-43bd-464a-08db550d2247
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZQt18Zx2Q7gYapKgYgOrdPVGIOREES7e3pxajyAeogTLWyYwpoAtZ5P5OEHpFZaBYtXEKhrwU1CfoIRnHaoElbxwNdi7ddbX8vX+f/KT6Q8nxjCX9f8TFMwKgt2w4ISx13/uEG/ftc0XOxjeRg1pFmhHjhKpwW3gD9oXjTne6okWF16KFB46OaNu43MKAb7316YKIfbTbR78x8kr1yIbYufuVPy6MTA+nFPD5Hp6uWjLIwKYeVQEV6BjIWU0LVmKIHTKXzdseueo41obngB7Kas+NfAxjbxRJI8G7ba7GRB+OpEV6d0Bd3gYzm7jUOvQ5uTAziE1k30fbw1FN7bQBhLvSGtsawfY4aOPxT7p1egq8Np5jqe1Rfw/BBFsSCAi4//P7ZVUSPpSKjRsdhWree3N2EwLl9cSZBA4TuYJuFN72UXZ1Oe6nanXSyzTkYUwU8q1IWcpCEB1OnVy00iDUgBxhWe1dhmdUrKaQWlMuKB11tjM6z/lYyWmZn4IGmvdM1qi3/THsQzP0z6V22ui76mTek80IY5YtwzifHkpu1A/DIDW4UxfRvuPXmDYzbifZirCx0u87BbnvECnRG7aOgIeOGaHtviVLX+mlH3YBb1CzHZNXu3jlJ6DFj4KBNBfiCIjKGkzqK2mzgo0S/0/jVkix7835e8NVhjWu5o5FIjf2x03l2kezaNH1SCBD/1AD/8jwqFLq0p63L4UsBIK2g==
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39830400003)(346002)(396003)(376002)(451199021)(46966006)(36840700001)(83170400001)(54906003)(478600001)(8676002)(8936002)(44832011)(5660300002)(2906002)(15974865002)(36756003)(82310400005)(4326008)(70206006)(70586007)(40480700001)(316002)(7596003)(356005)(7636003)(41300700001)(36860700001)(47076005)(186003)(2616005)(6512007)(6506007)(1076003)(83380400001)(26005)(336012)(42882007)(6486002)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 06:25:14.7139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a13a646d-a02b-4352-f0f0-08db550d2524
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT064.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8109
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
