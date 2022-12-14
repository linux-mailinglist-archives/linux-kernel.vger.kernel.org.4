Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCBC64C283
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 04:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbiLNDHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 22:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237083AbiLNDHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 22:07:31 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2138.outbound.protection.outlook.com [40.107.105.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA1823EAE;
        Tue, 13 Dec 2022 19:07:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuNV4r7xqgd4gCojnninbjVzeyML5LK7/SXOQ8Tv3SoZhvgQhc2IFbZs5zwZPmPVyk3vY5OZzkM/vaEfAQ0d6v4/YZsq2/kMjgOYleM2YaA+KOrrchdzDjCRc0RnAzHzYnpKL8cXHPmdRQVJPqORyD0QtmY4Xyf35afjttihEzRc+IxxjTXIHpmnkUFTsUFgViqERomCxIMgCEsPD5Ufh8QGBA7FZuTjVhFBN3zzKG0HqJ9Xci/z/t0nSbqK/N38L3VfL6XTmeKdmnAQYAQVzy9KbTjgakuLSm0VscfG/XpQtS+Teyl5vYjonBq5EL7DHWT1z0qTNDZEBwy4Nsi4PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTZxqgyTh5Qa7gdQgrB34dfPDBc4rzCVQtm3RyxgQ94=;
 b=DlhO0lhm7133Ga7U41xBicCxnq05wkk954OQg8GO3AihY8NsMfJKbEPkL6VqtwG2dmq9q9I/R6hB4f/sztO05NxAJ5cZXp+4kFd1ooSPdUi3YbEch7p1ybK6bv67IcCMuwBiQJt8zRqwYcauxlVPUGWCfwwas8se6x6VutXVXDGx5D6Pu6ntKKJUjS9HW7M5KA/Ti9BmAhFG8dNTWgPO72SdnO+rOZQSxLFkrC04ULc1Y4Dd5B43CNeoAdY/mDOuOAaOtX5pCWGOtAL1n7K+Kl04/kWM5oVT5xJirCROjk1Nldog091S1oDWILjT2Xun7MGkFagOwhpfSRB+6l8SDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=reject sp=reject
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTZxqgyTh5Qa7gdQgrB34dfPDBc4rzCVQtm3RyxgQ94=;
 b=KrPsIwSmlKvzYauTb7ReiQg2XuP5BihWbQMw5CE/8feBrr/c5/pO5TrAnlFVv+XOr/XzIoJiGTu3HyBdPi4wE6fGzQauWlOhX/efJST6IeR/vfMhFFUmIxCx8rypnOHa4dTz6fToYiTmyWuL1VZNVBTH5ntHdBVqFL3gHLFfjow=
Received: from DB6PR1001CA0048.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:55::34)
 by DB6PR0602MB2838.eurprd06.prod.outlook.com (2603:10a6:4:9e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 03:07:26 +0000
Received: from DB5EUR02FT062.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:4:55:cafe::9c) by DB6PR1001CA0048.outlook.office365.com
 (2603:10a6:4:55::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19 via Frontend
 Transport; Wed, 14 Dec 2022 03:07:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 DB5EUR02FT062.mail.protection.outlook.com (10.13.59.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.21 via Frontend Transport; Wed, 14 Dec 2022 03:07:25 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Qing-wu.Li@leica-geosystems.com.cn, 18701859600@163.com,
        bsp-development.geo@leica-geosystems.com,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V4 1/1] clk: imx8mp: Alias M7 SRC/DIV to M7 CORE
Date:   Wed, 14 Dec 2022 04:07:19 +0100
Message-Id: <20221214030719.4123889-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221214030719.4123889-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20221214030719.4123889-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR02FT062:EE_|DB6PR0602MB2838:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 99132dc7-b20d-4599-ac1c-08dadd805421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TZ6jUPJN7CSNpY3voXec6XnecVF66FGRF9Tj5+A0D0JCZB52DLdu6miMBTBk7jyRP3DaG7QNoFh8Xg6nuBDPRMfDpGcLo7m8an0MyLSdNqQLbKWygVZTiBvqFrt9J/3YJy1e8MUad+Dpf3It9txixLnzRix9ELoJjBil/w95qdLct5ZT89gGmhHuVgDvHRCo44WvnfjrcYLdFON282rU8t3OqRB2vse7yZ7Jzhucwtd0cqo9zWdIOzs4Z7DUswkmUjq7iZrcyxgLZv9bTcNnhrXvmacPWBYHCUHa94iejyIeKNrS1r7pswWhb5ow/a5wPkiVVATmYe9UxxMZofLuh2KOJI2eV8siQPkVEd5zv4ydZHEmRWkpTVdaeQLuGao6GdcbsYH3k8NJtmFOCp53iG3enSHVJHoOXdGoprpJpHLgcJOjE7DIXpPMrepP/LhotDaqH9+39I90mfYrQX2JJHteOeB4NN5zJlFm4fKbAnYIuH4Qq57mczRxyYBOHXur/whozZfHWMF266oHcUW7klikSGswFqxuJVVEjA0YLDVLaxpA75S4BGfzDXlbvDHoMot3u/ZYX/sv7fbp1F07MnDnjej/nWy7jrukj5fHqE2aRBXQd/O2HuIXqBClqk9JdqVwk3qq8fSPHWSS13V+ccim3jcbNlr2Viz/ClsMs3hBIrDw/xwu8xjuYWLTh8I5eQ9OPzNLCa7Wtp7yZGeYPQRConFajU9zaPH/xlsZHZX2ItGLwOMh5+5h47mF+7yE
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199015)(40470700004)(36840700001)(46966006)(83380400001)(81166007)(86362001)(2906002)(118246002)(6486002)(478600001)(82740400003)(40480700001)(36756003)(40460700003)(36860700001)(2616005)(1076003)(82310400005)(336012)(356005)(9316004)(47076005)(956004)(6506007)(316002)(921005)(6512007)(70586007)(8676002)(26005)(186003)(4326008)(8936002)(70206006)(7416002)(6666004)(41300700001)(36736006)(5660300002)(32563001);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 03:07:25.6829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99132dc7-b20d-4599-ac1c-08dadd805421
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR02FT062.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0602MB2838
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defined IMX8MP_CLK_M7_SRC and IMX8MP_CLK_M7_DIV in imx8mp-clock.h
but never assigned. It will cause the system to hang if using them.
Alias IMX8MP_CLK_M7_SRC and IMX8MP_CLK_M7_DIV to IMX8MP_CLK_M7_CORE
for backward compatibility.

