Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122D663F428
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiLAPh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiLAPhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:37:08 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AF1AE4E2;
        Thu,  1 Dec 2022 07:37:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwM6epcZk7f1RyCbYJ8BNidLtUi908/E5t9tHw/cFO5YI94ly4TKVm4+gCnbhis42kkbaNK2FGLMY+ROXJM9d/+4CwLOBsXy75fFLQFoq5k48M8DYYCVTa4fUfF7avknHOxc70RXFGgEu8FQN6QauxuuW1NDnPz9uM2HAcreel0Z6Xcm+f1BkiQLQfNDEK7lTYuBmA3hMaRn+xfqCCB8m1YTNXNDC/d60MeVMBb29Np1S1m1ADYxK/QDfCVnD/EindYajHj5yr8hhuRab4Krm4jRAu4mNgfSHURh/YP71VnlLeZyc89NbMG3S+o7z64r3XY5PRWgF1u+qLaUO2NQjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiG/9RARrO/kQegglLrfX8Om4FftYr91k2tO+rZZ6NA=;
 b=jWY5iDnBw4Y0NsbIop7Kmvs4WR0BNwiUHpGo0KthtdoQSTg4ia3HLB/0dUVV9fwoL9hhjJ9yHRFtjkuDcYn+okI9PhtauMpUEZaWBBrGxSiX7fZcLtzG1LGE75BNFWx2TY2wljFjR9+md4ZM7xICb2Gam0BEZGL6mpMw/+2pjY0jtnm7VJlu33MreoBz5RD7F6H7a0QJwD3Y83WRy/7YoB9gJEa9l0AV57hUsiwhtMm5jqWN6hTtz++XZ/obXkfEWDP5B+ztCFazf/25qCbZOItV5O5WbOM61uZOpqk55DdELAV0sY5AuN7C/VaLztsuxdrTbpaU5OJfSUSMmz/Jig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiG/9RARrO/kQegglLrfX8Om4FftYr91k2tO+rZZ6NA=;
 b=iwdUnEsf4tRcnyEYWxHmikckmElFqHEpNZfjVZzVkHqP532slJFLuN8igLX6Y1aaPlqbJvzrqxPekY0OLALg67G28TCJlLSjrQuj8EGJzW5aEx8M2vwlvwLBNJsgTPIEZLJEgcNCiKj/Dio5kpFg+Ptq8E0Pf5GHBf5Inj069XE=
