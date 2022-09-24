Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A3E5E8ABF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 11:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbiIXJ0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 05:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiIXJZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 05:25:47 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C6D41D2D;
        Sat, 24 Sep 2022 02:25:45 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MZNn82HCYzlXKk;
        Sat, 24 Sep 2022 17:21:32 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 17:25:43 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <patrice.chotard@foss.st.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] cpufreq: Add __init annotation to module init funcs
Date:   Sat, 24 Sep 2022 17:21:59 +0800
Message-ID: <20220924092159.56594-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing __init annotation to module init funcs.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 drivers/cpufreq/highbank-cpufreq.c | 2 +-
 drivers/cpufreq/sti-cpufreq.c      | 2 +-
 drivers/cpufreq/ti-cpufreq.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/highbank-cpufreq.c b/drivers/cpufreq/highbank-cpufreq.c
index ac57cddc5f2f..a45864701143 100644
--- a/drivers/cpufreq/highbank-cpufreq.c
+++ b/drivers/cpufreq/highbank-cpufreq.c
@@ -55,7 +55,7 @@ static struct notifier_block hb_cpufreq_clk_nb = {
 	.notifier_call = hb_cpufreq_clk_notify,
 };
 
-static int hb_cpufreq_driver_init(void)
+static int __init hb_cpufreq_driver_init(void)
 {
 	struct platform_device_info devinfo = { .name = "cpufreq-dt", };
 	struct device *cpu_dev;
diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
index a67df90848c2..1a63aeea8711 100644
--- a/drivers/cpufreq/sti-cpufreq.c
+++ b/drivers/cpufreq/sti-cpufreq.c
@@ -252,7 +252,7 @@ static int sti_cpufreq_fetch_syscon_registers(void)
 	return 0;
 }
 
-static int sti_cpufreq_init(void)
+static int __init sti_cpufreq_init(void)
 {
 	int ret;
 
diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index df85a77d476b..f64180dd2005 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -398,7 +398,7 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ti_cpufreq_init(void)
+static int __init ti_cpufreq_init(void)
 {
 	const struct of_device_id *match;
 
-- 
2.17.1

