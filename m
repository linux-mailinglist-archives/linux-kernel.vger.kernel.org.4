Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09C0629295
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 08:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbiKOHht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 02:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbiKOHhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 02:37:42 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140049.outbound.protection.outlook.com [40.107.14.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E476209B1;
        Mon, 14 Nov 2022 23:37:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THAfdgfv9JfEt3ftVbfymylgna8vMkWxriqldG1nwxPlMwXtS35aYSMFV/YfPZFMd44IUOVMnfWuQ8hYuqsC8ia0WOTeZLHL+OQlNR1eK+0j/lmsf5swCdTsegFzS6FAoUYqFa76gG1Z41+U0i7+sDB3xRePCrl455X1c3NWmQ5cWmY/arukcNEvOXa9x6nVkIWsMc3D5wtJmh1n/b5ST8pkMW7hR1UOshN8n+EVoe2Htp0rBVnXtpZPfG55zpVH2q/ILy1OjbvhJszIsbKvGtEO6t++gYfyXYVQTpNKFaJbfRWFAXq7WqbpUyaE0f2pjJCJGJHs+UGo3m/fj60yPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLXFf/8BGPone5aUboXz5O+mbjujruOKb3Pz+GfZalo=;
 b=agzKjai/jg5g7Rmr9P049aFyQYK+5Y5KR6jkD0OyOiJTkqq3J33uwYH6w5EwSkyY7W0KwrjID5bAxvfyG+nPYp+zwmHvmu/kXJ7+Il0i3/wRDl3ScKRlpgpYW6GTGXKsnSVDZeBU322QRigmLpX5y6iJaasDqnikRRyjbhsoPh4k8NgjvZLD5oWcNzFX1KE6tpuXBNdRAlzeHdtnhc2uAAYy7K69T73mroB6E0tpDWiKqP+LVgXhDRaorFIe4TwWdD3dljCzKHAlZ+Xk78ghWRRzrMptAvTYsrWzKATrcWx/vs2KRJGrT0Oz7+087iv4R5wQD2EhhnDfXzhuGH9a8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLXFf/8BGPone5aUboXz5O+mbjujruOKb3Pz+GfZalo=;
 b=IUpCB59O/8cAaS9X2PTp+k1h9HMiXzGgFKDfFd9Y3UCNl+yh9PAXP9GTGGw4ez9pUcHwie0AgWIORVyklurBcQrp8ma0szf5I6OEoALYtIEGSbZiw15/E1EHuc5rySbjYM/tkdGaHzLs7XKrDAyQ+9+OwDVoE0GcFMgfDihGvYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com (2603:10a6:803:100::13)
 by AS2PR08MB9572.eurprd08.prod.outlook.com (2603:10a6:20b:608::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.7; Tue, 15 Nov
 2022 07:37:37 +0000
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454]) by VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454%6]) with mapi id 15.20.5834.006; Tue, 15 Nov 2022
 07:37:37 +0000
