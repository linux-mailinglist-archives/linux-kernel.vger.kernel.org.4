Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BF3722817
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbjFEOCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbjFEOCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:02:10 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2082.outbound.protection.outlook.com [40.107.104.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CBE99;
        Mon,  5 Jun 2023 07:02:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BauuUyEKH3u1hEeU/RPo631ZzqOu8g5t/rBd7YQAiE4apHgi0ek9mRXFxBZ3B/m1bPVkHI5OKPxhPHsC3T8Z7EVs1G1jMGx6fZNZRmy/9s/PZb14s5aBtC8IFQdm28FM1ntkpU3ufsWvX6jIpoL+zu5DQtOdfaZqf2Y88RRB5OeTCZHKE46ggOlZqe/pAWGYljgmZQcNUd4uU18y/JUsqLVAH8opQx6zvBvrhSWwTkz7ryoGPOwWf/UzkAo/1WjlK0JczmP2LBGLWKM3ePF7hXUI8KjMj6aOfI29klfZLwDZm54hedJvu0SOog1OL8W4ZNBC96Dh2cFStR+9ThcoSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACNTvMS01QKa/OHBdOFK1KXMr2wxvU+0YiJnwR2fA+Q=;
 b=NcjAKjQXmnCTxp6RxO6BKk4cbEJPJzU+VQfE/ayBqq7tUWCZMpwstKGGnoEduxrDqoxoJJEdZvqUDHlya0TakkkFO3Y1yJMc5cgt4T3UuH0+hRP66/p1ZyYmMxtGWRSY34PiqfwIEA1OY7UWrfITsM1h9SdHzZZnUzdU2jwLBkhSEwKCnjt9XFZshb76mqmc6GVVApsnBJBfrhq9aaUPy3sNWKnZjWvonkX8JyYCe7YxlUgfySdj0tCfVRgnkoMzF0CZ7kFduTeAYJ+rl5B/+h8nxH1220NsacTmB06WvGnCzTbkWF2O51bZgrFTGjbU6WOQFLq/RgSdRxo91L5LKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=topicproducts.com; dmarc=none action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACNTvMS01QKa/OHBdOFK1KXMr2wxvU+0YiJnwR2fA+Q=;
 b=Beu88oXGPUuUSUu9hu01gVGDcyuulpgVH8kmQ8pUsOrviZce/eaekYdI/swrrrK+fk3olqVTxqjrU4oS+G9R3oAVOCXfnw9aifo5leMFe/QmnxwIxZU1/CNkX9gP1j1qmqKqPmg3VWOy2ziavnRwjXBS45IJj8jV9ccuwxfWU3CbFMx8iZuijzgfvn7OyMSfAODk8TJhgk0uVZ2wCQq7wtPK62D9LcR9gnX2BkQn6K9iG1LVDzYaImClhxCgFnsGOn9VsrussZedJcte0fhDIQ9GkDBqHeZSTYiU2PuoUT1TumY/o82Faxb3TI0dbgoZLs5Pt/d7LOQOCcdz8afx5Q==
Received: from FR3P281CA0112.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a3::15)
 by DBAPR04MB7288.eurprd04.prod.outlook.com (2603:10a6:10:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 14:02:01 +0000
Received: from VE1EUR01FT083.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:a3:cafe::56) by FR3P281CA0112.outlook.office365.com
 (2603:10a6:d10:a3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.18 via Frontend
 Transport; Mon, 5 Jun 2023 14:02:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 VE1EUR01FT083.mail.protection.outlook.com (10.152.3.59) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.18 via Frontend Transport; Mon, 5 Jun 2023 14:02:00 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (104.47.0.58) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 05 Jun 2023 14:01:58 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by AM9PR04MB8193.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 14:01:56 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696%5]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 14:01:56 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org
