Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83B0640158
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 08:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbiLBHxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 02:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbiLBHwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 02:52:20 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01034B43ED;
        Thu,  1 Dec 2022 23:52:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLPJ2qIljzSVNlGqe9qNlitZHYw8sZoJWldFFlvDqbR3T4DgiQiLk6iKAtqdk+lFsHjgjtJEF0TpYcINA9E1JYyCTPItZvQSQMLwvbkDQw1j0NHgEOEji22K5DHLv7QZysb2LrtvMayCMGH7wgsEEHSq+q71iDGw1IERalSRQsGDVphfSBb/rCz0S3RxCGgnIyC4jzaBpPo+mPIB9VZfArGQUEQiE/7XkE2HrDiAoU07tkDV5vMILS0FPA1fbRhiqchx3k/xlTv9gAKa/ILk7J649kf9FI9Nmtn2Z8GCCjjvVHbmm6w28sNdXFddrQRX2AKIDSf2Vg42ddmK3Ud/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+h6w480G7ILuZ3lh0HRzs+C09ou5AXJS7eh4zmsLT8=;
 b=ElW1hQzPAmWuvt4HnPHtAEq4TmoUZLF+p2vohDq6f/WKw9FG9QvT+Veza2trPJDfjWjTxzfS5LDsC0zDf9fTwF/Wf1zLbIDNobHhBEYHs6kjIsx6ZebTtfCf9Y3wFFwQ1YzjZ5bs0z4q8HIHZNSoSDxrUbfSdWsH3n4V8f/Jq6g39jzgbiSTLFvJNPyU28nNYBnwrRDif+V2amJ5/zZ0iohI5F9Oh0AFaw2lKBwQCjJcfofl7Gxus0qBWd/7MOY/+Pbi+A4P1jnkER0lmfx8Q1+yE9f5Kf4wfQpGTqgkUgzTEnIE/BYvIprso1rZB9a8vxPbjnaWmOvZrup/oxixSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+h6w480G7ILuZ3lh0HRzs+C09ou5AXJS7eh4zmsLT8=;
 b=O3ev4YLlbWSMwQwbk7Qv7X5uLJ7kghZ65aZGA2gMLVejNRkYkF2PtO4XYFQRxotEfTq59yfjq/+CWgxBcz2mE3nQeSu16/ZH5gPq6W8VjEeC1ZSrJlqSmqsj/UX7d1Oui4X6vJtZ0IlsKdI1GMBiYvzmU3WVN71RUkVhe65Ic7M=
Received: from DM6PR02CA0112.namprd02.prod.outlook.com (2603:10b6:5:1b4::14)
 by CY8PR12MB7196.namprd12.prod.outlook.com (2603:10b6:930:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 07:52:01 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::b5) by DM6PR02CA0112.outlook.office365.com
 (2603:10b6:5:1b4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Fri, 2 Dec 2022 07:52:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.20 via Frontend Transport; Fri, 2 Dec 2022 07:52:00 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 2 Dec 2022 01:51:26 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 08/11] cpufreq: amd_pstate: add driver working mode status sysfs entry
