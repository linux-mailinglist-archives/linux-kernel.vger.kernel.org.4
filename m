Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9A063F41B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbiLAPg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbiLAPgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:36:12 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4AC113D;
        Thu,  1 Dec 2022 07:36:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEfJ4/U7n1Xp33FLSMwL94rxbjd6nhqG60yTrtpct3Y46pVxMq5ben+HYR1D2wByeza6ObqWjJZg0KeXZDz6eYL8ywWiBK1Tie5S7oRyJV30j3t811eoznezdvnjXqDV04PX2G0Aawrih1JA41HbuhIsDVA7L+f4GPGtDgAQ7hVPNs1l3zuswRbgvo+kiP0QmzskoOngldn9h3RNjwdGEq1oQQpiE7fZI5JXT/Xb1Opi0gz1mJf5HbrY6qvwpUXigF5SQBhWcUORyLW3li98xIJXP8+j+yEUUe+sDcoTHsTvY0sIY4/D7KX7mscVyMAM8r6fd/G+6yQg2NWX7xeIXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkLVrTvLw1WU7zzDUJHpOxIQIKxihpI7OP3U/SqQUNM=;
 b=n3ZiX4M5CTb5f8z/J4dEMgzEBmUWsv7WYlWhnZuHewEdTue+P5Hrv3Wc0YJcZVs0gEs/To0Egd1mjKl+deIaSddt0xEO86jjF+cvlDWJPxKela+BKb0qWBFl7VJAjcZMUmAazczp1mvUXN2QC23QHIqy2KS7GHd7Z3kmRZ+w+oJ/whMKg8Kcu8X5BUH0HM4y5GmRsAcy6TLvQ/zzEZ2ZjMVkg8J3YU6zEOFsL8vtUElMrNS+uWJHSvWe6StkG/uq7MnN4dCXzz8+AvdG/iMF5qdgQqNy3upXvtbE2ZTPllE7ZdE4uUZpuIzD/folaL2UeC+CGCMZ0QteVeHw4ZuzvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkLVrTvLw1WU7zzDUJHpOxIQIKxihpI7OP3U/SqQUNM=;
 b=P7OOupJTVuJjIf08P/fdnXWA4ACMITjbCaPzhtBTpRGbF/72JzMToqrQgwvYghRW2ZBJG3nPRZ5yrBNZmT0qiYmqonCTBgLTBcxdp0CbVJrIKMEEpuy/InfSFYpiiy9xez9qU6MyRE7HrWs3551CY7+OEW3adjspjD2DANj7zTs=
Received: from MW4PR03CA0158.namprd03.prod.outlook.com (2603:10b6:303:8d::13)
 by MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Thu, 1 Dec
 2022 15:36:05 +0000
