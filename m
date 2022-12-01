Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4209863F41F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiLAPge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiLAPgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:36:25 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C104063F9;
        Thu,  1 Dec 2022 07:36:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehCz4xXHgOhlTA1U2U6v93RNOuNYhhD8rLPy6q5IVlOB0fXxr+MF3GAMvAYzg8TcAOZtKqde6XZqgD3zMlrj9IaJzM5BfyCp5X0BSVP2QazYbYXnFJoFvHCyeeVPv387C+Tmi8YoZBD3VgCB02U+UyJzWcYOLSdXyAl75TMFg1cnOw7Q0eBvhGUUzCfBz7q8wT2BF3Ux9vGAvLjSLNHBNcO2tW+jWF6jtjZ8j4vtfwIZQUuvXETtgLBmcpo5NZQguleFZOyI/YToKVRTwLMP/a+uKgXeRD/jgFlONGbXTdqtOiS8Y9jgC6YVC6sT9TbnMtBW4bgr9juyF6li3iuuMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgNbgOAPy8YioWxJmvlFQuLCkJsioW4F/62dgyZePsA=;
 b=eGN40sbEwAcpVt25NabQRwdmDaXbu5jEwzM5/0FKOAs9r9qQJAmkGrD9M10qBYne1be9y3meUs0YctbNo2lA11/nY5fmM/GXX9jHdQqTz0B7MDRighjnEcJ3A/HCRPLxGfpNUPXnayKXp6vdEjYEOlOvTnU150xFtLaJrsEsnV219bHzritfvHZRQabctpiwHX8YsuMNRZJHSqNMnfwXQBTnOT9CVh4c1yBAJG42/akRjYUlLUDePisdnv0JXlcANz7xoz0hsmiAsZunfd3d66wfWQ3782KjNkrA93lb/su96R5F3utCw8ufNcvyTR5xavnCxt/H9tpWoy5N/nOHpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgNbgOAPy8YioWxJmvlFQuLCkJsioW4F/62dgyZePsA=;
 b=d4JRI4wPWMMMz1wLoE0L8HS6yQTBFwVczvXbfxCiEHe1zW7YlqWmQWbzXogDSQsxndJkajVA/P8krkp/LVgasjd8lon2PCYI6Cu6kajszokwzmCcDo8a4g4hcoXeaI7jbiyT0oI94sNEn3xCnqmz2wCQbeCybR/cV90jJm4iKn4=
