Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E3E649B68
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 10:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbiLLJpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 04:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiLLJpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 04:45:42 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2114.outbound.protection.outlook.com [40.107.14.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02339FF2;
        Mon, 12 Dec 2022 01:45:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEtu+nfs6i4MqnvjpT8yi9qDonslIq5+ZyCEm2dQGO130nHhkBibvPJEZY07GsLEfei7vqG9ncHTVS9EYSV74sK1fDenKy8xHGdKZG1vydEGUytvpKznMgqcpa4MpC0aTOV6a76iBOWRZrJjWp7iXvQlBDsKPlp/NSj6G/xkLgarig0bz2RrehmimlkbG1di3x6y4mX/WNUdOHX1odePS98OZR7Mc/Bbbg46I8JXmWIu/uJygbF4fhWOK30kFoLvgtRX8Kx+yG3fbluFjzCn7JAaPz2i/T768m064J7tk2T5S82Opuuqle2yci4dK9qaCB4TVQ5K8/CPYZxrFiiweQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ged4BuMPbBk9O+dm+IJgzcqYWmksvyEewBg5EjYH1CI=;
 b=FnPa6sPa87ZmngOzh61Ir20c0Gsq19bO+ogV7kCikWel5NVVKq3Cf76AEJqgivTmIovAQwEgE8QZ21LAvjatF3h+VFzDRyYMosMIBg9Zl/+rkMYxDhVnjrwpVTbjbLSub/dH5Sx3ywnxkNZoMMXRYQbbHfotRB7aHYYdtJkbBAsZ6XAS6hMDBZZ8UKmmP9FjDiRsWsFOMRgwixTdXgsxf8W+of19Ovnwg7nkeqBncNfDuggRCE0PCZIPYjsbrdwDV7btYbzMC9ijdRGZxad+WLU23HSkLs/NyjZ8ZMrP4QRmEKYvsMyfjJowjN6tisQMVGI0jMebLKMwvabqhUwvzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=reject sp=reject
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ged4BuMPbBk9O+dm+IJgzcqYWmksvyEewBg5EjYH1CI=;
 b=OLQWnoSFMPdDpda5VUbBMpXcrDLZua/gRi9hniPthHGqckN0+TmBft6hazBLAKDqBt7BTTJN7eS0T71sEEGlFHbUstFHvGNHHrhUHTQvx3fKQfMOcoPS+R++0ES977zh5yTpVRS7+qrDIz3SngmXrM0DnovnpheeZk+qXIPp6a0=
Received: from DB8PR06CA0043.eurprd06.prod.outlook.com (2603:10a6:10:120::17)
 by AM6PR06MB5304.eurprd06.prod.outlook.com (2603:10a6:20b:90::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 09:45:39 +0000
Received: from DB5EUR02FT030.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:10:120:cafe::28) by DB8PR06CA0043.outlook.office365.com
 (2603:10a6:10:120::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19 via Frontend
 Transport; Mon, 12 Dec 2022 09:45:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 DB5EUR02FT030.mail.protection.outlook.com (10.13.58.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.21 via Frontend Transport; Mon, 12 Dec 2022 09:45:38 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Qing-wu.Li@leica-geosystems.com.cn, 18701859600@163.com,
        bsp-development.geo@leica-geosystems.com
Subject: [PATCH V2 1/1] clk: imx8mp: Alias M7 SRC/DIV to M7 CORE
Date:   Mon, 12 Dec 2022 10:45:33 +0100
Message-Id: <20221212094533.2803867-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221212094533.2803867-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20221212094533.2803867-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR02FT030:EE_|AM6PR06MB5304:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 690ae9ce-e464-4df5-e692-08dadc25a09e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lIPQui6ZEtDRopjcnS9MKVQlDAOfmomZm6niwMcx/SY9GzJuTn5YfWdEvZ57+QhOAcCgCzCN9bFBNBbq8i/AehLXm3mNpK68nKtD56JMhz4GexQFfYzL1Fj3w5TvAZ8OSD62bW55xeSThwY9whYd/PvI1M65weappmvHq1Vuie2LPG5Wmk0BeWqnptq1cc8A9bG33ifTMC4fw/FDvUYiPNaCXCSZkHoabuWf5OeG9qPwRoeGX8SWj/X/DVbwGA+tDIQFnsN1iAVTYbSZkr6GhBUj85/buY8ZDoZiyVZy8cGWpkuMwHQaWRCyjD6UR8JmrqxVi+7XwrBWwzrJM+DFDi1AeXmfrBSFceFDHcHyiOa/z207A+7ktRHA5DM2nRhfsyPZovqK333l9dWDgohIvfOIUCTcLPO87TNu/6otPY9KpYiL9bnacpHoihKkzzfBxgGI9KrsbFOEX1vtNu1TcXqenyAmUtujLuYGAnLYUAeaDBLQvcGWFYhf3p07zSFWdiPjhk7AOauta/1auomwc6K45HAA2R34PO2sk4V89sjf1mj0f2M94qUKtbb8RLyD3+X56MHXatWcAgrjgXeh4FsVYNiBpsqvfEf8LdiveiDPRgMj95aNPjaaOAFE06LZVxdHR0Z04NznPX4UqLWuuSXst8SE+xtVB7nOqGeSiLxfCcR/ibZBYdtbh7cjV+rSzMXo2QMN1+CJ1aWxFt5vu+lilB/tEOEbyfvZUuY2H+OT1d6Yq6w5mvjpUnl9R6Ev
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(6486002)(2906002)(6506007)(36860700001)(8676002)(6666004)(4326008)(82310400005)(40460700003)(86362001)(36756003)(118246002)(478600001)(8936002)(9316004)(956004)(2616005)(5660300002)(356005)(81166007)(82740400003)(186003)(6512007)(26005)(41300700001)(107886003)(1076003)(7416002)(40480700001)(36736006)(336012)(47076005)(921005)(316002)(83380400001)(70586007)(70206006)(32563001);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 09:45:38.7703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 690ae9ce-e464-4df5-e692-08dadc25a09e
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR02FT030.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB5304
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
Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/clk/imx/clk-imx8mp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 652ae58c2735..bae5ecc81bdc 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -531,6 +531,9 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_HSIO_AXI] = imx8m_clk_hw_composite("hsio_axi", imx8mp_hsio_axi_sels, ccm_base + 0x8380);
 	hws[IMX8MP_CLK_MEDIA_ISP] = imx8m_clk_hw_composite("media_isp", imx8mp_media_isp_sels, ccm_base + 0x8400);
 
+	hws[IMX8MP_CLK_M7_SRC] = hws[IMX8MP_CLK_M7_CORE];
+	hws[IMX8MP_CLK_M7_DIV] = hws[IMX8MP_CLK_M7_CORE];
+
 	/* CORE SEL */
 	hws[IMX8MP_CLK_A53_CORE] = imx_clk_hw_mux2("arm_a53_core", ccm_base + 0x9880, 24, 1, imx8mp_a53_core_sels, ARRAY_SIZE(imx8mp_a53_core_sels));
 
-- 
2.25.1

