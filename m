Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874036007D4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiJQHjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiJQHja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:39:30 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC433882;
        Mon, 17 Oct 2022 00:39:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PP/+nOtABHumazqWJP1UK3JagJXQx9bB6UlbOxB8crfUblXBtPcVtDGqH9OQRJaGuYD+yMmA8uvCsZpMSQDsQPdDkWlMJ8xm05YpueY9ga2UwZ8NUsLcz1bYcNg1iVsEQGRURZKSTBLkv2xmpMVn6eXCX8bVdvSVyjUNbDuEltPkfPE1zDI9dLexTr944IgkDHkgexkRyb56fErbnVRYaKSYQPO9xOMif5F/sWCEvXIj1RDw7T8a3u9th75LpvN72S5Zmjccc+z0chSSHNYjc3Ld7VvqbHpqpNg8q66B4NQ+22xQ/tUAY7fpVW4FPh2kP/bp0JFAIjFtLaBtdkokDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LuE9t6xE7VgZDLpktxCcelohM6tQZoKemd1YsbKbV0=;
 b=oBIWSXzBMJxy6RfQZOzAzdwr23zVVa0DecW0/cHwaiitY10QNltRNSQrwI4PrflMDg2o+199KFwFSsUaxRZEZgK6Ajb1wdTIcyp48F+AF+EN68CBmKPauhJuc4lWkq1lTv5Z8D+Q2c/Ui/mXp0SC7DsGNpWOZlbvSuXaoZe73Nlq894e1jjEz5/UPP3AqS32z6wxXHdovK5/2pEUMOBvb7mXQxyHZ9MeVdEliTQJc9f9pTbrwEH72OcebovNdXpkV8FUunotYmr3jR3Kst0n1WjwAUNdrBr3xZFyxjj0G+QSjRVdE2uAF+TLQMpI1qtr4p4KzOYO7360TYYH17N9Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LuE9t6xE7VgZDLpktxCcelohM6tQZoKemd1YsbKbV0=;
 b=WpiZj99KRUIVXO2z+/ysyzwbsMI9rcpbS9l6U3jQvjOVpFKwvOIdpRju8YqN5gFD77cze6cLPy5rpnqdtA9CJ17IFj7TgKHAGIHIsuzv81/faAFLeCajs0FhnlmpykaLLNdk6el713Ig0QaBj9lLUrvLO9CaFY55IxEm5A1YZqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AS8PR04MB8296.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 07:39:23 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::181b:75f7:dbc8:b4bc]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::181b:75f7:dbc8:b4bc%6]) with mapi id 15.20.5723.032; Mon, 17 Oct 2022
 07:39:23 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, saravanak@google.com,
        gregkh@linuxfoundation.org, geert+renesas@glider.be,
        krzysztof.kozlowski@linaro.org, robh@kernel.org
