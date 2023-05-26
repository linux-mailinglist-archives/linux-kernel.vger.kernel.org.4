Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8E07127FB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 16:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243815AbjEZOFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 10:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjEZOFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 10:05:33 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2059.outbound.protection.outlook.com [40.107.15.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CD9F3;
        Fri, 26 May 2023 07:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EF4SYo/B1/9J5STD6HY6dmsD2kbsblogAIlGpme+1Vs=;
 b=H2U+nh8VMp1O4ADnczeGJcYcbXgtCS4CF8wuu4tUC1wg7Bk5GE6CR5vgiFvUFqJQANGOz46y01uu7hVsLLYuOmZQz44/Q5v8IAwxcAf3ulbWaHcOiwdtcjDJoIN0npZ25WAURor31R3p4yWLoaBjf5dhynGZl0C+l+gqjjObCt7EcvlETHLZPaWBWptVkF4nXt8SzkMAe/993WvpnBGba695zLCQ1SGg0uTsx/5fQWA6e1zCm2OfQzdYgKQfvFrDiHMXPIyJNsHa3FgzW1CNGPiQ/KS/p/2GjaEesqflAaiXTM1PSJR979LRpL32mpaiczpwuITHwd+XwqQqfiY2lQ==
Received: from GVYP280CA0025.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:f9::20)
 by AS8PR04MB8200.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 14:05:26 +0000
