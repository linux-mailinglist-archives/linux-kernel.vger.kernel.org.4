Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4547128A4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 16:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243976AbjEZOjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 10:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243734AbjEZOi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 10:38:59 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2063.outbound.protection.outlook.com [40.107.6.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C4A10CE;
        Fri, 26 May 2023 07:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVjjWcqPr8lJTnpi2X80hXHfdpTBWqdwmSqX0me0pLc=;
 b=ptNdbqaCkQa59qMYFK00AHBScGKNZXUmA45StskgnkOinw1WGb4Er9T3ywxOD1qvED8K9A9xldmJYVavJe007IO280539CV20qMHMVMHIc21rbgz6mU7t05ukDXHOR6KEMXWCMsVHqxFnJ+qnY+3jUIIGw0xiP8cxw0Njo68DJ6tEf/7Juzl4O+5Em2QXTcYhwSvZhSlT6fFkbW+NZ6IlxyrS8rp9fUWGyX1o+neNnhbftYA4HkMBVFshKv1l8h+XWiJ+ertucrZ1vzecyvh+R6/o5wg8vd54fkGDl4kZI0gZexkxRrrvi8jZ89f1BICFzMWUlFWxnEhzxbsYET2XA==
Received: from OS6P279CA0092.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:3d::15)
 by AM9PR04MB8572.eurprd04.prod.outlook.com (2603:10a6:20b:437::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 14:38:19 +0000
Received: from HE1EUR01FT015.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:3d:cafe::2b) by OS6P279CA0092.outlook.office365.com
 (2603:10a6:e10:3d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18 via Frontend
 Transport; Fri, 26 May 2023 14:38:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 HE1EUR01FT015.mail.protection.outlook.com (10.152.0.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.18 via Frontend Transport; Fri, 26 May 2023 14:38:18 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (104.47.51.234) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 26 May 2023 14:38:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIb3FWSoK4WqbwjDR+5Fbi8z0uymPQesPUlOQDdDSsqzLYJjmsLKT1x3RD7YowRficdNlwPtFPOKqBg8jNlpI8tMURml87McFx1CU1jwxNQ6je/4CR9lXVbEiMPb1S/S4BLkDAaqg2qWLA1XzOKT+46L223afiyNqdAD626UlzGNmHSrNc3WS0kpMjldqctyfMLVX21c/1/IfA9znwOy9u2Aj4LgcwI+W8ofIElumpkbzNnFIYiNMdpMx4MFampr4sxn6ZldYVkv5wz87cvrBZ5Tps8GhFlPAIJ8Xsw5LlDlgR/CjSz7CVt37hQ4DK0/VamspuKRg4GnVm0CQXtnzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PI1aq+Z/4X994/0gkJLCODVycf5eVNzzIEUxDoMQo7I=;
 b=XHg3D3KDv+giQ5pGaXIBS2xGmw6e6aMYOc3iAt4bE6c2nVoGHmHspxeg2b9M7F1UWvirJ48I/1wHoHUutjbsFtIpW1baIhZdzu+Yqmqkmi2Vu2wD1vvBlsXe2KPyJJ+oec2R/4xU0YLZjUmBMB1AZIM7HAbB+Y1lIJlpuixpO3i/u6WzgQ10TktkOcgpQdB9bwERosShO4CraJkGuM3nEkMg7baME/9ZZ4U/i9ONqYFSGcr3hVX9efdZX7e4af+LBnbBVmwKjBXPGed2/0aZSGY7ZTIIo6vYrb+Ze2cK4gWHiYWSmEyrrgW7q0wpLZ7Vz8R5olbQk4CWbNZwHZridA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by PA4PR04MB7775.eurprd04.prod.outlook.com (2603:10a6:102:c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Fri, 26 May
 2023 14:38:14 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696%5]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 14:38:14 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org
CC:     Mike Looijmans <mike.looijmans@topic.nl>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] clk: Add nvmem-clock provider
Date:   Fri, 26 May 2023 16:38:07 +0200
Message-ID: <20230526143807.10164-2-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230526143807.10164-1-mike.looijmans@topic.nl>
References: <20230526143807.10164-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.c94258f7-321c-4603-be80-fc92c2c311e9@emailsignatures365.codetwo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0005.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::10) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|PA4PR04MB7775:EE_|HE1EUR01FT015:EE_|AM9PR04MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: 697735c7-0a6b-4ae9-fac3-08db5df6d8ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: COSoz+9Mbwx71USKXUZiPYH4ZuSHyE3YiROX9d9TALp1DwXF/zO2Ocou8R5ww7qfQRNsnArj9BLHbzagCIXbzqknTmrT7vADOpTqiO6m5IPEdGTczxFPncuMtD74yGHS1WRNjc0MBVuWoKfSaLRvN/Hs+qCLJaQe3p5Yezfa8+rD8k7SD48dOC9hQKl05LtFfwAgqIOq2Ag6ObxOH5HlpzFKpJLeEbe+heRaP2cbJE+mkRnyjnbTBe2jm+my0Gz+JBld5WjgObbW87Lafnkv2ZpTHS/Nquu6ivmko/tdlVgao7D+bDSlpqmJ9oKYkx2EjBo8GRL2yqjfuS2djhMlqBqGgrTk20nn5q8c8cB3RFedo2ofuSoPwGZ5QNYaONcC7nIGnGP9TL1oxdOAiHWffVBWwZ5JNwbhGOP3czBto/tnCJ7mpKc7SM2qPi27Zp+2Y6k4XzqGQl8a91EAxSxeQRcGeeKtzYYHfFRlJJ5vsDXcSzBwyfPqxBq7BdY4wMoWTvv+Paf6ra8TbDZIK+3ZZR9TAfKjDormcPJECeQ5sLvg9NeR/pc4IddPRpCtJ4Ct4QWFLLSu9sp6tXHHxcQibRjr8QX/FKqTeUcsTy2+40MGRJlnEGCMm7OoFdj/3H0B
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(346002)(39840400004)(136003)(451199021)(66946007)(66476007)(4326008)(66556008)(316002)(54906003)(478600001)(6486002)(52116002)(41300700001)(83170400001)(6666004)(186003)(6512007)(6506007)(26005)(8676002)(8936002)(44832011)(83380400001)(2906002)(42882007)(1076003)(38100700002)(2616005)(5660300002)(36756003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7775
X-CodeTwo-MessageID: 838f56c7-4ab7-4c7c-a818-0df24416cd3f.20230526143817@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT015.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5b1cff4d-d3ec-457a-4646-08db5df6d648
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aQNDDx5WW2dOWxfVy1EP8ktouafBBPoi21TjWqc5AbJs8MOvDRsj+JV5I7ED3Yo36AaE/wnmcfa5THnO5Wtzfa25QPKt+2TEDFJPl6wJlUV2bTJbflxG1RijlRfkrDQa1IycnT6x2kJ+Ey3XRWyN54KDbYuj8poPvdspJUWBH3k+Jj9wGmsbCEVyFnQ0y/1TmVxLCIreUxc8aWssK7P1BgQyIvc/NOvjfPC0xxatH+1E2xYLhPzY/+Df2rE8w0RxkIU4fr+AhNcJAhuBGpMxcLQG+BEgTytBDdT6DQlpvjn7xjCqrXXS9VyXIKLQPT6OLk+s3yxaI3ULiv1Wx6RegqdTsOZlzxLSqO/EFaiiCIKlGNUC8fciXJfg0G813DUBkBRAHrRl1gRhSF81TwYH++mTwoGxJJyQ+0cU72YmhZq9ckrB77tSn/mo6ivcFrRKxpQDwrKVeKhRp86DVjFBI6B77RTHBMJjPHxUick6HG/sbEdx1YvPxlppVN0+AJ7kh1Oeb1Y9SAPG9/FpY3jCyoW4cQLq11Dzk0A4bkTJbhN5BcXrCZYQtLZG8yT+70nkL6F3NVwzf1duNljrJ8mM3OZ5H2oquSmfERfcEU75yYC5Q3SS6xeZmk54jEzugOtSuX0/XKXY7n1xHujImtTyscb/LLXvVoMRWwpYOn/nALxDbrA9uCdcB4LL8ACGSdGgK7yJa53BEbvPb6BaO+O7rg==
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39840400004)(376002)(396003)(136003)(451199021)(36840700001)(46966006)(316002)(6666004)(83170400001)(6486002)(41300700001)(44832011)(26005)(1076003)(6512007)(6506007)(8676002)(5660300002)(36756003)(2616005)(36860700001)(82310400005)(83380400001)(47076005)(336012)(42882007)(8936002)(2906002)(186003)(15974865002)(40480700001)(7636003)(7596003)(356005)(4326008)(70586007)(70206006)(54906003)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 14:38:18.3642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 697735c7-0a6b-4ae9-fac3-08db5df6d8ea
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT015.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8572
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a fixed-rate clock that retrieves its rate from an NVMEM provider.
This allows to store clock settings in EEPROM or EFUSE or similar device.

