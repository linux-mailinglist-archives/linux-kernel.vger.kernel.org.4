Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AF16F64F0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 08:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjEDG0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 02:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjEDG0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 02:26:13 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20620.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::620])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93CF2D40;
        Wed,  3 May 2023 23:26:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mR+3yYD3ZjPyjKuK6quNfTFrZ48wns2NA3uQkZ9eVQIcuYukTc5WYuj1/VKw0jqeUbJPj35/Qwh5iiELtnK/DpOBbw+oJr2I8WO190RBofjkJrbpZ9qvZofKRhrJCv5cWfSDB3VrN7/xonYve8tG8V4/M02ijs9IAWV4LapbmXz0Yk8pxiBM4+QXVmcOnrOLLyBtgkbyGMaeNdhRkbEMgRbeVegpPpcaNMw8iqO6MyAgmIiAUb0qIQtSyd0BdG4SXYNhVXusYeW93tmQ3Sl+tmzGelDmhQMOEluHGhQkl2vgs9Huw0A7QLbHL5AteMlcKh2t5X6ub1bvYAyqmU4JVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h19YoTxj5pyK6T4Rcl1YJTrEyQ3AcXng6j/v4t2ZhO4=;
 b=HqzwFjKPeqcpdzs2QoIzVWSyYWANRpMWhHTrLgTCWfzn7Ee45TszkWgkKsn+eYLHrVYGxf71BUA+XuR9PYhUT05B0AiqyJfjhkkCRlb7YC5+EDyyQjNAi7tTi0fprTqNTQqBtthGHDBe/6DGyxn7AyIVRqkuOTUfjqQQTmx8GdQflBmEeh2MO+L6m+vrgoxNuf2W2q4qsXNoicJKiQP2OD//7tQWSPlv2mejYJlu727Jzsz0skGOdO7jC0bsuaRXB21O4hEY6acHyi5nt4vekthzoo3GssVDQ+j9+2veLOS0aTgbcDGsnIBSGmPAvn2P98Le3etg1RKNlyOpgmWWSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h19YoTxj5pyK6T4Rcl1YJTrEyQ3AcXng6j/v4t2ZhO4=;
 b=uIHIrfz8Tk4oS8BlqQAb9RkPCLPlMrTg9HKYWa6NPo4Yx8Si8PS0xIpqY+gNzEs3GrHyzZaincj7BxcA8RsIE/JxJIQtQZSk0vAD0Tqb/ZllNP88Tjsx3VMGXSM7L8Jaz+r5hHlflJrWot6C6duGrb55MY0X7B5SNPNJ5nuHdJ0=
Received: from SJ2PR07CA0016.namprd07.prod.outlook.com (2603:10b6:a03:505::16)
 by SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 06:26:04 +0000
