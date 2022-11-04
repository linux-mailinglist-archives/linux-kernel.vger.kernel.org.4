Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A623A61A1B7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiKDUAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKDUAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:00:32 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33B445EC2;
        Fri,  4 Nov 2022 13:00:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOKE3+EoIxzVYgzxZTcS/Y7AWQ209B3DaNry+7ALxVulPmoIWBDYumbDzcm1kDdeqi0D8V6dp5iK8R3vV6gpNNoqnxKYw14+aozADUZbspuZsp1pCXBaI8UMcaF3pHrTLdVih68RYTjsIre0W3bJzVUR8VsIZDoICHrvH7gi/v+lassmB3f4kzZGA23A1xyEC8RAGnRcWsQ8JXdcYweKBAZbVya/KuH7EtzTCWPpv8cNV02gwlXxIBH5VV8wtWehPEXc3ZIdR8lWKIA65HqEhZC+dsU2xp5ShXL8cIKJWSISxl97fqfQVTzWjXPlzpJmX589kCvXSltKDQPjsiR3PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jd3w3P/weTCZO0Nq/NnxPBowTYaTCyeGACzKZuq6P0M=;
 b=B9gyrUEjkwDqBg0lOTA1ili5bmOeil10bQQy9WNybz4aCiuE8YOOXAtrRAkNXdIyz1TMbxFBwPPcVoDKl+ASrf42XnSXXlBcs9HgstKR5o8U+LRCYJJy1s5o5FuLaTBN+i84am+uUT8o7S5VucKpPPj0qh8i5X95wpBvz947FnBQaHtA9IBpGh8NJskN+zU9k1uIHG1Z9rZqibASpQGSFfd8Ig8GOvTfI0QGLgNxsIh4O3R/L63rbHx4jxZHfP56C9nyB54okMTlMcyuNTt73KzwTSh0nWQz9LOa/hA69SdgSOib9Qb4Wq5tzhMHtdD8jEqfUeb8gqz+waFjmlR5dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jd3w3P/weTCZO0Nq/NnxPBowTYaTCyeGACzKZuq6P0M=;
 b=m1/oLmN2U3vYKvaS8olw9EebQE7H9a4/hx9DViAoTMYA27KLc8B9WuiXzMdcLL/ERG4y8eJ/ITcL5Bb5LNPdOfo85XguCeqK8+CPd4LOiOCroN6B8RakQDR1rzGIRLEMR0Wgb/2ioal8BkdUarSZYqQnfQw+rMtXZfMDkvVWDpY=
