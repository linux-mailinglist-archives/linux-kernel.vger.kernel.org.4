Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1529663F424
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiLAPgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbiLAPgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:36:43 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB7C240B1;
        Thu,  1 Dec 2022 07:36:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nN4ivzPGuurbaOPAfXeeaLVHXTLCf7gHnuH6bCgdDbFqsZisjtpN+AOtgey1JBMAC4s/6uGUlF9L/uJ6HpjfrsHQA5Z3qF8abYwkvwHdMMtNyxTbIzKIpNF0ZW/KAmDJvtQx24onkFKGaFRj4XbOm2UZPAl/2fNR+iqDTfwjxT0/QcwhiIXjMThuaJC8LexgP47wVrwLxbHDp6uxQIAHCSHfJRx4nBX7wm2UOfLcBN2H7g+7H50zeybnBMU2OmyKBksEBwLfEIuJov+KtDl8Xpu3oxB8VZCTmGRjyW2MF81VR3bS0Kpar9V0yHQaxUDfsBcyhOybMohFmB/o8GToAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AW2zd7jFywMJXdOBOuCf1XiDGPqCamz7HHcj07GWYDE=;
 b=e6nc3ofGC3SErpeGJnjZNTIGNDXABc+3vFf910jL8ViWRAa+Ut2bYhWLSWFQqooq1Rlr0Wkf50HQmk6wt4B2vVqeeElco83maml0nvdpGLm0GocjjP8beumvUwH1/G90XGNFYr2T/lIVBvXfc299ac3tqVGVB8WEQ0nst1k5/5bt6KRBKWto51AyjdXTGtc2WAMpvzzQHrf3L7BNnI921U28b4zW13bBw4FddPc37V5wcn5B2ZEh8I7cP6f7AObgROZ7EC/xjrFeDEd+rwyOQV9NHvkMsvD1WM/zElS+UF4EuViNAOYBvz7PyYB0DFYmW9Bw6E72cKwnOYgXOyAnSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AW2zd7jFywMJXdOBOuCf1XiDGPqCamz7HHcj07GWYDE=;
 b=xWF9mnZ+B+8eLOWVBXN0QcLU3/pZW5NVe5+npqatzAmlISBlGLT0hfHSV63rYAI8DKKsYVL3QROh3v2b7wGPUqo7vGEW0QaqwaZvd3I9KJ70YsozG2ImxBOEDjzT+ZLLGuDW/b8+AlTxEp6E5PxLlzuRYmW+V7/LkMY1DVD8GB4=
