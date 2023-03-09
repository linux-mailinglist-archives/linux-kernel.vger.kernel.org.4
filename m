Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2296B2DE3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 20:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjCIToi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 14:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjCITof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 14:44:35 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2087.outbound.protection.outlook.com [40.107.255.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD450E6FE8;
        Thu,  9 Mar 2023 11:44:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jm6GLac0qJf17J7n5xonbE8KSGtfZRMboR7NVygPWuXZqYbCtWeYxEWpf73duJOgly0u8Z2uPlf9xDvnudoHEPHXVjWE8poml0E+jUhmTk7wezU51bu8D1EQ5vkdsKMA5p1gCxlcirzfl0ZGQSfONThc/WgMvQELhOvoiq9MJ68sMamC7OAHarBA8uvndsKNW+LyKVjrvLnNbwRMDCGRkQGeLR07Ys0ohAYBDRgm1+EDtpY/8Yci34/IAUB1yhjg+LnIyHm7voEi6KrkFFPtA7OGTMuY+C0RnN1fJAT+oUQJQ79qnLhRxJJanUNT8B3SLwleZ1GcZH7MH18QY5d+Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cNJ6+qqP1dNogbazChbFz6FXbCy2cB/7zx+H744R80=;
 b=djzke3lRbYyRB+rNXDyK9mPcykCN7LYIrEQ1zYgTKJu+wn2WFybLOWlSSiOgGhv4rjY/E081onURB7jJ8kJS3dpK6AujqP2Q9q2oCMiEKQiPNNsPiHNDiNzpukYayjgd1aQvpYqFNY+9JTm0hCVukIdwwDVBos4HkGDWL4X7n2a/lHm7ac0nV0hkrE/y1+D/S96mLP7sj7hSyTkF7EBHzR0rjxSimgPvEgPFiJevWTEeV3hklgqVC9RgOZlaadswq0nsn+L8us8WyDR//nHcurXat5POib4W7Sms/wvnru3H7OLdxWqsId2wImUYUVQNBL8/RUjX5VzJ9GfUsmTxvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=baylibre.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cNJ6+qqP1dNogbazChbFz6FXbCy2cB/7zx+H744R80=;
 b=sQ+AXcdb+6ftAR+zHPDA/x/v080AsRnzKLIlitdNHSZEBse6ApTXvQDrF1vh7wvX5BFY5cC+VYNlBESrS4AC6WjNdQ/p8KMVvRe+3RXN0bay3l9MYQu2PNk63jGGgdk9T402a2cXCv3wxmuqMI3Kt4PLRl/+e3BLdxa/Q+Tjfsw=
Received: from TYCPR01CA0157.jpnprd01.prod.outlook.com (2603:1096:400:2b1::10)
 by SI2PR03MB5771.apcprd03.prod.outlook.com (2603:1096:4:150::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.26; Thu, 9 Mar
 2023 19:44:10 +0000
Received: from TYZAPC01FT022.eop-APC01.prod.protection.outlook.com
 (2603:1096:400:2b1:cafe::75) by TYCPR01CA0157.outlook.office365.com
 (2603:1096:400:2b1::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18 via Frontend
 Transport; Thu, 9 Mar 2023 19:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 TYZAPC01FT022.mail.protection.outlook.com (10.118.152.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6178.19 via Frontend Transport; Thu, 9 Mar 2023 19:44:09 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 10
 Mar 2023 03:44:08 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.7 via Frontend Transport;
 Fri, 10 Mar 2023 03:44:08 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id BC1126473B; Thu,  9 Mar 2023 21:44:07 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>
CC:     <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v15 0/1] Introduce Nuvoton Arbel NPCM8XX BMC SoC
Date:   Thu, 9 Mar 2023 21:44:01 +0200
Message-ID: <20230309194402.119562-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZAPC01FT022:EE_|SI2PR03MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: ae2f820b-fe9f-4d2c-923a-08db20d6a6ca
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uRJi+i8c90IezMt1Oe933aI10Djq2Dfn3lqYMkm2GEvtW4+rmIqC2hmRnGLLojWQmfLKALgewCJXY5KSmhSvTtbj3LYbcRxxA+eYa4XjoGimqh/1kLfOAcnwzFWEHWItdlOUnNaMZ7zkgC18n5KYV1kVcMeoFDMPivjIh0QFsOAdmwMoUfHgRLA1WnqIIvxdq9WqFWHPWYEJ9S2mTMXGJlSxiFli95Z74zN8Ey+jny5t2B874YfPahlBBb62zzf22PAdH1TlF7uhSTdolFxAtqdfIkAelSxUei5bsDq+BPGukHkLNfPKdUMVZoWkclCYTDaVxQxHji6cwtF+Yzu8P7vGSyby4moQKsQ7oe81nqmNzdBLcin6pzsHlWN0Yskb2LiZ/J1MIZ6kIU+CUjMEs7jToyhaJlz7mzb8OHzlT/65lAA7/NrPq6jb4edRw09cRejhMgsBzXecNU868pmHQ9yjFJxTFuwcXzNEqSznlFqw3gDOCssc+XaBIVMzq7Rx90f1k30ZzP/eZWzboA1tn4trC1XkTvTSv7v69qt33SgvRv94ySQ7ldGXXPX8xqcMHaWO1jrnObqO991v8QAiCJXf0sY3NUIJkEqUbLUQhSGYsPQiB2Ul7l4DIQ5pfmB5JeIkmQ26MDk0HaXkzMbBzo+nLQDqmFLSuC5ss700xhp9CoWLI7iiJFPxJNK/N7/uyj3QsSPcqVjuuckqywyPS1RQSSSJFcCGE5zOILFCG6A9S9mEj7ydG9s5qaW6dfy3z/LAnDNrrDadrmhZiH4fqQ==
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199018)(36840700001)(40470700004)(46966006)(2616005)(36860700001)(47076005)(42882007)(336012)(83380400001)(82310400005)(73392003)(54906003)(26005)(478600001)(42186006)(186003)(76482006)(110136005)(7416002)(82202003)(6266002)(1076003)(6666004)(316002)(966005)(8936002)(83170400001)(40460700003)(55446002)(40480700001)(356005)(81166007)(82740400003)(2906002)(5660300002)(70586007)(70206006)(41300700001)(8676002)(36756003)(4326008)(45356006)(32563001)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 19:44:09.5660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2f820b-fe9f-4d2c-923a-08db20d6a6ca
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: TYZAPC01FT022.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5771
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds clock support for the Nuvoton 
Arbel NPCM8XX Board Management controller (BMC) SoC family.

This patchset cover letter is based from the initial support for NPCM8xx BMC to
keep tracking the version history.

all the other initial support patches had been applied to Linux kernel 6.0.

This patchset was tested on the Arbel NPCM8XX evaluation board.

Addressed comments from:

 - Stephen Boyd: https://www.spinics.net/lists/linux-clk/msg78406.html

Changes since version 14:
 - NPCM8XX clock driver
	- Remove unnecessary register definitions.
	- Remove the internal reference clock, instead use the external DT reference clock.
	- rearrange the driver.
	- using .names parameter in DT to define clock (refclk).

Changes since version 13:
 - NPCM8XX clock driver
	- Remove unnecessary definitions and add module.h define
	- Use in clk_parent_data struct.fw_name and .name.
	- Add module_exit function.
	- Add const to divider clock names.
	- Add MODULE_DESCRIPTION and MODULE_LICENSE

Changes since version 12:
 - NPCM8XX clock driver
	- Use clk_parent_data in mux and div clock structure.
	- Add const to mux tables.
	- Using devm_clk_hw_register_fixed_rate function.
	- use only .name clk_parent_data instead .name and .fw_name.
	- Modify mask values in mux clocks. 

Changes since version 11:
 - NPCM8XX clock driver
	- Modify Kconfig help.
	- Modify loop variable to unsigned int.

Changes since version 11:
 - NPCM8XX clock driver
	- Modify Kconfig help.
	- Modify loop variable to unsigned int.

Changes since version 10:
 - NPCM8XX clock driver
	- Fix const warning.

Changes since version 9:
 - NPCM8XX clock driver
	- Move configuration place.
	- Using clk_parent_data instead of parent_name
	- using devm_ioremap instead of ioremap. deeply sorry, I know we had
	 a long discussion on what should the driver use, from other examples 
	 (also in other clock drivers) I see the combination of 
	 platform_get_resource and devm_ioremap are commonly used and it answer
	 the reset and clock needs.

Changes since version 8:
 - NPCM8XX clock driver
	- Move configuration place.
	- Add space before and aftre '{' '}'.
	- Handle devm_of_clk_add_hw_provider function error.

Changes since version 7:
 - NPCM8XX clock driver
	- The clock and reset registers using the same memory region, 
	  due to it the clock driver should claim the ioremap directly 
	  without checking the memory region.

Changes since version 6:
 - NPCM reset driver
	- Modify warning message.
 - dt-bindings: serial: 8250: Add npcm845 compatible string patch accepted, due
   to it the patch removed from the patchset.

Changes since version 5:
 - NPCM8XX clock driver
	- Remove refclk if devm_of_clk_add_hw_provider function failed.
 - NPCM8XX clock source driver
	- Remove NPCM8XX TIMER_OF_DECLARE support, using the same as NPCM7XX.

Changes since version 4:
 - NPCM8XX clock driver
	- Use the same quote in the dt-binding file.

Changes since version 3:
 - NPCM8XX clock driver
	- Rename NPCM8xx clock dt-binding header file.
	- Remove unused structures.
	- Improve Handling the clocks registration.
 - NPCM reset driver
	- Add ref phandle to dt-binding.

Changes since version 2:
 - Remove NPCM8xx WDT compatible patch.
 - Remove NPCM8xx UART compatible patch.
 - NPCM8XX clock driver
	- Add debug new line.
	- Add 25M fixed rate clock.
	- Remove unused clocks and clock name from dt-binding.
 - NPCM reset driver
	- Revert to npcm7xx dt-binding.
	- Skip dt binding quotes.
	- Adding DTS backward compatibility.
	- Remove NPCM8xx binding include file.
	- Warp commit message.
- NPCM8XX device tree:
	- Remove unused clock nodes (used in the clock driver)
	- Modify gcr and rst node names.

Changes since version 1:
 - NPCM8XX clock driver
	- Modify dt-binding.
	- Remove unsed definition and include.
	- Include alphabetically.
	- Use clock devm.
 - NPCM reset driver
	- Modify dt-binding.
	- Modify syscon name.
	- Add syscon support to NPCM7XX dts reset node.
	- use data structure.
 - NPCM8XX device tree:
	- Modify evb compatible name.
	- Add NPCM7xx compatible.
	- Remove disable nodes from the EVB DTS.

Tomer Maimon (1):
  clk: npcm8xx: add clock controller

 drivers/clk/Kconfig       |   8 +
 drivers/clk/Makefile      |   1 +
 drivers/clk/clk-npcm8xx.c | 561 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 570 insertions(+)
 create mode 100644 drivers/clk/clk-npcm8xx.c

-- 
2.33.0