Received: from MW4PR03CA0031.namprd03.prod.outlook.com (2603:10b6:303:8e::6)
 by MN2PR12MB4357.namprd12.prod.outlook.com (2603:10b6:208:262::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Thu, 1 Dec
 2022 15:37:04 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::28) by MW4PR03CA0031.outlook.office365.com
 (2603:10b6:303:8e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.25 via Frontend
 Transport; Thu, 1 Dec 2022 15:37:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 1 Dec 2022 15:37:03 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Dec
 2022 09:36:56 -0600
Subject: [PATCH v9 08/13] x86/resctrl: Add sysfs interface to read
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
Date:   Thu, 1 Dec 2022 09:36:55 -0600
Message-ID: <166990901578.17806.14559688057407662110.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT023:EE_|MN2PR12MB4357:EE_
X-MS-Office365-Filtering-Correlation-Id: ca28995d-45b0-43b7-18e0-08dad3b1e59e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P0PmAK1EZmeMDgYGHMEA/3NCO19nwiOZvtjWiOoZbRQ1a1LJ8LnbE5h22AVPUo8jCIbOIV+UQyjiGoBKn1Wghu5YT/cVHRIwLzL71CRWJ96Sc+zExvqhYcYk6CKAUEVmRIB8EvQjR/re/Hq85mG5+R6vKI7cX1JogI2fSj6+LolxcFsNFAxQIaS3rCQBlX112LEHCYC9Ul0rC3qTF5FTwnjrPERXtR2Uau42JzU47aHuXpHDwivNVv4UOABv5lLQ2t5HzOusU7tYbbmVSF8KPmsBS18dSOe7+N4LREf9DAg7JVBR9MKUYURbHg50HlP7PzuLgdQXtSVp/KXDyjYPvrjqpgjQJSxGuqz8DKK1jFq0dr66L/bd6wzexRmQn7LPFT62bi8wCpOfxJXwhx0S3lQbBjdbxbwU5A708qNTya6AwkQHdO8fx7a+gFTbTAe+HtO8wpZEfXa5RA2MUlQQdiEDUZU66iAipQ+bdsEE/4MwQSH+X+/j17PVDDu8wR/qi5qVBV3cV716bdYjCIQRdjFJBrPHfZG+5Z7ZCtI0ctnGi7vP9du3k56tCUNjelVfEEZywoWUfj1bzLFCfFUwY/g8i/d0gvuSPuj3XFAsYBQtwqlQB6fqr5omhVnMx9ciEJFxvQLiHhKpNnKLylrEvdBnA2Kh6f5ZFuFX6Em6oT39ko4EUBEuXRUuDpJka1or+gmd+C6Hu/Qjn4IjAaDh8kl5qp+u/aJZWh0VXHLfEd00aHtFNW24UUOfN1Jws0U5
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(346002)(39860400002)(396003)(136003)(376002)(451199015)(46966006)(36840700001)(40470700004)(16526019)(336012)(40460700003)(103116003)(54906003)(316002)(16576012)(110136005)(40480700001)(81166007)(356005)(86362001)(82740400003)(83380400001)(426003)(82310400005)(26005)(47076005)(186003)(9686003)(2906002)(5660300002)(7406005)(44832011)(36860700001)(33716001)(478600001)(8936002)(70206006)(70586007)(8676002)(4326008)(7416002)(41300700001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 15:37:03.9643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca28995d-45b0-43b7-18e0-08dad3b1e59e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4357
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current event configuration can be viewed by the user by reading=0A=
the configuration file /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config.=
=0A=
The event configuration settings are domain specific and will affect all=0A=
the CPUs in the domain.=0A=
=0A=
Following are the types of events supported:=0A=
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
By default, the mbm_total_bytes_config is set to 0x7f to count all the=0A=
event types.=0A=
=0A=
For example:=0A=
    $cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config=0A=
    0=3D0x7f;1=3D0x7f;2=3D0x7f;3=3D0x7f=0A=
=0A=
    In this case, the event mbm_total_bytes is currently configured=0A=
    with 0x7f on domains 0 to 3.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/include/asm/msr-index.h       |    1 =0A=
 arch/x86/kernel/cpu/resctrl/internal.h |   24 ++++++++=0A=
 arch/x86/kernel/cpu/resctrl/monitor.c  |    4 +=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   99 ++++++++++++++++++++++++++++=
++++=0A=
 4 files changed, 127 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-in=
dex.h=0A=
index e0a40027aa62..2e5f57c93605 100644=0A=
--- a/arch/x86/include/asm/msr-index.h=0A=
+++ b/arch/x86/include/asm/msr-index.h=0A=
@@ -1062,6 +1062,7 @@=0A=
 /* - AMD: */=0A=
 #define MSR_IA32_MBA_BW_BASE		0xc0000200=0A=
 #define MSR_IA32_SMBA_BW_BASE		0xc0000280=0A=
+#define MSR_IA32_EVT_CFG_BASE		0xc0000400=0A=
 =0A=
 /* MSR_IA32_VMX_MISC bits */=0A=
 #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index b36750334deb..f7fc69e82e8b 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -30,6 +30,29 @@=0A=
  */=0A=
 #define MBM_CNTR_WIDTH_OFFSET_MAX (62 - MBM_CNTR_WIDTH_BASE)=0A=
 =0A=
+/* Reads to Local DRAM Memory */=0A=
+#define READS_TO_LOCAL_MEM		BIT(0)=0A=
+=0A=
+/* Reads to Remote DRAM Memory */=0A=
+#define READS_TO_REMOTE_MEM		BIT(1)=0A=
+=0A=
+/* Non-Temporal Writes to Local Memory */=0A=
+#define NON_TEMP_WRITE_TO_LOCAL_MEM	BIT(2)=0A=
+=0A=
+/* Non-Temporal Writes to Remote Memory */=0A=
+#define NON_TEMP_WRITE_TO_REMOTE_MEM	BIT(3)=0A=
+=0A=
+/* Reads to Local Memory the system identifies as "Slow Memory" */=0A=
+#define READS_TO_LOCAL_S_MEM		BIT(4)=0A=
+=0A=
+/* Reads to Remote Memory the system identifies as "Slow Memory" */=0A=
+#define READS_TO_REMOTE_S_MEM		BIT(5)=0A=
+=0A=
+/* Dirty Victims to All Types of Memory */=0A=
+#define  DIRTY_VICTIMS_TO_ALL_MEM	BIT(6)=0A=
+=0A=
+/* Max event bits supported */=0A=
+#define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)=0A=
 =0A=
 struct rdt_fs_context {=0A=
 	struct kernfs_fs_context	kfc;=0A=
@@ -531,5 +554,6 @@ bool has_busy_rmid(struct rdt_resource *r, struct rdt_d=
omain *d);=0A=
 void __check_limbo(struct rdt_domain *d, bool force_free);=0A=
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);=0A=
 void __init thread_throttle_mode_init(void);=0A=
+void __init mbm_config_rftype_init(const char *config);=0A=
 =0A=
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/re=
sctrl/monitor.c=0A=
index b39e0eca1879..2afddebc8636 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/monitor.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c=0A=
@@ -784,8 +784,10 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *=
r)=0A=
 		return ret;=0A=
 =0A=
 	if (rdt_cpu_has(X86_FEATURE_BMEC)) {=0A=
-		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL))=0A=
+		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {=0A=
 			mbm_total_event.configurable =3D true;=0A=
+			mbm_config_rftype_init("mbm_total_bytes_config");=0A=
+		}=0A=
 		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL))=0A=
 			mbm_local_event.configurable =3D true;=0A=
 	}=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 8342feb54a7f..e93b1c206116 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -1423,6 +1423,90 @@ static int rdtgroup_size_show(struct kernfs_open_fil=
e *of,=0A=
 	return ret;=0A=
 }=0A=
 =0A=
