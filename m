Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17C261A1B3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiKDUAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiKDUAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:00:17 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CAF45A20;
        Fri,  4 Nov 2022 13:00:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lepj2GiQifyEKbt3sHT3oSpY2x0lvvXzDgk6NWyBtZrwye/wZF5MayBRUIR7CN8hanGrMuiKW/JaVSLzIX0Pf3w0kJu4dTUsXyM0B9Hx1VfM2bYkGytq8hFoGzYfuIOjR00RsmBzUJpd1HhAeghyi5ZCdooYtGss+zazZDA6Vwuk/wvZFKfRSo2vB8H+aqAzLIURvpq4/2VUflsuvntELw5xhKLlUHdA5vxIuSH1IAyY/WXxwTvDZzPhfDRB0RMWgjJY8Izc2Qsu4k+v8tqR/mM7HSxI7m9E8A9vpAcWIFCEdCLlYvj9plgIy0Hc2S7WX0fYY8ykw/nxyftCxMhuQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjDnqO29sOEgSFMiVrU5p1hyybZIQ5Vf8NR6Gv9ZDXk=;
 b=Q7osxiZHFvV6E4AsEtlkLsgZnuxGOjvnhiaB04O1YysYRAmI/y7gQnzrxwwxsQF0F14nY1yYT9FkAldnJYZDrT43WL7zcRceKVsd71uvpB1V9BRIey6BanIZwMii3s/a5im7WraY5e4wzpxQNsDhgqcewzUvkUfW4O+Z+t3AbrNKNZKtjdeGpNIMKmY8v9zlTVB8Dp7eB0TSgZ9x7NIuU7UPNH/39I4Oqii78nA05TxAJT7ZlKU3JG5LZ9Q7nZhbCqTwSLIOreLFpP0s1ny2ug7q3YBpvFNWMSF7+pX0w6wmeNK3UbRIF5ymZoTTu1dQDBiYkL3TyGiJkIav/HW96Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjDnqO29sOEgSFMiVrU5p1hyybZIQ5Vf8NR6Gv9ZDXk=;
 b=CXyRNXtJoQSrdWNcQ6BtYEN5vaGHvSAm5ddiIiqrQNdXCyXrxbUs3XfQcKlsACtYxzP2iAU0yswjsDqps306Er4soQfd3LabtORBHyVBCwd0aqOKI9EdVcVZx+/UMmrebHGkZfLXzPO4N7UF7aBGF8F1qq/bQqWuewzkBYyfwJ4=
