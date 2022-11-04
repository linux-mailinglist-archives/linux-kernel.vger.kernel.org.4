Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C516961A1B5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiKDUA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiKDUAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:00:21 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A08845A20;
        Fri,  4 Nov 2022 13:00:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGhD+r/2hWWiGNh2fS9yHRtd+IvQVum6Nq3qShs9UcbXhs8hZ6kU7D/6WoyUJJgfNyL+LKUyNTtygERfBu7iv5EUs96Ng0MpYowtl1dupaE9ujgQHoXFEzYevi9oRY93agALx5X6Kzij7LyLBXr9uWZ+n46aS4KN/Bq8p6L7AVm1Z7WlrLA2hJsoK8GmQeX6hF2xLX/8ndy8mJdpsa9iCEbxvlB1xNM+FbXgtlzhzCBDvaGgBVwoE9IzKOhljwoedPrLpLh0vfJQABSeaDEkqmYqk4VC4Fep57qN9L9K9cCifD9UIKP8fqg6DDXNnNauLl+ED4EqMX9nWOjJfJRyyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aS1lU0zXNAUhuu9mwovoNExV1tBWYnCwFelGPZ1pfQA=;
 b=SwLGWW1vmvV3e0Qksur7yVTvR041ada0K34dRAZ+N9YEOruXi9oaHB92jokjs0KoJ4/rayzcBs4VTOWspA1Kx4zIKFYy2hVIFtgKKamXds0Ab9EsSK7dFzLu7bnjmplRVoOU+t/o3xbfLo/UoBCvAgKktgKsJ4EUQp90gtLSNjMGXYZWZuV47T+wpxGqloYp3Uo/SpAdMGzKkxTlhZ6jtRYdkg/neG57tsqzG9433dgSMBFTZT5pBiln2oljRnrGlj5aAiqlU7kzvyNaMvaK4lplnSHrBuH64EPG7BWeG40tQsbnSLjf9N2iNnMopSoibMh6IUFkccRysRbeJSmMZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aS1lU0zXNAUhuu9mwovoNExV1tBWYnCwFelGPZ1pfQA=;
 b=MSd+BvIWBGBRUd1+ecmmR3OvKnKWkgOLRIL0wtW+lxkCjYPpQswSiPfsgYFWKFfQO0t448IafUD8BFTNc0D2rkg+BMww5FbEByyaqOCQ/sz3B2gTNwYTpb5Z+TeGofjQnSPWsr9x7G7h2W7iRK3zmClkHUlSTnaEWROoJQ/Gstg=
