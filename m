Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39827678EA7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 04:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjAXC74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 21:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjAXC7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 21:59:50 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7A2EB50;
        Mon, 23 Jan 2023 18:59:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fxu0YpLe9u5QWT6xGVzqpsZiIK3m2R0wtSRdeGWQzA5n+4S4fCXlIKJyxgFgNPOfDqt0cXt+i+W6dfm3hdS78YTnR9+z1q2Ved7V0eA8sTDW3UazYy+YSq7wz9lcvir5iRLVjZbnKjT4vNgFviWi9NO2LHoPbQB6OcUurGW3akRsnImMkA8DDnxLZzxWBSBjxvguSHUKZ5nEQKxZHNAbBFzwIvcykPpvnEGvgirtjsWk9YMb3nHtzlmqfMDXNz8kvAwNHOeO9Qisc5FN17SPgsc8NiRfLPFniTMlO+llFWuPCDr7+ACqvccz0+1bWkEfRAVZS/aqrlI+QBEoUCfyaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjlJBC7qztIPk4Sj2tmazuHuei4RKoeAGFyQ8i95ydo=;
 b=loFeNpwD0vki2AEDfxTzDd+EZxaXR0jpbzaiPkBPuRmMAqqBv+7lC2Ebk57gDQ1r7umGGKS1G5X/2uHI84cjNURMylclKIbW0JzpMTd8pLsdkZ7geEn1Ta2c7Ext2SQwYu68SDruVCt4Xk15KZ96s8e3vtfOWlRrAqVeKpL9DyNpB1wesOg3m0VIL4q7YGj7qEsLs7c3H2iLVPBrekoc/isvQgelR5jGVKvDW6w4DShR05uuYs8jM5uiVvTLtvQ49bPzW2+wF2Lp+6r9Hl3MMPeffF2gwbxyhv1jXn+ybMvFPnekAmJINRLA9hD2eTb1OWXUbYhduhT3NmLrOg9iuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjlJBC7qztIPk4Sj2tmazuHuei4RKoeAGFyQ8i95ydo=;
 b=kq4KMgAkYDzLOvN2lrFsWcVK6/xe+EmLCtccKS4dHXRUaeIP63v566h5fr04RrW5l0+FPTfBKrna2GVOoSce82uXHB1afaTGnP6bSpmFzCMgszCS1MkT06ABNiSVGTzR3UKc0Xwg7gCZd4flOk+Jn7CkNTWEPhOJAUFF3sS3o+8=
Received: from DS7PR06CA0003.namprd06.prod.outlook.com (2603:10b6:8:2a::27) by
 SJ0PR12MB5408.namprd12.prod.outlook.com (2603:10b6:a03:305::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 02:59:46 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::49) by DS7PR06CA0003.outlook.office365.com
 (2603:10b6:8:2a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Tue, 24 Jan 2023 02:59:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Tue, 24 Jan 2023 02:59:45 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 23 Jan 2023 20:59:41 -0600
From:   Brad Larson <blarson@amd.com>
To:     <andy.shevchenko@gmail.com>
CC:     <adrian.hunter@intel.com>, <alcooperx@gmail.com>, <arnd@arndb.de>,
        <blarson@amd.com>, <brad@pensando.io>, <brendan.higgins@linux.dev>,
        <briannorris@chromium.org>, <brijeshkumar.singh@amd.com>,
        <broonie@kernel.org>, <catalin.marinas@arm.com>,
        <davidgow@google.com>, <devicetree@vger.kernel.org>,
        <fancer.lancer@gmail.com>, <gerg@linux-m68k.org>,
        <gsomlo@gmail.com>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee.jones@linaro.org>,
        <lee@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <p.yadav@ti.com>,
        <p.zabel@pengutronix.de>, <piotrs@cadence.com>,
        <rdunlap@infradead.org>, <robh+dt@kernel.org>,
        <samuel@sholland.org>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <will@kernel.org>,
        <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v9 11/15] spi: dw: Add support for AMD Pensando Elba SoC
