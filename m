Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B66C61A1D0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiKDUCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiKDUBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:01:49 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EED4D5C3;
        Fri,  4 Nov 2022 13:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJ2m/+BEZY5+vQF+kIpddnbkR8WDjpN+S3i0mDkXwLt0kOxvTIurNNVjhnNZvwegajhm2R9bhxwhVH1Tr0eMbiaNaHJczWVJR0sMnjdfOEb/KWS6dCgYyGBHBhxPZZDkjyICIF9juYKoC0T5KgGM81uJ4Y2Oef6/8pTDWJ21+zH/1y0u63v9sfzU6D1a7y2N5hDJLxhQ5+oq4xEKI3fZltIvvy/7RkpgLC2ibE7wJBL9oKjvuqDCXS+ta6cWPM4JFTqUam1tsgePgF5UBCvo39Dfe0bQ/cikbyB2n+HmaT71Oc/c7huF0M6Oif+CHcOrDXpby5jbVD62MYAW6KZ50Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Zet5DKiEM4lCLt7BH9iSf59T7ygIwURNyOBh4jTAdo=;
 b=Gl81TEqDGP4CFDY1RiXgFWTX3DYnr2Lu1NF5kKWL9MUpesbPSyLFKp5oU9FVnCJE2xRJeflchqDrSBUmyH3qV80QGpmkuKnBEjouDYOD6nbePhoXCaTAWGwgep+tvYV3MKB/nwJUuxe7T5hhPKTYQ59Ost1hTv87pNfEmcNUSXSoBW4skHTtsvTanb8/ZzIDRsUNLxFJMu2mLAKtRxleejCE5ZdWGEsPYmZvk7EW1kW9ne9gqizpfvNDUoa7YA6BovY41jnbbDJAxo1P6/6YbcqT1JKRWa6U3/KFcHD7QL7NDRXlujvB2GClfx6U/2XjjAzo2bX11uPDTGNHj0a3YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Zet5DKiEM4lCLt7BH9iSf59T7ygIwURNyOBh4jTAdo=;
 b=P89rJWN9Vkm5ucEQT0JXCxLInNaWv9FKUvFvd/0iADKKFBW2tse9vtkM9ROC9CXGSBWgmQ0vIp7stp7UpQA+eqBap6brf7JFiUEBT9mcn++hU2MRbLPUDn1YJOIM+KRfwKvjb+le2G2ZLQa7L7IRZXCYo2jxZewZiXea3Pucl8g=