Date:   Fri, 2 Dec 2022 15:47:16 +0800
Message-ID: <20221202074719.623673-9-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221202074719.623673-1-perry.yuan@amd.com>
References: <20221202074719.623673-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT035:EE_|CY8PR12MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: 0725a9a5-0d64-410d-ae29-08dad43a185e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hWHbQGnDWsqcV2wE4NXSywMZaKUEwK6qTBxF8UPivRQSCpSDrf5Bi7gXqPl8svYUPfhjdmoSfKG98x2Xbp2LpK1VyHSmN3Q3tLs+nm+kuSRjNyof/NTgLomBSLa0ejFY+tr3kJhSGpJ5NsqniiqXvXP3gc2NGDmbdNtfu5DN+dnd1PudMcEUJumdgUyrCG7nBaoHse47jKAvL9bnQGl/CTLzbl1R1QCdsVyghu4TixgzQ5VqCJ27wrPFjjN33zn5qP2F/bamqe0qYS7jTtKQtVkh+nD2jZxrldzHLJ3YbuTwbUa/oMC41YQMXDqSaneorr+CBH9vkJSb+cdCFgddtnO6edlERDk24Q/EZ5LXF/kQLxXc5mpgBgoOd40cPtZKzW43OXbwRinMYVN7Ia5CEyKDTyp37FI0uZpdLPKKfNv7Dn9el3O7GLZ9AleBV0OnaQSXAsJb5TzTqUq3gNFHlYqCC9EQ8q++hrbIzyDzQikk2wmICi+AjiMr0V/s9va2NidL+APbxo0EQ90Nv5oEVNGhfWl4lniIs/EmHYvBL8y6fqCc/y9xVlTaEx9WfFaacOXRn5xVaAzVUnakYCsNVsu7hjT4yQKvq9w6T3a95ySu4jW/VKVGtoWZOGkU/ftvxtT2Jv7sTkb7z2SgGpn89epKi3uDKxVmwnbqUWACiJzfdAjltEw9vwg6rE1deRzKJ4MkbIPcWxe80MS9k8xUU9q0YsAbMv+JzEsyLgUaiKo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(356005)(5660300002)(81166007)(2906002)(44832011)(82740400003)(8936002)(40480700001)(54906003)(70206006)(82310400005)(26005)(83380400001)(316002)(47076005)(7696005)(41300700001)(8676002)(4326008)(36860700001)(40460700003)(110136005)(478600001)(426003)(86362001)(36756003)(70586007)(16526019)(2616005)(1076003)(6666004)(186003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 07:52:00.7615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0725a9a5-0d64-410d-ae29-08dad43a185e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7196
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Perry Yuan <Perry.Yuan@amd.com>

While amd-pstate driver was loaded with specific driver mode, it will
need to check which mode is enabled for the pstate driver,add this sysfs
entry to show the current status

$ cat /sys/devices/system/cpu/amd-pstate/status
active

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 44 ++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 6936df6e8642..7f748a579023 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -66,6 +66,8 @@ static bool cppc_active;
 static int cppc_load __initdata;
 
 static struct cpufreq_driver *default_pstate_driver;
+static struct cpufreq_driver amd_pstate_epp_driver;
+static struct cpufreq_driver amd_pstate_driver;
 static struct amd_cpudata **all_cpu_data;
 static struct amd_pstate_params global_params;
 
@@ -807,6 +809,46 @@ static ssize_t store_boost(struct kobject *a,
 	return count;
 }
 
+static ssize_t amd_pstate_show_status(char *buf)
+{
+	if (!default_pstate_driver)
+		return sysfs_emit(buf, "off\n");
+
+	return sysfs_emit(buf, "%s\n", default_pstate_driver == &amd_pstate_epp_driver ?
+					"active" : "passive");
+}
+
+static int amd_pstate_update_status(const char *buf, size_t size)
+{
+	/* FIXME! */
+	return -EOPNOTSUPP;
+}
+
+static ssize_t show_status(struct kobject *kobj,
+			   struct kobj_attribute *attr, char *buf)
+{
+	ssize_t ret;
+
+	mutex_lock(&amd_pstate_driver_lock);
+	ret = amd_pstate_show_status(buf);
+	mutex_unlock(&amd_pstate_driver_lock);
+
+	return ret;
+}
+
+static ssize_t store_status(struct kobject *a, struct kobj_attribute *b,
+			    const char *buf, size_t count)
+{
+	char *p = memchr(buf, '\n', count);
+	int ret;
+
+	mutex_lock(&amd_pstate_driver_lock);
+	ret = amd_pstate_update_status(buf, p ? p - buf : count);
+	mutex_unlock(&amd_pstate_driver_lock);
+
+	return ret < 0 ? ret : count;
+}
+
 cpufreq_freq_attr_ro(amd_pstate_max_freq);
 cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
 
@@ -814,6 +856,7 @@ cpufreq_freq_attr_ro(amd_pstate_highest_perf);
 cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
 define_one_global_rw(boost);
+define_one_global_rw(status);
 
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
@@ -833,6 +876,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 
 static struct attribute *pstate_global_attributes[] = {
 	&boost.attr,
+	&status.attr,
 	NULL
 };
 
-- 
2.34.1