Received: from DM6PR06CA0032.namprd06.prod.outlook.com (2603:10b6:5:120::45)
 by BN9PR12MB5050.namprd12.prod.outlook.com (2603:10b6:408:133::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 20:00:25 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::d4) by DM6PR06CA0032.outlook.office365.com
 (2603:10b6:5:120::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Fri, 4 Nov 2022 20:00:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Fri, 4 Nov 2022 20:00:24 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 4 Nov
 2022 15:00:22 -0500
Subject: [PATCH v8 04/13] x86/resctrl: Include new features in command line
 options
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
Date:   Fri, 4 Nov 2022 15:00:22 -0500
Message-ID: <166759202231.3281208.4695877999050945787.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|BN9PR12MB5050:EE_
X-MS-Office365-Filtering-Correlation-Id: d2c68264-7e31-49d0-556b-08dabe9f365e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mOX11GZGFUMNYm8M9MW6Zw1W72meylsxWnw3gLehvoNTwB7bNazbFY6oZyiLkLFIE9Uvfmp/FasOVRYRlMzz+oENdTBvqtwc9PBVmPR88w6WUsdUIg7IdyMOKttpt5EDaL6tingsszPe+wXd9stOQKt6Rx29WyLHtBngw6BZ8gBVuJefDOG7DOsTAC/2EjSheAnnOu63lZI1d22sgMx2jAo0mNX/TVSmzBJaWq8W/+hV695skHbw8i8CslzH0a+tc9YUeUHpXAgQEywLEVGXZHNbg9VD0s0KGsHlITCXNmmCCJLJ9pwIA2t079wbPlzQEUtJHLKL79Zemjjmjh7IC27BEVaOTQ9ymhJYcaGVz7uVWOciEjJGsVtzuT7gZqO3R19nR8oEsLr4IVLFZNA8V5YFDKZERx29uGgaT0jH6+klok4vVkwSXRrf3GVmQBgdE5otJl7QcTYUOh7a9lw51DvVE6Gb5uAL6XGF8MMV581g1gdwijwopcQEF3ppZE96Bd/6JRssbcOQDi4HE1bN1uTdxdOK7ZKrKvu9opH3eYr2Yk1peHkgwzIdJnEFavQ6TVwLiOBmGs+rUgTbN/B4oFRAOr8Iv8OqomAGW6piWSS1DeTQY/DTET3C4rRs2JVmkOk1quWjms8Rb/mhqhnQvW9GV3Gg2AmdlgLGbEa3cN34QUbNMIwinvGxs8tBdzBxgpFyP19gVXEvD1Gux+XPjshvBXGpr3IzNhw7lauMPPfA7+DDiVkn4IQykrz1mUJGgsAk04e0KpHSqLEMxfNXlttS73GyP0FgMLWVMH4II7qBWddm1HBO7KpOXEUEz4SF6LAO1sqXGNKIu9zGorOTqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(376002)(396003)(346002)(136003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(54906003)(336012)(426003)(83380400001)(8936002)(478600001)(70586007)(70206006)(4326008)(7416002)(8676002)(110136005)(40460700003)(40480700001)(2906002)(33716001)(86362001)(44832011)(41300700001)(16526019)(26005)(9686003)(186003)(36860700001)(103116003)(47076005)(356005)(81166007)(82740400003)(5660300002)(82310400005)(316002)(16576012)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 20:00:24.6950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c68264-7e31-49d0-556b-08dabe9f365e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5050
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the command line options to disable the new features.=0A=
smba : Slow Memory Bandwidth Allocation=0A=
bmec : Bandwidth Monitor Event Configuration.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 Documentation/admin-guide/kernel-parameters.txt |    2 +-=0A=
 arch/x86/kernel/cpu/resctrl/core.c              |    4 ++++=0A=
 2 files changed, 5 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentatio=
n/admin-guide/kernel-parameters.txt=0A=
index a465d5242774..f3f0870144fb 100644=0A=
--- a/Documentation/admin-guide/kernel-parameters.txt=0A=
+++ b/Documentation/admin-guide/kernel-parameters.txt=0A=
@@ -5190,7 +5190,7 @@=0A=
 	rdt=3D		[HW,X86,RDT]=0A=
 			Turn on/off individual RDT features. List is:=0A=
 			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,=0A=
-			mba.=0A=
+			mba, smba, bmec.=0A=
 			E.g. to turn on cmt and turn off mba use:=0A=
 				rdt=3Dcmt,!mba=0A=
 =0A=
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resct=
rl/core.c=0A=
index 4b970e7192e8..e31c98e2fafc 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/core.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/core.c=0A=
@@ -659,6 +659,8 @@ enum {=0A=
 	RDT_FLAG_L2_CAT,=0A=
 	RDT_FLAG_L2_CDP,=0A=
 	RDT_FLAG_MBA,=0A=
+	RDT_FLAG_SMBA,=0A=
+	RDT_FLAG_BMEC,=0A=
 };=0A=
 =0A=
 #define RDT_OPT(idx, n, f)	\=0A=
@@ -682,6 +684,8 @@ static struct rdt_options rdt_options[]  __initdata =3D=
 {=0A=
 	RDT_OPT(RDT_FLAG_L2_CAT,    "l2cat",	X86_FEATURE_CAT_L2),=0A=
 	RDT_OPT(RDT_FLAG_L2_CDP,    "l2cdp",	X86_FEATURE_CDP_L2),=0A=
 	RDT_OPT(RDT_FLAG_MBA,	    "mba",	X86_FEATURE_MBA),=0A=
+	RDT_OPT(RDT_FLAG_SMBA,	    "smba",	X86_FEATURE_SMBA),=0A=
+	RDT_OPT(RDT_FLAG_BMEC,	    "bmec",	X86_FEATURE_BMEC),=0A=
 };=0A=
 #define NUM_RDT_OPTIONS ARRAY_SIZE(rdt_options)=0A=
 =0A=
=0A=

