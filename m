Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A348F61A1C4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiKDUBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiKDUBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:01:11 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203434D5C5;
        Fri,  4 Nov 2022 13:01:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2+gUvkMPkOSwnEfp7uUzxs4Wh8mFhhkdV+zE2vWjRNjcSgWmx/ouwh5uQXKffMz/WT+CZSE3yTmCtglhqkcrxakfmMV/Nuj3FTlulAlzaG30CPp0RncY8yopSqW095wuowThp9PU7dBjRFqOKqkahExW19CIte84+nZZQP4NHzi88QjUUPUweD4RXocY+tXOTodD93IVMyS5VOvKRITnYrW113etm3sGxAlA0dMRxKXCUON4E8lyvSyvbvag3KBCTOOiUUMvh5MTpck5R3Aa6tlnkjcLMy3XCyU1KYa581bwhwb4JaSbvIw1i/qg9heXEJrDCkES0XH91HyP0qlqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufPDQv/9dsvkv3ag0LNeCo92Tiz85xefszd+/x9G4ss=;
 b=S8L/v+CFRtuRp1zNx/67HXtxNWTyCpVffA0Q58Grn9uMx+rn72G48VeUAhqPf2vynipMh2P8HMR9PrvtM3BA03g8uzZ5pCWwQNoJpS130NTc0cF/stm/kE2mkBxkPUWR6zb6OK5d+IxiSKlKp6zoiq3EQgWM9nEAf/AYoKECiuyiVAuqEfSPa4tJLZwa5ck9Lz4eUNVOMaf4scIS6X9VGheW2uZbzKj8wXZNoBHTrAzjYUDK9y2UY9CcRYcmalibNaSC/hzi9THs6B+6/BiVdc09K+JCPSNxWu3/ZeSnQ3/q5DDDW4V0Il9i2vLho8bioa7RWSFdEukl75wLAXEeKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufPDQv/9dsvkv3ag0LNeCo92Tiz85xefszd+/x9G4ss=;
 b=UNpJsccRia6DUrZbyluUetDhzmy+SeHE/KHQn+gYTfnLbfu3/xd4RfMsORqjRTYZDSM5Uk8QEuLbgFpSnEXKWYjO4kWopLYB4Pe+B1fPqoGw/DKE+0SfT7EKS65i4p+eH4o77OZFg1QrkdXBWOgAOM4FE4yxR1RTaT8lSQreMVg=
