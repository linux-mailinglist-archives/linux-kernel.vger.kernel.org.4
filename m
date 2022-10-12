Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7BF5FCE36
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiJLWML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiJLWLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:11:45 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B755A8BC;
        Wed, 12 Oct 2022 15:10:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+bcsJHB3s2EFEc771BcQiGF9pGGscJ0q81E+LUYEkzS63sgUhGI96/Frah9MouRqhxKgfD85d3cqO0dSNDwbsdmpuW1kk0sWoJnn34wDYqmu5pofcYgTFKsWGJXPYqA0J52gFjCK0OSQCRIlb4UshJw/qZEzF2endCtX1lJcKNCFnalW2S/dHv9igDlHUWJ+TI9z3G3Q0DKdjUOPlkcyR+4I7otpCIh+f4kjJpsKTnd2gy7PEiRkXayhs3k52lodGUzEOJ2BB7/jMDvWIvE7SX/nmDmHo3F0MWc9qWH4PQWqBAPqgyzZ+U7LdnjQa3xc11oJz+TDs+cO5Aoxwd5bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLbfajWIU0Zfe4jeuBWOTmWy15jAla8cL1+z/iisaTQ=;
 b=G+1rmVI7uaMunBYfepUy/QPpUrSt65Hqg6GcLHPypBOOGPlZD20O6pFJ+SH/rds9B70PSxK32b7wAghf8OJ8rSDF8u6XbxQ6Ndkfe7uN6rXqi881g5YxOQTeyNe4RT4eCM5UMGzxwfy8mQLwb+6dBOipuIaLsY5K0LvaNgnWTpTOJlxnKVsSu6fcLV5+2S7zDwNcfa+iMOIT9NkU7YFK6B528/8nYKPuBOlydg4lN8o7eMpl0rzudjn5Oo2MRMlLaXRGaiGISv2NheOFb6AExF8itUgRyWc5WJvmgOopsbsLZLAuZh/mN0u62e9XkNABzFGpQTJbmdTv1zpC+afVXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLbfajWIU0Zfe4jeuBWOTmWy15jAla8cL1+z/iisaTQ=;
 b=DhLUFhFd1YlLX0NAQzMY5hniHC0FzhXUIYYZf0ASq2YQfr02JLDnM3xNJMnPgVUg+8+f3jgYyGgwhTbIs+ezhHurrO1ubvKPWBjXa8eOWWIIzzMSdpdkBBmkymKEf5BKoFu/lhO9reBDoeLmWWIJwDQM/0apRjKBQTpnH8RnOAA=
Received: from BN9PR03CA0796.namprd03.prod.outlook.com (2603:10b6:408:13f::21)
 by DM4PR12MB6446.namprd12.prod.outlook.com (2603:10b6:8:be::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.34; Wed, 12 Oct 2022 22:10:45 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::89) by BN9PR03CA0796.outlook.office365.com
 (2603:10b6:408:13f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21 via Frontend
 Transport; Wed, 12 Oct 2022 22:10:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Wed, 12 Oct 2022 22:10:45 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 12 Oct
 2022 17:10:44 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
CC:     Mark Pearson <mpearson@lenovo.com>,
        Pananchikkal Renjith <Renjith.Pananchikkal@amd.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] pinctrl: amd: Add dynamic debugging for active GPIOs