Received: from CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::25) by MW4PR03CA0158.outlook.office365.com
 (2603:10b6:303:8d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Thu, 1 Dec 2022 15:36:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT103.mail.protection.outlook.com (10.13.174.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.17 via Frontend Transport; Thu, 1 Dec 2022 15:36:04 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Dec
 2022 09:36:00 -0600
Subject: [PATCH v9 01/13] x86/cpufeatures: Add Slow Memory Bandwidth
 Allocation feature flag
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
Date:   Thu, 1 Dec 2022 09:36:00 -0600
Message-ID: <166990896023.17806.9274990355490405865.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT103:EE_|MN0PR12MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: 5875e2a5-7db7-47a1-8cf8-08dad3b1c270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v7t3fdq9H0isSgQeJRcTEEGxd2wlmFv60dxf0/1NmOmOq3vkacAnGsZ3CiOfnku6O4oGVaNiJRY7dCtChrGMM1qBQexlvBuvrktzT7es41uSEmryQUy+GlHsqd0UQAHV42fVsEuZbLGqBRCHeAAg+chZQtPgcZPqc5sxSw4PkPLRxayZLK65ipGM68XrZAI3Fi99rPywvDFNuFOSnZCxpLshzO+Zk79Pk6tRNQaAOJkIngajngEv6OBECbkIIrw0UaZGGoEuJcfgVl1Uv9+GsHk8OMIyX8OL+EQO2rM9QX3rbzgiO3y6lPoNaTTueBSxiBdWS9TjChzwjYiLayRuzWNgFXJSJk6PdT24TdyBaeakn3sL1SRc8qN84eMaMJ1JxxN0iyQ3ECHSy8CrUBixF778qIX/0RmM3mFkG8TCnr7nKAmK6Gu1SYBUfKRpfoqZOHynKSk+XnyPxLdImtcSGU0kG1SWTOfrOJgaB4HL2h4+iEvu0cu56KVOZgwdBWTwg60yu14ROP3NTByCMu67T5ATgOdJwF7cG98IQdZy3xh1M8zdMj6Yqt1pPWXVXHUpMztq2dizM9W6pVKnSHlcg5Jh5Klmz0O4xK1RZkxPURmq7fTaPE2L7iMR2ODMGEDgGTb/4+5/MyLcEfvaVgMKerAn2SxjVKc/rXpI/h1BPaQBavPck45iWj9a5FuTYaUudOD/jAA7Srhyr0VG7UD5LKZRwUsZBvnmiaYLzvT2mCZdAhxdDzWDZY8bazD8FkiM1EfstOI3KhjUf90Qk/0AOkoHfPM4i/Fwjvd5UE4hW1pkAytm/agvaX/zeTtExnYTyUhuSu+HejSMuJxDVO74Mw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(7916004)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199015)(46966006)(40470700004)(36840700001)(86362001)(81166007)(40480700001)(103116003)(40460700003)(966005)(478600001)(2906002)(9686003)(26005)(44832011)(4326008)(5660300002)(41300700001)(70586007)(70206006)(8676002)(16576012)(54906003)(316002)(110136005)(7416002)(8936002)(7406005)(82310400005)(36860700001)(82740400003)(356005)(336012)(186003)(47076005)(16526019)(426003)(83380400001)(33716001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 15:36:04.9612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5875e2a5-7db7-47a1-8cf8-08dad3b1c270
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5953
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the new AMD feature X86_FEATURE_SMBA. With this feature, the QOS=0A=
enforcement policies can be applied to external slow memory connected=0A=
to the host. QOS enforcement is accomplished by assigning a Class Of=0A=
Service (COS) to a processor and specifying allocations or limits for=0A=
that COS for each resource to be allocated.=0A=
=0A=
This feature is identified by the CPUID Function 8000_0020_EBX_x0.=0A=
=0A=
CPUID Fn8000_0020_EBX_x0 AMD Bandwidth Enforcement Feature Identifiers=0A=
(ECX=3D0)=0A=
=0A=
Bits    Field Name      Description=0A=
2       L3SBE           L3 external slow memory bandwidth enforcement=0A=
=0A=
CXL.memory is the only supported "slow" memory device. With the support=0A=
of SMBA feature, the hardware enables bandwidth allocation on the slow=0A=
memory devices. If there are multiple slow memory devices in the system,=0A=
then the throttling logic groups all the slow sources together and=0A=
applies the limit on them as a whole.=0A=
=0A=
The presence of the SMBA feature(with CXL.memory) is independent of=0A=
whether slow memory device is actually present in the system. If there=0A=
is no slow memory in the system, then setting a SMBA limit will have no=0A=
impact on the performance of the system.=0A=
=0A=
Presence of CXL memory can be identified by numactl command.=0A=
=0A=
$numactl -H=0A=
available: 2 nodes (0-1)=0A=
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16=0A=
node 0 size: 63678 MB node 0 free: 59542 MB=0A=
node 1 cpus:=0A=
node 1 size: 16122 MB=0A=
node 1 free: 15627 MB=0A=
node distances:=0A=
node   0   1=0A=
   0:  10  50=0A=
   1:  50  10=0A=
=0A=
CPU list for CXL memory will be empty. The cpu-cxl node distance is=0A=
greater than cpu-to-cpu distances. Node 1 has the CXL memory in this=0A=
case. CXL memory can also be identified using ACPI SRAT table and=0A=
memory maps.=0A=
=0A=
Feature description is available in the specification, "AMD64=0A=
Technology Platform Quality of Service Extensions, Revision: 1.03=0A=
Publication # 56375 Revision: 1.03 Issue Date: February 2022".=0A=
=0A=
Link: https://www.amd.com/en/support/tech-docs/amd64-technology-platform-qu=
ality-service-extensions=0A=
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/include/asm/cpufeatures.h |    1 +=0A=
 arch/x86/kernel/cpu/scattered.c    |    1 +=0A=
 2 files changed, 2 insertions(+)=0A=
=0A=
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpuf=
eatures.h=0A=
index 11a0e06362e4..b6a45e56cd0c 100644=0A=
--- a/arch/x86/include/asm/cpufeatures.h=0A=
+++ b/arch/x86/include/asm/cpufeatures.h=0A=
@@ -307,6 +307,7 @@=0A=
 #define X86_FEATURE_SGX_EDECCSSA	(11*32+18) /* "" SGX EDECCSSA user leaf f=
unction */=0A=
 #define X86_FEATURE_CALL_DEPTH		(11*32+19) /* "" Call depth tracking for R=
SB stuffing */=0A=
 #define X86_FEATURE_MSR_TSX_CTRL	(11*32+20) /* "" MSR IA32_TSX_CTRL (Intel=
) implemented */=0A=
+#define X86_FEATURE_SMBA		(11*32+21) /* Slow Memory Bandwidth Allocation *=
/=0A=
 =0A=
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */=
=0A=
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */=0A=
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattere=
d.c=0A=
index f53944fb8f7f..d925753084fb 100644=0A=
--- a/arch/x86/kernel/cpu/scattered.c=0A=
+++ b/arch/x86/kernel/cpu/scattered.c=0A=
@@ -45,6 +45,7 @@ static const struct cpuid_bit cpuid_bits[] =3D {=0A=
 	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },=0A=
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },=0A=
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },=0A=
+	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },=0A=
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },=0A=
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },=0A=
 	{ 0, 0, 0, 0, 0 }=0A=
=0A=

