Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2FE61A1B1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiKDUAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiKDUAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:00:02 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C454385F;
        Fri,  4 Nov 2022 13:00:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKAQudwL0wYlWUj4Xvo+Jk9IFFa5BQ26d3hMpZ/8viugMFHApwumC7ejzKo0VVtmzCrBVJC+7V9k/6O7oBcR1q8FyMDeN4xT3udnAI0jDfD2OMzMQ9Kqc68Y3WwS+S2OpCtK4LhQRD1J3DHevuuLQJsfZucE2KYn3QiCqbVWv4X8LPNFeDi9HItE8lUMgQ4Ioz1rA7a9SIJpLYbluUS5vhGugAhTYjk1jCWmwrPIQ3hjfMIBQRdm7NCP+nG+Z1T8vj2xCqNHxPjnE5ObXIJWbA1tBn9oA4+0Ei4IN0am1sEq/iq/52G4SQ1mbcwuBkEnuP/9p8WQ255aw+UOZd4VBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qa/qyGGo0Kk/XV44RHn4fj4LicOA+VtADzzKtonlvlU=;
 b=KE6kPYEAZwmwsK6V0jN0w7TdA40iWWf5i28RBRL3KY3PP3OF30yx2EolWbLgzCEI9Mkmr4swUI4+FiY29eKhVuDwLSA1SfFH9IrSVQdAtxnuKsyJcipCXSuzq9OGjE9aJjD/0DD9LmJI8Ea7r9Zc82y3bqJWqh1bN2tcbOicv/HrwP4MLZohvohXcGTky0zXZA0QPGn91u9p8twqatvfGlG05AZ5a4yTYNYh1HpPJ9gSVsscoPue4JOlpWcHH001kkuy3yOoDAlE6Ctobe1BSSGKnZE4PM6tQvDWjpL9GhaPTlnaTUv7XvYs7nWdw07jFrrdMvWwkkV+k2i3X/eU6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qa/qyGGo0Kk/XV44RHn4fj4LicOA+VtADzzKtonlvlU=;
 b=GlaO3c1NIwy1h5P4bUz7GLNGuTpqF9NKDdbsSnJvHUtZ5ma8BGKZOLI472zSXw0rttGbdwO1X9sZfGRvituOa/Wj06JUHx9fe6ossugoizV8MylS9c/z8SUIC6BIvXFgaS5di2ZQ/nxMGoK6dQZpIYLzkwoVktDtwYnfHvENzFo=
Received: from DS7PR03CA0068.namprd03.prod.outlook.com (2603:10b6:5:3bb::13)
 by DS7PR12MB5720.namprd12.prod.outlook.com (2603:10b6:8:73::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 4 Nov
 2022 19:59:59 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::65) by DS7PR03CA0068.outlook.office365.com
 (2603:10b6:5:3bb::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Fri, 4 Nov 2022 19:59:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Fri, 4 Nov 2022 19:59:58 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 4 Nov
 2022 14:59:56 -0500
Subject: [PATCH v8 01/13] x86/cpufeatures: Add Slow Memory Bandwidth
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
        <eranian@google.com>
Date:   Fri, 4 Nov 2022 14:59:56 -0500
Message-ID: <166759199632.3281208.5709918293488898752.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT050:EE_|DS7PR12MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c8905ac-a3e7-4dda-1911-08dabe9f26e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rekPEjDHKKeLUg8NEGMS31WGnT3fxhD96c/4zvgQi1bF2NJaA4eQi2VG+HIUbj46z80QX85LI3ScRpxixcBpTOSr2XQWZfgBeQn9R5+lmPd9erVOuMnBkeqINuSAYottWz8877b7KcouFDi1Fb8P2/WfYUhSLiopNuE3acKzXx2r4B8lVy3L9Kkev2QNq8Uk+RyHLEX9ZAQrrTzG0vgma8ABZ0FSgHieluNqhAF9o4dsFM64zXHYric7z0raq9wxeEXbz+5oWXwc8p1fssZF1VCcNgClOWb2MG6aFxSNh3DpodmYxMw7ObHgBMUgpA4lGklXiR56hvgCISt9rZUXdesUsQ8RgmKEumBPPeDQta+cWJGA0o4kmepn8FiSf+h9mCqCkxgwQPZS1SMKRuYDFYNfhwwk0QWJv++PJ1M2XFWiKas0PmunhpjjUwXB6p3DYrvaSRMyOtdprP2uiH5GVYPYk7W9NTlLKyFtNYgAgj6fnigqOZUIM7sydLuoWIe2zNrk9OUpHKdiCzAjG/9iKQZpTxTYC5/DbU/WjgMuWu5naU5hY7PdOQ4xbg/qOplXekLju/+6yxZOudHesfku1Nvm10Gorc+7avEF4wcvEqJo6wAUyMRYWeDYcux9pljW8lIBY11bPPma8HujnJfSKL+JMN3FL7eXvIBjOI7xW2Y3UeDFFSRr1bUnSolJbugwINtr9U20c4k0Uob5k/4ZxTa0RI+7bVwx76Co7F/5rkNFiInwH+RF1gM8uzxEDwbFHmgg7KQ4WWwt7R7AbxCa60x0V8H1VMPuH2r0Y2C3nRPODoqx+gyUaChfcheEFkRYcq6ITJ+8h10KwOmbqcMTbkOn3BigAV6zOeQyUIZ6J0krVtmU4d7+8Drgb11oVPY6Jn4chiySWlUwibH4/Xgxng==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(7916004)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199015)(40470700004)(46966006)(36840700001)(103116003)(81166007)(86362001)(2906002)(356005)(82740400003)(36860700001)(83380400001)(44832011)(40480700001)(186003)(316002)(9686003)(47076005)(16526019)(478600001)(336012)(40460700003)(33716001)(966005)(26005)(8676002)(5660300002)(54906003)(110136005)(70206006)(82310400005)(41300700001)(7416002)(4326008)(8936002)(70586007)(426003)(16576012)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 19:59:58.7387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8905ac-a3e7-4dda-1911-08dabe9f26e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5720
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
Currently, CXL.memory is the only supported "slow" memory device. With=0A=
the support of SMBA feature, the hardware enables bandwidth allocation=0A=
on the slow memory devices. If there are multiple slow memory devices=0A=
in the system, then the throttling logic groups all the slow sources=0A=
together and applies the limit on them as a whole.=0A=
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
index aefd0816a333..d68b4c9c181d 100644=0A=
--- a/arch/x86/include/asm/cpufeatures.h=0A=
+++ b/arch/x86/include/asm/cpufeatures.h=0A=
@@ -305,6 +305,7 @@=0A=
 #define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB during runtime =
firmware calls */=0A=
 #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on VM exit w=
hen EIBRS is enabled */=0A=
 #define X86_FEATURE_CALL_DEPTH		(11*32+18) /* "" Call depth tracking for R=
SB stuffing */=0A=
+#define X86_FEATURE_SMBA		(11*32+19) /* Slow Memory Bandwidth Allocation *=
/=0A=
 =0A=
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */=
=0A=
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */=0A=
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattere=
d.c=0A=
index fc01f81f6e2a..5a5f17ed69a2 100644=0A=
--- a/arch/x86/kernel/cpu/scattered.c=0A=
+++ b/arch/x86/kernel/cpu/scattered.c=0A=
@@ -44,6 +44,7 @@ static const struct cpuid_bit cpuid_bits[] =3D {=0A=
 	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },=0A=
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },=0A=
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },=0A=
+	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },=0A=
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },=0A=
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },=0A=
 	{ 0, 0, 0, 0, 0 }=0A=
=0A=