Received: from DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:505:cafe::eb) by SJ2PR07CA0016.outlook.office365.com
 (2603:10b6:a03:505::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26 via Frontend
 Transport; Thu, 4 May 2023 06:26:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT108.mail.protection.outlook.com (10.13.172.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.26 via Frontend Transport; Thu, 4 May 2023 06:26:03 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 4 May
 2023 01:26:00 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Dominik Brodowski" <linux@dominikbrodowski.net>,
        <gautham.shenoy@amd.com>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH] cpupower: Make TSC read per CPU for Mperf monitor
Date:   Thu, 4 May 2023 06:25:44 +0000
Message-ID: <20230504062544.601566-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT108:EE_|SN7PR12MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: 55385e59-007f-4318-9cc5-08db4c686fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kahb3Vy/VPmUUt9ZNbk3z0ShvcY3jcz2u+EOuRms+/Ku0cgQscOPYbc2rS4GjlBoxq2/9N1mTjEJMjO1MKkedzN8U5gSGHYRlrrIJYbOn3ehmdIJigV1ln6eHCxuBx78qOHzmPJJjTBJAlApuMkOr8d2vEV9FKEiFQ9w1EQWVxIDfWSPbImB3UytdvD04tzuQd5iCFkTFZlO1dZ0ASectdj/re7rNrQ0zJ8OaplbszanA8tm1hML8l1NlRbt3nEAp3hBjGrUZLot0OjU/4WWCfVfmAWYn3U/sTi0zahR7vaoahE9caUl1LEBy4dLhki3GNAk9hbUTeHQxRa8N9ctsx6xgAlOtoSe+eyhdk0hu4RBTYWp3Z70j6woMeNxwCzNCue7l/Pjd2pr0+Kn9927fuWRggwH0EGEi2c+QE/HOMXcc9DIl+ELyRVSzD07zu0JmTXq4czq/aRqhy8ZVRWSZ3OwjsaZTY7lewnNwlxft1O625ydSJ/beZplS26CMNLXwYD7hmaxltiedunVvDMPFt48kUPsobzMePnDNon8GtBabik5eubojKZljE39j6bkoIx/iKoHZocD6fP+anpjwuYYEIj9fz0om3NKXN8JrV7c8VkdBRHnVNaikPUS6A1MvtDeMAqqRy+AnVlKS/yXh7GiBmGRZ51zMhN2Ajacv3x1Sk2Jn5dRHjE/Flej+J75aGfIMX2vgQFi31dbcZiid+sjKSTfttNlpn/sT4tdNPA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(40460700003)(36756003)(81166007)(5660300002)(2906002)(44832011)(8676002)(8936002)(86362001)(40480700001)(316002)(70586007)(70206006)(4326008)(82310400005)(41300700001)(356005)(82740400003)(47076005)(83380400001)(426003)(336012)(16526019)(186003)(1076003)(26005)(478600001)(7696005)(2616005)(110136005)(54906003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 06:26:03.7807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55385e59-007f-4318-9cc5-08db4c686fc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6744
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

System-wide TSC read could cause a drift in C0 percentage calculation.
Because if first TSC is read and then one by one mperf is read for all
cpus, this introduces drift between mperf reading of later CPUs and TSC
reading.  To lower this drift read TSC per CPU and also just after mperf
read.  This technique improves C0 percentage calculation in Mperf monitor.

Before fix: (System 100% busy)

              | Mperf              || RAPL        || Idle_Stats
 PKG|CORE| CPU| C0   | Cx   | Freq  || pack | core  || POLL | C1   | C2
   0|   0|   0| 87.15| 12.85|  2695||168659003|3970468||  0.00|  0.00| 0.00
   0|   0| 256| 84.62| 15.38|  2695||168659003|3970468||  0.00|  0.00| 0.00
   0|   1|   1| 87.15| 12.85|  2695||168659003|3970468||  0.00|  0.00| 0.00
   0|   1| 257| 84.08| 15.92|  2695||168659003|3970468||  0.00|  0.00| 0.00
   0|   2|   2| 86.61| 13.39|  2695||168659003|3970468||  0.00|  0.00| 0.00
   0|   2| 258| 83.26| 16.74|  2695||168659003|3970468||  0.00|  0.00| 0.00
   0|   3|   3| 86.61| 13.39|  2695||168659003|3970468||  0.00|  0.00| 0.00
   0|   3| 259| 83.60| 16.40|  2695||168659003|3970468||  0.00|  0.00| 0.00
   0|   4|   4| 86.33| 13.67|  2695||168659003|3970468||  0.00|  0.00| 0.00
   0|   4| 260| 83.33| 16.67|  2695||168659003|3970468||  0.00|  0.00| 0.00
   0|   5|   5| 86.06| 13.94|  2695||168659003|3970468||  0.00|  0.00| 0.00
   0|   5| 261| 83.05| 16.95|  2695||168659003|3970468||  0.00|  0.00| 0.00
   0|   6|   6| 85.51| 14.49|  2695||168659003|3970468||  0.00|  0.00| 0.00

After fix: (System 100% busy)

             | Mperf              || RAPL        || Idle_Stats
 PKG|CORE| CPU| C0   | Cx   | Freq  || pack | core  || POLL | C1   | C2
   0|   0|   0| 98.03|  1.97|  2415||163295480|3811189||  0.00|  0.00| 0.00
   0|   0| 256| 98.50|  1.50|  2394||163295480|3811189||  0.00|  0.00| 0.00
   0|   1|   1| 99.99|  0.01|  2401||163295480|3811189||  0.00|  0.00| 0.00
   0|   1| 257| 99.99|  0.01|  2375||163295480|3811189||  0.00|  0.00| 0.00
   0|   2|   2| 99.99|  0.01|  2401||163295480|3811189||  0.00|  0.00| 0.00
   0|   2| 258|100.00|  0.00|  2401||163295480|3811189||  0.00|  0.00| 0.00
   0|   3|   3|100.00|  0.00|  2401||163295480|3811189||  0.00|  0.00| 0.00
   0|   3| 259| 99.99|  0.01|  2435||163295480|3811189||  0.00|  0.00| 0.00
   0|   4|   4|100.00|  0.00|  2401||163295480|3811189||  0.00|  0.00| 0.00
   0|   4| 260|100.00|  0.00|  2435||163295480|3811189||  0.00|  0.00| 0.00
   0|   5|   5| 99.99|  0.01|  2401||163295480|3811189||  0.00|  0.00| 0.00
   0|   5| 261|100.00|  0.00|  2435||163295480|3811189||  0.00|  0.00| 0.00
   0|   6|   6|100.00|  0.00|  2401||163295480|3811189||  0.00|  0.00| 0.00
   0|   6| 262|100.00|  0.00|  2435||163295480|3811189||  0.00|  0.00| 0.00

Cc: Thomas Renninger <trenn@suse.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>

Fixes: 7fe2f6399a84 ("cpupowerutils - cpufrequtils extended with quite some features")
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 .../utils/idle_monitor/mperf_monitor.c        | 31 +++++++++----------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
index e7d48cb563c0..ae6af354a81d 100644
--- a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
@@ -70,8 +70,8 @@ static int max_freq_mode;
  */
 static unsigned long max_frequency;
 
-static unsigned long long tsc_at_measure_start;
-static unsigned long long tsc_at_measure_end;
+static unsigned long long *tsc_at_measure_start;
+static unsigned long long *tsc_at_measure_end;
 static unsigned long long *mperf_previous_count;
 static unsigned long long *aperf_previous_count;
 static unsigned long long *mperf_current_count;
@@ -169,7 +169,7 @@ static int mperf_get_count_percent(unsigned int id, double *percent,
 	aperf_diff = aperf_current_count[cpu] - aperf_previous_count[cpu];
 
 	if (max_freq_mode == MAX_FREQ_TSC_REF) {
-		tsc_diff = tsc_at_measure_end - tsc_at_measure_start;
+		tsc_diff = tsc_at_measure_end[cpu] - tsc_at_measure_start[cpu];
 		*percent = 100.0 * mperf_diff / tsc_diff;
 		dprint("%s: TSC Ref - mperf_diff: %llu, tsc_diff: %llu\n",
 		       mperf_cstates[id].name, mperf_diff, tsc_diff);
@@ -206,7 +206,7 @@ static int mperf_get_count_freq(unsigned int id, unsigned long long *count,
 
 	if (max_freq_mode == MAX_FREQ_TSC_REF) {
 		/* Calculate max_freq from TSC count */
-		tsc_diff = tsc_at_measure_end - tsc_at_measure_start;
+		tsc_diff = tsc_at_measure_end[cpu] - tsc_at_measure_start[cpu];
 		time_diff = timespec_diff_us(time_start, time_end);
 		max_frequency = tsc_diff / time_diff;
 	}
@@ -225,33 +225,27 @@ static int mperf_get_count_freq(unsigned int id, unsigned long long *count,
 static int mperf_start(void)
 {
 	int cpu;
-	unsigned long long dbg;
 
 	clock_gettime(CLOCK_REALTIME, &time_start);
-	mperf_get_tsc(&tsc_at_measure_start);
 
-	for (cpu = 0; cpu < cpu_count; cpu++)
+	for (cpu = 0; cpu < cpu_count; cpu++) {
+		mperf_get_tsc(&tsc_at_measure_start[cpu]);
 		mperf_init_stats(cpu);
+	}
 
-	mperf_get_tsc(&dbg);
-	dprint("TSC diff: %llu\n", dbg - tsc_at_measure_start);
 	return 0;
 }
 
 static int mperf_stop(void)
 {
-	unsigned long long dbg;
 	int cpu;
 
-	for (cpu = 0; cpu < cpu_count; cpu++)
+	for (cpu = 0; cpu < cpu_count; cpu++) {
 		mperf_measure_stats(cpu);
+		mperf_get_tsc(&tsc_at_measure_end[cpu]);
+	}
 
-	mperf_get_tsc(&tsc_at_measure_end);
 	clock_gettime(CLOCK_REALTIME, &time_end);
-
-	mperf_get_tsc(&dbg);
-	dprint("TSC diff: %llu\n", dbg - tsc_at_measure_end);
-
 	return 0;
 }
 
@@ -353,7 +347,8 @@ struct cpuidle_monitor *mperf_register(void)
 	aperf_previous_count = calloc(cpu_count, sizeof(unsigned long long));
 	mperf_current_count = calloc(cpu_count, sizeof(unsigned long long));
 	aperf_current_count = calloc(cpu_count, sizeof(unsigned long long));
-
+	tsc_at_measure_start = calloc(cpu_count, sizeof(unsigned long long));
+	tsc_at_measure_end = calloc(cpu_count, sizeof(unsigned long long));
 	mperf_monitor.name_len = strlen(mperf_monitor.name);
 	return &mperf_monitor;
 }
@@ -364,6 +359,8 @@ void mperf_unregister(void)
 	free(aperf_previous_count);
 	free(mperf_current_count);
 	free(aperf_current_count);
+	free(tsc_at_measure_start);
+	free(tsc_at_measure_end);
 	free(is_valid);
 }
 
-- 
2.34.1