Received: from MW4PR03CA0197.namprd03.prod.outlook.com (2603:10b6:303:b8::22)
 by CY5PR12MB6550.namprd12.prod.outlook.com (2603:10b6:930:42::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 15:36:23 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::ab) by MW4PR03CA0197.outlook.office365.com
 (2603:10b6:303:b8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Thu, 1 Dec 2022 15:36:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Thu, 1 Dec 2022 15:36:22 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Dec
 2022 09:36:20 -0600
Subject: [PATCH v9 03/13] x86/cpufeatures: Add Bandwidth Monitoring Event
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
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <pawan.kumar.gupta@linux.intel.com>, <jarkko@kernel.org>,
        <adrian.hunter@intel.com>, <quic_jiles@quicinc.com>,
        <peternewman@google.com>
Date:   Thu, 1 Dec 2022 09:36:19 -0600
Message-ID: <166990897968.17806.16187773270520553795.stgit@bmoger-ubuntu>
In-Reply-To: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT046:EE_|CY5PR12MB6550:EE_
X-MS-Office365-Filtering-Correlation-Id: 98cd4971-5ad4-440e-b2e9-08dad3b1cd03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9/9R15tZnmTzk4hAzC/k/4t8yNyYCK4xrRX8oTAOPLWOaX2Bhhr4tYXtdCVvv0s0rYaqQcG4Hu40KvAbSCiNMaQzKt0211pJEhhrvnG9OEwJ1BzNvhzgRZHwBpAmQ9E4h/DGq0KaONazjkUug17W0lRXCAt5TFJVXLPwusn41eOQkEBl321u5LI0eD+RCFQToCyucNA/dBIiYiwbBh7lXywi6jpwDChgV2YwB8vTYWa0vNd+f5VNiz8R8JrAwmiFlNoFjEZiElFHDo/aKxjS5N/gOPmzsaW/yAALq8Y6deMqISPZJ+q0bH74zrvUP7EB7+673OSMSFmdEY8PLYUYyantuBH6FMxMgoqB5QjFmddZE3iPdzk0qOLI4XX/oyrjOd0TnPvlyjl5r5GmTBtKyhTDXb97V5JMUJKEtk3TG8Q2A6PrP6XGVwyumN7RYWSz4mzUMF7Tw0W3ZDDeoJo7q72V6/YUKJssdJvTsMjsyYcjc3+2N9MSeaEH2WDqDfPfsCptuyEXpHBYv7FQQjqFUcY1Frk5d9mRVPWML6mMJtiaMf/PorGOVExFTkmFLsODfsEaqv/oxZEuHYpOOPrQrwqUPEDnFxm6dZta5xE6DFHPkvQIzu4jp8i5l9kz6kG6raTSNtnlWEdBvGDynu3UWNSIFw8VrTbGSl0R3sbe1eAIzEw64IncfLKSx53APRWm0wqsUlDQu0Gj/gW0oFLjbLm94unlGVz//jxTSUIogksO+Wr79SPb1Df1dRHlZPy8iC3Gt/A9laU6Lqy4/Jk+Le9FIb2mILbBNWJAhfY9LL9iJUf9+8UwutGNoe9T3IpEev2iZG3q8LIoZv0Xo9m9ow==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(7916004)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199015)(36840700001)(46966006)(40470700004)(40480700001)(16576012)(7406005)(103116003)(5660300002)(966005)(8936002)(7416002)(316002)(86362001)(478600001)(40460700003)(54906003)(83380400001)(47076005)(70586007)(44832011)(8676002)(33716001)(16526019)(4326008)(110136005)(82740400003)(356005)(9686003)(336012)(82310400005)(186003)(81166007)(70206006)(426003)(2906002)(26005)(41300700001)(36860700001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 15:36:22.6246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98cd4971-5ad4-440e-b2e9-08dad3b1cd03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6550
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
Each BMEC event has a configuration MSR, which contains one field for=0A=
each bandwidth type that can be used to configure the bandwidth event=0A=
to track any combination of supported bandwidth types. The event will=0A=
count requests from every bandwidth type bit that is set in the=0A=
corresponding configuration register.=0A=
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
 arch/x86/kernel/cpu/cpuid-deps.c   |    2 ++=0A=
 arch/x86/kernel/cpu/scattered.c    |    1 +=0A=
 3 files changed, 4 insertions(+)=0A=
=0A=
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpuf=
eatures.h=0A=
index b6a45e56cd0c..415796d7b309 100644=0A=
--- a/arch/x86/include/asm/cpufeatures.h=0A=
+++ b/arch/x86/include/asm/cpufeatures.h=0A=
@@ -308,6 +308,7 @@=0A=
 #define X86_FEATURE_CALL_DEPTH		(11*32+19) /* "" Call depth tracking for R=
SB stuffing */=0A=
 #define X86_FEATURE_MSR_TSX_CTRL	(11*32+20) /* "" MSR IA32_TSX_CTRL (Intel=
) implemented */=0A=
 #define X86_FEATURE_SMBA		(11*32+21) /* Slow Memory Bandwidth Allocation *=
/=0A=
+#define X86_FEATURE_BMEC		(11*32+22) /* Bandwidth Monitoring Event Configu=
ration */=0A=
 =0A=
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */=
=0A=
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */=0A=
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-d=
eps.c=0A=
index d95221117129..f6748c8bd647 100644=0A=
--- a/arch/x86/kernel/cpu/cpuid-deps.c=0A=
+++ b/arch/x86/kernel/cpu/cpuid-deps.c=0A=
@@ -68,6 +68,8 @@ static const struct cpuid_dep cpuid_deps[] =3D {=0A=
 	{ X86_FEATURE_CQM_OCCUP_LLC,		X86_FEATURE_CQM_LLC   },=0A=
 	{ X86_FEATURE_CQM_MBM_TOTAL,		X86_FEATURE_CQM_LLC   },=0A=
 	{ X86_FEATURE_CQM_MBM_LOCAL,		X86_FEATURE_CQM_LLC   },=0A=
+	{ X86_FEATURE_BMEC,			X86_FEATURE_CQM_MBM_TOTAL   },=0A=
+	{ X86_FEATURE_BMEC,			X86_FEATURE_CQM_MBM_LOCAL   },=0A=
 	{ X86_FEATURE_AVX512_BF16,		X86_FEATURE_AVX512VL  },=0A=
 	{ X86_FEATURE_AVX512_FP16,		X86_FEATURE_AVX512BW  },=0A=
 	{ X86_FEATURE_ENQCMD,			X86_FEATURE_XSAVES    },=0A=
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattere=
d.c=0A=
index d925753084fb..0dad49a09b7a 100644=0A=
--- a/arch/x86/kernel/cpu/scattered.c=0A=
+++ b/arch/x86/kernel/cpu/scattered.c=0A=
@@ -46,6 +46,7 @@ static const struct cpuid_bit cpuid_bits[] =3D {=0A=
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },=0A=
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },=0A=
 	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },=0A=
+	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },=0A=
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },=0A=
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },=0A=
 	{ 0, 0, 0, 0, 0 }=0A=
=0A=

