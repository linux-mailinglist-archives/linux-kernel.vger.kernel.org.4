Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBBF6EA9F6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjDUMGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 08:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjDUMGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:06:42 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8E24C34;
        Fri, 21 Apr 2023 05:06:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLZIWf2Gc3bZDe5a9CppPSfU8uaU/fbSlPcVGGDHCdsdejTY9Ot3Eh9GfI0vUdIuuFCwAWEvkDLkpNyw/Vfx+dr5z0cKJ0rzA6PPJwDMOAN7IvnQp/UUCLsXiG71yxNbjKMNRwkPxk6WOGnzsynBi4+fC1T3H8fZ9UJzYi5XI0ZGdWWgXG8ZpyVWwWQHSQx1nCFfbvbdcSUnEBK+pzaT0qOwqG2ndheMT5PMrQUuq1qX39yvonX8DjVeydNhxzjhkYr3e5Gto32NdSPypC2eDqeJHZCw9NA4O7ORipmd8iHA9zcXUasTvgOitdheJRCWaWZAobo+dJOmw3l5UU1O/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrX8qhVR5L5CgyL0nftwEO/etkavJ+ol/IWvSd0WdAM=;
 b=LtlG9H+IQXGKGVb6YSN8FQFJCV5kl7YhhDjQSHRQ8G6v51ExKb4M1nKuZoH2r5HVdpk+Z5CliQ1/jVLsE55MJoT/YQa5cJMsOlsBTwCO/EgEmiXowhFKUJ8TgLR/WDiF8rePcu209xsWPe65T32bGxhbT7HzcUEeZ9lIYssYsEmzA0hkJuaCev3xWbYcTTQaAWNiZJbmN8EZShAQlL5z4XLQ4sNVG/yTCF3F3A2dZi02fLaLJjPzF+tJoHsJ8GYPRJdoFfSgvFnxcU0P+sP/UyNabKDa3EdfkYJrqxAYPeQNySqOvdiAv2MJOCuQ7DflKLN9FaGY5Lon7jwWn477SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrX8qhVR5L5CgyL0nftwEO/etkavJ+ol/IWvSd0WdAM=;
 b=qfFEbxwEW5TXdhnS5vhZrY/ZKamlUVr7dXyhhJpojAThsfguHpmcLvJgg6mhsXLNVlGIG8IBfWfHndJhgCDL7YtOI4RlHOXNqIO8NtY+sMKAtTp+hrpa9kJ04TgHE4UbDGtX6KaDaEdn0TQv0g9k5MhhgGKeKSHSylnFstfh5d4=
