Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCF26658B3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbjAKKMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236364AbjAKKMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:12:16 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2096.outbound.protection.outlook.com [40.107.105.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C2CBC97;
        Wed, 11 Jan 2023 02:11:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbF7s1PnBhLDjVM/dHvA+iGzj2X7qOyvyiWJ9B6BZWjUhYpKJfvD15+FpfGZuxUUC2Xpsjpxul/ACgcJpp/YKq4p6UA6zWCYYj3XS7jOENBGyimgBUjtQJS9K5fiJ8pEV+uyKzTX8gB/t+8vgxAS1wZv254eUOed5su3vqhlX/Qs0FuTjAYKY4CKsdV3JhXf6UgSSZHTE20ddUOmpL2u7blLglgBYRijIBzk6HrNLD6vw0+PXEW4A4wp8RKgF1b5Ut6Ara/uKY6u3IsyLVbR8F5aVU091PDD7edksG93rq1aWI5d2B3TRCEPH77P138X8Z2xrz2Aeg0fKejmQqCL8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkLD8QQ7rpnOZOnaoYfQ6Zl7m7s95sDYej/3+Soh8Hs=;
 b=I4gfw5OBKGDXrofILfkW+8WonujXX5V1tI4PU+WRxQC7euOjFyW3uNwzIgJryvTN+DUoI1aVYaRyezE6gmbhcqQVOd68T+eGwWH8cHerpP9HCtjoXpTOlSg/BR8Gp51Zf51oxH7224boAuucBWTZ+f5hUDeK9v4Q2Nn9ECvlJy2RwasTJ+IBQNJjEVhGdY0tXLML9RjSRusJljhnxoQ10NXVFAo5kPs2nl7ZtPV+LNeyLaz6ACD/5g1B59Zce6G/sjkI0negknSZ44ypNWEoCsr3YDvj7GpZX5yX9CFEmhzwPSBfrFEk/ZqfVsh88/Qz9VHEaTR3jl3m2O7X2oLd4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=reject sp=reject
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkLD8QQ7rpnOZOnaoYfQ6Zl7m7s95sDYej/3+Soh8Hs=;
 b=o9yGznDHshqUwpgboW96Q8tDfC+Ph6/CYxyT/w34eEpryzmL1lWjyGRUk7aSPMdx81wRG48+cW2GHnaWpRhmkRHWf6KGFbmhoRkl+3bd4RG1zUwSpB9/qbhkn+i9dIwbSTsHrSeJm3Hzl1uSVOji4EAeA818nbXlPEJeg7l/rHE=
Received: from AS9PR04CA0142.eurprd04.prod.outlook.com (2603:10a6:20b:48a::16)
 by VI1PR0601MB2303.eurprd06.prod.outlook.com (2603:10a6:801:12::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 10:11:04 +0000
Received: from AM0EUR02FT020.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:48a:cafe::ce) by AS9PR04CA0142.outlook.office365.com
 (2603:10a6:20b:48a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Wed, 11 Jan 2023 10:11:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 AM0EUR02FT020.mail.protection.outlook.com (10.13.54.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18 via Frontend Transport; Wed, 11 Jan 2023 10:11:04 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        abel.vesa@linaro.org
Cc:     Qing-wu.Li@leica-geosystems.com.cn, 18701859600@163.com,
        bsp-development.geo@leica-geosystems.com,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V5 1/1] clk: imx8mp: Alias M7 SRC/DIV to M7 CORE
Date:   Wed, 11 Jan 2023 11:10:30 +0100
Message-Id: <20230111101030.686885-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230111101030.686885-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20230111101030.686885-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0EUR02FT020:EE_|VI1PR0601MB2303:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9a2749d5-da7d-42f5-cd82-08daf3bc2610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qH0wqjE+Qo/UlQKc9XtEy20O9YFGfk7sEpzMh/qQ5V3SWI10u2LWoDDFLptbtmDrl8HkEl9PenyIL4T8jrSu9qoY1652KxLE+RquvTZ83ZoxbqGKZvfqPKrBzDjTmRRqbRStbD456MJIMVbdBhqfguKXfveJ/kfsKzRZMbCkA6a0rvByo/rsihmyxWmX8iYAZMCX6/8hrxNX69mnLh6p1Qq2ExMsRoFy4jx+k/KXRAIM3nGOS5t3Y+U4FOyLE4PoDDxTkFoCU9w4U3Y2r01tmureIpScXG/s/nsEk/+cUQzWHeP2zvTbSjw143Mi+1VvdasIgY3VwIDpgv8DOJH8uaV58UeojJ1oAlob8KFImDbSHmNrUOER1Fl1TWKwnqN7RFjku0Cs72FPWKsa0Kt8sf4okP6eiF5lngUyssJ4sFSmoKtXiYr0mD+fQrvFFleJgcoqjwyGjnE2o0hB0UAn2e80qC4cBg15tjd7C2qDa9T5BZFukbsMdsw7r7Eg3bOcOKHoEj/eqenpe8/hroe8iLR3IPErEXDDxzGdSiOhZEfljBTVi0k9bFggReP3GEVch/YrMjj4bTWU+4ljyXn8uWpDmvBiH79w27PpJU0d0HlAuuYOMVEWiaxf3om7uOtE/9tHO+0/zN/sBSTqL6j5D29zKoSGGK5ECL3QvilMFxq5cAOmX8VflFdTI/zXvpeZa9izuheAxnrbA/kUIWjoEAhNIuO8Q8v17xo4DXPff2oM49z9959wj1dez9Ek2wO2
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199015)(46966006)(36840700001)(40470700004)(82310400005)(36756003)(9316004)(118246002)(8936002)(186003)(2906002)(47076005)(40460700003)(7416002)(81166007)(41300700001)(5660300002)(36736006)(4326008)(70586007)(8676002)(70206006)(316002)(356005)(921005)(40480700001)(82740400003)(336012)(6512007)(26005)(956004)(1076003)(2616005)(86362001)(36860700001)(83380400001)(478600001)(6486002)(6666004)(6506007)(32563001);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 10:11:04.0633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2749d5-da7d-42f5-cd82-08daf3bc2610
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: AM0EUR02FT020.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0601MB2303
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
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
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