Received: from MW4PR03CA0192.namprd03.prod.outlook.com (2603:10b6:303:b8::17)
 by CY5PR12MB6153.namprd12.prod.outlook.com (2603:10b6:930:27::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 15:36:37 +0000
Received: from CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::ae) by MW4PR03CA0192.outlook.office365.com
 (2603:10b6:303:b8::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Thu, 1 Dec 2022 15:36:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT110.mail.protection.outlook.com (10.13.175.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Thu, 1 Dec 2022 15:36:36 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Dec
 2022 09:36:34 -0600
Subject: [PATCH v9 05/13] x86/resctrl: Detect and configure Slow Memory
 Bandwidth Allocation
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
Date:   Thu, 1 Dec 2022 09:36:34 -0600
Message-ID: <166990899399.17806.8574636266624372983.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT110:EE_|CY5PR12MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 044ff21d-6125-455a-79ba-08dad3b1d57f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: daxT0xhPBWeYmJpJfrrRgQsW/WOQ5h2RTmm7OWDTPIu2TmSqIYJYf/pOd0bo8jo521YLG4Lm7lyUVbABYyUX8fvyFsYSR/MX6ZCRCnuiq2MEd1orRFKRmw3GKNdKMJFqt25TMxajkq+EubzXTpzNDKHsMe/aez3jUPB5EiChEhFD6BsdxWUrzixmf/ghseitPnxz67m8A4gKMbBO7q6Q4tYqtd5Pk6vzrD09eCerb4Za0xCse2pyBPOxX1skYIPDq6TXiO7yw2vJiFmskl3ZLDfjK0L7g7XJLdVK4V/QvEYEUmygDHstqTyEYQajLwzIeDgnW+cAsrGI+hBDffttSAGTjzQ4qdPBQYg6cEAWazbXm9Abzd47911uUwd0jP+iUvanE6EL8XejwSHfqGQb/3GSIzDH9XCgExHWYylqA1ATy7y1MU9I+tDV8eTa21GrbLqFEKp4/8T5JJcXH0ZHCi/tb5jcWFzWtBIaxM1NiLiS+6CQKNJ7GF4gHhz3a8D5pmVw4vtKMF33r7FeZPW04cOFypkprJ1/ZBhjsaPRl+oTHu83uxsow7ly6eWU0k+Wm8xEb3rkMv2db7kjFyPQEwZb1MmYrMUBMbeWpPiJziNq8QRYpYVWk53RnBIYEzAIia+BSeDSd2hgZTtaJfGrj7CrkIGAMu5VqWq8xw4LNuLh7oRliyFnKZoFrTelkszmZMkqfR8HwtxzUgwMgMit2I2AGXO7PQNFDv8OCnB1XamIOImhy8Dc3fKCM/4Y4LbgGMVBBGCt8ttI2ra+t6H37Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(346002)(376002)(136003)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(103116003)(356005)(8676002)(82740400003)(2906002)(7416002)(7406005)(41300700001)(40460700003)(44832011)(426003)(81166007)(36860700001)(70206006)(16576012)(86362001)(83380400001)(47076005)(316002)(54906003)(478600001)(110136005)(8936002)(186003)(70586007)(5660300002)(26005)(82310400005)(33716001)(9686003)(4326008)(40480700001)(16526019)(336012)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 15:36:36.9357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 044ff21d-6125-455a-79ba-08dad3b1d57f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6153
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QoS slow memory configuration details are available via=0A=
CPUID_Fn80000020_EDX_x02. Detect the available details and=0A=
initialize the rest to defaults.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/include/asm/msr-index.h          |    1 +=0A=
 arch/x86/kernel/cpu/resctrl/core.c        |   36 +++++++++++++++++++++++++=
++--=0A=
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |    2 +-=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |    8 ++++--=0A=
 4 files changed, 41 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-in=
dex.h=0A=
index 37ff47552bcb..e0a40027aa62 100644=0A=
--- a/arch/x86/include/asm/msr-index.h=0A=
+++ b/arch/x86/include/asm/msr-index.h=0A=
@@ -1061,6 +1061,7 @@=0A=
 =0A=
 /* - AMD: */=0A=
 #define MSR_IA32_MBA_BW_BASE		0xc0000200=0A=
+#define MSR_IA32_SMBA_BW_BASE		0xc0000280=0A=
 =0A=
 /* MSR_IA32_VMX_MISC bits */=0A=
 #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resct=
rl/core.c=0A=
index 10a8c9d96f32..b4fc851f6489 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/core.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/core.c=0A=
@@ -162,6 +162,13 @@ bool is_mba_sc(struct rdt_resource *r)=0A=
 	if (!r)=0A=
 		return rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl.membw.mba_sc;=0A=
 =0A=
+	/*=0A=
+	 * The software controller support is only applicable to MBA resource.=0A=
+	 * Make sure to check for resource type.=0A=
+	 */=0A=
+	if (r->rid !=3D RDT_RESOURCE_MBA)=0A=
+		return false;=0A=
+=0A=
 	return r->membw.mba_sc;=0A=
 }=0A=
 =0A=
@@ -225,9 +232,15 @@ static bool __rdt_get_mem_config_amd(struct rdt_resour=
ce *r)=0A=
 	struct rdt_hw_resource *hw_res =3D resctrl_to_arch_res(r);=0A=
 	union cpuid_0x10_3_eax eax;=0A=
 	union cpuid_0x10_x_edx edx;=0A=
-	u32 ebx, ecx;=0A=
+	u32 ebx, ecx, subleaf;=0A=
 =0A=
-	cpuid_count(0x80000020, 1, &eax.full, &ebx, &ecx, &edx.full);=0A=
+	/*=0A=
+	 * Query CPUID_Fn80000020_EDX_x01 for MBA and=0A=
+	 * CPUID_Fn80000020_EDX_x02 for SMBA=0A=
+	 */=0A=
+	subleaf =3D (r->rid =3D=3D RDT_RESOURCE_SMBA) ? 2 :  1;=0A=
+=0A=
+	cpuid_count(0x80000020, subleaf, &eax.full, &ebx, &ecx, &edx.full);=0A=
 	hw_res->num_closid =3D edx.split.cos_max + 1;=0A=
 	r->default_ctrl =3D MAX_MBA_BW_AMD;=0A=
 =0A=
@@ -750,6 +763,19 @@ static __init bool get_mem_config(void)=0A=
 	return false;=0A=
 }=0A=
 =0A=