CC:     Mike Looijmans <mike.looijmans@topic.nl>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] clk: Add fixed-clock-nvmem provider
Date:   Mon, 5 Jun 2023 16:01:49 +0200
Message-ID: <20230605140149.16841-2-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230605140149.16841-1-mike.looijmans@topic.nl>
References: <20230605140149.16841-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.126def07-6421-480e-9340-c05b31d83203@emailsignatures365.codetwo.com>
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0048.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::21) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|AM9PR04MB8193:EE_|VE1EUR01FT083:EE_|DBAPR04MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: be7b8b7e-48be-4818-8861-08db65cd6efe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: eXD36CjAFWQ4IeOObI3ALHzTGbAIT6aYnbGLJ8JuR9eMAmlOeXqLYGtD9IzbOQj9LO+n2AyuicBDCanvEDAebOgqHBguWy8jhKB8MyOR3zjWx72/h+vkrUS2uhCVRc++coyidA9LMCKNOcNrG7k6GCjKlzAR5BdfBi+J4ngfGxo6pX09supr+czH6cNF9khlbgeS3A6GvfdO1sQqeeQ5b2iHSDTOFFqw8PJqbdEAx/Ag5ZPef3xGnaRQu9ospybOMiLOwjmPopjiCyI2brWa539gtc53R25bR4weWElss/YkcjDT049BVE0+L0rRRKmTqq2Hb7VcRnJa9f6CO8fD+SB8SpaCsJz0JAGT5odjwljRVPBwKFVUZnN31bomrwefjO09mgQDYXHJBqPw1akzNDQ6QlKeZm7b61OT0uaxUrAQdO14R8l4X+tXhlFBl0lLdiyFb+RalI/ABlTgrW0BeM6NWF+yjLWjhfDRN85hNaOdSRcMlt0/5wJQB33Ln0eq+43u1MRFKDgpDuPaSj5sMR1xDUK6MFTDgqMju+eqCKG7+SLnj2uQeUcaIjTx4aDvjzLiJU4Ac8UcVJOHm/yvVMd+L59EGPjRv4/MkcPhhLLipYL2BcJteyPgvReoYl5H
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(39840400004)(346002)(451199021)(83380400001)(42882007)(83170400001)(44832011)(54906003)(478600001)(8676002)(8936002)(41300700001)(316002)(66476007)(66946007)(66556008)(5660300002)(38100700002)(38350700002)(4326008)(6486002)(36756003)(6666004)(52116002)(2906002)(6512007)(186003)(6506007)(1076003)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8193
X-CodeTwo-MessageID: 2eeee32c-7dec-4d7d-9a63-f7c352689976.20230605140158@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT083.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 17a3b140-8a40-46be-25b1-08db65cd6c63
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qTJUixgxqSw1KxBUSnfNVry8MsL+ssLK5AIRYM+RWrPQRgZyytMml0TI2q4ovzJCkKF5SH3/f8ar7ZJPCRTYHAHPwdwvfIkJR9dYK8H6YFAy8UhpcH4sEVk/F7GpNcEHIYjZyWaQsEZp3AP35IRrM0T+eC4gKWu4hxznJbWpMEu19arWj+D3JkGzetN8xPEmjWoXM5OTc6sm7LBS5sddiMGR44GbMGG9ZJFaqza9GFdN/yHigojpTTAvwL931aFpMKI6dd66MIHxBglkE9divpec75ZZldATwpcQjNg5B+S+xJ4lcKyDNK/MaYzYgAqWxZFXmCwM5wSNtcPTrxpO+uHt/MmdyrKdxEusHmygjIH0tEeIYH5CLwAqH0MFI7s6SKldrurX9KjvaFBp9F54lcIfM483jkq+jcGYSPA9a6NTFDvi4Ai/PhDlX1O6A0xw+legP0GGb7F6Y+scA6REVckPCRphPXbu6ad9mSz8/Xg5nQ1uBmKm62+iKjOBQ4wnZNiX/4HHsG2X+nRhOmeTg9sDjHW04FbdGkMYmdT+DJgqPlRw7mXEJA+YiF0/nJmU/dDLx8dmEyrkHfdstxK0xxbZY2IyMjvkEf7j+1KYQKWNes4e1gnACXVLD5/nt4MS4qKgm0IrvR4Eqs1reayi8HIDJ5N/xeDVJUAab84AGZt4BHlO/SmssVQnHIv6DxZv+m/9Oeggzpbr1OVy1hj1fQ==
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39830400003)(376002)(346002)(136003)(451199021)(46966006)(36840700001)(70586007)(70206006)(2906002)(478600001)(316002)(4326008)(8936002)(8676002)(41300700001)(54906003)(44832011)(6666004)(5660300002)(6486002)(7636003)(6512007)(6506007)(1076003)(26005)(83170400001)(7596003)(356005)(2616005)(40480700001)(186003)(47076005)(42882007)(83380400001)(336012)(36860700001)(36756003)(82310400005)(15974865002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 14:02:00.6595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be7b8b7e-48be-4818-8861-08db65cd6efe
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT083.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7288
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
range of input frequencies using the clock framework, but this required
us to patch the devicetree at runtime or use some custom driver. This
provides a more generic solution.

Because this clock depends on other hardware (typical NVMEM provider is
an I2C EEPROM) it cannot be integrated into clk-fixed which uses
CLK_OF_DECLARE to initialize.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

(no changes since v3)

Changes in v3:
Change compatible to fixed-clock-nvmem

 drivers/clk/Kconfig     |   7 +++
 drivers/clk/Makefile    |   1 +
 drivers/clk/clk-nvmem.c | 113 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+)
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
index 000000000000..19aad5cd222f
--- /dev/null
+++ b/drivers/clk/clk-nvmem.c
@@ -0,0 +1,113 @@
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
+static int nvmemclk_retrieve(struct device *dev, const char *name, u32 *va=
lue)
+{
+	struct nvmem_cell *cell;
+	const void *data;
+	size_t len;
+	int ret =3D 0;
+
+	cell =3D of_nvmem_cell_get(dev->of_node, name);
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	data =3D nvmem_cell_read(cell, &len);
+	nvmem_cell_put(cell);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	/* Abort when all zeroes or all ones */
+	if (!memchr_inv(data, 0, len) || !memchr_inv(data, 0xff, len)) {
+		dev_warn(dev, "%s invalid, using default: %u\n", name, *value);
+		goto exit_free_data;
+	}
+
+	switch (len) {
+	case 1:
+		*value =3D *(u8 *)data;
+		break;
+	case 2:
+		*value =3D *(u16 *)data;
+		break;
+	case 4:
+		*value =3D *(u32 *)data;
+		break;
+	case 8:
+		*value =3D *(u64 *)data;
+		break;
+	default:
+		ret =3D -EIO;
+		break;
+	}
+
+exit_free_data:
+	kfree(data);
+
+	return ret;
+}
+
+static int nvmemclk_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	const char *clk_name =3D dev->of_node->name;
+	struct clk_hw *hw;
+	u32 rate;
+	u32 accuracy =3D 0;
+	int ret;
+
+	of_property_read_u32(dev->of_node, "clock-frequency", &rate);
+	ret =3D nvmemclk_retrieve(dev, "clock-frequency", &rate);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "failed to access clock-frequency\n");
+
+	/* clock-accuracy can be provided by either NVMEM or property */
+	of_property_read_u32(dev->of_node, "clock-accuracy", &accuracy);
+	ret =3D nvmemclk_retrieve(dev, "clock-accuracy", &accuracy);
+	/* Only abort in case of deferral */
+	if (ret =3D=3D -EPROBE_DEFER)
+		return ret;
+
+	of_property_read_string(dev->of_node, "clock-output-names", &clk_name);
+
+	hw =3D clk_hw_register_fixed_rate_with_accuracy(NULL, clk_name, NULL,
+						      0, rate, accuracy);
+	if (IS_ERR(hw))
+		return dev_err_probe(dev, PTR_ERR(hw),
+				     "Failed to register clock %s\n", clk_name);
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
+}
+
+static const struct of_device_id of_nvmemclk_ids[] =3D {
+	{ .compatible =3D "fixed-clock-nvmem" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, of_nvmemclk_ids);
+
+static struct platform_driver nvmemclk_driver =3D {
+	.driver =3D {
+		.name =3D "fixed-clock-nvmem",
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