Subject: [PATCH v4 RESEND 1/2] drivers: bus: simple-pm-bus: Use clocks
Date:   Mon, 17 Oct 2022 15:40:38 +0800
Message-Id: <20221017074039.4181843-2-victor.liu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221017074039.4181843-1-victor.liu@nxp.com>
References: <20221017074039.4181843-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AS8PR04MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: ee2c4fe2-dda8-4219-e034-08dab012b5a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c+vkZl6Pf2CTX90/qRcYxaE5058DMHqJs0y1jrpOmVM/5Wq1Je9HKS0KbGsOfDT/oE8Qw3j64tyTWyX5ZmaBfZZoJ0KFIOceCA1N/T4xPSDXhLXSji2+n02UK0Zna2Mf/tkrWD31W37en+TMUvVZXGyDW07E8dhronCASO2Lco8lls16N73bcrEe1FLp+xG8KP/HpDAjIecnDVslQX8/GgTCwbyrhHbFRPH2y8PifUs/t0DSjffbseMU6SozaeW8Vl8FtlEpcVvuibsU9EGF2paOTW0F+ET4cyqAmef2jau3M/7cf/bT5pbGrnIfxIHsbmiXDTnSkdpb1v16sZC/tk9KfI8KCK1wTiBomsnTxDQQ+yJmg+QewS/d1D+eIxVIJ2KcFtUi93Nlpz4m53O5yXny3Z+PtN1FZ75gWh2CSCEGKQcymIhXCOhh7dbdSfkLUcEn8zbuAIvCIJppeeYphdqzHc9eOy/kK1eHM5q8BUnJpe4MeTuc2G4NApgimUiQx224RwviZo4PfOgrjvxZtSUpbrCGaLILJGIbuTUAYn0uCFEXzsmc3RcbdiK/WpMegrZxqIWjKAf7V+rcJgnHYeeXTszfO44v4NLTPvLe+8MN+z9QFfv90veBE8hkIV0kIxIdUn73OpQDUUvFlCIx/F4ApIZcOJt5/LGJdXnysxsYk0rwLEYj21fZOrZ9qD14cDDgWER/DgZn6Wf2BEPOYOJ3SyhGgaqhyKy6hwChT+OwrOPps5ekX1KlLuIbFz+Oc3qDvlNbW7NhsJAlys9aiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(4326008)(8676002)(6666004)(66476007)(66556008)(66946007)(83380400001)(52116002)(6506007)(36756003)(86362001)(41300700001)(5660300002)(26005)(6512007)(8936002)(7416002)(316002)(2616005)(2906002)(38100700002)(1076003)(186003)(38350700002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w7g8z3ZIKhPcrWpgLcFqRNdqGnkiJDCbbc9VP4Jin2kLLOEUazOmXliPEwAJ?=
 =?us-ascii?Q?yzxw4a9AYBhv9LzNJvECOMrrl1U37uH0+lZ/2nNA8EDLU72eqLVsjC3iRj4f?=
 =?us-ascii?Q?KoIamMPzv5d+niVK6V0ejwbUW3HEGjOlTbjGXxAFEyLWxt2s+ZZWqm6QXAEz?=
 =?us-ascii?Q?xlW5Lfw7lt74soXvzklU5xoJ0GZNTtf7w7RUzqX8wS/KNhwjR3chb9Ln4GL1?=
 =?us-ascii?Q?kUmeFDky+3Wp3DETXqAisJJ5cW+YzmRFW4zHKibOu7ZZvvrnVrS4mJw+d9L/?=
 =?us-ascii?Q?8HobwHtdoTjpxfGRd8fUYAJCFW6vHF9KQ4EDTCdZ86gqx0O53Qp7nCFlNBBA?=
 =?us-ascii?Q?pyDD1+HSgdTqQ9NoSpyiDtZ9nBGkNOEOGRZNXQ+bTinHImAW8T6eRKeCuzeI?=
 =?us-ascii?Q?feXcnvZ9zQmBAZvBzECpiZsX3f9MOKkPQsJmvviq2jFRrpasL8TsFAAkTg5z?=
 =?us-ascii?Q?mNazMopImHXd1nkj0PKYxXTrsV5KJipuCp37t1HAhnf+GVOPn28CaGfEe6SF?=
 =?us-ascii?Q?G07ikpyYr1ta1NM67fR6b/bExUPX/05VqrZhw4DiMJGjjtjnQALGMFq3+QP7?=
 =?us-ascii?Q?tk01T87bL25wfK2i1lJBYMZHoBhCrgZH3F6HOenwS20d1Wsus9btv48YGcLB?=
 =?us-ascii?Q?JLhqVFYEx2Xfztu9owXvwyB2qXwpHN+wf2gAGKGietsAwd5tWuxbWFO0AaJd?=
 =?us-ascii?Q?Yx5i67BPOIy2r2r0Vqwu1LjM5GpdaduPW5iD1veiRLEkXtVWC7ib7HFtV2Rw?=
 =?us-ascii?Q?BG3StgzMZgkxA9Mcl6ffoWFAorcFfbJrGS7LMwMFMeqwrAFmAyEsDXzLxs6D?=
 =?us-ascii?Q?n+cgc0VX3qIiQa7LxW7mOZ42VRELUKG300JAhonY5rT6meQx5//MiZxgrjJW?=
 =?us-ascii?Q?bFVAX9hoKqC/axDka5C+Pk51DaiSdnbNtEKiJyEtKKqWQbjnCWQ+If/7i/5K?=
 =?us-ascii?Q?QkXDShZoxLnXsqDoIKqF5lhKif819EGE0z+4WhM8Hp4THoVsvBCEm+Esd8Vx?=
 =?us-ascii?Q?xbyiyvpDRjnZlbYtqJGYbSta6Rr/ZnegJO/P4T+/SkzW+XSOT3bRPgvPMsQ1?=
 =?us-ascii?Q?XTbET6wi97YDsHxsDTOCfbGzyDyOEQSXfMcK4FMzUW9sCREN44Law/7T3RFM?=
 =?us-ascii?Q?VkMVXEzuhGN+f2uxG9t+nDw6f+Fj4CGnFxGGckquqU/W0mmN04OnH1O8OPAc?=
 =?us-ascii?Q?tCE1/tx0cWSn80AUJW2Zt+A1qEKP/G+i+YqRm+XUgSsS3decVAaIAUlXyF6W?=
 =?us-ascii?Q?wZXLV4krV0GsUNFHn4n61f7vO1u4jf8tZXGz1MUt/bVoL5cteUqA0f0GxujL?=
 =?us-ascii?Q?ikSJ3Yv1qdmOXDSgUCYhfrYT/K3Gnxtve0RN1a/F79MgCEAARBCp4DcDx7HA?=
 =?us-ascii?Q?fxAV2MIETf7wm2erxGQ8WOiL7mAhLWXUL9vJwoqt7VmQ+aSzDD+fx9ytwRvd?=
 =?us-ascii?Q?VJW61bX3Ur2dH2wFaOznN1EQq+Qz2nNdo0Kccvl+G44oJi2qm0wrTiktSjut?=
 =?us-ascii?Q?F4WGCpBjdncSslfVcSyBSrDI6fWwX7xeDwH4k9BZnDGvtWZFOb3wc/BmlPs1?=
 =?us-ascii?Q?9nYwgw1OMz/JN2IJmLw80r35/OKmMx8aOqizaoCf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2c4fe2-dda8-4219-e034-08dab012b5a3
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 07:39:23.2161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rxv+cZBSBuAeeAFMzhqcNUe6N64MjAuskOvh5Cf62S/0JgPbuWWyqkBHLQiAwfzugunTx3P5hUPfWVDH+GoVkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8296
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple Power-Managed bus controller may need functional clock(s)
to be enabled before child devices connected to the bus can be
accessed.  Get the clock(s) as a bulk and enable/disable the
clock(s) when the bus is being power managed.

One example is that Freescale i.MX8qxp pixel link MSI bus controller
needs MSI clock and AHB clock to be enabled before accessing child
devices.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v3->v4:
* Drop unnecessary 'bus == NULL' check from simple_pm_bus_runtime_{suspend,resume}.
  (Geert)
* Add Geert's R-b tag.
* Resend v4 based on v6.1-rc1. (Greg)

v1->v3:
* No change.

 drivers/bus/simple-pm-bus.c | 48 +++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
index 6b8d6257ed8a..d7b043fefde9 100644
--- a/drivers/bus/simple-pm-bus.c
+++ b/drivers/bus/simple-pm-bus.c
@@ -8,17 +8,24 @@
  * for more details.
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
+struct simple_pm_bus {
+	struct clk_bulk_data *clks;
+	int num_clks;
+};
+
 static int simple_pm_bus_probe(struct platform_device *pdev)
 {
 	const struct device *dev = &pdev->dev;
 	const struct of_dev_auxdata *lookup = dev_get_platdata(dev);
 	struct device_node *np = dev->of_node;
 	const struct of_device_id *match;
+	struct simple_pm_bus *bus;
 
 	/*
 	 * Allow user to use driver_override to bind this driver to a
@@ -44,6 +51,16 @@ static int simple_pm_bus_probe(struct platform_device *pdev)
 			return -ENODEV;
 	}
 
+	bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
+	if (!bus)
+		return -ENOMEM;
+
+	bus->num_clks = devm_clk_bulk_get_all(&pdev->dev, &bus->clks);
+	if (bus->num_clks < 0)
+		return dev_err_probe(&pdev->dev, bus->num_clks, "failed to get clocks\n");
+
+	dev_set_drvdata(&pdev->dev, bus);
+
 	dev_dbg(&pdev->dev, "%s\n", __func__);
 
 	pm_runtime_enable(&pdev->dev);
@@ -67,6 +84,36 @@ static int simple_pm_bus_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int simple_pm_bus_runtime_suspend(struct device *dev)
+{
+	struct simple_pm_bus *bus = dev_get_drvdata(dev);
+
+	clk_bulk_disable_unprepare(bus->num_clks, bus->clks);
+
+	return 0;
+}
+
+static int simple_pm_bus_runtime_resume(struct device *dev)
+{
+	struct simple_pm_bus *bus = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_bulk_prepare_enable(bus->num_clks, bus->clks);
+	if (ret) {
+		dev_err(dev, "failed to enable clocks: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops simple_pm_bus_pm_ops = {
+	SET_RUNTIME_PM_OPS(simple_pm_bus_runtime_suspend,
+			   simple_pm_bus_runtime_resume, NULL)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				      pm_runtime_force_resume)
+};
+
 #define ONLY_BUS	((void *) 1) /* Match if the device is only a bus. */
 
 static const struct of_device_id simple_pm_bus_of_match[] = {
@@ -85,6 +132,7 @@ static struct platform_driver simple_pm_bus_driver = {
 	.driver = {
 		.name = "simple-pm-bus",
 		.of_match_table = simple_pm_bus_of_match,
+		.pm = &simple_pm_bus_pm_ops,
 	},
 };
 
-- 
2.37.1