Received: from DM6PR05CA0063.namprd05.prod.outlook.com (2603:10b6:5:335::32)
 by PH7PR12MB6634.namprd12.prod.outlook.com (2603:10b6:510:211::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 20:00:06 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::7e) by DM6PR05CA0063.outlook.office365.com
 (2603:10b6:5:335::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.8 via Frontend
 Transport; Fri, 4 Nov 2022 20:00:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Fri, 4 Nov 2022 20:00:05 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 4 Nov
 2022 15:00:03 -0500
Subject: [PATCH v8 02/13] x86/resctrl: Add a new resource type
 RDT_RESOURCE_SMBA
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
Date:   Fri, 4 Nov 2022 15:00:03 -0500
Message-ID: <166759200326.3281208.5387897092180999498.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT010:EE_|PH7PR12MB6634:EE_
X-MS-Office365-Filtering-Correlation-Id: 831d8c16-8701-4405-2141-08dabe9f2b15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tGfMb3MdCHsaTi0EBbnmVFVPO6gjp93qEYIgW6NnijDg/qMEoJjsExGmzrdbmtlSJrmjSn9XPYCFxnIihDdPKdT7VIxNX1EfYe9utgK7NjlltQZt+MtQLuyB8ovMp7sQcePDqV93cQVbod0n4n9bjBbSjT7JJkCSwOrt6yjZVWHTdq1Zy9sn79lzfhMFuxGdyR9Syoe91ScVYgQtYcDQC0y0zn0gYEuUgw/UI/AnbeNrd2rxWFNnxfhnAMCNzK2KeB0dDBzNjUq9KNOY5qM7VDjCZ9vpwH7K5EMnd9tYvDDojGo9sQ+vfTqfSLwK5zKIUP7Wm4QVPoQUTOBLg6uaRPXAt+625C0d48d575yXUlxPrwH19buG1Dqh8LN8u+Ik12ZxRVKf/nptXI4/ZKQGSLhd+tyvhmtBNz48AuUgvXPGlAyzfgEUBML0Sc2Wv2pgtsNIVSaBF4W8dsj39LSRtPJPkS+nH5qW8LbhGJ6QTIninU4aXsNst18TsmTtVfy/iGnNrIrRTw98KXxG0yx42+V3jnhu3wGqVEhYEzDKzZRgInAfC+/9mgcfDCej1N2yxX7xeP+yK2rn1nZdPzlbXsfsRTS8swfLSjCEBXwCcQy9iD27LJjrVYoTQTaqxQ9rhHpZAO+hR19/8JGwFArBdwlnZ9xmQzH6c4R8vcqJ2jp4A4kmtXXNXBxjWVt73uu6uH3Frqzn1gW0YkstX4dNaFHrp1k28mhcy+uv6pMNBB1yuOyo+s3KzlCqFmLGVNMRZRC1SxbEzSv+u49fPcTy7dUud3k5xC6rMVRbSsRJsQS+AC3ci0vfows3fmXfOClIsUJ/kek16cbDn49ZplOwHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(396003)(346002)(39860400002)(376002)(136003)(451199015)(36840700001)(40470700004)(46966006)(478600001)(86362001)(356005)(7416002)(82740400003)(2906002)(5660300002)(36860700001)(426003)(40480700001)(103116003)(336012)(47076005)(40460700003)(186003)(110136005)(16526019)(26005)(16576012)(9686003)(54906003)(44832011)(316002)(81166007)(70586007)(41300700001)(8676002)(8936002)(4326008)(70206006)(33716001)(82310400005)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 20:00:05.7447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 831d8c16-8701-4405-2141-08dabe9f2b15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6634
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new resource type RDT_RESOURCE_SMBA to handle the QoS=0A=
enforcement policies on the external slow memory.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
Reviewed-by: Ingo Molnar <mingo@kernel.org>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/core.c     |   12 ++++++++++++=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |    1 +=0A=
 2 files changed, 13 insertions(+)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resct=
rl/core.c=0A=
index 03cfbf0fe000..4b970e7192e8 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/core.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/core.c=0A=
@@ -100,6 +100,18 @@ struct rdt_hw_resource rdt_resources_all[] =3D {=0A=
 			.fflags			=3D RFTYPE_RES_MB,=0A=
 		},=0A=
 	},=0A=
+	[RDT_RESOURCE_SMBA] =3D=0A=
+	{=0A=
+		.r_resctrl =3D {=0A=
+			.rid			=3D RDT_RESOURCE_SMBA,=0A=
+			.name			=3D "SMBA",=0A=
+			.cache_level		=3D 3,=0A=
+			.domains		=3D domain_init(RDT_RESOURCE_SMBA),=0A=
+			.parse_ctrlval		=3D parse_bw,=0A=
+			.format_str		=3D "%d=3D%*u",=0A=
+			.fflags			=3D RFTYPE_RES_MB,=0A=
+		},=0A=
+	},=0A=
 };=0A=
 =0A=
 /*=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index 5f7128686cfd..43d9f6f5a931 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -419,6 +419,7 @@ enum resctrl_res_level {=0A=
 	RDT_RESOURCE_L3,=0A=
 	RDT_RESOURCE_L2,=0A=
 	RDT_RESOURCE_MBA,=0A=
+	RDT_RESOURCE_SMBA,=0A=
 =0A=
 	/* Must be the last */=0A=
 	RDT_NUM_RESOURCES,=0A=
=0A=

