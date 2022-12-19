Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0B36507AF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 07:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiLSGls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 01:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiLSGlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 01:41:24 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7F126F1;
        Sun, 18 Dec 2022 22:41:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lc2yKiv1RBZoOY2zlrvv+36NLLT+W/o64QF8nXmJn8zkutWNX4wR4xoa68PPURL7Zq0jDXd9UoaN0m6fk3t8X7hNCsHV6RqUWR2Uw4T77Iyq+Y/hBFT1WzW9ebr2HSWV/2+GEJuclND7T7BybsfzxSn8jv71kv4wT6Rft2mKrN4ZpEiJFpDv5mgLs9v6X/Gnx9ZdYL1/FwgyhYUg6qwwoHjtqHk/I7yoHkyZLz9VBLdZh9ROBr6LwJBA/a++ZF0DL9eMIKYNQ3RpmPr1SOCfJAhPMSj4eLPfABYFX4bi4cMdlEFjVbI69PjDOYYjQZQO0danGUdQGyRs4l+/pmOdJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItkWZS7N7TsFSYYznfiCZsZjwXt0F1NknfG+HEWWxsE=;
 b=C3H6nlIWS6LvOl3VGza/DBKAcfNhqOr7zZ04mVNftEKDc98w9nVGSQh7mI+urOFJK6HqNXvU+6RMLiNI8cUtyAkd+2ZvIHnmCqj2vbgPnKxfHYre/L2Qq9Zz2XfBvRyF057XOT/lHX5Uf8dBPYiuZOqWy2yUOSIyRmY4L/Ko0noUJ5ek6dCw+vJMUhe5qsTTWx/CpojXPnKunvm5I+K8BAgHHDdOBfXaiJwBxygZ1b2ljdsL7GpazOtz+AUQhHHWPNgxjUhwd0bcnLZz0ZcrRWmIIIAsAB8gkg4MGXnut3tX66PJY/5KjgPxiL6F3bcWrPZ2zN87VXcO/jzni6kkQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItkWZS7N7TsFSYYznfiCZsZjwXt0F1NknfG+HEWWxsE=;
 b=qG6ODjgxIRfkR8wvSAabBFGh+i9wx+lnWwrFcFfsYWqiES7yzJUmuYg5b3K3w5cKekn7xNLXzOrqmgmcP0sY51S7MO9tbxXB0SJhR1883r16oh2oStOheaSO34dYjqsMMoBz0MFWNC3GeNWogQXI+BRv+s0+yZxVPYZk2nLvFAA=
Received: from DS7PR03CA0302.namprd03.prod.outlook.com (2603:10b6:8:2b::11) by
 MN0PR12MB6174.namprd12.prod.outlook.com (2603:10b6:208:3c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 06:41:18 +0000
Received: from DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::ae) by DS7PR03CA0302.outlook.office365.com
 (2603:10b6:8:2b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.20 via Frontend
 Transport; Mon, 19 Dec 2022 06:41:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT101.mail.protection.outlook.com (10.13.172.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.16 via Frontend Transport; Mon, 19 Dec 2022 06:41:17 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 19 Dec 2022 00:41:14 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 04/13] cpufreq: amd-pstate: fix kernel hang issue while amd-pstate unregistering
Date:   Mon, 19 Dec 2022 14:40:33 +0800
Message-ID: <20221219064042.661122-5-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221219064042.661122-1-perry.yuan@amd.com>
References: <20221219064042.661122-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT101:EE_|MN0PR12MB6174:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ccb2026-0b1c-44bc-6b54-08dae18c0847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qX856iBrS0kU9lq3g943XpndPLuATzzgrMXbdHCA2pB3f8kMohCHglKDnLTPwzOuAxh6mEx/PXzxaGB+eAB929ZjVpdThWqRyUCigjaL4awd2EApQGHo/fSEANMpU9FSQ/YW+J+8mFhEDNswVSWmHhIgnzlKEhXU6+wv1AccSi2IADv0lRtqZ9/78Bs1Wep0JbuUy0lsVml/84ZvT0fnxjdgueazJCFsI5c5HK5rITV4a23ugD6CIIvbsSRFmFOLXkiAIRXmAIv5+9r/SkAQUgF9laXV87OlZ3j09EMCMluwZ303CzdlVm9hzkhccL7eJljKCmv5bJTpGSrGhHzzRubE8gwfd7OXlGKcxa0Y6stozBQ/vlSsz7Erz2yLCIcoARzAWrZD5xUJ1V+3UhwWrEsgSF4anFaKhXB1WU0uwiBT+t9vXmfQIE/rVmdghUG4BK5Z4Lk1z0Asag8ktb83PcEKNOSFZhAIjxesCzralws5XYBtPFyyye/YhHUixIetYIwLEG23asvP+UMxTnQ+KNbrrYePcVYGxJfs9Tcda8bbouxFwXln8SGwUWV6ZwxkFLBJ4KNYhQTZbHjgAnMBC2m7nok78QdY9VzChLoR267NebzZfDjIXFl0sZd1tB+uaQ5HISap1P2R3FZo6QyrC5rdqkP7Yd8j7FlCY8OVetV78WNtGAu4Ptxw+lAfkWckM6IVOFbdcxfM7RjN1qvLIhun2nDicKdR9Fq8HQCx5cc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199015)(46966006)(40470700004)(36840700001)(36756003)(478600001)(81166007)(86362001)(356005)(47076005)(426003)(40460700003)(336012)(83380400001)(82740400003)(7696005)(6666004)(1076003)(2616005)(16526019)(186003)(26005)(41300700001)(70586007)(70206006)(4744005)(5660300002)(4326008)(8676002)(316002)(2906002)(40480700001)(8936002)(36860700001)(110136005)(54906003)(82310400005)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 06:41:17.6134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ccb2026-0b1c-44bc-6b54-08dae18c0847
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6174
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the amd_pstate_adjust_perf(), there is one cpufreq_cpu_get() call to
increase increments the kobject reference count of policy and make it as
busy. Therefore, a corresponding call to cpufreq_cpu_put() is needed to
decrement the kobject reference count back, it will resolve the kernel
hang issue when unregistering the amd-pstate driver and register the
`amd_pstate_epp` driver instance.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 204e39006dda..c17bd845f5fc 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -307,6 +307,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 		max_perf = min_perf;
 
 	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true);
+	cpufreq_cpu_put(policy);
 }
 
 static int amd_get_min_freq(struct amd_cpudata *cpudata)
-- 
2.34.1