Component shortages lead to boards being shipped with different clock
crystals, based on what was available at the time. The clock frequency
was written to EEPROM at production time. Systems can adapt to a wide
range of input frequencies usign the clock framework, but this required
us to patch the devicetree at runtime or use some custom driver. This
provides a more generic solution.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

(no changes since v1)

 drivers/clk/Kconfig     |   7 +++
 drivers/clk/Makefile    |   1 +
 drivers/clk/clk-nvmem.c | 107 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100644 drivers/clk/clk-nvmem.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 016814e15536..63f165473481 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -447,6 +447,13 @@ config COMMON_CLK_FIXED_MMIO
 	help
 	  Support for Memory Mapped IO Fixed clocks
=20
+config COMMON_CLK_NVMEM
+	bool "Clock driver for NVMEM provided frequency"
+	depends on COMMON_CLK && OF
+	help
+	  This driver allows a clock frequency to be provided by NVMEM data, for
+	  example in an EEPROM, by fuses or other non-volatile storage.
+
 config COMMON_CLK_K210
 	bool "Clock driver for the Canaan Kendryte K210 SoC"
 	depends on OF && RISCV && SOC_CANAAN
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 0aebef17edc6..aef1361e5085 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_ARCH_MOXART)		+=3D clk-moxart.o
 obj-$(CONFIG_ARCH_NOMADIK)		+=3D clk-nomadik.o
 obj-$(CONFIG_ARCH_NPCM7XX)	    	+=3D clk-npcm7xx.o
 obj-$(CONFIG_ARCH_NSPIRE)		+=3D clk-nspire.o