Fixes: 8c83a8ff4dd9 (clk: imx8mp: use imx8m_clk_hw_composite_core to simplify code)
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/clk/imx/clk-imx8mp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 652ae58c2735..601eea7ab99d 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -522,6 +522,8 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_A53_SRC] = hws[IMX8MP_CLK_A53_DIV];
 	hws[IMX8MP_CLK_A53_CG] = hws[IMX8MP_CLK_A53_DIV];
 	hws[IMX8MP_CLK_M7_CORE] = imx8m_clk_hw_composite_core("m7_core", imx8mp_m7_sels, ccm_base + 0x8080);
+	hws[IMX8MP_CLK_M7_DIV] = hws[IMX8MP_CLK_M7_CORE];
+	hws[IMX8MP_CLK_M7_SRC] = hws[IMX8MP_CLK_M7_CORE];
 	hws[IMX8MP_CLK_ML_CORE] = imx8m_clk_hw_composite_core("ml_core", imx8mp_ml_sels, ccm_base + 0x8100);
 	hws[IMX8MP_CLK_GPU3D_CORE] = imx8m_clk_hw_composite_core("gpu3d_core", imx8mp_gpu3d_core_sels, ccm_base + 0x8180);
 	hws[IMX8MP_CLK_GPU3D_SHADER_CORE] = imx8m_clk_hw_composite("gpu3d_shader_core", imx8mp_gpu3d_shader_sels, ccm_base + 0x8200);
-- 
2.25.1

