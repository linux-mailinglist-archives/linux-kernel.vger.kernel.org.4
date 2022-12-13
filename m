Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E8B64B36A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 11:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbiLMKor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 05:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbiLMKoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 05:44:39 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2127.outbound.protection.outlook.com [40.107.103.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786725F99;
        Tue, 13 Dec 2022 02:44:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGSp/tgwIKLXQfcDFA+u4VCfV00+rkd5zdEA3abaUiaaoAH2f/Hx81G4UIJTzHdMlwk2LyYG12zYjekMt86uXQGub/9jDO5Hgve7hP0fAyLZ1hgSDKsS8zCS8GaIFhbhsMtlM3w1qDEGSqLLQ9IF5P5Y9SaPB2fJpAxtkYc+6VURX68q6GM3YPJIC6OTuu2YIk+mYUER3nkYhG3FHj4CTU64sIxiO2XmfRuBoZCyzebnH2BLvG8l5ut/zGmKYxIPk0S+uZkNcfmo2p54AJZk/8ry6au87Og74f1iNque2csQbJX4ZcVkqk8a3jNBz0DAdUrGxc0iHtiqZ5vkVLEuKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/iWhMK7llkXEHkDptJuwul4jTQkGlzujIqvfGiYNDik=;
 b=nWRhXeGgWZoG1712XD0wovbEsISOtpc6l9pXy9b5kEvO3UuEWHz6rOXYhiIWGvJt8RkFJRG2XXeAqZwtajJm7i48qb5ZV7Iy+mCFdiXoW1cBNstKMLWLyTPg7njw6f+IhhtV0+r4siVnWrZEIyP+u6s1d0/6Mc00XfB0qDwcwPIl3C/wmHf4NPUc4aQfOIKdoaMifmPzdiP2G+YYhworequcpKuB9XCIPSr1naiW+AuHXdehm3kX+fkA8yES8oKWpgYNzdEjo4VcPIgm0QN7mXZHwnnpy008u76MvG4A7MOBM8B6J64WhWBuR1efA4LvNdSo4NQIjSPL+tv1Kt1Jhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=reject sp=reject
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iWhMK7llkXEHkDptJuwul4jTQkGlzujIqvfGiYNDik=;
 b=ScHzP29RQW9L1CagIK9lFttrFQcPvbNkn1UjOf2mYFtm86dj32iRM/wTvnT/yXrQl8xoF+k3rFhbRh9Wv4eBsN2D0Z6UugV40jsH1cuK77VmyA9M8RXwwCMKMIvOBrtS7tOKeDHE2XWtAR3rBQJ+qfDK3mxN/s7d4zPxiPxBrz4=
Received: from DB6PR0301CA0007.eurprd03.prod.outlook.com (2603:10a6:4:3e::17)
 by AM6PR06MB4184.eurprd06.prod.outlook.com (2603:10a6:20b:16::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 10:44:33 +0000
Received: from DB5EUR02FT026.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:4:3e:cafe::d) by DB6PR0301CA0007.outlook.office365.com
 (2603:10a6:4:3e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Tue, 13 Dec 2022 10:44:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 DB5EUR02FT026.mail.protection.outlook.com (10.13.58.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.21 via Frontend Transport; Tue, 13 Dec 2022 10:44:33 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Qing-wu.Li@leica-geosystems.com.cn, 18701859600@163.com,
        bsp-development.geo@leica-geosystems.com
Subject: [PATCH V3 1/1] clk: imx8mp: Alias M7 SRC/DIV to M7 CORE
Date:   Tue, 13 Dec 2022 11:44:26 +0100
Message-Id: <20221213104426.3864788-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221213104426.3864788-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20221213104426.3864788-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR02FT026:EE_|AM6PR06MB4184:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7cedfdb5-d87a-4e1b-2507-08dadcf705b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dQqkk8HGwy5pTIdvF90sBNSbvNZSxF15yKBC5CT2HH04YqWghs8vQ2QDxhMv7T0RvS2dc1r+1EJ1b1zRmJ+dzrucUP8p/RlLwGzFzJZDo/eY6w82U/DVj1kFd8//MljSWR3JeYuUKpq0JURF1NN+d4N+VVrhaTtg3zRJOehqqenlusqX4T+1pzDmyT4aV+rzSlp9A4GylNWR7xPowwKqqOHdXkn2SgBo6uSQXKkanh+yQz/uotkUeJM99OiC6W/0Hn3XhNLAzb89V19mobB0HIWLGBfJeGUDUb5M+2CoFNZ5KJInzwcUQeSNFAIQPRqUoiK21JTPDqWKAHu1CTYIRf6L+xEooPjKofKn2D34nT0m2JtKcmsoSYSYZcDzTDBOQ9if7IdYJMoPO4JO0TPGKWfkQbJAKCbMS39qffRe0dEfv8KvsCD1b7Z43qM4eTemG5TT7w+L2vsP67N+Sz3f+ZaWgF9Y30Y8VlAm/bjd3V256sdMFJ+b+T/IDax4/pX5D3sRf1WFYev6Cdjfpge8R7GsTwllKogLjoygGir3YSP3VfM5uqLpTqH4E43Qb5BPNcOngzmXVfnyTzfOt7K7Krs7sKnYHpp0gS2USPFUy2Jtz0huXu0gwmd1JfuQPsGyaXr+//CqXdp3UCJM81bl5c3YrSEYLn8hC9azsAas6au00F5IQJDS7Cb4AECNQaH/9E6MyEFTHLF+jkIZuSw1BNjDo9YDUi0gaPwZ6lYTPi0itf5yzWqqkYQjmhvMcIPr
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199015)(40470700004)(36840700001)(46966006)(4326008)(41300700001)(40480700001)(5660300002)(70586007)(8936002)(7416002)(36736006)(316002)(86362001)(70206006)(8676002)(6486002)(9316004)(956004)(921005)(83380400001)(356005)(336012)(81166007)(82740400003)(118246002)(478600001)(2906002)(6512007)(1076003)(6666004)(186003)(6506007)(36756003)(47076005)(82310400005)(26005)(107886003)(2616005)(36860700001)(40460700003)(32563001);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 10:44:33.1174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cedfdb5-d87a-4e1b-2507-08dadcf705b7
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR02FT026.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB4184
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
index 652ae58c2735..db03d632ea8d 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -522,6 +522,9 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_A53_SRC] = hws[IMX8MP_CLK_A53_DIV];
 	hws[IMX8MP_CLK_A53_CG] = hws[IMX8MP_CLK_A53_DIV];
 	hws[IMX8MP_CLK_M7_CORE] = imx8m_clk_hw_composite_core("m7_core", imx8mp_m7_sels, ccm_base + 0x8080);
+	hws[IMX8MP_CLK_M7_DIV] = hws[IMX8MP_CLK_M7_CORE];
+	hws[IMX8MP_CLK_M7_SRC] = hws[IMX8MP_CLK_M7_CORE];
+
 	hws[IMX8MP_CLK_ML_CORE] = imx8m_clk_hw_composite_core("ml_core", imx8mp_ml_sels, ccm_base + 0x8100);
 	hws[IMX8MP_CLK_GPU3D_CORE] = imx8m_clk_hw_composite_core("gpu3d_core", imx8mp_gpu3d_core_sels, ccm_base + 0x8180);
 	hws[IMX8MP_CLK_GPU3D_SHADER_CORE] = imx8m_clk_hw_composite("gpu3d_shader_core", imx8mp_gpu3d_shader_sels, ccm_base + 0x8200);
-- 
2.25.1