Date:   Wed, 12 Oct 2022 17:10:28 -0500
Message-ID: <20221012221028.4817-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221012221028.4817-1-mario.limonciello@amd.com>
References: <20221012221028.4817-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT044:EE_|DM4PR12MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: bd69a314-a496-4ff2-6107-08daac9e9c8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y5ilB3v/0hIh17UmovjkU7vmSvJdjp6c38BVyqkcrETSGX2ZfvRMHdHj6fa+SbbVhZ1BaFEniIDMk1IxHtqQUxNCyIVP/eYd6e9BjRu8EeZmKrtsmj8jAQvv/1pi1DvV2I3ebYvKoPl6Ezt+SZ9BzQdJCIjz/u7/1KWnyeZ5Ux159SZ/Fu+3nqESKj4I0nvR6YouYqEsR+AWZ3aMO1kpbS5M595UoQ2q9il4a5FXbJqBByafIvgYNOir4iLRb6TdzhxmKh+MV2xygUmwelkYxba6kRpexAJACsxqWcSC8GUUeufpZ2QhGKwJg4j5D3XvfSvrEUa9jlpjvxR+4uaa0mSbzXECgBlWjuXAPmVn4TrDSEOb2op/MMwel7XBK+L62nVvbKjJDVfhqO6e9M5pWEJK1Y0zggNWIECbOKzdSJ6JBFiW61jobmygQmfU5S9AlY2mFEb8WDdM+4hGRnUh8khF7yqQ79LGqhzhVwvokFjyuWYLobqTebBxKUbIbOdxLcyMugFVfHSv6OamgAMD4JjYGgsQKQbvsRP9RdQ2IYzTVjsoUdegF0dBT82/McWTgnDL3cfDeLhLISFg4HDGohe2dq0xKJV4bT7234M6te9cxeKlsXSDlZaZxlFP/NBfBDWRMaBCEkasm2JbSgi5jSngUdlAEturkNnIXEVi+vrbOO6mgWFgwjY072XSgfwqKbmcMHqtUyvyJfCyz7NrNYH9bkgPHb9cs7o8CD3ai54P3/90u6aqSkcn+m9rLIkOCUS06AhzAzBZe51fN2KgfA4hOxsFdTcTzNSPg0WUDuWQKXqAK63IV9MrdR2axJ20
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199015)(40470700004)(36840700001)(46966006)(2906002)(186003)(16526019)(47076005)(83380400001)(2616005)(36756003)(4326008)(8936002)(41300700001)(6666004)(40460700003)(86362001)(40480700001)(7696005)(70586007)(82310400005)(356005)(81166007)(44832011)(82740400003)(5660300002)(36860700001)(426003)(336012)(26005)(6636002)(110136005)(70206006)(54906003)(478600001)(8676002)(1076003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 22:10:45.7289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd69a314-a496-4ff2-6107-08daac9e9c8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6446
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some laptops have been reported to wake up from s2idle when plugging
in the AC adapter or by closing the lid.  This is a surprising
behavior that is further clarified by commit cb3e7d624c3ff ("PM:
wakeup: Add extra debugging statement for multiple active IRQs").

With that commit in place the following interaction can be seen
when the lid is closed:

[   28.946038] PM: suspend-to-idle
[   28.946083] ACPI: EC: ACPI EC GPE status set
[   28.946101] ACPI: PM: Rearming ACPI SCI for wakeup
[   28.950152] Timekeeping suspended for 3.320 seconds
[   28.950152] PM: Triggering wakeup from IRQ 9
[   28.950152] ACPI: EC: ACPI EC GPE status set
[   28.950152] ACPI: EC: ACPI EC GPE dispatched
[   28.995057] ACPI: EC: ACPI EC work flushed
[   28.995075] ACPI: PM: Rearming ACPI SCI for wakeup
[   28.995131] PM: Triggering wakeup from IRQ 9
[   28.995271] ACPI: EC: ACPI EC GPE status set
[   28.995291] ACPI: EC: ACPI EC GPE dispatched
[   29.098556] ACPI: EC: ACPI EC work flushed
[   29.207020] ACPI: EC: ACPI EC work flushed
[   29.207037] ACPI: PM: Rearming ACPI SCI for wakeup
[   29.211095] Timekeeping suspended for 0.739 seconds
[   29.211095] PM: Triggering wakeup from IRQ 9
[   29.211079] PM: Triggering wakeup from IRQ 7
[   29.211095] ACPI: PM: ACPI non-EC GPE wakeup
[   29.211095] PM: resume from suspend-to-idle

* IRQ9 on this laptop is used for the ACPI SCI.
* IRQ7 on this laptop is used for the GPIO controller.

What has occurred is when the lid was closed the EC woke up the
SoC from it's deepest sleep state and the kernel's s2idle loop
processed all EC events.  When it was finished processing EC events,
it checked for any other reasons to wake (break the s2idle loop).

The IRQ for the GPIO controller was active so the loop broke, and
then this IRQ was processed.  This is not a kernel bug but it is
certainly a surprising behavior, and to better debug it we should
have a dynamic debugging message that we can enact to catch it.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pinctrl/pinctrl-amd.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 4691a33bc374f..8378b4115ec0d 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -628,13 +628,16 @@ static bool do_amd_gpio_irq_handler(int irq, void *dev_id)
 		/* Each status bit covers four pins */
 		for (i = 0; i < 4; i++) {
 			regval = readl(regs + i);
-			/* caused wake on resume context for shared IRQ */
-			if (irq < 0 && (regval & BIT(WAKE_STS_OFF))) {
+
+			if (regval & BIT(WAKE_STS_OFF) ||
+			    regval & BIT(INTERRUPT_STS_OFF))
 				dev_dbg(&gpio_dev->pdev->dev,
-					"Waking due to GPIO %d: 0x%x",
+					"GPIO %d is active: 0x%x",
 					irqnr + i, regval);
+
+			/* caused wake on resume context for shared IRQ */
+			if (irq < 0 && (regval & BIT(WAKE_STS_OFF)))
 				return true;
-			}
 
 			if (!(regval & PIN_IRQ_PENDING) ||
 			    !(regval & BIT(INTERRUPT_MASK_OFF)))
-- 
2.34.1

