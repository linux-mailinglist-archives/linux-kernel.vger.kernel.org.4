Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F7964B36C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 11:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbiLMKov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 05:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbiLMKoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 05:44:38 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2132.outbound.protection.outlook.com [40.107.20.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263EE635C;
        Tue, 13 Dec 2022 02:44:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjX5nJjjzv0n39clJ+V96z/NeerZWfYrZ+Vi5wRzKQjJq2vPvI05Zwjmyu3YArZ2jMa3RGl95qhLamk4QFwz6qlOBJI73hXBr8yi1jHHsYNTQ9MnZUHe+vBnNsTXOC8+r14F7yf+ninVu6sU41IzfLyuynR7Rm8epkvkUollhbxCQ03jtb4f5be3yMcmTX5g1HgXKX7O3ertLezshnMgjVDko+wcDhhUBeYf+MYd7Hh7r2ZpB0AaxwWP/CUExRcCehMmLJTDpnh8d3bc8FePCJwt8s3lcf3kWCiA0zVyu+FRyn5IB3JXczzHlxQr2rAE9exhnbrEWPoo/EkM3OJw9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I50Suh0HbvYzvFN3YgdCP3bVtvvBEHQJwtuOi3WKugw=;
 b=M4Oiu2/fozJmkIz1xb4s17lKtuhPN04E0mBHcNuHPg9Rw7cDNBALaV2tSGUa1a5zKJ1+stYQIPCnodUX1UmzqhM/NNnO5kwSFMWZmcb+YiEV/7DbJ3R2msQby962nn/Q1WqUWz/QdbRdX6B+thINKZquQpxXoCQ3Lq2/1KRnotl/J5JNA8/PedMTgI7OEIWMHAbUOjttWPIBNslL0iwvjVxaArNXA2x3IDNZ2ZV/urpUqjTU5ojcn0NqLVThyF5na2QGByyPlwQ3Do798uR0cGGD7h8qCQ8A4H7v4jobSqMmbqNX4bkoUGiVsj+qI7GQ47s5b6Uee3L8+ZpJ14zc+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=reject sp=reject
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I50Suh0HbvYzvFN3YgdCP3bVtvvBEHQJwtuOi3WKugw=;
 b=fnhEi5iS6O19VCAh649M7rr2nFmNBdf8Q0WS02J1jugZtikFL3HbQ8sF9HjwZUyDzvf5jBD9ngrlviiVXO0agMZ9ywbQw0ksn7cRBBspjBn+xP3hEIbk2NeV8/OP5uFzAXdkhIzxKZjpRGQoYqjSm7uAUkBy3fCUVNZnizBIxdc=
Received: from DB6PR0301CA0016.eurprd03.prod.outlook.com (2603:10a6:4:3e::26)
 by HE1PR0601MB2556.eurprd06.prod.outlook.com (2603:10a6:3:51::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 10:44:31 +0000
Received: from DB5EUR02FT026.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:4:3e:cafe::ec) by DB6PR0301CA0016.outlook.office365.com
 (2603:10a6:4:3e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Tue, 13 Dec 2022 10:44:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 DB5EUR02FT026.mail.protection.outlook.com (10.13.58.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.21 via Frontend Transport; Tue, 13 Dec 2022 10:44:30 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Qing-wu.Li@leica-geosystems.com.cn, 18701859600@163.com,
        bsp-development.geo@leica-geosystems.com
Subject: [PATCH V3 0/1] clk: imx8mp: Alias M7 SRC/DIV to M7 CORE
Date:   Tue, 13 Dec 2022 11:44:25 +0100
Message-Id: <20221213104426.3864788-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR02FT026:EE_|HE1PR0601MB2556:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 73e574b3-6328-46f9-a391-08dadcf703e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YIzUDxCUskB4j15TK63OD39e2a+YzDRNCdV5raQOyw513VA5kC63s160oDa3JMxt9Zc4/XSo2spV+/f7LUdiU5Vb3cwnJCJ301dllD27gYBChQMu8ZbjfkwL+kO0nWZ65WraR1QOPW46EHXP9FUChNvOVQCyiMiprjMxbxUTDfdJsG5PyMRLBanDzcK0rac2yUwMckyFpGxWJGsKw9pI4ucasm9AnNezol9KrlthDvK6dsHpDioIZzw8EhZbEK+RfCFLOiacn9Gj2Q6OFiCUl6koeObMgri4ILhP0uRUhssq1aFVBKWVOJZSI9D1vJEmvqvEmxIRefzQqvl0GkbqYeM0qpa2wzFvDGprqJuzMgKkpkaHZnttQfWRsYAcS/CSosj0Wwa6qKPfA6xx17gW4Hx8hlpnhiVNokAuHyHtIq/HjY24rWRGLA9X9wdLx2XQnTPRx+Vtuiw6Xz9ig+V1azYXz4IaBmmr/lNhMCFVjaFsKH2g8dIFE4lIcLCP5Lfq/txEbDS9gJ2iJNrUSHsoINgbxcGOYMdGXJ0Q05Hcy6pws11iMLIyT+uBYX4x1B6wAKNrtUizIOKYU5XPXBcrV1AGiJoISOnbB3v2YUlzQ1gssNDz4QW0/bS2qW6ljeJxQTon1CxeqYPtOM8ygJsL5DOF374RXtx0Mo/ceh4qNS7VGFV0xCZW6IvHOzEaPp+LIx2DjpmLr6X1Rac3BGXijBmYMCWpv8AcHWiq2Osh4/KTrcm1CGiu7IALtkCsHEck
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(478600001)(336012)(1076003)(6486002)(186003)(6512007)(9316004)(956004)(6506007)(2616005)(82310400005)(26005)(47076005)(36860700001)(4326008)(558084003)(40460700003)(86362001)(2906002)(8676002)(36736006)(83380400001)(41300700001)(118246002)(70206006)(316002)(70586007)(921005)(40480700001)(7416002)(107886003)(5660300002)(6666004)(36756003)(82740400003)(8936002)(356005)(81166007)(32563001);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 10:44:30.1020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e574b3-6328-46f9-a391-08dadcf703e8
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR02FT026.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0601MB2556
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in V3:
  move IMX8MP_CLK_M7_SRC and IMX8MP_CLK_M7_DIV
  close to IMX8MP_CLK_M7_CORE.

LI Qingwu (1):
  clk: imx8mp: Alias M7 SRC/DIV to M7 CORE

 drivers/clk/imx/clk-imx8mp.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.25.1

