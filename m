Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8BF64553F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 09:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiLGIKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 03:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLGIKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 03:10:51 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2093.outbound.protection.outlook.com [40.107.8.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCDE2FFFB;
        Wed,  7 Dec 2022 00:10:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcatiO8uF29qkAbAGvg8Xu5GeneiL7Ye9dA7BlhAjUPktIyK508TT9AMG0LJiornw+xhA0IUbLxllh1+dssIXo6G8kySe389MPXJeoCAJXyOEFfQ5Ak+prRr7EIS3gw+W5drQrqINAcpPf1iQkdSFIYv+cb65x4SlYQ7n/uD1o18KKx5FRYLvDAVOdn/r4vuChV1Gq20VzTB8zqxGnnBpvEh7bc7r+8cidq5Tl2bBe20v8q40/xZAKm2Lmt79238k2W3HP6VUQeG3Z3miDvTW5JWcYdcCke4GBhIZ+thX2HgNpM1DcMs1LSZ2Gp1VQlDUNMDhz5dSiolDw8b2pPrFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IinO/Bg7v7fgOo2d0xAWPkhCOzu8SKkfsTDkULlVkCg=;
 b=QkuYOnHPkhjFUOf2EB35v+7o67i4yLmffzKVbnIHu/QWEXm6tzkBU9jSwh4A19fPQbmN0NzfilxSLfuJB2DjUd9V3oiLLNh/dIpyceMjR5OuR8yDBHqf11SsrMVpTWqzpyOXZdrRaNsf4kTTbA40vdzyF27PDxi9ghlovWB9O6CoGPjP3GASRMUF8an1AT70AYnpDQzju15foJ9QQhJ07P1cOJf2EANHB6dQUx2eIjwB3fkD8+KIh3ZGl1Hr8CyQrcp4X4vgB4z5s4bcG9SU3ZxrM0TavjII7M25OtO9xuIMRdRs2z0aW3wAHLBAO7AKfTqyX0556iQgPnu1Ccp5Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=reject sp=reject
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IinO/Bg7v7fgOo2d0xAWPkhCOzu8SKkfsTDkULlVkCg=;
 b=FANwSAPrx4akBVed7D3rJOpVZqEnLPcQo1jnSX02FheGgK/VLsUv4gVXyny/ZnwFWXoSyRZWvOyVKyTPbb/fjq2rfSjCXYxFeee/AJlwK9VpvFiEBC27xzy3a6NTpeErP3GtwpMaVsoLG3YKEwIUOhoy7kj2Qj0mIZnthnRXOj0=
Received: from AS8PR04CA0201.eurprd04.prod.outlook.com (2603:10a6:20b:2f3::26)
 by PR3PR06MB7146.eurprd06.prod.outlook.com (2603:10a6:102:92::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 08:10:46 +0000
Received: from VI1EUR02FT018.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:2f3:cafe::1a) by AS8PR04CA0201.outlook.office365.com
 (2603:10a6:20b:2f3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10 via Frontend
 Transport; Wed, 7 Dec 2022 08:10:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VI1EUR02FT018.mail.protection.outlook.com (10.13.60.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.16 via Frontend Transport; Wed, 7 Dec 2022 08:10:45 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Qing-wu.Li@leica-geosystems.com.cn, 18701859600@163.com
Subject: [PATCH V1] clk: imx8mp: Alias M7 SRC/DIV to M7 CORE
Date:   Wed,  7 Dec 2022 09:10:42 +0100
Message-Id: <20221207081042.3897128-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1EUR02FT018:EE_|PR3PR06MB7146:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4b972453-3da5-4344-48fe-08dad82a8b1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GzSbYRDEEBeheu/F427BdZFGxR+/0Pw4xrhLtARVXNoGmWSZ9pZcin4l2ZjvwXxbsOn0SjGZ+k3TCanMLWcPtQhrQmbZJUSXjBeiZZJVWvBHgIjSRhyXt+6bDpmfjTnt7xh1yqrN8R4QBK6jG03CG4xBJtFrL884TwrYGFlSdps3PwTDuGLSEoQvYvkmFgrENmQrN5mg1OdODJzdOwwyojq9b8b/121Xo58TC1YFbAHlqVmRQ6JE8DJU6uN84W2E44K7N7iceOWkywRwOv0RR546Bkg7zB2jBa+mlCV7GjOu54WSIYjHqBFYCTTpEuA3ZG9vDsrHdWSCDpVAjYSCkclX5Dkt6AsaATPrls5doenqeFU7kbrd7/EqWP73zmzfvAIqRXbBlqgwxXPK5DIu1DtOzkppvraXDxtyXU9k9jj0y1/j3O+uEemVYWBfL4U9XUflInSD+9NtA4qbg+PrigVqmA+1uD9iX8Bee0FHp+7A3y0goG8SBgn91ggGIVoaItCbsyExpK6WZF+aXShyKKfTCJX926h6FQmCcrEEo+GRlOeIGWfIyLEU8Q+uiaHaNMSnjKKDmoz/mhzrJQ46zLPPIsVWMFNBHKn/ey8rnUdrXymo3nkMnbDQTyNgQyMX26peIBUGdfWhILVj02pkPFVjPFCZN0t1PogbgL7/tL2vNf8FcbuEEUw0TImupyPu7hlFVoQt79+xOq1hVfJo6XiieyiBK5DtBYWXQbyocCxDvv7AMdctxbcplpy3shsyGjxmAJDneEjZ1w0PdDGtUA==
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199015)(46966006)(36840700001)(40470700004)(186003)(956004)(2616005)(118246002)(81166007)(1076003)(41300700001)(921005)(336012)(2906002)(83380400001)(82310400005)(34020700004)(9316004)(40460700003)(36756003)(47076005)(7416002)(36860700001)(82740400003)(8936002)(6666004)(5660300002)(478600001)(356005)(8676002)(40480700001)(6506007)(6486002)(70586007)(26005)(86362001)(70206006)(4326008)(6512007)(36736006)(316002)(32563001);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 08:10:45.7672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b972453-3da5-4344-48fe-08dad82a8b1a
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR02FT018.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB7146
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
but never assigned. It will cause the system to hang if using it.
Alias IMX8MP_CLK_M7_SRC and IMX8MP_CLK_M7_DIV to IMX8MP_CLK_M7_CORE
for backward compatibility.

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

