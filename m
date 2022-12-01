Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B6463F42C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbiLAPhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbiLAPhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:37:24 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBC98D649;
        Thu,  1 Dec 2022 07:37:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sq3oCYo1/V8pNXGb9WTQC3r4mwyr+JjE6iV8RFYXEEi+Gb7cv19ytnyftI9uwvz6izpPWLkPLV8nn1J3nI8P3QPAoDnoEyEjb/D/EUuNP3XlmhPkR6XGwXmA6KyxGIAQkeJbgNjJP7xFz4tHJzdcKNmXHAyNRI5JNMqaFC7o+YRc7+traT7CAlbxo/yV1epfQLAwFiRAeBIcWZcNX9atu9zVG70r96YKhdw0s41fT5uqXt4LDjTHF7NQr292jAPxL+bwIYMqsPlcq1uoRFTz/YP2IwoAds7W5MgUf5ljT1pIVpOto1iQXNchLdk6PiX4ljnOsNNWIaln5AyxGlhgHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uzowYfQobwSEZJ6ftLgb5iSVQSyJuZ59EqCdWfiPf4=;
 b=HkXC1YqasvEeLrlxAgdjBsCg/UOqhMYgYSiNCd8k8e1c2Qx8RrzkV/ZOQEfq3tYVDzECLIFzMjhG0GVs75tm0CrAtKbWo5PmMv/TFU1JgFJs8sqajp2NKKTkZ4eje+n0Hgl062kCEFcEm1Y0qVKKF65V16dbiAcs8fjbSpBq44ZoBG7UnJCwtyC3FSkb8hOSvK96rVuvxpTt+ot1Pavzxc2gwpyUAqpz7iOoA9wb/tBu7NYx4UQ2nuBmyPKVql3Cnu7vpui9hYag9LLG/d5juZFiQ6uzJSRpRnAyEveVuAAeHYY22nCb333wJsZIv9HONbKKDyMJMTL4aI9uLGEKFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uzowYfQobwSEZJ6ftLgb5iSVQSyJuZ59EqCdWfiPf4=;
 b=eH36igBJfDm8lYZIbKG/Gp1jLhhOJA9wXi0tcAVLMmtsFRbBmuf3XzH8asAmn6KG0fn0+oUZMbjEw5hbtt2ZyQUwQyq5gVwFBXn/swM7VgX55k2gxZa/OHUWFJKWN31zZai1hzcjiugUck/eXTQyhaYtdu22lBItp4T7XHdkuew=
Received: from MW4PR03CA0107.namprd03.prod.outlook.com (2603:10b6:303:b7::22)
 by DS0PR12MB7677.namprd12.prod.outlook.com (2603:10b6:8:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 15:37:20 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::d7) by MW4PR03CA0107.outlook.office365.com
 (2603:10b6:303:b7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Thu, 1 Dec 2022 15:37:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Thu, 1 Dec 2022 15:37:19 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Dec
 2022 09:37:15 -0600
Subject: [PATCH v9 10/13] x86/resctrl: Add sysfs interface to write
 mbm_total_bytes_config
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
Date:   Thu, 1 Dec 2022 09:37:10 -0600
Message-ID: <166990903030.17806.5106229901730558377.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT009:EE_|DS0PR12MB7677:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fea3cfc-724e-483c-192a-08dad3b1ef22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lzb603UZF5EcBkYVBnp2ADGjTZn+TRdB+TDYW2HkOU7CIAv3HGoBHAzXqcXhLYUQ1neQ59f8UIbta4RKhL6xqK8MNFF0kCAuh85hMhD37f0YOvVN42F634eBSUteC9WQJbu8tyx3iYTShfT5P0GgMi1nE8MFW2Sft+Ya1VfcGs8ZsyVvd8vIvEqveBn/W0Y0rntU0H/Atrs/TUP+JUwcDyJqS4fEiu+xDr8Em4H8d235ZsIhvTb9y9PFXgxc3pUbm76XEY/xxlHncedNS30ydByEmEvu/GeVa60UuTRrhjKSEwzICGZGugHNpVk0kqJNasPH/E6GAGrdlABt3fCjlsqamC16Xkt25i6k15uSzSfIm5sRJim0rdmAU1acfUOHGqkvEltUC18ePFixlH3gOZPr1GtWwseXCyUg4hXften9QuDTQndwjgxSC7JOY+z3m1vXJCgseBv0rurviTfAZ6OB41dQyyM2Zj5nJDrRHYHS3RmM6+97SotBSWV7pYHb4DqtxeJS72+QM0I1kTA5WaGlR0Ak8F/LuHhI6QAAyDBc787cQ3MKhTL/ayq5E5atoTgxMgcR86RKqHQZpn+VbUwL6oGKxNUoPezqiac7sGBwUdFi9qNwwPfDz8hzRfCgGlFfT3fb32uc5fzID1jmTjjX4j5AQFc8nBT1PPV2Ho+veNrWrrcd9XE9wzNVZvd18kXzUKM7dADjVDWVy1RYdZGnTmAVLTdGJXH7ZCxbdyzyAOpyZpXqri2gj+4HBtX57BPDri0LYtYLSf3cyzbq2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(136003)(396003)(376002)(346002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(41300700001)(5660300002)(86362001)(7406005)(81166007)(110136005)(7416002)(26005)(8936002)(16576012)(54906003)(316002)(40460700003)(426003)(336012)(47076005)(103116003)(186003)(83380400001)(40480700001)(82310400005)(4326008)(8676002)(33716001)(70586007)(70206006)(44832011)(36860700001)(478600001)(16526019)(9686003)(82740400003)(6666004)(356005)(2906002)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 15:37:19.9445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fea3cfc-724e-483c-192a-08dad3b1ef22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7677
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current event configuration for mbm_total_bytes can be changed by=0A=
the user by writing to the file=0A=
/sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config.=0A=
=0A=
The event configuration settings are domain specific and will affect all=0A=
the CPUs in the domain.=0A=
=0A=
Following are the types of events supported:=0A=
=0A=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
Bits   Description=0A=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
6      Dirty Victims from the QOS domain to all types of memory=0A=
5      Reads to slow memory in the non-local NUMA domain=0A=
4      Reads to slow memory in the local NUMA domain=0A=
3      Non-temporal writes to non-local NUMA domain=0A=
2      Non-temporal writes to local NUMA domain=0A=
1      Reads to memory in the non-local NUMA domain=0A=
0      Reads to memory in the local NUMA domain=0A=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
For example:=0A=
To change the mbm_total_bytes to count only reads on domain 0, the bits=0A=
0, 1, 4 and 5 needs to be set, which is 110011b (in hex 0x33). Run the=0A=
command.=0A=
	$echo  0=3D0x33 > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config=0A=
=0A=
To change the mbm_total_bytes to count all the slow memory reads on=0A=
domain 1, the bits 4 and 5 needs to be set which is 110000b (in hex 0x30).=
=0A=
Run the command.=0A=
	$echo  1=3D0x30 > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/monitor.c  |   13 +++=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  127 ++++++++++++++++++++++++++++=
++++=0A=
 include/linux/resctrl.h                |   10 +++=0A=
 3 files changed, 149 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/re=
sctrl/monitor.c=0A=
index 7c8a3a745041..b265856835de 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/monitor.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c=0A=
@@ -176,6 +176,19 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, s=
truct rdt_domain *d,=0A=
 		memset(am, 0, sizeof(*am));=0A=
 }=0A=
 =0A=
+void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_domain=
 *d)=0A=
