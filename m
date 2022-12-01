Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88A663F438
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbiLAPix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbiLAPgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:36:48 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430688D649;
        Thu,  1 Dec 2022 07:36:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtX/1umaSO58/yBN/I//OsPMQt4OQQ05FutZl1k3wZahCmbst2PE+/JckY8Hyg3pSXxn5qRqxwGjC1XvCflT8yVyjhxFVvk43wYXaNiE69a276AYHxr7KQTFiW91C94ygwTnnb9C8XmPUQLon8yIrvyYBKfY1cPV9KHSgt8HXfhBuGE7s9/NmRVQHyiU+O62UD9Dn1x7yNFXCltLurIjXVEuo1C4GQGdkGL9C/iVoaAlbPVVUOZLKz4F9egHfkZE4q02Xi2dI1dvLZFskm/ihsr3lckeLBjtdkqWvFMEDG41bOAoABMBrd6HvXp51CgI8pcK1NARCO/17rfmBAOuvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhymE8J2J2VKrJKj+eoQdxHpbz1Uz67GFmgMCMjBxeQ=;
 b=g17tJ3POxoOdL4cOseOzhGsRCyjElo14uvuF5vlW2EmYlaSqqWRqM3nq0cadMvg7D7gY2de4nrx1DdJDXfK3/Ntec0mKeOnwhiCFeEvluk/OsX0ifWbq1NVG1/iSKiSVVYL31VqRpFX9fQhAHgysJ3E9jByDKvtGGrnQTmfPL43F7Fq4OQTn7OCo3vYh8PKl07dt8KMUFarg/FhEXC6A9874JcgaW0M5Dq3HMRYV8jm8iBpZvIbw7tL49fN6QraxjqWIelFvzDVW86Yb8iW3ztNJW5nQKj4v1IJ87I3/qTvxiPnuMrb4ulofHOVOpZWQlJI81+X+yucq9Gk5szYa9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhymE8J2J2VKrJKj+eoQdxHpbz1Uz67GFmgMCMjBxeQ=;
 b=KihilvybwvmCs2l9PpV7NN6dCYfq3HE4UNhRBUnGihOx264nbtjeuL3z5ncLMWoeCP+LdzwbQ2IAgcx8BCpcOoAKwd5bgIFESf7vhJ4fl/tldlgBNiX0rpRmxhpiSeEAFBLx7Vg+ww9crLPOJNS47PuIB2JnVTSrAsHG9UXfwVw=
