Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F63662B8B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236365AbjAIQo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbjAIQoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:44:24 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2CA5F43;
        Mon,  9 Jan 2023 08:44:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jD/1T7I98Y10YbiJc0IEARg7oSS5YLy6j2paMZW91eGqPpqv8aDMXfKSfLNnhhK7+Ij1VZyL7BD5VDgqUkB3VmHwX3KNhTb17dx0sU4OKykM9bBcgRw4X0cArp0h8q8iZjqbVN9CKbRoGi+XE5wdMByFjpkSqRp4gv+YYehGx61prLFd4zM+oiEg/DxVbahmqd6/nIBeTo3MEqDJZ/hicxACv/x9BJPmAM8Ehgk3y3CZcKgoMVR2BDClodc6W6owU1WUA66UK5NMZ4+7rFX/KkRmSWc+ixLJ0lh5vBnEYwsGQ8icNMAQ4btBo1souhAunwf2ZTCuFtoZLkW/v7x/og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZ0txemEripltiNGTXy/Z+dsa5is9tRbljc7gm5f0gg=;
 b=U10ex7FDYHn7QlE2kLdWsbW0bx7KBJ+VoE/C9DF8do+49h48E0XHiz/7Jq42v6iluAw/SJHxyaky+WseRDb9kh1Sy+lxP3wC/AtOcRfuHEUPG3kVxTQJUYPEy/gRX8kuFQsbPhspBhhlIHwvcZr6w72Wf/xdPNh9NXX1SDcEBE6fOhbes+4+zfJPE71ZrBvGKQpObT26Ef8zZxYiMCbGaYyI/wj0lKbv0bdSkfu+5NhpxzqwDaEgU/ioMN1wG6/d3Ddb5rc0M4gQg28A9klp0DcisKzRYbQebvlrLTsPy+4ra2/ejSd38RQPFVqYkLPPvPGJvnlIxwdd3euTfvvrLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZ0txemEripltiNGTXy/Z+dsa5is9tRbljc7gm5f0gg=;
 b=sac0a4j90zGl1ZQRONW7O96eOA4PYRT7BqgtmzeQQVOe14L7+XtFwEwgfDzjKBcNY2hCUzqDc6NMKFe8cv2ZCntlno0ln1adYquSzGNI42DQLGHbGNiGd7+Nh170/boeA7/RCHLehagENG21LFs8xho2znMhtx7lRj753GR9fOM=
Received: from DM6PR04CA0023.namprd04.prod.outlook.com (2603:10b6:5:334::28)
 by CY8PR12MB7538.namprd12.prod.outlook.com (2603:10b6:930:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 16:44:21 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::e) by DM6PR04CA0023.outlook.office365.com
 (2603:10b6:5:334::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 16:44:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Mon, 9 Jan 2023 16:44:21 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 10:44:19 -0600
From:   Babu Moger <babu.moger@amd.com>
To:     <corbet@lwn.net>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>, <babu.moger@amd.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
Subject: [PATCH v11 05/13] x86/resctrl: Include new features in command line options
Date:   Mon, 9 Jan 2023 10:43:57 -0600
Message-ID: <20230109164405.569714-6-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230109164405.569714-1-babu.moger@amd.com>
References: <20230109164405.569714-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|CY8PR12MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: 90e37580-85b4-4dc6-15fb-08daf260c26d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: esEGJ18LZBF0k27/EUVKT2nZUNnppDa5wGqZGbxGEUHNNNvTZdcchhJVx4y8dxUdxyoX4o62tSI9ulw6PjgOaXCMJTJiBJdd9wRvjCcFxu05VfesxXzBJJf2GjiwbwgJ3k2u8TSAgEM2poblHYNiYJue3mRjXCniR290OJesJBXeCuh8JdpGe7z1U+tRNVyQ7PKsptEMeEtQ5QbHMQAY4fRuo6Sg5OctNKLFznx+jaL6c9la7peoMami96D/54QEgZsHfKlNb0Df5/hHp1D9Z344FjsF1QwdT/ibXIFyLDJu8Qd+PnzWN4qCnFtfWJVCRbjaHLy5efqcN/6RE6k4vga0V+2hVR9fkOeCske7kqe4ofTdoq0aCGI6S+uBbPEKUAihGaUVzyqaYx+XEaR28mvDHA7T5H7sa7RbhYv2GdkWhzoXXku4SreMiHXNAia5SzdxyYkeOY0Ned/Ncd8PSusH5aEfx1UQrEqfShk5SLO9RmmjDoGm3ETKkjwwDTj3Cot2dd4faddrMXuF7MMLQXb07UqOpvCICfCaHtAO1w2tlvzo04QePiBlmXc6/ZO88BlOhpgKHYn18SIsoUcMix/KSs6fZ4PX5Ez1htf7JCrdDNQFGa5ex3DynRtcCs5+E0soSUD1QojZxccrOm60/GYw/+gGDV4D2WIZTbOMuhqMpeK9pXL43pqOVFqAL643/Xqw1NBp/rEEQbdQyLpr40fkN1+qBUC8AFBbGXVXSaI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(2906002)(44832011)(83380400001)(82310400005)(47076005)(336012)(36860700001)(426003)(54906003)(110136005)(16526019)(81166007)(1076003)(2616005)(7416002)(7406005)(5660300002)(7696005)(40480700001)(6666004)(26005)(186003)(36756003)(8936002)(478600001)(70586007)(70206006)(8676002)(41300700001)(86362001)(356005)(4326008)(40460700003)(316002)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 16:44:21.8276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e37580-85b4-4dc6-15fb-08daf260c26d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7538
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the command line options to enable or disable the new resctrl features.
smba : Slow Memory Bandwidth Allocation
bmec : Bandwidth Monitor Event Configuration.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 arch/x86/kernel/cpu/resctrl/core.c              | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6cfa6e3996cf..0ee891133d76 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5221,7 +5221,7 @@
 	rdt=		[HW,X86,RDT]
 			Turn on/off individual RDT features. List is:
 			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,
-			mba.
+			mba, smba, bmec.
 			E.g. to turn on cmt and turn off mba use:
 				rdt=cmt,!mba
 
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index f6af3ac1ef20..10a8c9d96f32 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -659,6 +659,8 @@ enum {
 	RDT_FLAG_L2_CAT,
 	RDT_FLAG_L2_CDP,
 	RDT_FLAG_MBA,
+	RDT_FLAG_SMBA,
+	RDT_FLAG_BMEC,
 };
 
 #define RDT_OPT(idx, n, f)	\
@@ -682,6 +684,8 @@ static struct rdt_options rdt_options[]  __initdata = {
 	RDT_OPT(RDT_FLAG_L2_CAT,    "l2cat",	X86_FEATURE_CAT_L2),
 	RDT_OPT(RDT_FLAG_L2_CDP,    "l2cdp",	X86_FEATURE_CDP_L2),
 	RDT_OPT(RDT_FLAG_MBA,	    "mba",	X86_FEATURE_MBA),
+	RDT_OPT(RDT_FLAG_SMBA,	    "smba",	X86_FEATURE_SMBA),
+	RDT_OPT(RDT_FLAG_BMEC,	    "bmec",	X86_FEATURE_BMEC),
 };
 #define NUM_RDT_OPTIONS ARRAY_SIZE(rdt_options)
 
-- 
2.34.1

