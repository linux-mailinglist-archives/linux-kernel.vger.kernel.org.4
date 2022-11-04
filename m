Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCDC61A1C0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiKDUBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiKDUAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:00:55 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C72D4AF28;
        Fri,  4 Nov 2022 13:00:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFNmaKNojYHCrrMbMVr8Y6C4gGPgxIfYlTQSFHzuOb2TN9dpSRGWwMBz8NlQl1GFSH5X13M9jJggXxF48am98qcDAQn8vE6cIMoDS+cYcgp54kIKs6fzC8LSgEUo7LwwyRYaBmItIfyInlJOUdylLyl+tPZXhgIonQUJLpNDoMBQ+NwishB33l3V/BPJ/L9bvLl64ZPbc7901dmYD0Xmz3nLHbdwnkO/KP2gx8OCTaYYdvS4iSjHlfkVxdzDeelSPnMII4iYUcSAHzz5m9veG4c5803X8XbMIhAEaWXqx54o+FY9z49TinA+ONpixG/wO//0vsDpf/99wXojUq79Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKb9tDfP1LbvSJvk9qh0dWDguSRtNWle59XvPJKlnR8=;
 b=GKYqXVp1iShoWGG2gFJ7zcC7UNno7IYqokmJFsKLxBTRGcU2z8yGAA0YR0ApY1d8NTKAPiQECTgsLXWxqO1q8CC5KSD/CRB6fwgvcw8rfY89mRHsQ6Ce8NSZpu6wm4AoIdOTSOPfe45SkT57wNPXV2LwO4yQ3YCGxgYagJOF3URAsAaFG8btlE672HaKCpcchc9drI2SQmuYclu/NHwILai6g+maNx6lFOCIgvKygkdHKPeXBkeaoIGiY/2pARut817Ow1OYCoU0tclsDC/RKc4OLID7MlvHAF1JadM9VJieAuwiXJMuRoi4ARZlUIRWcKwz1kKsaxy2aoUW2sX6WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKb9tDfP1LbvSJvk9qh0dWDguSRtNWle59XvPJKlnR8=;
 b=Qq+6dIuvMRWDF5pXrGCxAPpyIDITipJTUb3zZxhCJNu3R6MV416N0kxNa8qXY/8XkRtVGqEcxwwzM5CWAbphikoexhtET0A42b3J34y/Iav3h6kpMm+zpnDQkdDkhK621bFMzp+gVQET7Wa9sfYaPOs2IlxXcKCtQ+5nvkQ92eo=