Received: from HE1EUR01FT059.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:f9:cafe::b3) by GVYP280CA0025.outlook.office365.com
 (2603:10a6:150:f9::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.19 via Frontend
 Transport; Fri, 26 May 2023 14:05:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 HE1EUR01FT059.mail.protection.outlook.com (10.152.0.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.18 via Frontend Transport; Fri, 26 May 2023 14:05:25 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (104.47.12.58) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 26 May 2023 14:05:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAk9WbgCfIsEmy0+ui1z+xD54uKnzG5mv+qHPBJzo/gjnGFyb9bTMWQPUgVdB0Exn9J1u8BaM9azyaiLOhzP/kHxMUDX+Ziv1NjTAzeeQV2JxXlPGXJD/i/S18FMUC7lDG/N00PY6gj7KhS8rijHnFfouQJbgSBpuX677l1pHmGzhamdpuhPELaSuaJeA8yH5cXV8+fzrp7lmw0ja0Jk0YyTxkpOUPiyLrQf1WKfOo67vafna859nvqyRWwwFARJ24vpgQYfLZgSG7KN73ZU8Wo5I1X6KZaBHF6ZY6KYBygR1v/hWhMZDPhDmB+QZnuZw+P1FBPGKjCr0vRg/a04MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJvQ5fZp76RCPeoDJEQgC+DkVi1PBM4wY81/rp2aMQE=;
 b=iA1AR/hmAM3c1EU/kttBRXNf6C3V7bkzTECAIwRygALKKRIC4EHl2BlmOJWrg91RDbv869blC7tR4fsrooNOUgQOvUuv3MA5ZNYvq+lNGu9h+Lb8noyRNAQTKvLGY6UwrMfvO/dPqUeCSty+blxM9XiqCiSpC22H0TMkKra5LA2uU3SnxeOjbv0wugbBoavBBp2drEcqvSD+quNp6eRFWUe7PpKleV0aX9ux1NnvG9xhR0zDq4LQECLI5y5R9C1pVE+irPkvTf21Tk6Qq+xLopbPUGdbwA+eKLX5eAfq+AdC2sYHGX225BjKKFBgNW7m+cGjuvsuSzlosdYwO0vytw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by PAXPR04MB9105.eurprd04.prod.outlook.com (2603:10a6:102:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Fri, 26 May
 2023 14:05:20 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696%5]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 14:05:20 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org
CC:     Mike Looijmans <mike.looijmans@topic.nl>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] clk: Add nvmem-clock provider
Date:   Fri, 26 May 2023 16:05:13 +0200
Message-ID: <20230526140513.6943-2-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230526140513.6943-1-mike.looijmans@topic.nl>
References: <20230526140513.6943-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.bde89ba8-9823-401a-932f-0c2d16ab91ba@emailsignatures365.codetwo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM8P191CA0011.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::16) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|PAXPR04MB9105:EE_|HE1EUR01FT059:EE_|AS8PR04MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dff6c06-92ae-4767-add7-08db5df2411e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: sdhP1faTuo9zLzjP6HHzW1rVYCXRgMNGb/jYNbKipsHkOsvnThQZgZ/zzmdiNLBMPBYgB/uGBppECpJuFA3+eHac8AbQVdOO9V4uPcI60Nv7K7Lsug832acJR/3vYT40foSWNn5dXZBulZAZLwwObAJb/74rhPEhYlhiYtrTmr1BtoK5FXDWOWNd6E/412gCa5rQr18gvrscuuje4g6tOsYHdka75AazqTKSkyA9spQV/c37pQ6wkC2sp7uQ4dRKXHDWSAOTPSU7PV/SDN8E/ZLnSeOTLDwPU560spdkedtzj8WwwMDeZRbw+0L34ENJJKDjr6j3oR1XBBEOUq3fXVCNUMBxCVV4ITdx/j/4fm3MKkqjUgoxMR0Evl6ZLpCuBPKOQrVYsoYOqQxn1iEAW2fwdgGRCTj3FO3NoSfhyg0GJYqGIVg4pF4Ikn0EsfDqkfyFOw3LTNtdy8+tZmhKzYLd0NLaf5+goTzKzuA6+yPjbJE6aYqMpbAnTxUWjYqLKw3bL7mI3e/zGG671KNNfpNaMO0YoHWBVX5NnIL8cwj3adtbeE030CqbStih7s/Kg7dZm98xvosHZTbqeV8kL+X773MIc3cGp6oB92MndradQKbXyvf9tnTdJTtwqMmp
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39840400004)(376002)(136003)(366004)(451199021)(4326008)(36756003)(1076003)(41300700001)(8676002)(8936002)(186003)(6512007)(6506007)(26005)(42882007)(44832011)(2616005)(54906003)(316002)(83380400001)(5660300002)(66556008)(52116002)(6666004)(66476007)(66946007)(478600001)(83170400001)(38100700002)(38350700002)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9105
X-CodeTwo-MessageID: e62130b1-4071-457f-9a46-5bbdf3506e46.20230526140524@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT059.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 45906c6a-0871-45ce-e6b9-08db5df23dab
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VwCID8bIpz/f7cwP4/luyK1X6/0HiWx16gs3uJf4xT0cXa5Hy2ZcSI6K3cGv9PVsvT5ehzLAFeNJozjzmjNtjKA45IcX4Xydc9UIyUed9Jhpy7VnfKs09kCd8Ldsx4SNn7BFoM1kxSXU+WX4BhV/V3KsFA9VO82DmWICfKS/6dH5MLqgGXd+SiCZJ+CqpduT1XRufoE5jtWyS5CXQfU+dzmVS9jmXwu/qxg0DN1OH0DH+KqzV2ziLHqE9p7iO6kY3PpsGbLGIpb6kuuIU0bDqLXANK70Le1LHJOz4ZSBSP6Rw/uQ7W18wqc22YgTpaE7Z1PRcDz7gqYeXoByzo3s1EpZbQhZHftqHtBnSPFEHqGm+MNB8jaijK0VlHcuX5Q8wQonAdHhN+Tf/wpN0h0rbOx1n2GhmNQSJVdFxqjKuOWxwIm3lDVwwYPVXCzDZCMfWOVsJevTvzOEVU30/Kft/6ofNGL+EW5RuGbIcaMDozDLCgv15nBCf5qOe0ToUBX0wEi4fa2BZ0c6Q96Ox3BDXq5OWCztDfIO01RRNEIHAHQ0cUa2qfdUUyqlautqk7+GGXDnWYkLoV+CXF9HuwXWoapp7pih/eZgeT8/2plsc/++DABUXVRzHM2s0WJ42kmlMIczZtLdD/y7mON3RYIEsxRBR1/yDB/yPJyyh1xw+MPHnEF1PcM/60Mv6vAbC1t6BeV6Ur2lrUAjggUVGHsFsg==
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39840400004)(451199021)(36840700001)(46966006)(70206006)(70586007)(4326008)(54906003)(356005)(478600001)(83170400001)(316002)(6666004)(41300700001)(6486002)(186003)(2906002)(15974865002)(40480700001)(7636003)(7596003)(26005)(1076003)(6512007)(6506007)(8676002)(44832011)(47076005)(36860700001)(83380400001)(82310400005)(2616005)(8936002)(336012)(42882007)(36756003)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 14:05:25.7336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dff6c06-92ae-4767-add7-08db5df2411e
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT059.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8200
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
