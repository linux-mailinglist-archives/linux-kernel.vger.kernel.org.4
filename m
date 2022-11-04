Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAE961A1C9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiKDUB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiKDUBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:01:21 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE2C45A37;
        Fri,  4 Nov 2022 13:01:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T17cwrFzi0/pI0U4J3jC62qPpKJE/EaxOyEITknh1IJ7OGu9x44gUx28MS8eofnOTny3dEkROI43AzfQeR04qfOFOkFNH03toAlVUeMX1OiGHWuDCgKgDYfnoyRl2v5esJraBz9lGftw+tib2T9zXUZhg8T2j8admMMZM9KST4sZHEy18rAcSEd1u/PvW0xP3xEQ+y1PjbZh/7oe4GNOiX7XG7R7h2xqCu+hYgjEJd1kFz78dxcBBWRuHLO1hd+bftTFyY8qT91v3m5HqPzo9zNwK3e/3w1lM6hhU76sB/mY4CfWdfuMXPy9uuYpRvU4CfR3ouZ18ZglLK5j3UkYDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhPsXuc7Ix2Dzi+ZlbtEA0mEhLgjscPZHWQv6Fb9h2g=;
 b=ngynHBVA4AzA/Zo7QlN9TfHPCitGyDF7xyG4Grt4eE53ix+bKb7KTDLgFN7Dqnci03Ryn1eSrhk4VR+CUXTnBkvMpj1CyUIU/46Q/FOuzwFXHLOoGfZo15ISdmCdcBWUVgR9599mctlnOMe+ia/tIj9BgmL8xYP+GlOGSQTLZE0Qyiws1uv+J5H75EhPuoP6eeERBB144dIs1DochFJDcnPsDKEktEJVE5PG77mU8VUYWENiwKkb9haHEpCWJRraZ3GFboc673C35NQ8l6eqUBjIPAUmYmjJ/6feiiyN4SZBRRVCMgc7L4bWcx8H0Ko3k3S0WtDFnhi8rOUJAdygbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhPsXuc7Ix2Dzi+ZlbtEA0mEhLgjscPZHWQv6Fb9h2g=;
 b=H2wC0/cBIahPQjilhd+6Qy+JhPqxmHEmqnL9z9ENOHK2LxHoZeR7PlwiYXIdcXuv+DCfId69ax+291lkONczQX0mWq3albrLb7Frrt/Li7hmubh1huw/pihsU4b4/yLuvONNc0x6IKvrl8E+pHP1YUWUtbeMx0IpHDbYkGHA5k0=