Received: from DM6PR03CA0002.namprd03.prod.outlook.com (2603:10b6:5:40::15) by
 PH7PR12MB6633.namprd12.prod.outlook.com (2603:10b6:510:1ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 20:01:04 +0000
Received: from DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::da) by DM6PR03CA0002.outlook.office365.com
 (2603:10b6:5:40::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Fri, 4 Nov 2022 20:01:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT108.mail.protection.outlook.com (10.13.172.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Fri, 4 Nov 2022 20:01:04 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 4 Nov
 2022 15:01:02 -0500
Subject: [PATCH v8 09/13] x86/resctrl: Add sysfs interface to read
 mbm_local_bytes_config
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
Date:   Fri, 4 Nov 2022 15:01:02 -0500
Message-ID: <166759206202.3281208.14680469884299384074.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT108:EE_|PH7PR12MB6633:EE_
X-MS-Office365-Filtering-Correlation-Id: a8965902-4534-4d01-66fe-08dabe9f4e02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2b5nc0bERNA0inMcy8LHlEHggUIJIe1rMs6Yu1+hQR6HeTaRasu1DorRwS63O3fxZLKyoOEyPvYNrXSRYVjXaJ073N1wln/H+nDsL0L0IbJXzYu8m75GQl4fTWdCcOtUoErFTLXUW2Axcrh0zfB2AoeSdkDfq62Gq9QYOQxZJMf1jzoJ22bUd5lobePnABxbLkL3/Z5r7em2aL61EFu9SIx4W0eeZ4uAVt5NQ71LOnlv+GNUHHt3G6eLYy2vFfDFmCz3kz/C0ECCKwAdVY1+f42A5qlU994Zm+VNYxCUF/PLIndMAChJh8ey/zNjUc+RZKV+mm9wLuY8Ik+4j5a5fRvZ5GKbsmG/ntGVKzLTnyTk0STWxOdY+VqEug+6mAjQ2YzMrrX1jAVJr0Tiy2yxfEVJvG5/NBgP3RgnMDgcJdVOAQzXiWaXiHqqnNovg2ztXahbG5GTJ+Ml0qt9YFIxsOoSo9ybGMqjc/BYzjogs8YCAeDwlnsqr6ju1RjxnY2QK4AzChpSTTumhzaCdbN9nqCdOqMNRKzR2Xp+E15I8JcMN2pLb+26FMBgx9FxqhRLJ+HOaJ2iEaJnkyRBps79iPmrYayHQXkf3HKiTEJXPDA+rl+RuRiiY9amRfrcl81WlbPjcHfTyhnQtuyfRt6M6DbHB3sRRhIYz12Q7FodfU4aW25R7ODkLApk5eAVU1LO9lnHYh8ljKOQqzppzmMaEIuDE7rZa68WAj6A1P/4CaltLjTYzrIEf9lDquULzarpqkF51quweIN9NwmXSe4Q/MpOs9/S54xufkhW6dibrmpUyzdBE66ZawpfBX1c7RyfWNeGCsU3ZRB5E3O51xT4eQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(346002)(396003)(136003)(376002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(44832011)(2906002)(186003)(426003)(47076005)(336012)(16526019)(478600001)(4326008)(70206006)(8676002)(36860700001)(5660300002)(7416002)(70586007)(86362001)(82740400003)(8936002)(9686003)(316002)(82310400005)(54906003)(16576012)(110136005)(40460700003)(40480700001)(41300700001)(103116003)(81166007)(356005)(33716001)(26005)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 20:01:04.3266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8965902-4534-4d01-66fe-08dabe9f4e02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6633
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
the configuration file /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config.=
=0A=
The event configuration settings are domain specific and will affect=0A=
all the CPUs in the domain.=0A=
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
By default, the mbm_local_bytes_config is set to 0x15 to count all the=0A=
local event types.=0A=
=0A=
For example:=0A=
    $cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config=0A=
    0=3D0x15;1=3D0x15;2=3D0x15;3=3D0x15=0A=
=0A=
    In this case, the event mbm_local_bytes is currently configured with=0A=
    0x15 on domains 0 to 3.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   20 ++++++++++++++++++++=0A=
 1 file changed, 20 insertions(+)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index dea58b6b4aa4..18f9588a41cf 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -1495,6 +1495,16 @@ static int mbm_total_bytes_config_show(struct kernfs=
_open_file *of,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+static int mbm_local_bytes_config_show(struct kernfs_open_file *of,=0A=
+				       struct seq_file *seq, void *v)=0A=
+{=0A=
+	struct rdt_resource *r =3D of->kn->parent->priv;=0A=
+=0A=
+	mbm_config_show(seq, r, QOS_L3_MBM_LOCAL_EVENT_ID);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /* rdtgroup information files for one cache resource. */=0A=
 static struct rftype res_common_files[] =3D {=0A=
 	{=0A=
@@ -1599,6 +1609,12 @@ static struct rftype res_common_files[] =3D {=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D mbm_total_bytes_config_show,=0A=
 	},=0A=
+	{=0A=
+		.name		=3D "mbm_local_bytes_config",=0A=
+		.mode		=3D 0444,=0A=
+		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
+		.seq_show	=3D mbm_local_bytes_config_show,=0A=
+	},=0A=
 	{=0A=
 		.name		=3D "cpus",=0A=
 		.mode		=3D 0644,=0A=
@@ -1712,6 +1728,10 @@ void mbm_config_rftype_init(void)=0A=
 	rft =3D rdtgroup_get_rftype_by_name("mbm_total_bytes_config");=0A=
 	if (rft)=0A=
 		rft->fflags =3D RF_MON_INFO | RFTYPE_RES_CACHE;=0A=
+=0A=
+	rft =3D rdtgroup_get_rftype_by_name("mbm_local_bytes_config");=0A=
+	if (rft)=0A=
+		rft->fflags =3D RF_MON_INFO | RFTYPE_RES_CACHE;=0A=
 }=0A=
 =0A=
 /**=0A=
=0A=

