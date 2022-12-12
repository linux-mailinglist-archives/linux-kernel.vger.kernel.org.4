Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CF9649B67
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 10:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiLLJpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 04:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiLLJpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 04:45:41 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2123.outbound.protection.outlook.com [40.107.21.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498A79FED;
        Mon, 12 Dec 2022 01:45:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcUmbuNtpgm2TevNF2uBUeg0pZd/DjC99pUKEMkw09uYCym5k8ckcvibMH2M9liSzDeo2jMKowx3BWuaR2OVkcB7ndTSi4YmPWfbk+q9M7lBL9klYk6y5ya+kRNXRK+ya5Jm0dKq2KsJ8Fzh8iKa6oeMDybWyIc8gWluF1QbNUGbioQkwR6HH9UZm+VE7z6Igh8gupa6IJb8JJEjbVD+6Yidw3Hdnabx0Gj99yCVSwWHIVtzKBs8JIgrjTw7LA+cZ2Zw9NT1gbgbX5a1x4EeuhbF3fZ80urx5n3fMBpH37o7O+h2vKBcV0rFf1k6pkiZZ+5Bd7lpPpokTN/kVfnoJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ln3657+58mGN/ughoWIf6ft3sS33ihxJ7zLdgGAPnTo=;
 b=lN6PMtMVfEOfBDypCIxi3Hrr3H2pXX5wkWowCQaTyXYLez/PvI8k4UtPdEQTMukDTXSReQ4dstioYwBgo/rNAI813PsvXeX6cF0xEqqihWRO1jXZxsrQVPgOR+cFrkTmOJuXkPHCatNWlRbXmUHfBaP/aIcVAXEBFY/PS7p2P4Tpg3jcRUxjDhpLO30e6QqSTHBwjm81kEahh35vhyxIyA0BBW59bV08m+tTqv+DVl8r0SAxjmfnRShG9WRpNXQWNVgezUax0VRlSRYmicEEEFFbsq2XK6guJT70UPc1wnPJ5NVLTZJ7OQRGh/4Dr3lDsJOJgCw3QWMEDoFvXDCK4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=reject sp=reject
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ln3657+58mGN/ughoWIf6ft3sS33ihxJ7zLdgGAPnTo=;
 b=uSntvAjZ2nbnaZkHbbgnLUBobk7FHiiMUg1NEMMZkBTjgt/9sAmMDOjtRK1PLDETerb+gBwaNu6l6u3qgOsSEh/jERqcQPh3jqtCL4TmTl0ji7JPULGi7D/SfK+ik6w5zHpNCWTFXCvqUweXIALEDmIG39rePp325NOG1O9EpmY=
Received: from DB8PR06CA0057.eurprd06.prod.outlook.com (2603:10a6:10:120::31)
 by DB6PR0602MB2952.eurprd06.prod.outlook.com (2603:10a6:4:9e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 09:45:36 +0000
Received: from DB5EUR02FT030.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:10:120:cafe::9b) by DB8PR06CA0057.outlook.office365.com
 (2603:10a6:10:120::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19 via Frontend
 Transport; Mon, 12 Dec 2022 09:45:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 DB5EUR02FT030.mail.protection.outlook.com (10.13.58.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.21 via Frontend Transport; Mon, 12 Dec 2022 09:45:35 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Qing-wu.Li@leica-geosystems.com.cn, 18701859600@163.com,
        bsp-development.geo@leica-geosystems.com
Subject: [PATCH V2 0/1] clk: imx8mp: Alias M7 SRC/DIV to M7 CORE
Date:   Mon, 12 Dec 2022 10:45:32 +0100
Message-Id: <20221212094533.2803867-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR02FT030:EE_|DB6PR0602MB2952:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c7756708-c2ab-4f22-2aed-08dadc259ed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XJsHrkxfQQZOPVKNvyhRbA/L0DYYymneSklX+X279O3dvUYBKiJancAQdWUsfR6Ac4g+WoIT3k6n07aZdyRB8O0EXQ/csFMY/+BhvPstxI8lL02g7nNG5U1fkWcXae3Zy8wqoncGXSRUbFVwYl9EmUUuWc3jBwaHRoDX5e1ptPB0QpnWZkV1ERN5fzl04Ic0n3MV6Nr2hRXShOwa/jC82Xx+kK4OKQEDkqyvmp1cloh6gKfYxIWq4sk7nyZW0+4+22b1+HK7dLf70NbQ6razVpM7GxevUnCvSZASUXqjWsZzgl9j2TbdWmtxEHJ8Hfrso1cq+fBc17+ryrrvQRI/cw4UC4p8OjGyRy2ui+0Cl92nPXyccMDpMeHGOhxa7IKEJmZ4prbzFCJuII1LhgsFSdgn77tA7QVmwMZkn5cV4/TV9R1HeO7H8avo8XVLuM6kR67JRPEapNp9myvNW0lTyr6NltoxYs9zYuPWESrWXEJK9deePC/5ZKMi8vFlJrIqKKLTLvwLqf5B+XJJsOJOWviA8YhjqJyLIGfgFIoAmNA+vhTbKwG6+5kceIE80H29NA4BBqwTZqfy7I7p+PElWibx+YlSLt/eNeDzpA+m9lIFwI5s7BGSMRBBD3nRzLhV/6vdu9oASJCC+ifa4wanMvl2vecrh+8S0D6yLocv9Bu26p9Dwox3Dp3T4Q68hU8SEbip4MV/7FVHj3tF601W2Ul5FJT2jHfHf7+W7cOX3GtPU00/YkiRtB2X0T+jPC46
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199015)(36840700001)(40470700004)(46966006)(41300700001)(316002)(118246002)(36736006)(36860700001)(40460700003)(558084003)(2906002)(86362001)(4326008)(8676002)(8936002)(356005)(81166007)(36756003)(82740400003)(7416002)(40480700001)(5660300002)(921005)(70206006)(107886003)(70586007)(6666004)(6486002)(478600001)(336012)(1076003)(2616005)(6506007)(956004)(47076005)(26005)(82310400005)(186003)(6512007)(9316004)(32563001);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 09:45:35.7705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7756708-c2ab-4f22-2aed-08dadc259ed5
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR02FT030.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0602MB2952
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in V2:

  Add Fixes tag:
  Fixes: 8c83a8ff4dd9 (clk: imx8mp: use imx8m_clk_hw_composite_core to simplify code)

LI Qingwu (1):
  clk: imx8mp: Alias M7 SRC/DIV to M7 CORE

 drivers/clk/imx/clk-imx8mp.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.25.1