Received: from MW3PR05CA0003.namprd05.prod.outlook.com (2603:10b6:303:2b::8)
 by PH7PR12MB7844.namprd12.prod.outlook.com (2603:10b6:510:27b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 12:06:37 +0000
Received: from CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::1c) by MW3PR05CA0003.outlook.office365.com
 (2603:10b6:303:2b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.15 via Frontend
 Transport; Fri, 21 Apr 2023 12:06:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT103.mail.protection.outlook.com (10.13.174.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.26 via Frontend Transport; Fri, 21 Apr 2023 12:06:37 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 21 Apr
 2023 07:06:35 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>
CC:     <nakato@nakato.io>, <korneld@chromium.org>, <richard.gong@amd.com>,
        <Shyam-sundar.S-k@amd.com>, <Basavaraj.Natikar@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] pinctrl: amd: Adjust handling for firmware misconfigurations
Date:   Fri, 21 Apr 2023 07:06:20 -0500
Message-ID: <20230421120625.3366-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT103:EE_|PH7PR12MB7844:EE_
X-MS-Office365-Filtering-Correlation-Id: 58e9529e-d51b-44d8-a176-08db4260dbdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ap9rfZy3+l5rt6JSpURhseSi+X05mhJNQ9v3VJcx1MDXPHln2e4WwHturvkwc1+PPSAuvEpzqxA220G2oGx0InyGEjn9WJGZFCIMAPLfKAN5S62+f9RcnZtwM78l8JA1Sajy+DxIPJtp4JHtc95s/mbLCqcSBAo765H2evz+BJNFVG5/lewUc+dzifz6safY6ZkCix30mS/zDYrYeZPvXah0oB+tjVC4OMCjgRtIGTUQMXyoXlqbXiz7yXtUSg029DwPhl0nW5TEUb+asXdz6Uks0gxnnt6WRfDyYRPkGdraohevRNHZ7l0e/74YUZ6dG0p2D6UjvWiAb8mElDVBiyUaj+G5eV/BaqUIfgCLMgRogB1wUSC4w/K8V1MvaMrDhCgsuPGb3h0M+lS3kKWrKb78KxwE9e8H2/9K6KvUOA/Og0ShnbRd63NLDO6dbF6ppTGIHtR/IxU9kWddYDtbRcWoSWzEuE7cBZcMRl/TqKrmj5HC55Pw2GIEQ3CL57x8gBi+3SUVbasFqol8AtycKVGRpdJ2wJbAK5r1JNUKR4XE4XIxeXiiN84nUZEwO2AAnYGN/1nDEcEXunm/e8t2yJCYGwwuhd7k8l8jMZMLXZzJfYfEENf3BvCvovwu0O0Ej8BsRHBNaj0MfNZO0awcuxdqQ2v0FphDCF4ObOu92HOGH8WXiwoAmy/mckER8tyR3ruqLkigWJODSwML1jLC3LH52mYkxCFyLxX0NMzqtA+1NjPdjOGE6aVBPFVWFc7C
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199021)(36840700001)(40470700004)(46966006)(36756003)(44832011)(40460700003)(5660300002)(2906002)(81166007)(41300700001)(356005)(82310400005)(8936002)(8676002)(40480700001)(86362001)(7696005)(6666004)(26005)(1076003)(54906003)(45080400002)(2616005)(36860700001)(478600001)(83380400001)(66574015)(47076005)(336012)(426003)(186003)(16526019)(70206006)(70586007)(4326008)(110136005)(82740400003)(316002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 12:06:37.4679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e9529e-d51b-44d8-a176-08db4260dbdd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7844
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 4e5a04be88fe ("pinctrl: amd: disable and mask interrupts on probe")
had intended to work around firmware problems on a Microsoft Surface
device but actually masked other real bugs in firmware and the driver.

Before this commit, "wake on lid" doesn't work properly on a number of
systems, but this is because debounce handling was improperly configured
in the driver and due to a bug in this commit it gets configured a
different way.

commit b26cd9325be4 ("pinctrl: amd: Disable and mask interrupts on
resume") attempted to build on top of this to mask issues on resume, but
it happened to "fix" the bug in commit 4e5a04be88fe ("pinctrl: amd:
disable and mask interrupts on probe") which "broke" wake on lid since
the debounce handling was programmed differently.

This was reverted in commit 534e465845eb ("Revert "pinctrl: amd: Disable
and mask interrupts on resume"") which fixed the wake on lid.

To fix this series of unfortunate events and prevent them in the future
this series corrects the GPIO0 debounce handling and reverts commit
4e5a04be88fe ("pinctrl: amd: disable and mask interrupts on probe"). A new
patch that is safer is included that will fix spurious interrupt handling
and is expected to fix the issues that both
commit 4e5a04be88fe ("pinctrl: amd: disable and mask interrupts on probe")
and
commit b26cd9325be4 ("pinctrl: amd: Disable and mask interrupts on
resume") attempted to fix in a more scalable way.

Kornel Dulęba (1):
  pinctrl: amd: Detect and mask spurious interrupts

Mario Limonciello (3):
  pinctrl: amd: Detect internal GPIO0 debounce handling
  pinctrl: amd: Fix mistake in handling clearing pins at startup
  pinctrl: amd: Revert "pinctrl: amd: disable and mask interrupts on
    probe"

 drivers/pinctrl/pinctrl-amd.c | 50 +++++++++--------------------------
 drivers/pinctrl/pinctrl-amd.h |  1 +
 2 files changed, 14 insertions(+), 37 deletions(-)

-- 
2.34.1