Received: from MW3PR05CA0022.namprd05.prod.outlook.com (2603:10b6:303:2b::27)
 by PH8PR12MB6865.namprd12.prod.outlook.com (2603:10b6:510:1c8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 15:36:44 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::8a) by MW3PR05CA0022.outlook.office365.com
 (2603:10b6:303:2b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17 via Frontend
 Transport; Thu, 1 Dec 2022 15:36:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Thu, 1 Dec 2022 15:36:44 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Dec
 2022 09:36:41 -0600
Subject: [PATCH v9 06/13] x86/resctrl: Add __init attribute to
 rdt_get_mon_l3_config()
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
Date:   Thu, 1 Dec 2022 09:36:41 -0600
Message-ID: <166990900117.17806.4506067708943298894.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT011:EE_|PH8PR12MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e0b8140-a62f-425e-2186-08dad3b1d9e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vJFR55M4jFpguM2lXfcE33iVFauBpUa6+SyasIkQ9Il1hGeaRoJ4WnGg73j7Yeukgg39TN+mfn+W8QMYo6CEJWcEyaaOqFbB9Ve4WWLi7Swb+ztjf5UQkupYeHtju8sfgUARJewFG81zLZBKXwEc4bC39ozyhFLD7eXZKDKi0unbA54BHTgX4t/gNyUdT+T/L1RgeSC7iMbq3wv+8nGgFLhn3mcwQdPuNcTv3BRCRre9S7FaBGVT4h9vZBXfXNZvgS+W+yavlxQZQGNEo1IEu4Kip/GPU07RXA87cvyY2df/uHxFT3XvnmcwVhdptp73CdKmo/8F0yVsJxMqyRm5hvdWK6Yk7hKRkStstAN+JXwA+/23hkigOmiqogmlKMCroNPUDK7oL994B61YHPl0LvjBs0s0BSUG7umkpVHMw0OTRf1FVOp1tb2utZq1niPs4SW3Tg06tEnw2JZijBkzRxDE321QT14PR9vbTtkyRp41H+cpiMZ1WCW+zRCJDMbq1A7xINBKq69GQW7qHd4nv7pv0U3qoY6C6zGe/+hnAhWspNN1MY25NzoaOq6gThzt3AzF3s3l48hlX2q6uiQP/Xv8gkW6iumEeE3XxIVud9sJHUNQV3qisMvUwvAR6THNqu5WKjRdIflafU2oCXuw35+SpR8TkQgmIKrbGFgAPxkXDWfQS/NyjHEdQaasnLXHVjXKcu341JkoW0In6ifaBrddRoDIBSXmfkp0cowxA+B5Z2rUT0biBMuwsxOGP2V02YzD4RHDc7HM4jB57AmfSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(7916004)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199015)(40470700004)(36840700001)(46966006)(83380400001)(36860700001)(2906002)(186003)(70586007)(70206006)(16526019)(336012)(40460700003)(41300700001)(7406005)(86362001)(40480700001)(82740400003)(26005)(110136005)(54906003)(81166007)(103116003)(82310400005)(5660300002)(8676002)(7416002)(47076005)(426003)(16576012)(356005)(4326008)(33716001)(44832011)(478600001)(9686003)(316002)(8936002)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 15:36:44.2997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0b8140-a62f-425e-2186-08dad3b1d9e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6865
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function rdt_get_mon_l3_config() needs to call rdt_cpu_has() to=0A=
query the monitor related features. It cannot be called right now=0A=
because rdt_cpu_has() has the __init attribute but rdt_get_mon_l3_config()=
=0A=
doesn't. So, add the __init attribute to rdt_get_mon_l3_config() to=0A=
resolve it.=0A=
=0A=
Also, make the function rdt_cpu_has() available outside core.c file.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/core.c     |    2 +-=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |    1 +=0A=
 arch/x86/kernel/cpu/resctrl/monitor.c  |    2 +-=0A=
 3 files changed, 3 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resct=
rl/core.c=0A=
index b4fc851f6489..030d3b409768 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/core.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/core.c=0A=
@@ -728,7 +728,7 @@ static int __init set_rdt_options(char *str)=0A=
 }=0A=
 __setup("rdt", set_rdt_options);=0A=
 =0A=
-static bool __init rdt_cpu_has(int flag)=0A=
+bool __init rdt_cpu_has(int flag)=0A=
 {=0A=
 	bool ret =3D boot_cpu_has(flag);=0A=
 	struct rdt_options *o;=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index fdbbf66312ec..7bbfc10094b6 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -512,6 +512,7 @@ void closid_free(int closid);=0A=
 int alloc_rmid(void);=0A=
 void free_rmid(u32 rmid);=0A=
 int rdt_get_mon_l3_config(struct rdt_resource *r);=0A=
+bool rdt_cpu_has(int flag);=0A=
 void mon_event_count(void *info);=0A=
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);=0A=
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/re=
sctrl/monitor.c=0A=
index efe0c30d3a12..e33e8d8bd796 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/monitor.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c=0A=
@@ -746,7 +746,7 @@ static void l3_mon_evt_init(struct rdt_resource *r)=0A=
 		list_add_tail(&mbm_local_event.list, &r->evt_list);=0A=
 }=0A=
 =0A=
-int rdt_get_mon_l3_config(struct rdt_resource *r)=0A=
+int __init rdt_get_mon_l3_config(struct rdt_resource *r)=0A=
 {=0A=
 	unsigned int mbm_offset =3D boot_cpu_data.x86_cache_mbm_width_offset;=0A=
 	struct rdt_hw_resource *hw_res =3D resctrl_to_arch_res(r);=0A=
=0A=