From:   Gerald Loacker <gerald.loacker@wolfvision.net>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Jakob Hauser <jahau@rocketmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Gerald Loacker <gerald.loacker@wolfvision.net>
Subject: [PATCH 2/2] iio: magnetometer: add ti tmag5273 driver
Date:   Tue, 15 Nov 2022 08:37:18 +0100
Message-Id: <20221115073718.2377311-3-gerald.loacker@wolfvision.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221115073718.2377311-1-gerald.loacker@wolfvision.net>
References: <20221115073718.2377311-1-gerald.loacker@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR08CA0017.eurprd08.prod.outlook.com
 (2603:10a6:803:104::30) To VI1PR08MB4544.eurprd08.prod.outlook.com
 (2603:10a6:803:100::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB4544:EE_|AS2PR08MB9572:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f67ba72-dd1f-45d5-c622-08dac6dc44a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zxlrSQqcdSN7WhY9pHgBuJiCyonARLedAG1gumayZWZMKlpahPCedRQEQniLp3OBOsc24K94+a92PFV4Xbl8dwYJiZfbldSOA3LZoInTUlu/CAFhVS39Jj40kw5qK3ucgZfhlLt2xD2Qgza7p+CaKyvdisKb/wXUwGT4AU8huzPtm6iW38o4On+idi70rElCU31M3N9c8LpIUIKx9m/dPeAvjIsQXCjhZzGQe+mZwGlOtKaFO6EYqwaeE83t1z7Pvsa8vtK8aXlwiR9KffmdF3ow2cQx1G4mdJZXg1EZI4APQ4GPcMAKsanD1tR0uFP52ooajOG9cOCJRQHSik4HSy2YLdsWp2UGAd16TFWPscTwLiwXUzzrQRLWFnssYfd1xmIe40VEXKwS1hsOqONpf51sXXkQ2wCmEi1orsZxfocjRcmC6HEVp1C+ybdnSfJ01oKXebBHMcYyv1O09IioZ7Hsrs2uwhLQ64txlXUgkgBKRRnvZyT7k4yw71rB0DgPqyrZuHFWm9+tzZhwLU5QgTNn1tiYNV3jp7WxXzJziktNa4eSA5uFu9y36LiAHTc5gE3qiv/GiJg8P/TOnKhxTwW2frCRNC4jEOBa3P7cp4H7dLBc5stfEPuaIuaT+lMiOjh15t7NHfN4YNomAIaz53j+uOf+I20ENWGrJeduUHDDCFE9ZwZNGN0LlOIqEzb6ovLixCIUm52/t0sAUJ51eyAPwy3+6fXEAn9Ym46wnjj5EHncBw8Z1AJu6s0QLdQrRxG8VdnYpagQZp1H6BUoOrDxi7nw3y8Q844fH9J8Ob8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB4544.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(346002)(39850400004)(376002)(451199015)(186003)(107886003)(86362001)(41300700001)(2616005)(26005)(83380400001)(6512007)(6666004)(6506007)(38100700002)(4326008)(8676002)(1076003)(54906003)(38350700002)(66556008)(66476007)(2906002)(5660300002)(36756003)(66946007)(966005)(6486002)(7416002)(316002)(8936002)(52116002)(478600001)(44832011)(30864003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qmbXmq23Zayk0YcZLoUD2fMCa2rFzOokv9TaqR5CRJm1OGGyo1UyOicCab3x?=
 =?us-ascii?Q?hhLycs4lLlGIEiZmEDeVeCF/GwbyQiDI7RWep7WkDgL/UNaJ6vJLE0wwekmW?=
 =?us-ascii?Q?HzRu1pYKw3Xf/hzwKSlFrPfDn+zViiCTLgAmXGRkcrNTKVJHSTA0Qb5IFWnq?=
 =?us-ascii?Q?i9CDZ96zyunvFJLIN+FZkxmUcq68p/Hn1gtACrnDfB1VoGn9xPVlCKRKEkFS?=
 =?us-ascii?Q?qDokXAZCgSOfy44NKrU7VlV/IeA3Tq6yXIPYLCnus3GeKb0B/fEvQGFXelzN?=
 =?us-ascii?Q?RpyPdofACJjq0c3CNFBme1knLefRBUaa3J2ATXJ3TRzsCM2z3y4cQCoCYUU2?=
 =?us-ascii?Q?WGU/scTv2FrVfM4ImoAFczEwfv+bEtZwuknSuOJPXfZoB5+zLNywYZDNFZMT?=
 =?us-ascii?Q?m5PTcdLvwZlzs8UuaYi1NBdU0lEjSj2HzWUshCvHdkGemgkXk4TbuuL58QDu?=
 =?us-ascii?Q?af5BomPJg+OWXRg+zlBpRI/xn3Q1yBoUjQ5iTHgSAuTqMPZCtGyZUvt0cFGr?=
 =?us-ascii?Q?8YHuolGEo2WyJV3Nj6EytW25FdyprAJVHYsKmtCvsqj9B73ejg/xhzbHlELk?=
 =?us-ascii?Q?K6oHZU0xW/bg7q+nTrLSGyycIjs8cYcxUX8VhcxGxyQwqyA/QdX7OI2Iw8ya?=
 =?us-ascii?Q?XppoZ0BVmcr1ER6bqk0BHU/K7agJeSbqz3GwP51ExfMidxlN2T0AKbTzdYVb?=
 =?us-ascii?Q?9b4EbKHU/BMdDnivpsPFKQjn+Rddcw4tklsPlbLCLFW3Z0dr6U0OFCIaAMw+?=
 =?us-ascii?Q?e3GvsKTjNbAbFnWLPWxCZwN7NKn5O2BRMcxR/mgDgufoijsQel+w80wemb85?=
 =?us-ascii?Q?gO5JkXaeoSsfOBIDPhvoLQ1LbqgI02yncPbaCfK1fQKQCxLUV10fU+0m6uzh?=
 =?us-ascii?Q?d7gmjSZFeit2qBw3KAtKKoKxMD3okEKOxDVdjXi/u5jiwnXDom8Y0WEb6J3A?=
 =?us-ascii?Q?ycaZIFA8nKsLjfW9BulnqNREyV+uTQZJ5fTciauZYtwu52KjpSnm6oFYzixS?=
 =?us-ascii?Q?dhFfQg09MplH2IHN/uxW7S6fmpGiTHF3z31hEd5sBU4LtNpKNSo/Uas0H9pD?=
 =?us-ascii?Q?NZNaVMXM4cSbgZrpkXsNKu51h0qge52vCIZFFu6vLMREc9uHC2YRKlqvADPv?=
 =?us-ascii?Q?PGi6zLpthIZhv8cCDFyfcf5UDDfawLLBDfuDvTIRNtFDO9Xj+ZEs18VtSE8j?=
 =?us-ascii?Q?+SKgGUXYkEPcbDAy8rEmoeAMDAEXWd0bPoU9n8PWQIFPgIyYEcU++PwIyiWf?=
 =?us-ascii?Q?TIFSY2UcjNq83CJSxotyqfWTePkU3NlmgcatrBY5cQgdNwVD8ehTJ+UnclyN?=
 =?us-ascii?Q?cAsrpqlWZP//GbJ4R0bdktSzdx3pyuehL0QSrrJ6ezPh6ARZWbThJBS0imDd?=
 =?us-ascii?Q?Rs/WAm/eTDSiIGP7bW0YcEVowYgFzrE0btnysHJ0jllqKnuNDYrTBAoS5+xy?=
 =?us-ascii?Q?xjPhEV5zaibUzVFiC0o2d8l5hJ1GmE4I6boUacMcumpz1X4BJZ6oOiguyfu9?=
 =?us-ascii?Q?WdraCLyMF4R3m6iNOzU6GahKc76/QSM2GsAIjEbkFTzZxdK9OQuOGab2QzqP?=
 =?us-ascii?Q?rMQyPWTUNs45T1NZMwnnqso9bVCYVxnSK24nSp2hjvrme4cl6OjgQEjRMAx0?=
 =?us-ascii?Q?eA=3D=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f67ba72-dd1f-45d5-c622-08dac6dc44a5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB4544.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 07:37:37.4572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2lpKjZVRfemm8BzxL3PhxiRifwGewVwY+KBicnw4t/S5pLSma3P00zb10Rm4rP3Ku/Et8yaEUDVBIAYt0Kr+sdizurxzcBj/tj4lNp+y29c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9572
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for TI TMAG5273 Low-Power Linear 3D Hall-Effect Sensor.
Additionally to temperature and magnetic X, Y and Z-axes the angle and
magnitude are reported.
The sensor is operating in continuous measurement mode and changes to sleep
mode if not used for 5 seconds.

Datasheet: https://www.ti.com/lit/gpn/tmag5273

Signed-off-by: Gerald Loacker <gerald.loacker@wolfvision.net>
---
 MAINTAINERS                         |   1 +
 drivers/iio/magnetometer/Kconfig    |  12 +
 drivers/iio/magnetometer/Makefile   |   2 +
 drivers/iio/magnetometer/tmag5273.c | 809 ++++++++++++++++++++++++++++
 4 files changed, 824 insertions(+)
 create mode 100644 drivers/iio/magnetometer/tmag5273.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ea7acec52f8b..9d20b5780051 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20618,6 +20618,7 @@ M:	Gerald Loacker <gerald.loacker@wolfvision.net>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml
+F:	drivers/iio/magnetometer/tmag5273.c
 
 TI TRF7970A NFC DRIVER
 M:	Mark Greer <mgreer@animalcreek.com>
diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index b91fc5e6a26e..467819335588 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -208,6 +208,18 @@ config SENSORS_RM3100_SPI
 	  To compile this driver as a module, choose M here: the module
 	  will be called rm3100-spi.
 
+config TI_TMAG5273
+	tristate "TI TMAG5273 Low-Power Linear 3D Hall-Effect Sensor"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say Y here to add support for the TI TMAG5273 Low-Power
+	  Linear 3D Hall-Effect Sensor.
+
+	  This driver can also be compiled as a module.
+	  To compile this driver as a module, choose M here: the module
+	  will be called tmag5273.
+
 config YAMAHA_YAS530
 	tristate "Yamaha YAS530 family of 3-Axis Magnetometers (I2C)"
 	depends on I2C
diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
index b9f45b7fafc3..b1c784ea71c8 100644
--- a/drivers/iio/magnetometer/Makefile
+++ b/drivers/iio/magnetometer/Makefile
@@ -29,4 +29,6 @@ obj-$(CONFIG_SENSORS_RM3100)		+= rm3100-core.o
 obj-$(CONFIG_SENSORS_RM3100_I2C)	+= rm3100-i2c.o
 obj-$(CONFIG_SENSORS_RM3100_SPI)	+= rm3100-spi.o
 
+obj-$(CONFIG_TI_TMAG5273)		+= tmag5273.o
+
 obj-$(CONFIG_YAMAHA_YAS530)		+= yamaha-yas530.o
diff --git a/drivers/iio/magnetometer/tmag5273.c b/drivers/iio/magnetometer/tmag5273.c
new file mode 100644
index 000000000000..549ed1ddba61
--- /dev/null
+++ b/drivers/iio/magnetometer/tmag5273.c
@@ -0,0 +1,809 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for the TI TMAG5273 Low-Power Linear 3D Hall-Effect Sensor
+ *
+ * Copyright (C) 2022 WolfVision GmbH
+ *
+ * Author: Gerald Loacker <gerald.loacker@wolfvision.net>
+ */
+
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/pm_runtime.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#include <asm/unaligned.h>
+
+#define TMAG5273_DEVICE_CONFIG_1	 0x00
+#define TMAG5273_DEVICE_CONFIG_2	 0x01
+#define TMAG5273_SENSOR_CONFIG_1	 0x02
+#define TMAG5273_SENSOR_CONFIG_2	 0x03
+#define TMAG5273_X_THR_CONFIG		 0x04
+#define TMAG5273_Y_THR_CONFIG		 0x05
+#define TMAG5273_Z_THR_CONFIG		 0x06
+#define TMAG5273_T_CONFIG		 0x07
+#define TMAG5273_INT_CONFIG_1		 0x08
+#define TMAG5273_MAG_GAIN_CONFIG	 0x09
+#define TMAG5273_MAG_OFFSET_CONFIG_1	 0x0A
+#define TMAG5273_MAG_OFFSET_CONFIG_2	 0x0B
+#define TMAG5273_I2C_ADDRESS		 0x0C
+#define TMAG5273_DEVICE_ID		 0x0D
+#define TMAG5273_MANUFACTURER_ID_LSB	 0x0E
+#define TMAG5273_MANUFACTURER_ID_MSB	 0x0F
+#define TMAG5273_T_MSB_RESULT		 0x10
+#define TMAG5273_T_LSB_RESULT		 0x11
+#define TMAG5273_X_MSB_RESULT		 0x12
+#define TMAG5273_X_LSB_RESULT		 0x13
+#define TMAG5273_Y_MSB_RESULT		 0x14
+#define TMAG5273_Y_LSB_RESULT		 0x15
+#define TMAG5273_Z_MSB_RESULT		 0x16
+#define TMAG5273_Z_LSB_RESULT		 0x17
+#define TMAG5273_CONV_STATUS		 0x18
+#define TMAG5273_ANGLE_RESULT_MSB	 0x19
+#define TMAG5273_ANGLE_RESULT_LSB	 0x1A
+#define TMAG5273_MAGNITUDE_RESULT	 0x1B
+#define TMAG5273_DEVICE_STATUS		 0x1C
+
+#define TMAG5273_MANUFACTURER_ID	 0x5449
+
+#define TMAG5273_AUTOSLEEP_DELAY	 5000
+
+/* Bits in the TMAG5273_DEVICE_CONFIG_1 register */
+#define TMAG5273_AVG_MODE_MASK		 GENMASK(4, 2)
+#define TMAG5273_AVG_1_MODE		 FIELD_PREP(TMAG5273_AVG_MODE_MASK, 0)
+#define TMAG5273_AVG_2_MODE		 FIELD_PREP(TMAG5273_AVG_MODE_MASK, 1)
+#define TMAG5273_AVG_4_MODE		 FIELD_PREP(TMAG5273_AVG_MODE_MASK, 2)
+#define TMAG5273_AVG_8_MODE		 FIELD_PREP(TMAG5273_AVG_MODE_MASK, 3)
+#define TMAG5273_AVG_16_MODE		 FIELD_PREP(TMAG5273_AVG_MODE_MASK, 4)
+#define TMAG5273_AVG_32_MODE		 FIELD_PREP(TMAG5273_AVG_MODE_MASK, 5)
+
+/* bits in the TMAG5273_DEVICE_CONFIG_2 register */
+#define TMAG5273_OP_MODE_MASK		 GENMASK(1, 0)
+#define TMAG5273_OP_MODE_STANDBY	 FIELD_PREP(TMAG5273_OP_MODE_MASK, 0)
+#define TMAG5273_OP_MODE_SLEEP		 FIELD_PREP(TMAG5273_OP_MODE_MASK, 1)
+#define TMAG5273_OP_MODE_CONT		 FIELD_PREP(TMAG5273_OP_MODE_MASK, 2)
+#define TMAG5273_OP_MODE_WAKEUP		 FIELD_PREP(TMAG5273_OP_MODE_MASK, 3)
+
+/* bits in the TMAG5273_SENSOR_CONFIG_1 register */
+#define TMAG5273_MAG_CH_EN_MASK		 GENMASK(7, 4)
+#define TMAG5273_MAG_CH_EN_X_Y_Z	 0x07
+
+/* bits in the TMAG5273_SENSOR_CONFIG_2 register */
+#define TMAG5273_Z_RANGE_MASK		 BIT(0)
+#define TMAG5273_X_Y_RANGE_MASK		 BIT(1)
+#define TMAG5273_ANGLE_EN_MASK		 GENMASK(3, 2)
+#define TMAG5273_ANGLE_EN_X_Y		 1
+#define TMAG5273_ANGLE_EN_Y_Z		 2
+#define TMAG5273_ANGLE_EN_X_Z		 3
+
+/* bits in the TMAG5273_T_CONFIG register */
+#define TMAG5273_T_CH_EN		 BIT(0)
+
+/* bits in the TMAG5273_DEVICE_ID register */
+#define TMAG5273_VERSION_MASK		 GENMASK(1, 0)
+
+/* bits in the TMAG5273_CONV_STATUS register */
+#define TMAG5273_CONV_STATUS_COMPLETE	 BIT(0)
+
+/* state container for the TMAG5273 driver */
+struct tmag5273_data {
+	struct device *dev;
+	unsigned int devid;
+	unsigned int version;
+	char name[16];
+	int conv_avg;
+	int max_avg;
+	int range;
+	u32 angle_en;
+	struct regmap *map;
+	struct regulator *vcc;
+	/* Locks the sensor for exclusive use during a measurement (which
+	 * involves several register transactions so the regmap lock is not
+	 * enough) so that measurements get serialized in a first-come-first-
+	 * serve manner.
+	 */
+	struct mutex lock;
+};
+
+static const struct {
+	int avg;
+	u8 reg_val;
+} tmag5273_avg_table[] = {
+	{ 1, 0x00 }, { 2, 0x01 },  { 4, 0x02 },
+	{ 8, 0x03 }, { 16, 0x04 }, { 32, 0x05 },
+};
+
+/*
+ * magnetic range in mT for different TMAG5273 versions
+ * only version 1 and 2 are valid, version 0 and 3 are reserved
+ */
+static const struct {
+	int range;
+	u8 reg_val;
+} tmag5273_range_table[4][2] = {
+	{ { 0, 0 }, { 0, 3 } },
+	{ { 40, 0 }, { 80, 3 } },
+	{ { 133, 0 }, { 266, 3 } },
+	{ { 0, 0 }, { 0, 3 } },
+};
+
+/*
+ * tmag5273_measure() - Make a measure from the hardware
+ * @tmag5273: The device state
+ * @t: the processed temperature measurement
+ * @x: the raw x axis measurement
+ * @y: the raw x axis measurement
+ * @z: the raw x axis measurement
+ * @angle: the calculated angle
+ * @magnitude: the calculated magnitude
+ * @return: 0 on success or error code
+ */
+static int tmag5273_measure(struct tmag5273_data *data, u16 *t, u16 *x, u16 *y,
+			    u16 *z, u16 *angle, u16 *magnitude)
+{
+	unsigned int status;
+	u8 reg_data[12];
+	int ret;
+	u16 val;
+
+	mutex_lock(&data->lock);
+	ret = regmap_read(data->map, TMAG5273_CONV_STATUS, &status);
+	if (ret < 0)
+		goto out_unlock;
+
+	/*
+	 * Conversion time is 2425 us in 32x averaging mode for all three
+	 * channels. Since we are in continuous measurement mode, a measurement
+	 * may already be there, so poll for completed measurement with
+	 * timeout.
+	 */
+	ret = regmap_read_poll_timeout(data->map, TMAG5273_CONV_STATUS, status,
+				       status & TMAG5273_CONV_STATUS_COMPLETE,
+				       100, 10000);
+	if (ret) {
+		dev_err_probe(data->dev, ret, "timeout waiting for measurement\n");
+		goto out_unlock;
+	}
+
+	ret = regmap_bulk_read(data->map, TMAG5273_T_MSB_RESULT, reg_data,
+			       sizeof(reg_data));
+	if (ret)
+		goto out_unlock;
+
+	ret = regmap_read(data->map, TMAG5273_CONV_STATUS, &status);
+	if (ret < 0)
+		goto out_unlock;
+
+	mutex_unlock(&data->lock);
+
+	*t = get_unaligned_be16(&reg_data[0]);
+	*x = get_unaligned_be16(&reg_data[2]);
+	*y = get_unaligned_be16(&reg_data[4]);
+	*z = get_unaligned_be16(&reg_data[6]);
+	/*
+	 * angle has 9 bits integer value and 4 bits fractional part
+	 * 15 14 13 12 11 10 9  8  7  6  5  4  3  2  1  0
+	 * 0  0  0  a  a  a  a  a  a  a  a  a  f  f  f  f
+	 */
+	val = get_unaligned_be16(&reg_data[9]);
+	*angle = FIELD_GET(GENMASK(12, 0), val);
+	*magnitude = reg_data[11];
+	return ret;
+
+out_unlock:
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
+/*
+ * tmag5273_get_measure() - Measure a sample of all axis and process
+ * @tmag5273: The device state
+ * @to: Temperature out
+ * @xo: X axis out
+ * @yo: Y axis out
+ * @zo: Z axis out
+ * @ao: Angle out
+ * @mo: Magnitude out
+ * @return: 0 on success or error code
+ */
+static int tmag5273_get_measure(struct tmag5273_data *data, s32 *to, s32 *xo,
+				s32 *yo, s32 *zo, u16 *ao, u16 *mo)
+{
+	u16 t, x, y, z, angle, magnitude;
+	int ret;
+
+	ret = tmag5273_measure(data, &t, &x, &y, &z, &angle, &magnitude);
+	if (ret)
+		return ret;
+
+	/*
+	 * convert device specific value to millicelsius
+	 * use multiply by 16639 and divide by 10000 to achieve divide by 60.1
+	 *   and convert to millicelsius
+	 */
+	*to = (((s32)t - 17508) * 16639) / 1000 + 25000;
+	*xo = (s16)x;
+	*yo = (s16)y;
+	*zo = (s16)z;
+	*ao = angle;
+	*mo = magnitude;
+	return 0;
+}
+
+static int tmag5273_read_raw(struct iio_dev *indio_dev,
+			     const struct iio_chan_spec *chan, int *val,
+			     int *val2, long mask)
+{
+	struct tmag5273_data *data = iio_priv(indio_dev);
+	s32 t, x, y, z;
+	u16 angle, magnitude;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+	case IIO_CHAN_INFO_RAW:
+		ret = pm_runtime_resume_and_get(data->dev);
+		if (ret < 0)
+			return ret;
+		ret = tmag5273_get_measure(data, &t, &x, &y, &z, &angle,
+					   &magnitude);
+		if (ret)
+			return ret;
+		pm_runtime_mark_last_busy(data->dev);
+		pm_runtime_put_autosuspend(data->dev);
+		switch (chan->scan_index) {
+		case 0:
+			*val = t;
+			break;
+		case 1:
+			*val = x;
+			break;
+		case 2:
+			*val = y;
+			break;
+		case 3:
+			*val = z;
+			break;
+		case 4:
+			*val = angle;
+			break;
+		case 5:
+			*val = magnitude;
+			break;
+		default:
+			return dev_err_probe(data->dev, -EINVAL, "unknown channel\n");
+		}
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_TEMP:
+			/* 1 LSB = 1 millidegree Celsius */
+			*val = 1;
+			return IIO_VAL_INT;
+		case IIO_MAGN:
+			/*
+			 * The axis values are in stored in 2^15 / range LSB/mT.
+			 * Since 1 mT = 10 Gauss, we need to multiply by 10 and
+			 * divide by [range] to get Gauss from the raw value.
+			 */
+			*val = data->range * 10;
+			*val2 = 32768;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_ANGL:
+			/*
+			 * Angle is in degrees and has four fractional bits,
+			 * therefore use 1/16 * pi/180 to convert to radiants.
+			 */
+			*val = 1000;
+			*val2 = 916732;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_DISTANCE:
+			/* Magnitude is unscaled */
+			*val = 1;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	default:
+		/* Unknown request */
+		return -EINVAL;
+	}
+}
+
+static ssize_t tmag5273_show_conv_avg(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct tmag5273_data *data = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", data->conv_avg);
+}
+
+static ssize_t tmag5273_write_conv_avg(struct tmag5273_data *data,
+				       unsigned int val)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tmag5273_avg_table); i++) {
+		if (tmag5273_avg_table[i].avg == val)
+			break;
+	}
+
+	if (i == ARRAY_SIZE(tmag5273_avg_table))
+		return -EINVAL;
+
+	ret = regmap_update_bits(data->map, TMAG5273_DEVICE_CONFIG_1,
+				 TMAG5273_AVG_MODE_MASK,
+				 tmag5273_avg_table[i].reg_val);
+	if (ret)
+		return ret;
+
+	data->conv_avg = val;
+
+	return 0;
+}
+
+static ssize_t tmag5273_store_conv_avg(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct tmag5273_data *data = iio_priv(indio_dev);
+	int ret;
+	int integer;
+
+	ret = kstrtoint(buf, 0, &integer);
+	if (ret)
+		return ret;
+
+	ret = tmag5273_write_conv_avg(data, integer);
+	if (ret < 0)
+		return ret;
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR(conv_avg, 0644, tmag5273_show_conv_avg,
+		       tmag5273_store_conv_avg, 0);
+
+static ssize_t tmag5273_conv_avg_available(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct tmag5273_data *data = iio_priv(indio_dev);
+	ssize_t len = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tmag5273_avg_table); i++) {
+		if (tmag5273_avg_table[i].avg > data->max_avg)
+			break;
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
+				 tmag5273_avg_table[i].avg);
+	}
+	/* replace last space with a newline */
+	if (len > 0)
+		buf[len - 1] = '\n';
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR(conv_avg_available, 0444, tmag5273_conv_avg_available,
+		       NULL, 0);
+
+static ssize_t tmag5273_show_range(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct tmag5273_data *data = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", data->range);
+}
+
+static ssize_t tmag5273_write_range(struct tmag5273_data *data,
+				    unsigned int val)
+{
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(tmag5273_range_table[0]); i++) {
+		if (tmag5273_range_table[data->version][i].range == val)
+			break;
+	}
+
+	if (i == ARRAY_SIZE(tmag5273_range_table[0]))
+		return -EINVAL;
+
+	ret = regmap_update_bits(data->map,
+				 TMAG5273_SENSOR_CONFIG_2,
+				 TMAG5273_Z_RANGE_MASK | TMAG5273_X_Y_RANGE_MASK,
+				 tmag5273_range_table[data->version][i].reg_val);
+	if (ret)
+		return ret;
+
+	data->range = val;
+
+	return 0;
+}
+
+static ssize_t tmag5273_store_range(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct tmag5273_data *data = iio_priv(indio_dev);
+	int range, ret;
+
+	ret = kstrtoint(buf, 0, &range);
+	if (ret)
+		return ret;
+
+	ret = tmag5273_write_range(data, range);
+	if (ret < 0)
+		return ret;
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR(range, 0644, tmag5273_show_range,
+		       tmag5273_store_range, 0);
+
+static ssize_t tmag5273_range_available(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct tmag5273_data *data = iio_priv(indio_dev);
+	ssize_t len = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tmag5273_range_table[0]); i++) {
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
+				 tmag5273_range_table[data->version][i].range);
+	}
+	/* replace last space with a newline */
+	if (len > 0)
+		buf[len - 1] = '\n';
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR(range_available, 0444, tmag5273_range_available, NULL,
+		       0);
+
+static struct attribute *tmag5273_attributes[] = {
+	&iio_dev_attr_conv_avg.dev_attr.attr,
+	&iio_dev_attr_conv_avg_available.dev_attr.attr,
+	&iio_dev_attr_range.dev_attr.attr,
+	&iio_dev_attr_range_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group tmag5273_attrs_group = {
+	.attrs = tmag5273_attributes,
+};
+
+#define TMAG5273_AXIS_CHANNEL(axis, index)                         \
+	{                                                          \
+		.type = IIO_MAGN,				   \
+		.modified = 1,					   \
+		.channel2 = IIO_MOD_##axis,                        \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |     \
+				      BIT(IIO_CHAN_INFO_SCALE),    \
+		.scan_index = index,                               \
+		.scan_type = {                                     \
+			.sign = 's',                               \
+			.realbits = 32,                            \
+			.storagebits = 32,                         \
+			.endianness = IIO_CPU,                     \
+		},                                                 \
+	}
+
+static const struct iio_chan_spec tmag5273_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
+	},
+	TMAG5273_AXIS_CHANNEL(X, 1),
+	TMAG5273_AXIS_CHANNEL(Y, 2),
+	TMAG5273_AXIS_CHANNEL(Z, 3),
+	{
+		.type = IIO_ANGL,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = 4,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
+	},
+	{
+		.type = IIO_DISTANCE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.scan_index = 5,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(6),
+};
+
+static const struct iio_info tmag5273_info = {
+	.attrs = &tmag5273_attrs_group,
+	.read_raw = &tmag5273_read_raw,
+};
+
+static bool tmag5273_volatile_reg(struct device *dev, unsigned int reg)
+{
+	return (reg >= TMAG5273_T_MSB_RESULT &&
+		reg <= TMAG5273_MAGNITUDE_RESULT);
+}
+
+static const struct regmap_config tmag5273_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0xff,
+	.volatile_reg = tmag5273_volatile_reg,
+};
+
+static int tmag5273_set_operating_mode(struct tmag5273_data *data,
+				       unsigned int val)
+{
+	return regmap_write(data->map, TMAG5273_DEVICE_CONFIG_2, val);
+}
+
+static int tmag5273_chip_init(struct tmag5273_data *data)
+{
+	int ret;
+
+	ret = regmap_write(data->map, TMAG5273_DEVICE_CONFIG_1,
+			   TMAG5273_AVG_32_MODE);
+	if (ret)
+		return ret;
+	data->conv_avg = 32;
+	ret = regmap_write(data->map, TMAG5273_DEVICE_CONFIG_2,
+			   TMAG5273_OP_MODE_CONT);
+	if (ret)
+		return ret;
+	ret = regmap_write(data->map, TMAG5273_SENSOR_CONFIG_1,
+			   FIELD_PREP(TMAG5273_MAG_CH_EN_MASK,
+				      TMAG5273_MAG_CH_EN_X_Y_Z));
+	if (ret)
+		return ret;
+	ret = regmap_write(data->map, TMAG5273_SENSOR_CONFIG_2,
+			   FIELD_PREP(TMAG5273_ANGLE_EN_MASK, data->angle_en));
+	if (ret)
+		return ret;
+
+	data->range = tmag5273_range_table[data->version][0].range;
+	return regmap_write(data->map, TMAG5273_T_CONFIG, TMAG5273_T_CH_EN);
+}
+
+static int tmag5273_probe(struct i2c_client *i2c,
+			  const struct i2c_device_id *id)
+{
+	struct iio_dev *indio_dev;
+	struct device *dev = &i2c->dev;
+	struct device_node *node = dev->of_node;
+	struct tmag5273_data *data;
+	int val, ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(i2c, indio_dev);
+	data->dev = dev;
+	mutex_init(&data->lock);
+
+	data->vcc = devm_regulator_get(dev, "vcc");
+	if (IS_ERR(data->vcc))
+		return dev_err_probe(dev, PTR_ERR(data->vcc),
+				     "failed to get VCC regulator\n");
+
+	/* Operating voltage 1.7V .. 3.6V according to datasheet */
+	ret = regulator_set_voltage(data->vcc, 1700000, 3600000);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to set VCC voltage\n");
+
+	ret = regulator_enable(data->vcc);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to enable VCC regulator\n");
+
+	/*
+	 * Regulators have to ramp up with 3V/ms, additional time to go to
+	 * stand-by mode is 270us typically. We give 1 ms to 2 ms time.
+	 */
+	usleep_range(1000, 2000);
+
+	data->map = devm_regmap_init_i2c(i2c, &tmag5273_regmap_config);
+	if (IS_ERR(data->map)) {
+		ret = PTR_ERR(data->map);
+		dev_err_probe(dev, ret, "failed to allocate register map\n");
+		goto out_disable_vcc;
+	}
+
+	ret = regmap_read(data->map, TMAG5273_DEVICE_ID, &val);
+	if (ret) {
+		/*
+		 * If we come from sleep with power already activated, the
+		 * first I2C command wakes up the chip but will fail.
+		 * Time to go to stand-by mode from sleep mode is 50us
+		 * typically. During this time no I2C access is possible.
+		 */
+		usleep_range(80, 200);
+
+		ret = regmap_read(data->map, TMAG5273_DEVICE_ID, &val);
+		if (ret)
+			goto out_disable_vcc;
+	}
+	data->version = FIELD_PREP(TMAG5273_VERSION_MASK, val);
+
+	ret = regmap_bulk_read(data->map, TMAG5273_MANUFACTURER_ID_LSB,
+			       &data->devid, 2);
+	if (ret)
+		goto out_disable_vcc;
+
+	switch (data->devid) {
+	case TMAG5273_MANUFACTURER_ID:
+		strncpy(data->name, "TMAG5273", sizeof(data->name) - 2);
+		switch (data->version) {
+		case 1:
+			strncat(data->name, "x1", 2);
+			break;
+		case 2:
+			strncat(data->name, "x2", 2);
+			break;
+		default:
+			break;
+		}
+		dev_info(dev, "%s", data->name);
+		data->max_avg = 32;
+		break;
+	default:
+		ret = -ENODEV;
+		dev_err_probe(dev, ret, "unhandled device ID 0x%x\n", data->devid);
+		goto out_disable_vcc;
+	}
+
+	/*
+	 * Angle-enable is optional and set to 1 (enable X-Y plane) by default,
+	 * the value is modified only if a valid u32 value can be decoded.
+	 */
+	data->angle_en = TMAG5273_ANGLE_EN_X_Y;
+	of_property_read_u32(node, "tmag5273,angle-enable", &data->angle_en);
+
+	ret = tmag5273_chip_init(data);
+	if (ret)
+		goto out_disable_vcc;
+
+	indio_dev->info = &tmag5273_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = data->name;
+	indio_dev->channels = tmag5273_channels;
+	indio_dev->num_channels = ARRAY_SIZE(tmag5273_channels);
+
+	pm_runtime_set_autosuspend_delay(dev, TMAG5273_AUTOSLEEP_DELAY);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_mark_last_busy(dev);
+	ret = pm_runtime_set_active(dev);
+	if (ret < 0)
+		goto out_disable_vcc;
+	pm_runtime_enable(dev);
+	pm_runtime_idle(dev);
+
+	ret = iio_device_register(indio_dev);
+	if (ret) {
+		dev_err_probe(dev, ret, "device register failed\n");
+		goto cleanup_runtime;
+	}
+
+	return 0;
+
+cleanup_runtime:
+	pm_runtime_dont_use_autosuspend(dev);
+	pm_runtime_disable(dev);
+out_disable_vcc:
+	tmag5273_set_operating_mode(data, TMAG5273_OP_MODE_SLEEP);
+	regulator_disable(data->vcc);
+	return ret;
+}
+
+static void tmag5273_remove(struct i2c_client *i2c)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(i2c);
+	struct tmag5273_data *data = iio_priv(indio_dev);
+	struct device *dev = &i2c->dev;
+
+	iio_device_unregister(indio_dev);
+
+	pm_runtime_dont_use_autosuspend(dev);
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+
+	tmag5273_set_operating_mode(data, TMAG5273_OP_MODE_SLEEP);
+	regulator_disable(data->vcc);
+}
+
+static int tmag5273_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct tmag5273_data *data = iio_priv(indio_dev);
+
+	tmag5273_set_operating_mode(data, TMAG5273_OP_MODE_SLEEP);
+
+	return 0;
+}
+
+static int tmag5273_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct tmag5273_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = tmag5273_set_operating_mode(data, TMAG5273_OP_MODE_CONT);
+	if (ret) {
+		/*
+		 * Time to go to stand-by mode from sleep mode is 50us
+		 * typically. During this time no I2C access is possible.
+		 */
+		usleep_range(80, 200);
+		ret = tmag5273_set_operating_mode(data, TMAG5273_OP_MODE_CONT);
+	}
+
+	return ret;
+}
+
+static const struct dev_pm_ops tmag5273_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	RUNTIME_PM_OPS(tmag5273_runtime_suspend, tmag5273_runtime_resume, NULL)
+};
+
+static const struct i2c_device_id tmag5273_id[] = {
+	{
+		"tmag5273",
+	},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(i2c, tmag5273_id);
+
+static const struct of_device_id tmag5273_of_match[] = {
+	{
+		.compatible = "ti,tmag5273",
+	},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, tmag5273_of_match);
+
+static struct i2c_driver tmag5273_driver = {
+	.driver	 = {
+		.name	= "tmag5273",
+		.of_match_table = tmag5273_of_match,
+		.pm = pm_ptr(&tmag5273_pm_ops),
+	},
+	.probe	  = tmag5273_probe,
+	.remove	  = tmag5273_remove,
+	.id_table = tmag5273_id,
+};
+module_i2c_driver(tmag5273_driver);
+
+MODULE_DESCRIPTION("TI TMAG5273 Low-Power Linear 3D Hall-Effect Sensor driver");
+MODULE_AUTHOR("Gerald Loacker <gerald.loacker@wolfvision.net>");
+MODULE_LICENSE("GPL");
-- 
2.37.2