Date:   Mon, 23 Jan 2023 18:59:35 -0800
Message-ID: <20230124025935.42081-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAHp75VfurZMfRbqDt7WRY368uu4NM3r2a6SDCogOukBZN5J8yQ@mail.gmail.com>
References: <CAHp75VfurZMfRbqDt7WRY368uu4NM3r2a6SDCogOukBZN5J8yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|SJ0PR12MB5408:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a50486b-3819-47c0-c7ff-08dafdb70cb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pgm3ApG+D+ov4x1pSqmPEXmEps6gdIPTQOGdilabo9uhSBOQOAxyIn8oXWwjr7zMkaSnHWqklDZUSsfh1p8O4ZS0M7mc2T5JLUvkm9iWZCYrOdz37i862iCJIvITRw/+8Ni5d+x5uXdpOqP+eWJTiGa4tNiGuOoONJhdJOTEM70zoKSZKgfc62OvvXKja0Qmr4hi4I0WFZm0YNNjVVdbjukPCgBJR1dbevSwsHJwjLvgLQH4NcuNMH4gHPHpGDLvL3VnIu7YfY46HD33xiPB8Ce9JMPyD9tevI7EyqyhsSr9BHV04vxagXshiBqJ0CM51ndqz3iuXKq2UrZY7hq2QTPhn5JQaM9ICRKzgg4jL6fuRsVwGkQFzQAK4azOVbYAHVW293PW/5q8OSj/GNKLwgPyWs2PgTpPCs7ASORExCblp0EB9kyA4tA15tklfqdrAX/tNnsYSRgqmcISlx+707ZO9Z0kAd4CmVJsCMMfI+H1WvPxMp4Jo29EE1zAdxde6Zjcyb+MlTXduYOP1omNYdQPf87ICyYGEIDGnZplKr0BQO7VwyfjDljeRi31u2ztEo9tpEkVz64V0idOZupt0oqIxndpFr7SXzCh4qy/8G32KkuMT6tfBBKHXeR4P4EYMzEbaIcFj4gYxjiU81XPZEWh/+GSEF/k3Suej1Scw9vPbY6i6cURGISBmrEQW4VyZai1Rx5RZwN5xQBDcqh5sr/gvm/5HsY1fOetA6p2NhA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199015)(46966006)(36840700001)(40470700004)(36860700001)(83380400001)(82740400003)(356005)(2906002)(5660300002)(81166007)(41300700001)(8936002)(7406005)(7416002)(82310400005)(4326008)(40460700003)(186003)(40480700001)(16526019)(6916009)(8676002)(26005)(316002)(336012)(47076005)(6666004)(426003)(70586007)(70206006)(53546011)(2616005)(54906003)(1076003)(478600001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 02:59:45.9425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a50486b-3819-47c0-c7ff-08dafdb70cb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5408
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 9:58 UTC, Andy Shevchenko wrote:
>On Thu, Jan 19, 2023 at 5:52 AM Brad Larson <blarson@amd.com> wrote:
>>
>> The AMD Pensando Elba SoC includes a DW apb_ssi v4 controller
>> with device specific chip-select control.  The Elba SoC
>> provides four chip-selects where the native DW IP supports
>> two chip-selects.  The Elba DW_SPI instance has two native
>> CS signals that are always overridden.
>
...
>
>> +struct dw_spi_elba {
>> +       struct regmap *syscon;
>> +};
>
>Why can't struct regmap be used directly?

Yes it can, all that is needed is regmap.  See result below.

...
>
>> +static void dw_spi_elba_override_cs(struct dw_spi_elba *dwselba, int cs, int enable)
>> +{
>> +       regmap_update_bits(dwselba->syscon, ELBA_SPICS_REG, ELBA_SPICS_MASK(cs),
>> +                          ELBA_SPICS_SET(cs, enable));
>
>> +
>
>Redundant blank line.

Removed

...
>
>> +               dev_err(&pdev->dev, "failed to find %s\n", syscon_name);
>> +               return -ENODEV;
>
>return dev_err_probe();

Changed in both places.

...
>
>> +               dev_err(&pdev->dev, "syscon regmap lookup failed\n");
>> +               return PTR_ERR(regmap);
>
>Ditto.

Smaller diff with the above change and looks like this:

--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -53,6 +53,20 @@ struct dw_spi_mscc {
        void __iomem        *spi_mst; /* Not sparx5 */
 };
 
+/*
+ * Elba SoC does not use ssi, pin override is used for cs 0,1 and
+ * gpios for cs 2,3 as defined in the device tree.
+ *
+ * cs:  |       1               0
+ * bit: |---3-------2-------1-------0
+ *      |  cs1   cs1_ovr   cs0   cs0_ovr
+ */
+#define ELBA_SPICS_REG                 0x2468
+#define ELBA_SPICS_OFFSET(cs)          ((cs) << 1)
+#define ELBA_SPICS_MASK(cs)            (GENMASK(1, 0) << ELBA_SPICS_OFFSET(cs))
+#define ELBA_SPICS_SET(cs, val)                \
+               ((((val) << 1) | BIT(0)) << ELBA_SPICS_OFFSET(cs))
+
 /*
  * The Designware SPI controller (referred to as master in the documentation)
  * automatically deasserts chip select when the tx fifo is empty. The chip
@@ -237,6 +251,56 @@ static int dw_spi_canaan_k210_init(struct platform_device *pdev,
        return 0;
 }
 
+static void dw_spi_elba_override_cs(struct regmap *syscon, int cs, int enable)
+{
+       regmap_update_bits(syscon, ELBA_SPICS_REG, ELBA_SPICS_MASK(cs),
+                          ELBA_SPICS_SET(cs, enable));
+}
+
+static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
+{
+       struct dw_spi *dws = spi_master_get_devdata(spi->master);
+       struct dw_spi_mmio *dwsmmio = container_of(dws, struct dw_spi_mmio, dws);
+       struct regmap *syscon = dwsmmio->priv;
+       u8 cs;
+
+       cs = spi->chip_select;
+       if (cs < 2)
+               dw_spi_elba_override_cs(syscon, spi->chip_select, enable);
+
+       /*
+        * The DW SPI controller needs a native CS bit selected to start
+        * the serial engine.
+        */
+       spi->chip_select = 0;
+       dw_spi_set_cs(spi, enable);
+       spi->chip_select = cs;
+}
+
+static int dw_spi_elba_init(struct platform_device *pdev,
+                           struct dw_spi_mmio *dwsmmio)
+{
+       const char *syscon_name = "amd,pensando-elba-syscon";
+       struct device_node *np = pdev->dev.of_node;
+       struct device_node *node;
+       struct regmap *syscon;
+
+       node = of_parse_phandle(np, syscon_name, 0);
+       if (!node)
+               return dev_err_probe(&pdev->dev, -ENODEV, "failed to find %s\n",
+                                    syscon_name);
+
+       syscon = syscon_node_to_regmap(node);
+       if (IS_ERR(syscon))
+               return dev_err_probe(&pdev->dev, PTR_ERR(syscon),
+                                    "syscon regmap lookup failed\n");
+
+       dwsmmio->priv = syscon;
+       dwsmmio->dws.set_cs = dw_spi_elba_set_cs;
+
+       return 0;
+}
+
 static int dw_spi_mmio_probe(struct platform_device *pdev)
 {
        int (*init_func)(struct platform_device *pdev,
@@ -352,6 +416,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
        { .compatible = "intel,thunderbay-ssi", .data = dw_spi_intel_init},
        { .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
        { .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
+       { .compatible = "amd,pensando-elba-spi", .data = dw_spi_elba_init},
        { /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);

Regards,
Brad
