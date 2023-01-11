Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE446658B1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjAKKMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbjAKKMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:12:16 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2093.outbound.protection.outlook.com [40.107.249.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D09D75;
        Wed, 11 Jan 2023 02:10:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQPrkvpqMRypfBuczsrXYexl4dJ8sp3pjlAP2dc0UmVe+JgI0lXPKpUPgRHigzjzauAoIIWOCfJGwpQm0Bm2CeMQC0DvNCeTu+1+Ibw68IsWhgZL1hsh0/hWtaTUxEcq+wcbbEfH1qy1bTDDfpVH9qz0XX6ZaZD5QhzHHgzt494uEaaH1sBpYd2dbpbi3O6JpP70lmHB8woEENFeyFERdA86D9kHOxcU8ZLwISV8cPvGK/ZffloAhbKOeIyTzbeSmZlJ4h/75uDzSMoei4qIctqujqKmZmO8tMXqRW4UUu49jGtPi7v69O+0Z7rnz6uOqvN8ydKbOxHObpQwzWILaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/xb5Twq31XW8/HfSLU0VsJSkdbjNeRAkrIH3tlqQXk=;
 b=avpAFPXn02Cfo9ZcZAnk0LNSOYhJ7urAjb+g6QoYzoyVNmrkO1DD4aXGNbFqGhLCdvCSPYl0/UXK9Hn/MEdWxH3ll7SO6J/FjbI0US3UQGMvz4MaUzYKfG7RMxqhZZMuMi/Cm1XStQs8HIN4JBePyFD0RzyCDEc9B2M2JVlWcRksJI2EEnV6uAN8PITnPnyAM7MjVhKct5LBs99ggx//RNezFTjgpAkfUrYBYFNZoBrxYsHH1UcgZen6/hyCOaFzfHy0D/JrpQOGR0WsJbuUDIRXkokqIvjc1t64sCBjgQ2vTx+kNpCpMzamj86Ir2ugtzJyrxjuqG0moBRecPkGQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=reject sp=reject
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/xb5Twq31XW8/HfSLU0VsJSkdbjNeRAkrIH3tlqQXk=;
 b=HntNwZSepXeqSQiajO2fA5OYR8i0iXf+1FW1bbO0efCB3MXlw0j8c8+S4+Kw7QDd1RpbhU06rYwpg2pU069r4kQuYSV6zM1nbirsqA0sbNRMvmjJUGjksvr3tA2i8QqqJyAw28hZqKFg5ghPmAEAPFnLPViHNKaKFb7k2Lqq8YA=
Received: from AS9PR04CA0152.eurprd04.prod.outlook.com (2603:10a6:20b:48a::26)
 by VE1PR06MB6141.eurprd06.prod.outlook.com (2603:10a6:803:119::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 10:10:51 +0000
Received: from AM0EUR02FT020.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:48a:cafe::2f) by AS9PR04CA0152.outlook.office365.com
 (2603:10a6:20b:48a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12 via Frontend
 Transport; Wed, 11 Jan 2023 10:10:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 AM0EUR02FT020.mail.protection.outlook.com (10.13.54.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18 via Frontend Transport; Wed, 11 Jan 2023 10:10:50 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        abel.vesa@linaro.org
Cc:     Qing-wu.Li@leica-geosystems.com.cn, 18701859600@163.com,
        bsp-development.geo@leica-geosystems.com
Subject: [PATCH V5 0/1] clk: imx8mp: Alias M7 SRC/DIV to M7 CORE
Date:   Wed, 11 Jan 2023 11:10:29 +0100
Message-Id: <20230111101030.686885-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0EUR02FT020:EE_|VE1PR06MB6141:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: deaea683-0b5c-42eb-9d20-08daf3bc1e21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uIjC8QaP0/4RIgVxAEpAWYG44kcY6+Cpcm24rZXOWMQuy3a2+NTZQGDmXtweo4AMBPCYvfO6LwpL90NdGEwTmjiLSPgbX9rw9rav5jJTJqSfglsBWfOScLtTdaqK/WrHm/vrkUG5NC1wsz6WgomXTNi7XuXbJstbAaj0URqUREItHWw3jIQnvJqGaJKEUWjZxmyhHGYa9Y1b+u4FX0uCPtS5fGUt5vyV8jVXndmtGZa/Ds2Vp+1BOxLtvHEksgTrbdJ5mdY2SbO00JxkumaPgW3GJxtejmJHrEaBYPknIBaLdQ/RUB5w6ItOhoL3R1yl49Z+OY2ZinAMl+URpQ3k/3WOtog4OXCx40vHLcU0rm5no4X4nLKU+g/Uw0CSVhSgJCJKgV8vMQ0G2izacXCldCcAvLIHqhgHn9PLGsmvhucPEUDu8hF0/qTQ3L8z1UVBkeSH3EWvek2rX7ECSrAlz/LG8ZfMo6oiQaFl6gXeQi2LJr3sujdWsMp5FdnI1fuhPrhLkNwLRfLcWqBihlmMvl6amGDra9V2hrYV3tCyQ3SNKkudqI62lhzH+bam/lO8b0TzYqNFHw3s9ex7yvDjcwewlkc4wm5AtlFXEOk+KrkHZMRXv2VCR/kC9JTIkvFV30lLeCH1nXIX9SN4smCCtJYzMM+V2fS3pBXelhrgMKbQJF7DVLBXNTK9BEqDNv79DEwBvkoLYR+0DzVHxY58jr3ecdf4mcOy4Gfd7oRhCw7SR8CB26V2SFpF86hRmTOB
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199015)(36840700001)(40470700004)(46966006)(70206006)(8676002)(70586007)(7416002)(316002)(36736006)(41300700001)(5660300002)(4326008)(2906002)(8936002)(6506007)(478600001)(107886003)(36756003)(6486002)(6666004)(118246002)(86362001)(921005)(356005)(81166007)(40480700001)(956004)(2616005)(26005)(6512007)(186003)(1076003)(82740400003)(336012)(47076005)(40460700003)(558084003)(36860700001)(82310400005)(9316004)(32563001);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 10:10:50.7829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: deaea683-0b5c-42eb-9d20-08daf3bc1e21
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: AM0EUR02FT020.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR06MB6141
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in V5:
  Add Reviewed-by: Abel Vesa.

LI Qingwu (1):
  clk: imx8mp: Alias M7 SRC/DIV to M7 CORE

 drivers/clk/imx/clk-imx8mp.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.25.1

