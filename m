Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075516FC0AB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 09:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjEIHqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 03:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbjEIHqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 03:46:42 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0607.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::607])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3017DA3;
        Tue,  9 May 2023 00:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlof671XPa6plhd/8pcw2icwMd1BgxnaHE4UK9/4Icw=;
 b=lNf82PSnFK9UR1wUcM/z6z48VykRnfDGn6E1Gz4YZej7to3KG8CMj16DjUUz5qWDXnVvKMdPaxGRAuS50g9AitTQnTO9bX4W4Zu5Pp6q+aOPVkLhuH49bdoQzJUW70TdCC6MoUeEVlY+6SXtR4mVo1hXtg2gLgxeAljWhTSueXr9q76Wncv3c27aWubt5BBL2x0hEZe56asSagCESjl+zQoPkWddC10BEeQk0LgHkMn3L24kTlMr5EgWsebIMDekfaPEXwgzgcAS37cOMkYgp87z0zeWf6UiQuZ+ARyf3RO4TEPSMAxUQPMK/kGWF45f2roEYKanXMn299sv+5+rJg==
Received: from FR0P281CA0063.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:49::11)
 by PA4PR04MB7646.eurprd04.prod.outlook.com (2603:10a6:102:f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 07:46:33 +0000
Received: from VE1EUR01FT077.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:49:cafe::40) by FR0P281CA0063.outlook.office365.com
 (2603:10a6:d10:49::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 07:46:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 20.93.157.195 as permitted sender)
 receiver=protection.outlook.com; client-ip=20.93.157.195;
 helo=westeu11-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 VE1EUR01FT077.mail.protection.outlook.com (10.152.3.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 07:46:33 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (104.47.2.56) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 09 May 2023 07:46:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJat8OLJWoLEY6Dpkqc/LvkOaQJaWFoJruqLMvjWVuK3vgyqdWByflxkU0qSUVpuGp5SfeDUsyg8TXYUcEaD925w/isWDb2NoxajoyWPd/GQzO7h7qvxvy4DXeOPwCDTTBIJnuPxuwZg8XmsbyVlZS/Hq58HPQ7MAUGRhJkyypfoiLK5Ml6Jy1PbckCpZl1P4sBzefi7vInsUXrNmuMFKGYXqmix2/IQYtEHW6eECQbXLw+6o7yaIVjBkmNmUEhERkIZhuIJZblcRWupTD6RnVx3nKXNFWCtE7K5zicRSiV2LoPUp/A4q348Dc9GcwbSK0udreLT9f9681orcj6otg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKlywL/exQRX0ZOdLE4a9Smvf72TMofRBaj+iqm5/uM=;
 b=RN+78jFDpHugznKCxCFAkewIstVUoVy38T20beU1OYH0eJD6QymY6kU2g/ofhQNwZm4F1pH1Pz2ktDC0TyHq2jqGhqlPy8I0/QprIXvs5fUheQMCZ8zR/hzUE3mqKpaFHdb1skJMDlmpuZ5v76/c5skDYeEaIsXC1YZuNrqr5L7Hb0l4UJ7Vp46ERKNhJHaP+Ka8KU+LhFMAeFqBX1C4w3JCz12zte2oZJZb9sZjnqtatEf2SkmXYG3CHyzwWbAcb0QDxPuVTvLP+2QnWizckbUlZcaqO8tPLkARI5RbMupOrqS/5DZZEoxbJK6tigErVAFCRM1bueYsMjwmvDOe2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AM6PR04MB6520.eurprd04.prod.outlook.com (2603:10a6:20b:f7::16)
 by PAXPR04MB8288.eurprd04.prod.outlook.com (2603:10a6:102:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 07:46:28 +0000
Received: from AM6PR04MB6520.eurprd04.prod.outlook.com
 ([fe80::8cf4:9979:4ca8:213c]) by AM6PR04MB6520.eurprd04.prod.outlook.com
 ([fe80::8cf4:9979:4ca8:213c%6]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 07:46:28 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org
CC:     Mike Looijmans <mike.looijmans@topic.nl>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean Delvare <jdelvare@suse.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] usb: misc: usb5807: Add driver
Date:   Tue, 9 May 2023 09:46:21 +0200
Message-ID: <20230509074621.29774-2-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230509074621.29774-1-mike.looijmans@topic.nl>
References: <20230509074621.29774-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.3007118c-795d-4ecd-9a82-6f1b4cd17152@emailsignatures365.codetwo.com>
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0026.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::13) To AM6PR04MB6520.eurprd04.prod.outlook.com
 (2603:10a6:20b:f7::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM6PR04MB6520:EE_|PAXPR04MB8288:EE_|VE1EUR01FT077:EE_|PA4PR04MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: c2775ce2-bef2-477f-386d-08db5061827d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: QDm1QZm6p06X6HEHTtsX7LD03EbxMmNCPIn1nzpto7ByIUr2BDx4nUpbf9e+uL05/hy1e7hgJh5LN36AkAu0jtEIrTvAFMtA90LZeOG0TcIyQR5nSOInkZZt35INKet9buRHOmieyuTOg6yFoR7vtiK1FOtT/Akvj5pDmNP6CpOoIw/M3gljANGaVN3TfC0l9wuv3iYf9TD++Yf2Y7nySVT32kfHoOQIB1Q8NZlpwsm7fwzyEg/nzaA0queXJDTi+0yvy/bDRbJ5EiXUW70Ra8P0DaHDPJ4lwtCheawT48+nkAXvoTbOL7TQRPJ0PJcWjnCL1JA0KxRHXZ16H9/sJNn0bNc+sTjC0Gkq0AgwAAYkF/pnlbyC1a4Aa4zmk6BJHsWA1MyQrIUv7vulG3rFk6PjpHilrbLRhNwdCAyopxAe+5+AbZh25sHrQJ23kt1DA9p5dcy+7AWsy48bx3LivUvJ4vpP9c+5XihQ3ZhG3kaH6iFFRErRZciHJvTixdjWu1i3Hkz3F/WKymq9eXheFgwZeH8lb2HL/jR7A8owwhUD1mMaK3dv/CRwWyfMt3Bu2L2iYOKskgcQtNpaL16dwBjnajtyyQV0YvsdCymNfnbIDHmn0AvX7JmPiCdUYJ5K
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6520.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(346002)(136003)(39840400004)(451199021)(2906002)(316002)(8676002)(8936002)(41300700001)(66476007)(478600001)(5660300002)(4326008)(54906003)(6666004)(66946007)(66556008)(44832011)(52116002)(6486002)(1076003)(6506007)(6512007)(26005)(186003)(83170400001)(36756003)(2616005)(42882007)(83380400001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8288
X-CodeTwo-MessageID: 0e4abc81-9e56-435a-af77-2eed4e4f38ee.20230509074632@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT077.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7aad3543-32c6-415f-acd7-08db50617f6c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J4ec3dqrL8V6Vn4oQCBjzuXVCU99L9SDJYzgCESIblxDgwmgLJ4PIxmlBjeV/fOgH4WUEcg9JsroDk2A6F/TfmMr134OF9cQ7VKPSY2ltNJDwpRkQFOFCfuHdj83X9oyiF04wjSngy7Mhr1HQOrLSF6fJLzMEWYi0umb5tVnVFkKQQaru4M2dHE+qj5exNgdw8NrTr+DRYkl0fLSCQWOV7iBLu2JsLNG0Vy1yHfFURgVMn/qmxmXVsl+zrlt5wwUvpcn6xNRSwjgfm53uzOR4KQU3W0NTs61EBFEzMOQ+wNr3k+HsbiewA38y3Oz1bZI7KxTOKBL4mU/1c6XwOEycu3s2UHvYPUTwV3tb99JEzckNiHc7nup6nEz1Bn8jy+e2yFn69urEmKGVd5S1A5aj5pQae75Ss+1QdvpYOenco/Ghj20ZsYDdEUKgB73p8yx95qpB5zt0sAg2yvSuBWroVp9BjyGV4/SgEhUMIjBDEMVTEhtMC8jcPybQp6H3f2KJVkSRNvnpHSOrcnCK0vwihtStCKmtcGch7Htjz2Xi/xi3dUMSctEy4kpHyWHfHbJkDVHmPQeRkdk0uT8whi5FVqUDHHeLw/wjXzkq6+RHt/g3qklHUO2MGKcD7GIsHMH3JVtI9fkYiONGsvr2ZZwP9SrbqBzarRarGEI3Hx4B8M=
X-Forefront-Antispam-Report: CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39840400004)(346002)(136003)(451199021)(36840700001)(46966006)(356005)(26005)(1076003)(6506007)(6512007)(7636003)(83170400001)(7596003)(70206006)(40480700001)(70586007)(2906002)(44832011)(4326008)(8676002)(316002)(82310400005)(54906003)(15974865002)(41300700001)(8936002)(478600001)(5660300002)(336012)(36860700001)(83380400001)(2616005)(42882007)(6486002)(6666004)(36756003)(47076005)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 07:46:33.2007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2775ce2-bef2-477f-386d-08db5061827d
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT077.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7646
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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

 drivers/usb/misc/Kconfig   |   9 ++
 drivers/usb/misc/Makefile  |   1 +
 drivers/usb/misc/usb5807.c | 175 +++++++++++++++++++++++++++++++++++++
 3 files changed, 185 insertions(+)
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
index 000000000000..04080ca81d4d
--- /dev/null
+++ b/drivers/usb/misc/usb5807.c
@@ -0,0 +1,175 @@
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
+static int usb5807_i2c_probe(struct i2c_client *i2c,
+			     const struct i2c_device_id *id)
+{
+	struct device_node *np =3D i2c->dev.of_node;
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
+	.probe    =3D usb5807_i2c_probe,
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