+obj-$(CONFIG_COMMON_CLK_NVMEM)		+=3D clk-nvmem.o
 obj-$(CONFIG_COMMON_CLK_OXNAS)		+=3D clk-oxnas.o
 obj-$(CONFIG_COMMON_CLK_PALMAS)		+=3D clk-palmas.o
 obj-$(CONFIG_CLK_LS1028A_PLLDIG)	+=3D clk-plldig.o
diff --git a/drivers/clk/clk-nvmem.c b/drivers/clk/clk-nvmem.c
new file mode 100644
index 000000000000..870f04a3954f
--- /dev/null
+++ b/drivers/clk/clk-nvmem.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Fixed rate clock that reads its frequency from NVMEM
+ *
+ * Copyright (C) 2023 Topic Embedded Products
+ * Mike Looijmans <mike.looijmans@topic.nl>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+static long nvmemclk_retrieve(struct device_node *node, const char *name)
+{
+	struct nvmem_cell *cell;
+	const void *data;
+	size_t len;
+	long ret;
+
+	cell =3D of_nvmem_cell_get(node, name);
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	data =3D nvmem_cell_read(cell, &len);
+	nvmem_cell_put(cell);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	switch (len) {
+	case 1:
+		ret =3D *(u8 *)data;
+		break;
+	case 2:
+		ret =3D *(u16 *)data;
+		break;
+	case 4:
+		ret =3D *(u32 *)data;
+		break;
+	case 8:
+		ret =3D *(u64 *)data;
+		break;
+	default:
+		ret =3D -EINVAL;
+		break;
+	}
+
+	kfree(data);
+
+	return ret;
+}
+
+static int nvmemclk_probe(struct platform_device *pdev)
+{
+	struct device_node *node =3D pdev->dev.of_node;
+	const char *clk_name =3D node->name;
+	struct clk_hw *hw;
+	u32 rate;
+	u32 accuracy =3D 0;
+	long value;
+
+	value =3D nvmemclk_retrieve(node, "clock-frequency");
+	if (value < 0)
+		return dev_err_probe(&pdev->dev, value,
+				     "failed to retrieve clock-frequency\n");
+	rate =3D value;
+
+	/* clock-accuracy can be provided by either NVMEM or property */
+	value =3D nvmemclk_retrieve(node, "clock-accuracy");
+	if (value > 0)
+		accuracy =3D value;
+	else
+		of_property_read_u32(node, "clock-accuracy", &accuracy);
+
+	of_property_read_string(node, "clock-output-names", &clk_name);
+
+	hw =3D clk_hw_register_fixed_rate_with_accuracy(NULL, clk_name, NULL,
+						    0, rate, accuracy);
+	if (IS_ERR(hw))
+		return dev_err_probe(&pdev->dev, PTR_ERR(hw),
+				     "Failed to register clock %s\n", clk_name);
+
+	return devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_simple_get,
+					   hw);
+}
+
+static const struct of_device_id of_nvmemclk_ids[] =3D {
+	{ .compatible =3D "nvmem-clock" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, of_nvmemclk_ids);
+
+static struct platform_driver nvmemclk_driver =3D {
+	.driver =3D {
+		.name =3D "nvmem-clock",
+		.of_match_table =3D of_nvmemclk_ids,
+	},
+	.probe =3D nvmemclk_probe,
+};
+
+module_platform_driver(nvmemclk_driver);
+
+MODULE_DESCRIPTION("NVMEM clock driver");
+MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
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