Received: from DM6PR21CA0014.namprd21.prod.outlook.com (2603:10b6:5:174::24)
 by DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Fri, 4 Nov
 2022 20:01:25 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::99) by DM6PR21CA0014.outlook.office365.com
 (2603:10b6:5:174::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.8 via Frontend
 Transport; Fri, 4 Nov 2022 20:01:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Fri, 4 Nov 2022 20:01:25 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 4 Nov
 2022 15:01:23 -0500
Subject: [PATCH v8 12/13] x86/resctrl: Replace smp_call_function_many() with
 on_each_cpu_mask()
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
Date:   Fri, 4 Nov 2022 15:01:22 -0500
Message-ID: <166759208296.3281208.13284924391643463358.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|DS7PR12MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: 012c4d51-8086-4bd5-130c-08dabe9f5a85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K9WQqLMErbsClgKaCRwSxSdDJKHwRGhBOEJSbC9ATEuv+LaZiN0eS1vlUpPFeRksEkE9IpTA2YgKvPEtxkj0ONw/yt+jxvxvUgZiHWrfH95unz6SuKFlN1mHOLzokyv9Sm9XRVetCsRNPA5H2l5wav9vDkX5nnD0lOxYqdWFpc05/g97Ltu73eKGC7CkICCh+2hqUVLgcHAu0VmkAr+BXJOVfDgt8uhqKpr2uyWqzkMVm4SOL2iOEui7anjRZTT59JHznrC5UhggSS5EVFbvXVKlXmJotiVjRQDBFUsw4Pp24vT6alqvZ7iJekSDzb2id1HiioZ8n5nYSyAa4gpRs5bxSU00bUbo3PlGs3HXgRYT6ag0M9N8Yr8C2Ggsp3KfKPAJK+ee37LJbBpfcixEGfsenF+y3yLuCo5fx+FCuMQlOLpdq5CcHenazc3GjXGFx7AuruN8VmdfUuh5umtfsSGsuJ2Jo+ArXuapbymypi7cBUGuyu0lvUR4hrwJjQifjC4XooFzd6hVqNsvJO56QIrNDAtFbpcnu5WRvxuf4o3D/QI6S/k2RgQPhqtVaE+9WmnTYUhBNdqfiKWtKkrpZ4+V2ZrD1CC7m/pK1mi6z9pZvXam4AxWW7OiTHZhzeVMhfzogcZpXzMHU7BapFP+KXTDORvc/yZT7LARFjeakUZDGalt+t0ZOuowIG1V+sa1111Tq7R5ZHPVtegfhZCrXmuHBt7Kgt45I0BPERfNDkVQ0eOmNf3ipjqwop2akOtGXleDA/xE3eWjuVOXQ/AmF2qcWDGMux7CC7nWnJPeD5ce9+hb1Dh8rGWW1k36JATxncLkCWH8rG4ii+NJ+9w3cw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(136003)(396003)(346002)(39860400002)(376002)(451199015)(36840700001)(40470700004)(46966006)(41300700001)(83380400001)(26005)(8936002)(5660300002)(2906002)(44832011)(186003)(9686003)(336012)(426003)(16526019)(7416002)(40460700003)(47076005)(82740400003)(86362001)(103116003)(82310400005)(33716001)(36860700001)(81166007)(356005)(40480700001)(54906003)(316002)(16576012)(4326008)(478600001)(110136005)(70586007)(8676002)(70206006)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 20:01:25.3313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 012c4d51-8086-4bd5-130c-08dabe9f5a85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call on_each_cpu_mask() can run the function on each CPU specified=0A=
by cpumask, which may include the local processor. So, replace the call=0A=
smp_call_function_many() with on_each_cpu_mask() to simplify the code.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   29 ++++++++--------------------=
-=0A=
 1 file changed, 8 insertions(+), 21 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index f37ecc16b34b..6b222f8e58ae 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -325,12 +325,7 @@ static void update_cpu_closid_rmid(void *info)=0A=
 static void=0A=
 update_closid_rmid(const struct cpumask *cpu_mask, struct rdtgroup *r)=0A=
 {=0A=
-	int cpu =3D get_cpu();=0A=
-=0A=
-	if (cpumask_test_cpu(cpu, cpu_mask))=0A=
-		update_cpu_closid_rmid(r);=0A=
-	smp_call_function_many(cpu_mask, update_cpu_closid_rmid, r, 1);=0A=
-	put_cpu();=0A=
+	on_each_cpu_mask(cpu_mask, update_cpu_closid_rmid, r, 1);=0A=
 }=0A=
 =0A=
 static int cpus_mon_write(struct rdtgroup *rdtgrp, cpumask_var_t newmask,=
=0A=
@@ -2130,13 +2125,9 @@ static int set_cache_qos_cfg(int level, bool enable)=
=0A=
 			/* Pick one CPU from each domain instance to update MSR */=0A=
 			cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);=0A=
 	}=0A=
-	cpu =3D get_cpu();=0A=
-	/* Update QOS_CFG MSR on this cpu if it's in cpu_mask. */=0A=
-	if (cpumask_test_cpu(cpu, cpu_mask))=0A=
-		update(&enable);=0A=
-	/* Update QOS_CFG MSR on all other cpus in cpu_mask. */=0A=
-	smp_call_function_many(cpu_mask, update, &enable, 1);=0A=
-	put_cpu();=0A=
+=0A=
+	/* Update QOS_CFG MSR on all the CPUs in cpu_mask */=0A=
+	on_each_cpu_mask(cpu_mask, update, &enable, 1);=0A=
 =0A=
 	free_cpumask_var(cpu_mask);=0A=
 =0A=
@@ -2613,7 +2604,7 @@ static int reset_all_ctrls(struct rdt_resource *r)=0A=
 	struct msr_param msr_param;=0A=
 	cpumask_var_t cpu_mask;=0A=
 	struct rdt_domain *d;=0A=
-	int i, cpu;=0A=
+	int i;=0A=
 =0A=
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))=0A=
 		return -ENOMEM;=0A=
@@ -2634,13 +2625,9 @@ static int reset_all_ctrls(struct rdt_resource *r)=
=0A=
 		for (i =3D 0; i < hw_res->num_closid; i++)=0A=
 			hw_dom->ctrl_val[i] =3D r->default_ctrl;=0A=
 	}=0A=
-	cpu =3D get_cpu();=0A=
-	/* Update CBM on this cpu if it's in cpu_mask. */=0A=
-	if (cpumask_test_cpu(cpu, cpu_mask))=0A=
-		rdt_ctrl_update(&msr_param);=0A=
-	/* Update CBM on all other cpus in cpu_mask. */=0A=
-	smp_call_function_many(cpu_mask, rdt_ctrl_update, &msr_param, 1);=0A=
-	put_cpu();=0A=
+=0A=
+	/* Update CBM on all the CPUs in cpu_mask */=0A=
+	on_each_cpu_mask(cpu_mask, rdt_ctrl_update, &msr_param, 1);=0A=
 =0A=
 	free_cpumask_var(cpu_mask);=0A=
 =0A=
=0A=

