Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D21E635E80
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 13:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238451AbiKWMyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 07:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238460AbiKWMwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 07:52:38 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2043.outbound.protection.outlook.com [40.107.21.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3F66F35F;
        Wed, 23 Nov 2022 04:44:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RM7x1llD1MLj4VRWGmz+m6HKc640/mRqUpYggWhNRYxyYMIc4POBUERVyKL0JAwGGViZun8FQGRORR63LwkaVx9YO1RufLROcVbVUAQ4gKls1uZDb++LomlSh69+NE1A04XiOl5zCb4DoHTpcxCkcENXFGuHP+1F9gziT/fNedZMEQG5yJFvdc52ouaXB+bSl0PLJsdpInECPJlia8cHJk/nSIuCPLbIE9ETP3hf+dUChea+49MLNzNacYbqAjAdpVPFVILwtGC4XURx5LFFe6OfDsjVMhWKSfSISmmAfJ/vMhoM6ZOA4kU/f4hHeCNcor15qkuDsskH98Y9VQy2PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9l36Vhq3JyGMCrdSPAOC0EBoTUN5Ij3qw3mtgku6e8=;
 b=GiOlwLBT/FpoyywfEYUpzAcCB6t9/c5m9k1ELPWNzXica+KCuW1NqNplkaIsunCOIFaSwTNwtbgqMZsrNg/tqNUOgVUNQID727o7tkWep2ObBsM9kdMcJMWxq4482l8MYmsAXmbdf2F9axSV4R9RABbfqO3j4Ryj9981C6RuFYdWw1aphOo7lsP6Jl2QLG/QJ+SlW0CiRPlkkqjCN1ntVbnLY+OGl2i+O4fE0YjycTy20yzynIplECOL1NJyN93BF14Z3KqR6Bz++ihBZS62PRekVDZGQRynYvKSJa2hSBONanlsHukoURtPGfojMOdfIhx123NbqYtJY9TBD9vLCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9l36Vhq3JyGMCrdSPAOC0EBoTUN5Ij3qw3mtgku6e8=;
 b=KwU2Eo4Hpiu0WXLQAMF9l7NfmDzxfM1a59uJ8KMS1GDPE85oEUa67EabzCUtJ1PSoHdAb26IeUaKMIDKSpHAa7xfOGqNdtfjTSYMPIQRXOZRk+kLDSxQqKkB1Tr5USXrpwLNb+ev7MlwUW6pv7Ffj3yGIIe28N4YRnPKwzpbPHY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by PA4PR04MB9344.eurprd04.prod.outlook.com (2603:10a6:102:2a8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 12:44:31 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7686:5382:16d5:c6de]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7686:5382:16d5:c6de%8]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 12:44:31 +0000
From:   Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        pmenzel@molgen.mpg.de, amitkumar.karwar@nxp.com,
        rohit.fule@nxp.com, sherry.sun@nxp.com