Received: from DS7PR05CA0035.namprd05.prod.outlook.com (2603:10b6:8:2f::18) by
 DM6PR12MB5007.namprd12.prod.outlook.com (2603:10b6:5:20d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.22; Fri, 4 Nov 2022 20:01:12 +0000
Received: from DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::60) by DS7PR05CA0035.outlook.office365.com
 (2603:10b6:8:2f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.8 via Frontend
 Transport; Fri, 4 Nov 2022 20:01:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT100.mail.protection.outlook.com (10.13.172.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Fri, 4 Nov 2022 20:01:12 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 4 Nov
 2022 15:01:09 -0500
Subject: [PATCH v8 10/13] x86/resctrl: Add sysfs interface to write
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
        <eranian@google.com>
Date:   Fri, 4 Nov 2022 15:01:09 -0500
Message-ID: <166759206900.3281208.11975514088019160962.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT100:EE_|DM6PR12MB5007:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ee638a-3275-480d-26df-08dabe9f52ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hG9n9cAnSqeTnoVfSyZ4ZqXfNvZ7C3UCGLGEyeZUaJtDIYSGb8c0jEc/KmDh392cfyVhuIqf86ufCG+kTfVimswHTczsj+GbZGUerEmv46633lb67/0Q6lF90quRw8u2jYvWa59y8g3rrSqQv3q9+sty302zTkSQCsP2LNmVxtV1THl7HGOvhJQ0pQxuWPlFo47Mcx1SzEfi432BuGuTLMH4QkRTg0+7+zqtwkggCckVHqZYEQZOL9bwTy/mX58mGHic5UIIjEg6EQRjSxuQjuHODeWfp//JNdq8DD6jpsAr/+ypiRCa4/QnxKD7Q1FPqSuxYM4oiYdE65D5nYevtmAkGt1cGRcYVTGOXVzmpEWbtY4aHWeivyk8zvI1dz+mnoUzAjrPfAbbvP85QakQbjPyQlw+4u5Cwd1aNqcELG+Z7UP6D5sm8lrH8UUFiEwd9FSJrM8fKNr+U7QVN9r+hhOzaQLsA3+DdY8bNHIK6KBK4E5iCd6Ga+KY5IqvNT2UoG20QwSnbLinufEGNvik1o13v5NO8FY+Iv68nDOwbrFd1fkYZXcNiGvYL9O4r2xgEqbhSt2OWPCnIWBjkqWKk1ppok9HKoEa+K325Wu3rJh7ZUpM8yDOwZzWLtbFOwp6yDFoYYAKOoJjDmNt0xKf7mwQlXNcUHmTwvoU48L2s6C9LCsI+tcC8GIQiUKJ/urM4YunhiOOHKFyHYKTu3P4+C4sqGJfCGXhN1CpHz4TmlWDUKSVv3DtL3PCvJARVmA93+kqgLve+fuEOvkh4g2ivV7xlBpDyDqO1uaeSBMx8j87gF9cWP5gDlrD5DHpO2vysXHrBYm5F5SUVmbC22XtoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(7916004)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(83380400001)(70586007)(8676002)(4326008)(70206006)(356005)(47076005)(86362001)(426003)(40480700001)(316002)(103116003)(33716001)(16576012)(40460700003)(54906003)(2906002)(81166007)(82310400005)(36860700001)(82740400003)(110136005)(8936002)(41300700001)(478600001)(9686003)(26005)(7416002)(5660300002)(16526019)(186003)(44832011)(336012)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 20:01:12.3778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ee638a-3275-480d-26df-08dabe9f52ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5007
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
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  130 ++++++++++++++++++++++++++++=
++++=0A=
 1 file changed, 129 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 18f9588a41cf..0cdccb69386e 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -1505,6 +1505,133 @@ static int mbm_local_bytes_config_show(struct kernf=
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
+	if (index >=3D MAX_CONFIG_EVENTS) {=0A=
+		pr_warn_once("Invalid event id %d\n", mon_info->evtid);=0A=
+		return;=0A=
+	}=0A=
+	wrmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, 0);=0A=
+}=0A=
+=0A=
+static int mbm_config_write(struct rdt_resource *r, struct rdt_domain *d,=
=0A=
+			    u32 evtid, u32 val)=0A=
+{=0A=
+	struct mon_config_info mon_info =3D {0};=0A=
+	int ret =3D 0;=0A=
+=0A=
+	rdt_last_cmd_clear();=0A=
+=0A=
+	/* mon_config cannot be more than the supported set of events */=0A=
+	if (val > MAX_EVT_CONFIG_BITS) {=0A=
+		rdt_last_cmd_puts("Invalid event configuration\n");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Read the current config value first. If both are same then=0A=
+	 * we don't need to write it again.=0A=
+	 */=0A=
+	mon_info.evtid =3D evtid;=0A=
+	mondata_config_read(d, &mon_info);=0A=
+	if (mon_info.mon_config =3D=3D val)=0A=
+		goto write_exit;=0A=
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
+	memset(d->mbm_local, 0, sizeof(struct mbm_state) * r->num_rmid);=0A=
+	memset(d->mbm_total, 0, sizeof(struct mbm_state) * r->num_rmid);=0A=
+=0A=
+write_exit:=0A=
+	return ret;=0A=
+}=0A=
+=0A=
+static int mon_config_parse(struct rdt_resource *r, char *tok, u32 evtid)=
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
+	if (!dom_str || kstrtoul(id_str, 10, &dom_id)) {=0A=
+		rdt_last_cmd_puts("Missing '=3D' or non-numeric domain id\n");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	if (!dom_str || kstrtoul(dom_str, 16, &val)) {=0A=
+		rdt_last_cmd_puts("Missing '=3D' or non-numeric event configuration valu=
e\n");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	list_for_each_entry(d, &r->domains, list) {=0A=
+		if (d->id =3D=3D dom_id) {=0A=
+			ret =3D mbm_config_write(r, d, evtid, val);=0A=
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
+	ret =3D mon_config_parse(r, buf, QOS_L3_MBM_TOTAL_EVENT_ID);=0A=
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
@@ -1605,9 +1732,10 @@ static struct rftype res_common_files[] =3D {=0A=
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
=0A=