+static __init bool get_slow_mem_config(void)=0A=
+{=0A=
+	struct rdt_hw_resource *hw_res =3D &rdt_resources_all[RDT_RESOURCE_SMBA];=
=0A=
+=0A=
+	if (!rdt_cpu_has(X86_FEATURE_SMBA))=0A=
+		return false;=0A=
+=0A=
+	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD)=0A=
+		return __rdt_get_mem_config_amd(&hw_res->r_resctrl);=0A=
+=0A=
+	return false;=0A=
+}=0A=
+=0A=
 static __init bool get_rdt_alloc_resources(void)=0A=
 {=0A=
 	struct rdt_resource *r;=0A=
@@ -780,6 +806,9 @@ static __init bool get_rdt_alloc_resources(void)=0A=
 	if (get_mem_config())=0A=
 		ret =3D true;=0A=
 =0A=
+	if (get_slow_mem_config())=0A=
+		ret =3D true;=0A=
+=0A=
 	return ret;=0A=
 }=0A=
 =0A=
@@ -869,6 +898,9 @@ static __init void rdt_init_res_defs_amd(void)=0A=
 		} else if (r->rid =3D=3D RDT_RESOURCE_MBA) {=0A=
 			hw_res->msr_base =3D MSR_IA32_MBA_BW_BASE;=0A=
 			hw_res->msr_update =3D mba_wrmsr_amd;=0A=
+		} else if (r->rid =3D=3D RDT_RESOURCE_SMBA) {=0A=
+			hw_res->msr_base =3D MSR_IA32_SMBA_BW_BASE;=0A=
+			hw_res->msr_update =3D mba_wrmsr_amd;=0A=
 		}=0A=
 	}=0A=
 }=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cp=
u/resctrl/ctrlmondata.c=0A=
index 1df0e3262bca..2dd4b8c47f23 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c=0A=
@@ -209,7 +209,7 @@ static int parse_line(char *line, struct resctrl_schema=
 *s,=0A=
 	unsigned long dom_id;=0A=
 =0A=
 	if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP &&=0A=
-	    r->rid =3D=3D RDT_RESOURCE_MBA) {=0A=
+	    (r->rid =3D=3D RDT_RESOURCE_MBA || r->rid =3D=3D RDT_RESOURCE_SMBA)) =
{=0A=
 		rdt_last_cmd_puts("Cannot pseudo-lock MBA resource\n");=0A=
 		return -EINVAL;=0A=
 	}=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index e5a48f05e787..8a3dafc0dbf7 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -1213,7 +1213,7 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgr=
oup *rdtgrp)=0A=
 =0A=
 	list_for_each_entry(s, &resctrl_schema_all, list) {=0A=
 		r =3D s->res;=0A=
-		if (r->rid =3D=3D RDT_RESOURCE_MBA)=0A=
+		if (r->rid =3D=3D RDT_RESOURCE_MBA || r->rid =3D=3D RDT_RESOURCE_SMBA)=
=0A=
 			continue;=0A=
 		has_cache =3D true;=0A=
 		list_for_each_entry(d, &r->domains, list) {=0A=
@@ -1402,7 +1402,8 @@ static int rdtgroup_size_show(struct kernfs_open_file=
 *of,=0A=
 					ctrl =3D resctrl_arch_get_config(r, d,=0A=
 								       closid,=0A=
 								       type);=0A=
-				if (r->rid =3D=3D RDT_RESOURCE_MBA)=0A=
+				if (r->rid =3D=3D RDT_RESOURCE_MBA ||=0A=
+				    r->rid =3D=3D RDT_RESOURCE_SMBA)=0A=
 					size =3D ctrl;=0A=
 				else=0A=
 					size =3D rdtgroup_cbm_to_size(r, d, ctrl);=0A=
@@ -2845,7 +2846,8 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgr=
p)=0A=
 =0A=
 	list_for_each_entry(s, &resctrl_schema_all, list) {=0A=
 		r =3D s->res;=0A=
-		if (r->rid =3D=3D RDT_RESOURCE_MBA) {=0A=
+		if (r->rid =3D=3D RDT_RESOURCE_MBA ||=0A=
+		    r->rid =3D=3D RDT_RESOURCE_SMBA) {=0A=
 			rdtgroup_init_mba(r, rdtgrp->closid);=0A=
 			if (is_mba_sc(r))=0A=
 				continue;=0A=
=0A=