Cc:     neeraj.sanjaykale@nxp.com, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/2] tools: Add identifier for NXP UART BT devices
Date:   Wed, 23 Nov 2022 18:13:41 +0530
Message-Id: <1669207421-9673-1-git-send-email-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0127.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::31) To AM9PR04MB8603.eurprd04.prod.outlook.com
 (2603:10a6:20b:43a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8603:EE_|PA4PR04MB9344:EE_
X-MS-Office365-Filtering-Correlation-Id: 032d9c8d-9bb3-4bc8-cc72-08dacd50779a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qXCF9oW6rKCZIKYKkrbFMu5NfVQN2C8vzyNNwSFXEaK3YoqyfDHUWS0GZuc450+V9+EMzaRYftDD2llaj5gVKIAWulTd9CNaAU+HSTQwna4MfaeSCF9376tcd1IaOey3J8bMHcr6WNr6yctzqe0m3PG4juV0yBKCuQe9TpPCjvAnAG0NO56cXK2o9bepzMhDsNakYw5oDDXGoWPSAC7uDqH4x71ywc+oZhkb9egBSdSgGN/XowMU1O2DwKi18goGjFxLDALvweqzEUBAbheaGQiTKJhUmAH8csLZYrAkdUgOO2h6+h1aycYTUyDbRtgUYHrl2sVd/bkKemsdkal8KchX8blTTq4MgPlz8eYysQq00OGOSKmA+iZH0/4+1dVhKQeWjDo1aye792fm303lAqGchq4pnQsd7wSAei3pxRjuDhqSQbr3/wl/6ne/RKmWsfEkB4ELXbVlqgEz9iATOSeo0kghybt38DVui0pyL0uOoKzW2Bj98XAhW1rrcgTbRPh48zd3r2ocGsom9HEwmKFn1CkKRfSg26QvywufdwPom7OG+PDnEN10rKvB2Xvmi1eJsfKJhd0XE5TMHIo49htisWkyXeZooq85rOltAFpSaF0pEAmdpL3seEO3/wb4jPVt/Qh5AOU1Y3reyGu6fappBIR3fvyVMwosw6ZatE4GdhMyX+qcZaaLcg54IlWpVLr78kBBlUZnWLx9qpQ6vA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199015)(6486002)(4326008)(38100700002)(38350700002)(5660300002)(86362001)(26005)(8936002)(66946007)(4744005)(6506007)(66476007)(2906002)(66556008)(41300700001)(8676002)(186003)(6512007)(2616005)(55236004)(316002)(52116002)(6666004)(6636002)(478600001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?72s+/82L4+455HFIdQKzQkzW2xKiKhWrCPAJUHjJ5SuB5di46LRbTG0U4mXp?=
 =?us-ascii?Q?m+cccbo0Cegq7qsWj/bgLEWMGTPoVaKynp7WXXANlAdHmT8PZlzeailfriWD?=
 =?us-ascii?Q?0BH3LSzAt7pOtfzXKhWSWi5/4KtSOMKJaybH0jKI5YWkGvQpRuAFAcQMUgDN?=
 =?us-ascii?Q?Sktc3Ko/M05W/uRrOE7IwXhBZYxJb1AFRQS5JbPen7Ovc8asycjZpzCQ+oIS?=
 =?us-ascii?Q?y6kRrzE/5eDF9lN/nW65/PcdmCapFZ7QOF/5YRLsgrqyIAzjQAKKY8qjUFjZ?=
 =?us-ascii?Q?p6WSz1SJ2aUdTSBFzojirbNTBJcgAikRKq2R28aXtEicaBh0RjCHIIXFt3d0?=
 =?us-ascii?Q?BmLsiZVtrJtS01JZTCnj7f0zomFPKjgKBMVH6KT4hS2Ya3C4vC08+PQdH60C?=
 =?us-ascii?Q?GKimZMGf3xmR1mgfyipvmFdrzTEGE2rjadTp1XjXChIOqxWA0J4UDVJSGu/o?=
 =?us-ascii?Q?RIOzdSo8XCr4jDmcZyPuXMMCVO3rEz5/5zhxN2vidBgm5MNfem7Ci0QBJ6Ms?=
 =?us-ascii?Q?/H1kVTAEAfxFI2SspIbsMtwJS1HsB76sWp3ymO8nDDWJgNtf4s6/txawBDBx?=
 =?us-ascii?Q?g2HrbGGWlGP1dGnIumwuJM2saIwJvOPGhgy5mbIYnvGXIksfu4DCW9PMzQLj?=
 =?us-ascii?Q?f+h0yL7Vp6SZloKRliJDCtRxpZy9PzPFtcctwVu6Lao7w/K/MNs5dhpUgLew?=
 =?us-ascii?Q?sEsFdAu2geSAa5aRvojLc0UqZgFFxDlJg0ozTgphrr1lF0XOjANwnJvVXnT+?=
 =?us-ascii?Q?WsuqS34hY7xgOeu61d1q0LzVevg9HdGWeJxen8nG5kacqWc/dAcu9SnZk8Hf?=
 =?us-ascii?Q?QnKp6lXbJrYpF3xNYtW+3v++lf1YoWRfXDoVrZEEY3ej/TRHNX4htxw/fq2c?=
 =?us-ascii?Q?F9LQUMmlwahc0+CQsewxOvr2ngwRD/Ejj23wUQdgrwxsU1rXV0R7dwmN3rMP?=
 =?us-ascii?Q?ETwOV9z2AXcsVfX5OTp9D9IgjM0+pfR4kll5FXEFlXwHlmlFjZ9W1N3Yqa+v?=
 =?us-ascii?Q?cuHv+xpmG4nJCDECUwzBUjRd8atPkTXpe6ZB9BK59WMiRBcetOgk1RQ9mw6v?=
 =?us-ascii?Q?mLWC/EIvdbxiawlAqXZweDFqf4HG+Od4zFR4TneujUJjzMU65MqOLZ/55CiT?=
 =?us-ascii?Q?WN9a9hfT96kb71rKlg+QvR8qfdrzd0+DzNZA2FM9KxBiYeB/Sua5Rmxm3t/o?=
 =?us-ascii?Q?Kdsvl8MSaKCBT7e0A1X7xqJ0gMJQq+SkOgKmxIEHPQUM0widGkbftttWgIpz?=
 =?us-ascii?Q?r5dhWrAL72u7na/3WajK98g8R4ZXrWXam8hUiMvEpi31H5bxB60/JrSBDdN4?=
 =?us-ascii?Q?JzEJ+1LiD9YOZB2AHdpXMebu7zUxrHbF7SmS/S+ULbiM9MEAYrtjV5Y2INl2?=
 =?us-ascii?Q?kQPp8bV2X0bsmSoZL21JX0egzxhmJmW1jlsUsQ/66CMQeMpj/9xr7hPL5JWN?=
 =?us-ascii?Q?PswxQolw1E8nuKguEzjy8dozFfR46U2uzilYOyzQgTt5fdTOozm0FMSSJLpZ?=
 =?us-ascii?Q?8ek50YytfA5C3/0HF2Tw/P3t47GzoWDD8G2N+nW6Mlwdl4XJUxV2IdwnFeMA?=
 =?us-ascii?Q?v700b978RmKpQCQ82NTdHh7KHhsvEJcBCBY82YcD18AQ7p6vb21IYtDDcYoN?=
 =?us-ascii?Q?Qw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 032d9c8d-9bb3-4bc8-cc72-08dacd50779a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 12:44:31.7025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3elSAIAK7ZEr0wqkS+JZ0ImRTZZCzzQFE65Q+ipwQTWw7xutnvpV0e3cTk9Pmd8WDUr+B/t+NiCoKxs39lkDgKmKvCNW0q6dzt6/647kGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9344
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add identifiers for hci_nxp to support NXP UART BT devices for btattach
---
 tools/btattach.c  | 1 +
 tools/hciattach.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/btattach.c b/tools/btattach.c
index 4ce1be7..8a30c5b 100644
--- a/tools/btattach.c
+++ b/tools/btattach.c
@@ -212,6 +212,7 @@ static const struct {
 	{ "ag6xx", HCI_UART_AG6XX },
 	{ "nokia", HCI_UART_NOKIA },
 	{ "mrvl",  HCI_UART_MRVL  },
+	{ "nxp",   HCI_UART_NXP   },
 	{ }
 };
 
diff --git a/tools/hciattach.h b/tools/hciattach.h
index 26c0d54..d62cabf 100644
--- a/tools/hciattach.h
+++ b/tools/hciattach.h
@@ -32,6 +32,7 @@
 #define HCI_UART_AG6XX	9
 #define HCI_UART_NOKIA	10
 #define HCI_UART_MRVL	11
+#define HCI_UART_NXP	12
 
 #define HCI_UART_RAW_DEVICE	0
 #define HCI_UART_RESET_ON_INIT	1
-- 
2.7.4