Received: from DM6PR02CA0146.namprd02.prod.outlook.com (2603:10b6:5:332::13)
 by PH0PR12MB8125.namprd12.prod.outlook.com (2603:10b6:510:293::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Fri, 4 Nov
 2022 20:00:17 +0000
Received: from DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::65) by DM6PR02CA0146.outlook.office365.com
 (2603:10b6:5:332::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Fri, 4 Nov 2022 20:00:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT082.mail.protection.outlook.com (10.13.173.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Fri, 4 Nov 2022 20:00:17 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 4 Nov
 2022 15:00:15 -0500
Subject: [PATCH v8 03/13] x86/cpufeatures: Add Bandwidth Monitoring Event
 Configuration feature flag
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
        <eranian@google.com>
Date:   Fri, 4 Nov 2022 15:00:10 -0500
Message-ID: <166759201032.3281208.8545863740733338256.stgit@bmoger-ubuntu>
In-Reply-To: <166759188265.3281208.11769277079826754455.stgit@bmoger-ubuntu>
References: <166759188265.3281208.11769277079826754455.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT082:EE_|PH0PR12MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: dbbb9ac0-38db-47af-e94b-08dabe9f3222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vGNb2lrg4jquiirc3zSnhBvmJxNY7oZx600M6+fF9EknOHVosZbcBzhf+jEuTRcYuV7IX0X/Xe9y64b2LAheZEkf6qTvZbWwJxLGf4996N6V4++LjBssge55iF+ZQo+tw+g1Y1s0TcJGujjaDORmDFmUbW3LJhraZKieorSxcoCQ3Gbz0Q5oPRO1ySIZsJZbiiKepHea5sjlUOTqr0yXJNo8lil9RgQE4uQtp5I2l9pzXvaffXzE6K8vk41N3McONCXSWaGJS5NOSRcG/rEqDEhNkIeZrbR8PIPHKLvDevtLLd57hc1tJdj18io8SwWatcwba8gxl7OlcSYcJ8SyQTRaZshuJIL5gqk67DPt4wRLpf+xhqbxVnKkYZQJXe34pTWnKd/tmORsKrlCyEWoUP93m1gu6DamxTCAbV+YWl5qRyqGs7ojGXs8MNEuV7QhziFI9vDWJlXf92Fyfgfez/GNsf7u5SHA9I1lhZSKpygxsmf+RhSBZgu//+cW4bX7Cj+dCGFqP1mZOI9nLo1Hk2D7rbLzm2oGGKUxY7g92GQUHJAGBRm5id5xBO/HGnVLpEVrVekfebsR3IWEPKlCWPGW8AcOf/qyC92Bfep622FsGOFdmSb1sqy1ltsd6og+rmiv0jJ39q/vfDCTJBQ6VUebIkB5JLnpNJwt31M4U3B7WQpFamOODmxs9uXi8kd8XSSTnSfrDDAHbzr5MnJi9sXSR5dKvAqpE1RQnFGI7Uvb3DIlkmje/hBcgd+58/0XATr/qiA1Soyy3lt7/kJc24tl4fyXUtcYaWLi1fQqBn8djd7K9gBERAIPm+qJi/fxR8tInCB14e9wG06YZhdnSetZa6imNhLF0/wXWuQZNETZo6VaHAOTFXGgM8Xdziig7jmB3t7zmbkgfBEV293zWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(7916004)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199015)(46966006)(36840700001)(40470700004)(103116003)(8936002)(966005)(82310400005)(7416002)(2906002)(36860700001)(9686003)(26005)(356005)(81166007)(33716001)(40480700001)(186003)(16526019)(47076005)(5660300002)(86362001)(336012)(82740400003)(40460700003)(478600001)(83380400001)(44832011)(426003)(41300700001)(70206006)(16576012)(4326008)(70586007)(8676002)(316002)(54906003)(6666004)(110136005)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 20:00:17.5635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbb9ac0-38db-47af-e94b-08dabe9f3222
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer AMD processors support the new feature Bandwidth Monitoring Event=0A=
Configuration (BMEC).=0A=
=0A=
The feature support is identified via CPUID Fn8000_0020_EBX_x0 (ECX=3D0).=
=0A=
Bits    Field Name    Description=0A=
3       EVT_CFG       Bandwidth Monitoring Event Configuration (BMEC)=0A=
=0A=
Currently, the bandwidth monitoring events mbm_total_bytes and=0A=
mbm_local_bytes are set to count all the total and local reads/writes=0A=
respectively. With the introduction of slow memory, the two counters=0A=
are not enough to count all the different types of memory events. With=0A=
the feature BMEC, the users have the option to configure=0A=
mbm_total_bytes and mbm_local_bytes to count the specific type of=0A=
events.=0A=
=0A=
Each BMEC event has a configuration MSR, QOS_EVT_CFG (0xc000_0400h +=0A=
EventID) which contains one field for each bandwidth type that can be=0A=
used to configure the bandwidth event to track any combination of=0A=
supported bandwidth types. The event will count requests from every=0A=
bandwidth type bit that is set in the corresponding configuration=0A=
register.=0A=
=0A=
Following are the types of events supported:=0A=
=0A=
=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
Bits    Description=0A=
=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
6       Dirty Victims from the QOS domain to all types of memory=0A=
5       Reads to slow memory in the non-local NUMA domain=0A=
4       Reads to slow memory in the local NUMA domain=0A=
3       Non-temporal writes to non-local NUMA domain=0A=
2       Non-temporal writes to local NUMA domain=0A=
1       Reads to memory in the non-local NUMA domain=0A=
0       Reads to memory in the local NUMA domain=0A=
=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
By default, the mbm_total_bytes configuration is set to 0x7F to count=0A=
all the event types and the mbm_local_bytes configuration is set to=0A=
0x15 to count all the local memory events.=0A=
=0A=
Feature description is available in the specification, "AMD64=0A=
Technology Platform Quality of Service Extensions, Revision: 1.03=0A=
Publication=0A=
=0A=
Link: https://www.amd.com/en/support/tech-docs/amd64-technology-platform-qu=
ality-service-extensions=0A=
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/include/asm/cpufeatures.h |    1 +=0A=
 arch/x86/kernel/cpu/cpuid-deps.c   |    1 +=0A=
 arch/x86/kernel/cpu/scattered.c    |    1 +=0A=
 3 files changed, 3 insertions(+)=0A=
=0A=
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpuf=
eatures.h=0A=
index d68b4c9c181d..6732ca0117be 100644=0A=
--- a/arch/x86/include/asm/cpufeatures.h=0A=
+++ b/arch/x86/include/asm/cpufeatures.h=0A=
@@ -306,6 +306,7 @@=0A=
 #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on VM exit w=
hen EIBRS is enabled */=0A=
 #define X86_FEATURE_CALL_DEPTH		(11*32+18) /* "" Call depth tracking for R=
SB stuffing */=0A=
 #define X86_FEATURE_SMBA		(11*32+19) /* Slow Memory Bandwidth Allocation *=
/=0A=
+#define X86_FEATURE_BMEC		(11*32+20) /* AMD Bandwidth Monitoring Event Con=
figuration (BMEC) */=0A=
 =0A=
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */=
=0A=
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */=0A=
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-d=
eps.c=0A=
index c881bcafba7d..4555f9596ccf 100644=0A=
--- a/arch/x86/kernel/cpu/cpuid-deps.c=0A=
+++ b/arch/x86/kernel/cpu/cpuid-deps.c=0A=
@@ -68,6 +68,7 @@ static const struct cpuid_dep cpuid_deps[] =3D {=0A=
 	{ X86_FEATURE_CQM_OCCUP_LLC,		X86_FEATURE_CQM_LLC   },=0A=
 	{ X86_FEATURE_CQM_MBM_TOTAL,		X86_FEATURE_CQM_LLC   },=0A=
 	{ X86_FEATURE_CQM_MBM_LOCAL,		X86_FEATURE_CQM_LLC   },=0A=
+	{ X86_FEATURE_BMEC,			X86_FEATURE_CQM_LLC   },=0A=
 	{ X86_FEATURE_AVX512_BF16,		X86_FEATURE_AVX512VL  },=0A=
 	{ X86_FEATURE_AVX512_FP16,		X86_FEATURE_AVX512BW  },=0A=
 	{ X86_FEATURE_ENQCMD,			X86_FEATURE_XSAVES    },=0A=
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattere=
d.c=0A=
index 5a5f17ed69a2..67c4d24e06ef 100644=0A=
--- a/arch/x86/kernel/cpu/scattered.c=0A=
+++ b/arch/x86/kernel/cpu/scattered.c=0A=
@@ -45,6 +45,7 @@ static const struct cpuid_bit cpuid_bits[] =3D {=0A=
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },=0A=
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },=0A=
 	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },=0A=
+	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },=0A=
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },=0A=
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },=0A=
 	{ 0, 0, 0, 0, 0 }=0A=
=0A=

