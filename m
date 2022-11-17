Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1EF62D3F9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239304AbiKQHUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239321AbiKQHU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:20:26 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2046.outbound.protection.outlook.com [40.107.212.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6191770181;
        Wed, 16 Nov 2022 23:20:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUJqmVedWM63jr+SJd9mkycpXqS2UNKswo3ny8l6fpDYZN0OMu5TpLxSUWyeOmQ7XCZWBk0ZRqGY5/S4lwRBrzDuRf85r+flVK3oyIiPOqKg902Gajv+TR0SxmRDVIgh7mPO8bT5pFS0Q+DpHhhQvPuGD7UbWG9ApNpzwi0BWJpsvOqXY0du3teV4Jf6kRj1dvx/UqKPNP56rteWTtVTCHlXyRfXAzLC7dydrGIs/cQZ1I3uaB/ozSbCuh6r3O91aNNilQ+7KTbCzp6ZyKgCXcB1cSeE8ZVwPJxi9/fYDBnYTdtK6tfHEWDxQ4yO767XMjBaQkfnQKxHVZd1kCM3Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lLwQ1RXi32JXc6ZkMW7tZFU84/CRCpBUME7bsJbU0w=;
 b=inwhDZ6u78xpP0eKKWbbQnKbB199RIyTVJg9K1X+qsOu9MexNMJlsGqaTNg4sLnNF/ZkzkwXQEazSN2xs54VwVxm2jFiZYFbHQyGYUnfYaWmBFGaTjfTHeGVC7mrDLzaIxVqkUrryL3PBAA/2MpD7rxDAWW+31ag8NMQjQp/Pjqs13nNjZU3hPQYg6LfHN2XdiJYSpTqvkrKG4I1EkmaU0/sMgvGl/Bw2fKQgBQCDyWFKBr7xHo9cdt3pFeSWakLkE78xVSuOpHMuOLjSdhga0VOkpkAIx6dFumUy7z8CKzLTGVeGxe3RJOMvn9oPfbudKPs4A35V4Cp0wOtiFLzAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lLwQ1RXi32JXc6ZkMW7tZFU84/CRCpBUME7bsJbU0w=;
 b=SAPjlJ9lBgRs8bIdwJa+BgK1zUWlKDZ9TRNWVQvlS2HfJ3PUt1Bp1jL3gmKO1nbFQhftD6AiC75kKREPJGKPjDIUMZUlITU0iayE1xROwQ6I/V0Fm8KroLz2UVkssK40mHzvcQAXq78m8a/NybE88+aEEgN81KHHjGFuT8ujD44=
Received: from MW3PR05CA0017.namprd05.prod.outlook.com (2603:10b6:303:2b::22)
 by LV2PR12MB5751.namprd12.prod.outlook.com (2603:10b6:408:17d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 07:20:17 +0000
Received: from CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::21) by MW3PR05CA0017.outlook.office365.com
 (2603:10b6:303:2b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.8 via Frontend
 Transport; Thu, 17 Nov 2022 07:20:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT103.mail.protection.outlook.com (10.13.174.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 07:20:16 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 17 Nov 2022 01:19:44 -0600
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>, <Mario.Limonciello@amd.com>
CC:     <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Deepak.Sharma@amd.com>, <Shimmer.Huang@amd.com>,
        <Li.Meng@amd.com>, <Xiaojian.Du@amd.com>, <wyes.karny@amd.com>,
        <gautham.shenoy@amd.com>, <ananth.narayan@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 4/5] Documentation: amd-pstate: add driver working mode introduction
Date:   Thu, 17 Nov 2022 15:19:09 +0800
Message-ID: <20221117071910.3347052-5-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117071910.3347052-1-Perry.Yuan@amd.com>
References: <20221117071910.3347052-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT103:EE_|LV2PR12MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: e9390d85-c059-4cf3-231b-08dac86c2d53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yBk6g8PE+PbsXfU9pjZujnd95O86MFDaSOHAxmjAFmWJUUbWO9dkMxMlDN71FQO1GA+1fAX3CPwwI2MmHXFxZJRZQdr9DpEh6pJCQqmx78RHT1fdTt8DXyhEhz7USPo8UT1UJqr/ObGwnPKq4GOsDWvS5sqlMcx9QREGHLHo7yTM5cYsM29ZWY7VVQYKcvQL05Cj6aCxbkzT4mtXU+X2w/uQV61FINzbWiR154Ap+XOw5JG+iP7k1hiyanAgOMrl578yiWP3haEcWNTsgLaertc94xaN67e5b91/6XmuqS+MuCVZHBKgx9z3oHE7cwOsGV6uMZ5xXU6NwWTAjhtfvwDuntiuLTbgYPkssq3ucCDQCfQ7D956sAzWQt2X+e8PQEAyRMkw4XlzGQu5wEthB2h5I9jHKJ7FbGOyKk3qx6C/j2zO96gIzVEtJVBRu7F+KO7A4VKzRaV4VGrr0NsV4QF94UF1ycE/zmdHWsHOjHJd8G/qDeVLhY41L6q5s3dA0EIw8H7f/aZfN5aimoQ2aGrHsM1wQ2kCS/Y9AvMbQzSzfJetwB9L7nDR57gnNagZcfv9Ckz9E+ww4gXkOpE6V6rHEcFR3qj45vSJ+63jNHF7WJYpqNk5hoeee0O1mcqNkbsQZGev25S9JSj9u8K/FkVluX2B1/E0h0+qHwAaVrdNlxRnk+IHx38kP/gFN2zkombWJtLiwFRiym7gTpp0IyxGlwUOua4Dd+vIVWp/tCqRLky3XIqZDFu5XUAjNqh2AFGkbCAIT7850rgZhyIbMm2pivtPsbYpKoAZiSHdAv4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199015)(46966006)(40470700004)(36840700001)(86362001)(8936002)(70586007)(8676002)(4326008)(36756003)(70206006)(5660300002)(40460700003)(47076005)(83380400001)(16526019)(478600001)(26005)(7696005)(6666004)(186003)(2616005)(426003)(336012)(1076003)(81166007)(54906003)(316002)(6636002)(356005)(82740400003)(40480700001)(2906002)(36860700001)(82310400005)(110136005)(41300700001)(2101003)(36900700001)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 07:20:16.7074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9390d85-c059-4cf3-231b-08dac86c2d53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5751
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the `amd_pstate` driver new working mode with
`amd_pstate=3Dpassive` added to kernel command line.
If there is no passive mode enabled by user, amd_pstate driver will be
disabled by default for now.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Tested-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 30 +++++++++------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/ad=
min-guide/pm/amd-pstate.rst
index 8f3d30c5a0d8..06e23538f79c 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -283,23 +283,19 @@ efficiency frequency management method on AMD process=
ors.
 Kernel Module Options for ``amd-pstate``
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-.. _shared_mem:
-
-``shared_mem``
-Use a module param (shared_mem) to enable related processors manually with
-**amd_pstate.shared_mem=3D1**.
-Due to the performance issue on the processors with `Shared Memory Support
-<perf_cap_>`_, we disable it presently and will re-enable this by default
-once we address performance issue with this solution.
-
-To check whether the current processor is using `Full MSR Support <perf_ca=
p_>`_
-or `Shared Memory Support <perf_cap_>`_ : ::
-
-  ray@hr-test1:~$ lscpu | grep cppc
-  Flags:                           fpu vme de pse tsc msr pae mce cx8 apic=
 sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mm=
xext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpui=
d extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 s=
se4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm =
extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt =
tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp=
_l3 hw_pstate ssbd mba ibrs ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2=
 erms invpcid cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsa=
vec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero=
 irperf xsaveerptr rdpru wbnoinvd cppc arat npt lbrv svm_lock nrip_save tsc=
_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_=
vmsave_vmload vgif v_spec_ctrl umip pku ospke vaes vpclmulqdq rdpid overflo=
w_recov succor smca fsrm
-
-If the CPU flags have ``cppc``, then this processor supports `Full MSR Sup=
port
-<perf_cap_>`_. Otherwise, it supports `Shared Memory Support <perf_cap_>`_.
+Passive Mode
+------------
+
+``amd_pstate=3Dpassive``
+
+It will be enabled if the ``amd_pstate=3Dpassive`` is passed to the kernel=
 in the command line.
+In this mode, ``amd_pstate`` driver software specifies a desired QoS targe=
t in the CPPC
+performance scale as a relative number. This can be expressed as percentag=
e of nominal
+performance (infrastructure max). Below the nominal sustained performance =
level,
+desired performance expresses the average performance level of the process=
or subject
+to the Performance Reduction Tolerance register. Above the nominal perform=
ance level,
+processor must provide at least nominal performance requested and go highe=
r if current
+operating conditions allow.
=20
=20
 ``cpupower`` tool support for ``amd-pstate``
--=20
2.25.1