Received: from DS7PR03CA0043.namprd03.prod.outlook.com (2603:10b6:5:3b5::18)
 by SA1PR12MB7126.namprd12.prod.outlook.com (2603:10b6:806:2b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Fri, 4 Nov
 2022 20:00:50 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::ae) by DS7PR03CA0043.outlook.office365.com
 (2603:10b6:5:3b5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.18 via Frontend
 Transport; Fri, 4 Nov 2022 20:00:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Fri, 4 Nov 2022 20:00:50 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 4 Nov
 2022 15:00:48 -0500
Subject: [PATCH v8 07/13] x86/resctrl: Introduce data structure to support
 monitor configuration
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
Date:   Fri, 4 Nov 2022 15:00:43 -0500
Message-ID: <166759204323.3281208.9744810874584175730.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT066:EE_|SA1PR12MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc93470-ef2d-410e-8565-08dabe9f45d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wpDlkeVRmiKXFkSd9vU/Xo8qxiBVjXfl/a6bUI7P3gilK+/5oSuVi3XEUBbXXLjL8rzewLWgKiSz5rwTDd2UMvbKxAeMtItj2ZN0KQuOE96hsHjRLiE6Qfl6yrrKyNGgp5M8Mj2RMT6To7OkaBLROKXzit4I9ggznfamktyItiO8034FnWM+xkB7QQ1c92k9uKuDsuIZO6x/wPOafEeKrWmQoWAFTUzWmbXw8Cu+TXDlHH0XVloxCuQQr8XH09GYxkRVBFIJCMA6KMmBHfN/fVWTx1zyhnS2+sC5fwiI7xdw1WwiorykTsOtB1ODKr3eB+//HTw+GfQOUDTAp2zezlW7sP2TrcS6X/WcqZL8mS6QndmsJUCmVnjyUbq10vtNkYzqxupqm623KSemNl5ccPWZSAp+ufXym2OktcCFx4V3cu+Xa8hIFIXYzBSCEGbYfjIwUtyF9NvJNXK2AFiCpvyPxPNfVzieCCO1Tz+r+K8IHnkCWWTjb0VHVAgU66UvPem58UoipfQZVBFnYf6Sjn4UWerq0rBQJnSw0M4Simq5YS1y+J1V6AJ559tXUv3LgknD/rEoPhsKgyh7NfJNKzWLql7T+oiNApyKJirh/wH3J8mQEIzB35IwxJG3JoRNjEV592vBr63JFw2qM64xjNeKLY9Ptev8Am0TbmMV4/W4aPE7Vs23UflOyYFQozXDkHZhyBW1cDGZos2bkxPHyai2JH/G1BUgw8dtalOF+9GLJ7M552BMDH5u40ra7+xTxxJqqBcHhEucqdgMUCH9NQymE8xwm8w2GhkH4rPTNQciJhDZyHbg7wERyRXTK9J4EwD33txr3/IY40L9QhtqTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(376002)(39860400002)(396003)(136003)(346002)(451199015)(40470700004)(36840700001)(46966006)(82310400005)(186003)(5660300002)(33716001)(44832011)(16526019)(81166007)(40460700003)(336012)(426003)(2906002)(47076005)(356005)(86362001)(83380400001)(7416002)(36860700001)(82740400003)(316002)(103116003)(4326008)(41300700001)(54906003)(70586007)(478600001)(70206006)(9686003)(16576012)(8676002)(110136005)(26005)(8936002)(6666004)(40480700001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 20:00:50.6264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc93470-ef2d-410e-8565-08dabe9f45d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7126
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new field in mon_evt to support Bandwidth Monitoring Event=0A=
Configuration(BMEC) and also update the "mon_features" display.=0A=
=0A=
The sysfs file "mon_features" will display the monitor configuration=0A=
if supported.=0A=
=0A=
Before the change.=0A=
	$cat /sys/fs/resctrl/info/L3_MON/mon_features=0A=
	llc_occupancy=0A=
	mbm_total_bytes=0A=
	mbm_local_bytes=0A=
=0A=
After the change when BMEC is supported.=0A=
	$cat /sys/fs/resctrl/info/L3_MON/mon_features=0A=
	llc_occupancy=0A=
	mbm_total_bytes=0A=
	mbm_total_bytes_config=0A=
	mbm_local_bytes=0A=
	mbm_local_bytes_config=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |    2 ++=0A=
 arch/x86/kernel/cpu/resctrl/monitor.c  |    6 ++++++=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |    5 ++++-=0A=
 3 files changed, 12 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index e30e8b23f6b5..5459b5022760 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -63,11 +63,13 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);=0A=
  * struct mon_evt - Entry in the event list of a resource=0A=
  * @evtid:		event id=0A=
  * @name:		name of the event=0A=
+ * @configurable:	true if the event is configurable=0A=
  * @list:		entry in &rdt_resource->evt_list=0A=
  */=0A=
 struct mon_evt {=0A=
 	enum resctrl_event_id	evtid;=0A=
 	char			*name;=0A=
+	bool			configurable;=0A=
 	struct list_head	list;=0A=
 };=0A=
 =0A=
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/re=
sctrl/monitor.c=0A=
index efe0c30d3a12..06c2dc980855 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/monitor.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c=0A=
@@ -750,6 +750,7 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)=0A=
 {=0A=
 	unsigned int mbm_offset =3D boot_cpu_data.x86_cache_mbm_width_offset;=0A=
 	struct rdt_hw_resource *hw_res =3D resctrl_to_arch_res(r);=0A=
+	bool mon_configurable =3D rdt_cpu_has(X86_FEATURE_BMEC);=0A=
 	unsigned int threshold;=0A=
 	int ret;=0A=
 =0A=
@@ -783,6 +784,11 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)=0A=
 	if (ret)=0A=
 		return ret;=0A=
 =0A=
+	if (mon_configurable) {=0A=
+		mbm_total_event.configurable =3D true;=0A=
+		mbm_local_event.configurable =3D true;=0A=
+	}=0A=
+=0A=
 	l3_mon_evt_init(r);=0A=
 =0A=
 	r->mon_capable =3D true;=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 8a3dafc0dbf7..8342feb54a7f 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -1001,8 +1001,11 @@ static int rdt_mon_features_show(struct kernfs_open_=
file *of,=0A=
 	struct rdt_resource *r =3D of->kn->parent->priv;=0A=
 	struct mon_evt *mevt;=0A=
 =0A=
-	list_for_each_entry(mevt, &r->evt_list, list)=0A=
+	list_for_each_entry(mevt, &r->evt_list, list) {=0A=
 		seq_printf(seq, "%s\n", mevt->name);=0A=
+		if (mevt->configurable)=0A=
+			seq_printf(seq, "%s_config\n", mevt->name);=0A=
+	}=0A=
 =0A=
 	return 0;=0A=
 }=0A=
=0A=

