Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB286AD7D1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 07:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjCGG5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 01:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjCGG4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:56:38 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2088.outbound.protection.outlook.com [40.107.8.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF73388ED2;
        Mon,  6 Mar 2023 22:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHzsf/IW9yq+1nK3iVDkjBQPSL/5LKAyNkD/yvvleeo=;
 b=BeKmsJB1Wt9xnfTGVYFQ1Dtu0b2ZHQOdKJWGDS6zd2+Fz2Avq/0lzjaDlI9Sy41I/oLUppQucrUGSbXjS2xg3TEn63GZ0EqkuWfLOb9hnN/MXC4ZlKqPUx1Q3obnF7dtaYJb6o8rwUteHJTa+cO+aem86EfEWNvMNsqY/4yRSCzrUa11hQtVpMTpAsDQVhOg6EkWOrXHVZzVBcrTzbzDgW3Pk9Km8yuUAQWzKxuFfmEZobQpeDb67p1aetXpzq5GWEPJDdZ0uPiFs8m0RECg7m3Sy69soD8Y4dhkEwV5e7e0JoV5GBa3eZpV1LPEB8Y/eOAZ738YMukOjjt+KDUVSQ==
Received: from ZR2P278CA0039.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:47::16)
 by VE1PR04MB7454.eurprd04.prod.outlook.com (2603:10a6:800:1a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 06:55:47 +0000
Received: from VE1EUR01FT072.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:910:47:cafe::47) by ZR2P278CA0039.outlook.office365.com
 (2603:10a6:910:47::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29 via Frontend
 Transport; Tue, 7 Mar 2023 06:55:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 VE1EUR01FT072.mail.protection.outlook.com (10.152.3.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.16 via Frontend Transport; Tue, 7 Mar 2023 06:55:46 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (104.47.51.173) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 07 Mar 2023 06:55:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoUsJ3Mmy9wrotw+kfgnu5fIb9fkHTLP8jn7TdLrjst1pHETPx/IAoRkepHfROg4I6M910PicOe76mEXYeC5jo4e4lc3B927XItABy65wxI1JNfvKtEf0Q1ybLb3Xgkk5c8LEyU+6/OU/KyKabhlzp/mg75qU4SMH4foV1e68pnZ9q0M60qji9JPsE+wvi8uUDbqSBSGXlETLaqy/mSvenmllbNv0sAPF3lY7qaybmZoJ87CiBrlto2fh0XZtk1U2vWkjKFRu4DVhZkgShI2E2WNmHLAwzWXQy4oBnyRcsaJzN+ZbR6K5mUddKHX/2/OS4fQkKZyvUmF4JGlFuURjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsOSUD+0m41jYblqif+ADXtq6jZRjgq+9+jfyR9v7Pg=;
 b=CUXbwaUP6HHCk2iyeeStRap0cJmk8+YP+GowQwUsOvlnHmTlnmgjqexIfAQRnCjxc9Q1K0C33hlODkzLlbpg4wltWpgcNtV5hREnwSKiPIpfawXaElNU6uPQNDFrMUq5VHMlHeMXa8UXZvSv+puk2OJkz26LR05qlRRFMwD9vUJQmCPtyTnlOfzELXxVSFEUUbdbPGbu0kzj86tcBZtj7UGmg4LOpnDrmuV0U/APlVJcCsFfg1fmUhThELicFReQflI7dr8GLsjXRmkUPNd1ajzRAKlHjAs1kAVW3g3M9e1AVX3FsWF/Ynj9tdCl7ZUtKO3bO0ZHYAOjB7pmtuaIRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by PAXPR04MB9107.eurprd04.prod.outlook.com (2603:10a6:102:229::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 06:55:42 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::a7e7:768:5a54:777a]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::a7e7:768:5a54:777a%7]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 06:55:42 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org
CC:     Mike Looijmans <mike.looijmans@topic.nl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] iio: adc: Add TI ADS1100 and ADS1000
Date:   Tue, 7 Mar 2023 07:55:34 +0100
Message-ID: <20230307065535.7927-2-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230307065535.7927-1-mike.looijmans@topic.nl>
References: <20230307065535.7927-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.812861c4-ffbd-402e-bb22-77232c1fbafb@emailsignatures365.codetwo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0112.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::29) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|PAXPR04MB9107:EE_|VE1EUR01FT072:EE_|VE1PR04MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb68c1a-e42a-43e5-3c4f-08db1ed8fabb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: MKw4yUh0RCSE22bodwan9u8SZ1UZ7JfAgdE/B7emrywPfIf56qsfqlc9FAHiu1KWf/HkLagK5iIYxg4JB2+3Pa+BBzoXR6O+oplyOl9D9mWSgOOBkrKbp0uZ+wbkEbB9XhACWTQZdufUSIHdreHiB760uCX2OJIf774NaFDm9pETIPI5eNZeDG02eG6QRd188kHChbzwI2I220ZaOHTMxp4IaMRFMwwQfsbUzMbYJzDaenO3jaPFl+p2QIOFc8aD7WPfo/EY12EDdShntZ+qq17cgcoRrdmPfY3lQTihLCu1krLyuzmAnCKRSmu2hI+LELlP4Byezqw6E8xRF+FQhBs+WfxaUsRbk3P3M+zxeiCyv/BcTr3yZICCXStPuVmNRAzRBF+dHRTPIboGk5Ke+RbCnrqEBloNa38HHOJkWzm8+DFx5PQIE27Q7ddYxoGOd2elOKcNHeaZgIhhdJS/A/SehAXJzWoEskObiebvS6reINrEdxPl0+yX3S9yKWbyO1s0J/b1yGnmnqboQm9F8osw2TQeyR2GwFvuNs1nceMLQ4KUBf27AqwFV+OodBIuCxKTY0x+JmYfxVYoggHOH44rSgDbqz2F50d4N0y111zsAxRP/GkIncmYQnIK6tX4KgX98LXOtkdYbH4Yw2MapXbYC2dj7ukpD3V0I5yv191H0MxRLdhGD5UXqm/hhurF
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(39840400004)(376002)(346002)(396003)(451199018)(36756003)(4326008)(44832011)(41300700001)(66946007)(66556008)(66476007)(8676002)(8936002)(6506007)(5660300002)(7416002)(30864003)(2906002)(6666004)(83170400001)(38100700002)(38350700002)(52116002)(1076003)(26005)(966005)(6486002)(54906003)(316002)(478600001)(6512007)(83380400001)(2616005)(186003)(42882007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9107
X-CodeTwo-MessageID: bd8b0bd9-e1ae-44a4-bc2a-48767379fb30.20230307065546@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT072.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: deb59960-dd4c-4681-2c85-08db1ed8f7e0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MFq3+XhhqnWvUuX+JT8oHqpl/tmXlCMNlzl2V87UHzzfRIxATM0kATiQKSqlUPq/ofA2cTk3u7QCPU9s4vRXKnAH0iT+r8GsbPeo6NqjYSKZahixvHpa1feUJ68MvTar776ddt4I4nn4RzvVIqDIyG0qXvt2w8PsU+rt6Eo8LMXdTM/SD5EnOrM6MJTlyUWBz/bIK1HgHvmYg5N+SUcysmPGhlOHyGPTiWN1vqGqkh2BCVm5dob4rf3Feq0gl1EbXcZPCtO1fwmnwVUBL0oAcQrQKhvo4EGYla+oMyxuRhLiA+twQQ/PWpSmlfjvKbSSEO5EiTO4B6FYRoNchrnqer1bCYz38IJ5ZdmNGBsllhfhM6uffc2d3FBJzBwUIOt6i7gIw/JEHCubc6yE9//4JuRHhvOn6AZQxxXhqR2gxfmhjtCDbrvWMe6CyRrWSP1ecxBhwKj4+kFY9WE9KZWzq9SEsIHKC8czAVjDE4N6tL91ntJxJxu7vTGUw1v0bULLNfB0vAoWNJrsTu5ppxnxGoJ0XCNjexl0vj6JY7zBuBKQ7saxvIjjJ7F9/UzSyriKGJB/9I/FWVj0lvqDXfZ61pZHx6H2a5Da01Qc9/UO9/wxETxV3/UKQexCyQQIZ6G6tVPbE7nXYHB5LuudgIeFMI8c1pyEj1tAZWsLDjA80j0=
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39840400004)(136003)(396003)(451199018)(46966006)(36840700001)(30864003)(7416002)(5660300002)(8936002)(44832011)(70586007)(70206006)(8676002)(2906002)(4326008)(54906003)(316002)(478600001)(36756003)(47076005)(6666004)(36860700001)(6506007)(6512007)(1076003)(966005)(6486002)(26005)(2616005)(41300700001)(40480700001)(82310400005)(15974865002)(42882007)(7596003)(356005)(83170400001)(83380400001)(186003)(7636003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 06:55:46.8119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb68c1a-e42a-43e5-3c4f-08db1ed8fabb
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT072.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7454
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ADS1100 is a 16-bit ADC (at 8 samples per second).
The ADS1000 is similar, but has a fixed data rate.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

Changes in v5:
Use scripts/Lindent to auto-format
Use DIV_ROUNDUP_CLOSEST in gain calculation

Changes in v4:
Use post-increment
Formatting fixes (commas, indents, empty line)
Use 'ffs' and explain gain formula
Use dev_set_drvdata/dev_get_drvdata for pm_ methods
Use units.h for micro-to-milli conversion

Changes in v3:
Add #include linux/bitfield.h and linux/bits.h

Changes in v2:
Remove "driver for" from title
Use proper PM_RUNTIME macros
Fix indents
Use dev_err_probe()
Unsigned index and post-increment
Use GENMASK and FIELD_GET
remove ads1100_set_conv_mode
remove Kconfig BUFFER dependencies
remove unused #include
Set SCALE instead of HARDWAREGAIN
Use devm_add_action_or_reset

 drivers/iio/adc/Kconfig      |  10 +
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/ti-ads1100.c | 444 +++++++++++++++++++++++++++++++++++
 3 files changed, 455 insertions(+)
 create mode 100644 drivers/iio/adc/ti-ads1100.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 63f80d747cbd..257efb25a92e 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1207,6 +1207,16 @@ config TI_ADS1015
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-ads1015.
=20
+config TI_ADS1100
+	tristate "Texas Instruments ADS1100 and ADS1000 ADC"
+	depends on I2C
+	help
+	  If you say yes here you get support for Texas Instruments ADS1100 and
+	  ADS1000 ADC chips.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called ti-ads1100.
+
 config TI_ADS7950
 	tristate "Texas Instruments ADS7950 ADC driver"
 	depends on SPI && GPIOLIB
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 4ef41a7dfac6..61ef600fab99 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -107,6 +107,7 @@ obj-$(CONFIG_TI_ADC108S102) +=3D ti-adc108s102.o
 obj-$(CONFIG_TI_ADC128S052) +=3D ti-adc128s052.o
 obj-$(CONFIG_TI_ADC161S626) +=3D ti-adc161s626.o
 obj-$(CONFIG_TI_ADS1015) +=3D ti-ads1015.o
+obj-$(CONFIG_TI_ADS1100) +=3D ti-ads1100.o
 obj-$(CONFIG_TI_ADS7950) +=3D ti-ads7950.o
 obj-$(CONFIG_TI_ADS8344) +=3D ti-ads8344.o
 obj-$(CONFIG_TI_ADS8688) +=3D ti-ads8688.o
diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
new file mode 100644
index 000000000000..ce386c18618f
--- /dev/null
+++ b/drivers/iio/adc/ti-ads1100.c
@@ -0,0 +1,444 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ADS1100 - Texas Instruments Analog-to-Digital Converter
+ *
+ * Copyright (c) 2023, Topic Embedded Products
+ *
+ * Datasheet: https://www.ti.com/lit/gpn/ads1100
+ * IIO driver for ADS1100 and ADS1000 ADC 16-bit I2C
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
+#include <linux/units.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+
+/* The ADS1100 has a single byte config register */
+
+/* Conversion in progress bit */
+#define ADS1100_CFG_ST_BSY	BIT(7)
+/* Single conversion bit */
+#define ADS1100_CFG_SC		BIT(4)
+/* Data rate */
+#define ADS1100_DR_MASK		GENMASK(3, 2)
+/* Gain */
+#define ADS1100_PGA_MASK	GENMASK(1, 0)
+
+#define ADS1100_CONTINUOUS	0
+#define	ADS1100_SINGLESHOT	ADS1100_CFG_SC
+
+#define ADS1100_SLEEP_DELAY_MS	2000
+
+static const int ads1100_data_rate[] =3D { 128, 32, 16, 8 };
+static const int ads1100_data_rate_bits[] =3D { 12, 14, 15, 16 };
+
+struct ads1100_data {
+	struct i2c_client *client;
+	struct regulator *reg_vdd;
+	struct mutex lock;
+	int scale_avail[2 * 4]; /* 4 gain settings */
+	u8 config;
+	bool supports_data_rate; /* Only the ADS1100 can select the rate */
+};
+
+static const struct iio_chan_spec ads1100_channel =3D {
+	.type =3D IIO_VOLTAGE,
+	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
+	.info_mask_shared_by_all =3D
+	    BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	.info_mask_shared_by_all_available =3D
+	    BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	.scan_type =3D {
+		      .sign =3D 's',
+		      .realbits =3D 16,
+		      .storagebits =3D 16,
+		      .endianness =3D IIO_CPU,
+		       },
+	.datasheet_name =3D "AIN",
+};
+
+static int ads1100_set_config_bits(struct ads1100_data *data, u8 mask, u8 =
value)
+{
+	int ret;
+	u8 config =3D (data->config & ~mask) | (value & mask);
+
+	if (data->config =3D=3D config)
+		return 0;	/* Already done */
+
+	ret =3D i2c_master_send(data->client, &config, 1);
+	if (ret < 0)
+		return ret;
+
+	data->config =3D config;
+	return 0;
+};
+
+static int ads1100_data_bits(struct ads1100_data *data)
+{
+	return ads1100_data_rate_bits[FIELD_GET(ADS1100_DR_MASK, data->config)];
+}
+
+static int ads1100_get_adc_result(struct ads1100_data *data, int chan, int=
 *val)
+{
+	int ret;
+	__be16 buffer;
+	s16 value;
+
+	if (chan !=3D 0)
+		return -EINVAL;
+
+	ret =3D pm_runtime_resume_and_get(&data->client->dev);
+	if (ret < 0)
+		return ret;
+
+	ret =3D i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
+
+	pm_runtime_mark_last_busy(&data->client->dev);
+	pm_runtime_put_autosuspend(&data->client->dev);
+
+	if (ret < 0) {
+		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
+		return ret;
+	}
+
+	/* Value is always 16-bit 2's complement */
+	value =3D be16_to_cpu(buffer);
+
+	/* Shift result to compensate for bit resolution vs. sample rate */
+	value <<=3D 16 - ads1100_data_bits(data);
+
+	*val =3D sign_extend32(value, 15);
+
+	return 0;
+}
+
+static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
+{
+	int microvolts;
+	int gain;
+
+	/* With Vdd between 2.7 and 5V, the scale is always below 1 */
+	if (val)
+		return -EINVAL;
+
+	if (!val2)
+		return -EINVAL;
+
+	microvolts =3D regulator_get_voltage(data->reg_vdd);
+	/*
+	 * val2 is in 'micro' units, n =3D val2 / 1000000
+	 * result must be millivolts, d =3D microvolts / 1000
+	 * the full-scale value is d/n, corresponds to 2^15,
+	 * hence the gain =3D (d / n) >> 15, factoring out the 1000 and moving th=
e
+	 * bitshift so everything fits in 32-bits yields this formula.
+	 */
+	gain =3D DIV_ROUND_CLOSEST(microvolts, BIT(15)) * MILLI / val2;
+	if (gain < BIT(0) || gain > BIT(3))
+		return -EINVAL;
+
+	ads1100_set_config_bits(data, ADS1100_PGA_MASK, ffs(gain) - 1);
+	return 0;
+}
+
+static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int =
rate)
+{
+	unsigned int i;
+	unsigned int size;
+
+	size =3D data->supports_data_rate ? ARRAY_SIZE(ads1100_data_rate) : 1;
+	for (i =3D 0; i < size; i++) {
+		if (ads1100_data_rate[i] =3D=3D rate)
+			return ads1100_set_config_bits(data, ADS1100_DR_MASK,
+						       FIELD_PREP
+						       (ADS1100_DR_MASK, i));
+	}
+
+	return -EINVAL;
+}
+
+static int ads1100_get_vdd_millivolts(struct ads1100_data *data)
+{
+	return regulator_get_voltage(data->reg_vdd) / (MICRO / MILLI);
+}
+
+static void ads1100_calc_scale_avail(struct ads1100_data *data)
+{
+	int millivolts =3D ads1100_get_vdd_millivolts(data);
+	unsigned int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(data->scale_avail) / 2; i++) {
+		data->scale_avail[i * 2 + 0] =3D millivolts;
+		data->scale_avail[i * 2 + 1] =3D 15 + i;
+	}
+}
+
+static int ads1100_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	struct ads1100_data *data =3D iio_priv(indio_dev);
+
+	if (chan->type !=3D IIO_VOLTAGE)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*type =3D IIO_VAL_INT;
+		*vals =3D ads1100_data_rate;
+		if (data->supports_data_rate)
+			*length =3D ARRAY_SIZE(ads1100_data_rate);
+		else
+			*length =3D 1;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SCALE:
+		*type =3D IIO_VAL_FRACTIONAL_LOG2;
+		*vals =3D data->scale_avail;
+		*length =3D ARRAY_SIZE(data->scale_avail);
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ads1100_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	int ret;
+	struct ads1100_data *data =3D iio_priv(indio_dev);
+
+	mutex_lock(&data->lock);
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret =3D iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			break;
+
+		ret =3D ads1100_get_adc_result(data, chan->address, val);
+		if (ret >=3D 0)
+			ret =3D IIO_VAL_INT;
+		iio_device_release_direct_mode(indio_dev);
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		/* full-scale is the supply voltage in millivolts */
+		*val =3D ads1100_get_vdd_millivolts(data);
+		*val2 =3D 15 + FIELD_GET(ADS1100_PGA_MASK, data->config);
+		ret =3D IIO_VAL_FRACTIONAL_LOG2;
+		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val =3D ads1100_data_rate[FIELD_GET(ADS1100_DR_MASK,
+						   data->config)];
+		ret =3D IIO_VAL_INT;
+		break;
+	default:
+		ret =3D -EINVAL;
+		break;
+	}
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static int ads1100_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct ads1100_data *data =3D iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&data->lock);
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		ret =3D ads1100_set_scale(data, val, val2);
+		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret =3D ads1100_set_data_rate(data, chan->address, val);
+		break;
+	default:
+		ret =3D -EINVAL;
+		break;
+	}
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static const struct iio_info ads1100_info =3D {
+	.read_avail =3D ads1100_read_avail,
+	.read_raw =3D ads1100_read_raw,
+	.write_raw =3D ads1100_write_raw,
+};
+
+static int ads1100_setup(struct ads1100_data *data)
+{
+	int ret;
+	u8 buffer[3];
+
+	/* Setup continuous sampling mode at 8sps */
+	buffer[0] =3D ADS1100_DR_MASK | ADS1100_CONTINUOUS;
+	ret =3D i2c_master_send(data->client, buffer, 1);
+	if (ret < 0)
+		return ret;
+
+	ret =3D i2c_master_recv(data->client, buffer, sizeof(buffer));
+	if (ret < 0)
+		return ret;
+
+	/* Config register returned in third byte, strip away the busy status */
+	data->config =3D buffer[2] & ~ADS1100_CFG_ST_BSY;
+
+	/* Detect the sample rate capability by checking the DR bits */
+	data->supports_data_rate =3D FIELD_GET(ADS1100_DR_MASK, buffer[2]) !=3D 0=
;
+
+	return 0;
+}
+
+static void ads1100_reg_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
+static void ads1100_disable_continuous(void *data)
+{
+	ads1100_set_config_bits(data, ADS1100_CFG_SC, ADS1100_SINGLESHOT);
+}
+
+static int ads1100_probe(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev;
+	struct ads1100_data *data;
+	struct device *dev =3D &client->dev;
+	int ret;
+
+	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data =3D iio_priv(indio_dev);
+	dev_set_drvdata(dev, data);
+	data->client =3D client;
+	mutex_init(&data->lock);
+
+	indio_dev->name =3D "ads1100";
+	indio_dev->modes =3D INDIO_DIRECT_MODE;
+	indio_dev->channels =3D &ads1100_channel;
+	indio_dev->num_channels =3D 1;
+	indio_dev->info =3D &ads1100_info;
+
+	data->reg_vdd =3D devm_regulator_get(dev, "vdd");
+	if (IS_ERR(data->reg_vdd))
+		return dev_err_probe(dev, PTR_ERR(data->reg_vdd),
+				     "Failed to get vdd regulator\n");
+
+	ret =3D regulator_enable(data->reg_vdd);
+	if (ret < 0)
+		return dev_err_probe(dev, PTR_ERR(data->reg_vdd),
+				     "Failed to enable vdd regulator\n");
+
+	ret =3D devm_add_action_or_reset(dev, ads1100_reg_disable, data->reg_vdd)=
;
+	if (ret)
+		return ret;
+
+	ret =3D ads1100_setup(data);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to communicate with device\n");
+
+	ret =3D devm_add_action_or_reset(dev, ads1100_disable_continuous, data);
+	if (ret)
+		return ret;
+
+	ads1100_calc_scale_avail(data);
+
+	pm_runtime_set_autosuspend_delay(dev, ADS1100_SLEEP_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_active(dev);
+	ret =3D devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable pm_runtime\n");
+
+	ret =3D devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to register IIO device\n");
+
+	return 0;
+}
+
+static int ads1100_runtime_suspend(struct device *dev)
+{
+	struct ads1100_data *data =3D dev_get_drvdata(dev);
+
+	ads1100_set_config_bits(data, ADS1100_CFG_SC, ADS1100_SINGLESHOT);
+	regulator_disable(data->reg_vdd);
+
+	return 0;
+}
+
+static int ads1100_runtime_resume(struct device *dev)
+{
+	struct ads1100_data *data =3D dev_get_drvdata(dev);
+	int ret;
+
+	ret =3D regulator_enable(data->reg_vdd);
+	if (ret) {
+		dev_err(&data->client->dev, "Failed to enable Vdd\n");
+		return ret;
+	}
+
+	/*
+	 * We'll always change the mode bit in the config register, so there is
+	 * no need here to "force" a write to the config register. If the device
+	 * has been power-cycled, we'll re-write its config register now.
+	 */
+	return ads1100_set_config_bits(data, ADS1100_CFG_SC,
+				       ADS1100_CONTINUOUS);
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(ads1100_pm_ops,
+				 ads1100_runtime_suspend,
+				 ads1100_runtime_resume,
+				 NULL);
+
+static const struct i2c_device_id ads1100_id[] =3D {
+	{ "ads1100" },
+	{ "ads1000" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, ads1100_id);
+
+static const struct of_device_id ads1100_of_match[] =3D {
+	{.compatible =3D "ti,ads1100" },
+	{.compatible =3D "ti,ads1000" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, ads1100_of_match);
+
+static struct i2c_driver ads1100_driver =3D {
+	.driver =3D {
+		   .name =3D "ads1100",
+		   .of_match_table =3D ads1100_of_match,
+		   .pm =3D pm_ptr(&ads1100_pm_ops),
+		    },
+	.probe_new =3D ads1100_probe,
+	.id_table =3D ads1100_id,
+};
+
+module_i2c_driver(ads1100_driver);
+
+MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
+MODULE_DESCRIPTION("Texas Instruments ADS1100 ADC driver");
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