+{=0A=
+	struct rdt_hw_domain *hw_dom =3D resctrl_to_arch_dom(d);=0A=
+=0A=
+	if (is_mbm_total_enabled())=0A=
+		memset(hw_dom->arch_mbm_total, 0,=0A=
+		       sizeof(*hw_dom->arch_mbm_total) * r->num_rmid);=0A=
+=0A=
+	if (is_mbm_local_enabled())=0A=
+		memset(hw_dom->arch_mbm_local, 0,=0A=
+		       sizeof(*hw_dom->arch_mbm_local) * r->num_rmid);=0A=
+}=0A=
+=0A=
 static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int widt=
h)=0A=
 {=0A=
 	u64 shift =3D 64 - width, chunks;=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 580f3cce19e2..8a22a652a6e8 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -1517,6 +1517,130 @@ static int mbm_local_bytes_config_show(struct kernf=
s_open_file *of,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+static void mon_event_config_write(void *info)=0A=
+{=0A=
+	struct mon_config_info *mon_info =3D info;=0A=
+	u32 index;=0A=
+=0A=
+	index =3D mon_event_config_index_get(mon_info->evtid);=0A=
+	if (index =3D=3D INVALID_CONFIG_INDEX) {=0A=
+		pr_warn_once("Invalid event id %d\n", mon_info->evtid);=0A=
+		return;=0A=
+	}=0A=
+	wrmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, 0);=0A=
+}=0A=
+=0A=
+static int mbm_config_write_domain(struct rdt_resource *r,=0A=
+				   struct rdt_domain *d, u32 evtid, u32 val)=0A=
+{=0A=
+	struct mon_config_info mon_info =3D {0};=0A=
+	int ret =3D 0;=0A=
+=0A=
+	/* mon_config cannot be more than the supported set of events */=0A=
+	if (val > MAX_EVT_CONFIG_BITS) {=0A=
+		rdt_last_cmd_puts("Invalid event configuration\n");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Read the current config value first. If both are the same then=0A=
+	 * no need to write it again.=0A=
+	 */=0A=
+	mon_info.evtid =3D evtid;=0A=
+	mondata_config_read(d, &mon_info);=0A=
+	if (mon_info.mon_config =3D=3D val)=0A=
+		goto out;=0A=
+=0A=
+	mon_info.mon_config =3D val;=0A=
+=0A=
+	/*=0A=
+	 * Update MSR_IA32_EVT_CFG_BASE MSRs on all the CPUs in the=0A=
+	 * domain. The MSRs offset from MSR MSR_IA32_EVT_CFG_BASE=0A=
+	 * are scoped at the domain level. Writing any of these MSRs=0A=
+	 * on one CPU is supposed to be observed by all CPUs in the=0A=
+	 * domain. However, the hardware team recommends to update=0A=
+	 * these MSRs on all the CPUs in the domain.=0A=
+	 */=0A=
+	on_each_cpu_mask(&d->cpu_mask, mon_event_config_write, &mon_info, 1);=0A=
+=0A=
+	/*=0A=
+	 * When an Event Configuration is changed, the bandwidth counters=0A=
+	 * for all RMIDs and Events will be cleared by the hardware. The=0A=
+	 * hardware also sets MSR_IA32_QM_CTR.Unavailable (bit 62) for=0A=
+	 * every RMID on the next read to any event for every RMID.=0A=
+	 * Subsequent reads will have MSR_IA32_QM_CTR.Unavailable (bit 62)=0A=
+	 * cleared while it is tracked by the hardware. Clear the=0A=
+	 * mbm_local and mbm_total counts for all the RMIDs.=0A=
+	 */=0A=
+	resctrl_arch_reset_rmid_all(r, d);=0A=
+=0A=
+out:=0A=
+	return ret;=0A=
+}=0A=
+=0A=
+static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)=
=0A=
+{=0A=
+	char *dom_str =3D NULL, *id_str;=0A=
+	unsigned long dom_id, val;=0A=
+	struct rdt_domain *d;=0A=
+	int ret =3D 0;=0A=
+=0A=
+next:=0A=
+	if (!tok || tok[0] =3D=3D '\0')=0A=
+		return 0;=0A=
+=0A=
+	/* Start processing the strings for each domain */=0A=
+	dom_str =3D strim(strsep(&tok, ";"));=0A=
+	id_str =3D strsep(&dom_str, "=3D");=0A=
+=0A=
+	if (!id_str || kstrtoul(id_str, 10, &dom_id)) {=0A=
+		rdt_last_cmd_puts("Missing '=3D' or non-numeric domain id\n");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	if (!dom_str || kstrtoul(dom_str, 16, &val)) {=0A=
+		rdt_last_cmd_puts("Non-numeric event configuration value\n");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	list_for_each_entry(d, &r->domains, list) {=0A=
+		if (d->id =3D=3D dom_id) {=0A=
+			ret =3D mbm_config_write_domain(r, d, evtid, val);=0A=
+			if (ret)=0A=
+				return -EINVAL;=0A=
+			goto next;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	return -EINVAL;=0A=
+}=0A=
+=0A=
+static ssize_t mbm_total_bytes_config_write(struct kernfs_open_file *of,=
=0A=
+					    char *buf, size_t nbytes,=0A=
+					    loff_t off)=0A=
+{=0A=
+	struct rdt_resource *r =3D of->kn->parent->priv;=0A=
+	int ret;=0A=
+=0A=
+	/* Valid input requires a trailing newline */=0A=
+	if (nbytes =3D=3D 0 || buf[nbytes - 1] !=3D '\n')=0A=
+		return -EINVAL;=0A=
+=0A=
+	cpus_read_lock();=0A=
+	mutex_lock(&rdtgroup_mutex);=0A=
+=0A=
+	rdt_last_cmd_clear();=0A=
+=0A=
+	buf[nbytes - 1] =3D '\0';=0A=
+=0A=
+	ret =3D mon_config_write(r, buf, QOS_L3_MBM_TOTAL_EVENT_ID);=0A=
+=0A=
+	mutex_unlock(&rdtgroup_mutex);=0A=
+	cpus_read_unlock();=0A=
+=0A=
+	return ret ?: nbytes;=0A=
+}=0A=
+=0A=
 /* rdtgroup information files for one cache resource. */=0A=
 static struct rftype res_common_files[] =3D {=0A=
 	{=0A=
@@ -1617,9 +1741,10 @@ static struct rftype res_common_files[] =3D {=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "mbm_total_bytes_config",=0A=
-		.mode		=3D 0444,=0A=
+		.mode		=3D 0644,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D mbm_total_bytes_config_show,=0A=
+		.write		=3D mbm_total_bytes_config_write,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "mbm_local_bytes_config",=0A=
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h=0A=
index 0cee154abc9f..e4dc65892446 100644=0A=
--- a/include/linux/resctrl.h=0A=
+++ b/include/linux/resctrl.h=0A=
@@ -250,6 +250,16 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, str=
uct rdt_domain *d,=0A=
 void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,=
=0A=
 			     u32 rmid, enum resctrl_event_id eventid);=0A=
 =0A=
+/**=0A=
+ * resctrl_arch_reset_rmid_all() - Reset any private state associated with=
=0A=
+ * 				   all the rmids.=0A=
+ * @r:		The domain's resource.=0A=
+ * @d:		The rmid's domain.=0A=
+ *=0A=
+ * This can be called from any CPU.=0A=
+ */=0A=
+void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_domain=
 *d);=0A=
+=0A=
 extern unsigned int resctrl_rmid_realloc_threshold;=0A=
 extern unsigned int resctrl_rmid_realloc_limit;=0A=
 =0A=
=0A=