+struct mon_config_info {=0A=
+	u32 evtid;=0A=
+	u32 mon_config;=0A=
+};=0A=
+=0A=
+#define INVALID_CONFIG_INDEX   UINT_MAX=0A=
+=0A=
+/**=0A=
+ * mon_event_config_index_get - get the index for the configurable event=
=0A=
+ * @evtid: event id.=0A=
+ *=0A=
+ * Return: 0 for evtid =3D=3D QOS_L3_MBM_TOTAL_EVENT_ID=0A=
+ *         1 for evtid =3D=3D QOS_L3_MBM_LOCAL_EVENT_ID=0A=
+ *         INVALID_CONFIG_INDEX for invalid evtid=0A=
+ */=0A=
+static inline unsigned int mon_event_config_index_get(u32 evtid)=0A=
+{=0A=
+	switch (evtid) {=0A=
+	case QOS_L3_MBM_TOTAL_EVENT_ID:=0A=
+		return 0;=0A=
+	case QOS_L3_MBM_LOCAL_EVENT_ID:=0A=
+		return 1;=0A=
+	default:=0A=
+		/* WARN */=0A=
+		return INVALID_CONFIG_INDEX;=0A=
+	}=0A=
+}=0A=
+=0A=
+static void mon_event_config_read(void *info)=0A=
+{=0A=
+	struct mon_config_info *mon_info =3D info;=0A=
+	u32 h, index;=0A=
+=0A=
+	index =3D mon_event_config_index_get(mon_info->evtid);=0A=
+	if (index =3D=3D INVALID_CONFIG_INDEX) {=0A=
+		pr_warn_once("Invalid event id %d\n", mon_info->evtid);=0A=
+		return;=0A=
+	}=0A=
+	rdmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, h);=0A=
+=0A=
+	/* Report only the valid event configuration bits */=0A=
+	mon_info->mon_config &=3D MAX_EVT_CONFIG_BITS;=0A=
+}=0A=
+=0A=
+static void mondata_config_read(struct rdt_domain *d, struct mon_config_in=
fo *mon_info)=0A=
+{=0A=
+	smp_call_function_any(&d->cpu_mask, mon_event_config_read, mon_info, 1);=
=0A=
+}=0A=
+=0A=
+static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32=
 evtid)=0A=
+{=0A=
+	struct mon_config_info mon_info =3D {0};=0A=
+	struct rdt_domain *dom;=0A=
+	bool sep =3D false;=0A=
+=0A=
+	mutex_lock(&rdtgroup_mutex);=0A=
+=0A=
+	list_for_each_entry(dom, &r->domains, list) {=0A=
+		if (sep)=0A=
+			seq_puts(s, ";");=0A=
+=0A=
+		mon_info.evtid =3D evtid;=0A=
+		mondata_config_read(dom, &mon_info);=0A=
+=0A=
+		seq_printf(s, "%d=3D0x%02x", dom->id, mon_info.mon_config);=0A=
+		sep =3D true;=0A=
+	}=0A=
+	seq_puts(s, "\n");=0A=
+=0A=
+	mutex_unlock(&rdtgroup_mutex);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int mbm_total_bytes_config_show(struct kernfs_open_file *of,=0A=
+				       struct seq_file *seq, void *v)=0A=
+{=0A=
+	struct rdt_resource *r =3D of->kn->parent->priv;=0A=
+=0A=
+	mbm_config_show(seq, r, QOS_L3_MBM_TOTAL_EVENT_ID);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /* rdtgroup information files for one cache resource. */=0A=
 static struct rftype res_common_files[] =3D {=0A=
 	{=0A=
@@ -1521,6 +1605,12 @@ static struct rftype res_common_files[] =3D {=0A=
 		.seq_show	=3D max_threshold_occ_show,=0A=
 		.fflags		=3D RF_MON_INFO | RFTYPE_RES_CACHE,=0A=
 	},=0A=
+	{=0A=
+		.name		=3D "mbm_total_bytes_config",=0A=
+		.mode		=3D 0444,=0A=
+		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
+		.seq_show	=3D mbm_total_bytes_config_show,=0A=
+	},=0A=
 	{=0A=
 		.name		=3D "cpus",=0A=
 		.mode		=3D 0644,=0A=
@@ -1627,6 +1717,15 @@ void __init thread_throttle_mode_init(void)=0A=
 	rft->fflags =3D RF_CTRL_INFO | RFTYPE_RES_MB;=0A=
 }=0A=
 =0A=
+void __init mbm_config_rftype_init(const char *config)=0A=
+{=0A=
+	struct rftype *rft;=0A=
+=0A=
+	rft =3D rdtgroup_get_rftype_by_name(config);=0A=
+	if (rft)=0A=
+		rft->fflags =3D RF_MON_INFO | RFTYPE_RES_CACHE;=0A=
+}=0A=
+=0A=
 /**=0A=
  * rdtgroup_kn_mode_restrict - Restrict user access to named resctrl file=
=0A=
  * @r: The resource group with which the file is associated.=0A=
=0A=

