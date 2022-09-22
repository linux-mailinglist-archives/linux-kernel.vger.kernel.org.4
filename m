Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404155E63B1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiIVNfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiIVNfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:35:16 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F827F0AB;
        Thu, 22 Sep 2022 06:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663853706; x=1695389706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=uNmyJGFQ0sIPiZsSeZdd651qCRfEeR1fmTyxguCl9bY=;
  b=EHzMk5BPyj9Tb1F8IhQa8puZ8fku4FXpiV6L3GbZUa7v1RfgZm2+hNiy
   HKHweYHXrI0v3baxkSq/ogJ8IBGijsHTODFujpxsoVt37FHvJUFS3+i0H
   iDunwdr06up1yOaOjfpgTf2PYgg7sxpO9Oq1dkRBgdaAV+oyj2wkenITB
   1l9r04B5IN5CYxyATfkSzzmM64RVjaipPR+FApG6LxzJt1yQ6xPG3qD5I
   2FfjhtxxUQnzYuMb574NwbyIvOnoJlfT6SbfPaLLKnD8NQ4Ryi7WrHuRT
   /6X543KswGL6LwNN+ifENfU8t40Ms6gm6pR/ygWsEuXGyg3Kev9G2mHy8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="297894114"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="297894114"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 06:35:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="619793850"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by orsmga002.jf.intel.com with ESMTP; 22 Sep 2022 06:35:01 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        corbet@lwn.net, fenghua.yu@intel.com, jdelvare@suse.com,
        linux@roeck-us.net, len.brown@intel.com, rui.zhang@intel.com
Subject: [PATCH V3 2/8] hwmon/coretemp: Rename indx to index
Date:   Thu, 22 Sep 2022 21:37:54 +0800
Message-Id: <20220922133800.12918-3-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220922133800.12918-1-rui.zhang@intel.com>
References: <20220922133800.12918-1-rui.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use variable name 'index' instead of 'indx' for the index in the
core_data[] array.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/hwmon/coretemp.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index ccf0af5b988a..bfdcfe8ccb34 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -515,15 +515,15 @@ coretemp_add_core(struct platform_device *pdev, unsigned int cpu, int pkg_flag)
 		dev_err(&pdev->dev, "Adding Core %u failed\n", cpu);
 }
 
-static void coretemp_remove_core(struct platform_data *pdata, int indx)
+static void coretemp_remove_core(struct platform_data *pdata, int index)
 {
-	struct temp_data *tdata = pdata->core_data[indx];
+	struct temp_data *tdata = pdata->core_data[index];
 
 	/* Remove the sysfs attributes */
 	sysfs_remove_group(&pdata->hwmon_dev->kobj, &tdata->attr_group);
 
-	kfree(pdata->core_data[indx]);
-	pdata->core_data[indx] = NULL;
+	kfree(pdata->core_data[index]);
+	pdata->core_data[index] = NULL;
 }
 
 static int coretemp_probe(struct platform_device *pdev)
@@ -647,7 +647,7 @@ static int coretemp_cpu_offline(unsigned int cpu)
 	struct platform_device *pdev = coretemp_get_pdev(cpu);
 	struct platform_data *pd;
 	struct temp_data *tdata;
-	int indx, target;
+	int index, target;
 
 	/*
 	 * Don't execute this on suspend as the device remove locks
@@ -661,12 +661,12 @@ static int coretemp_cpu_offline(unsigned int cpu)
 		return 0;
 
 	/* The core id is too big, just return */
-	indx = TO_ATTR_NO(cpu);
-	if (indx > MAX_CORE_DATA - 1)
+	index = TO_ATTR_NO(cpu);
+	if (index > MAX_CORE_DATA - 1)
 		return 0;
 
 	pd = platform_get_drvdata(pdev);
-	tdata = pd->core_data[indx];
+	tdata = pd->core_data[index];
 
 	cpumask_clear_cpu(cpu, &pd->cpumask);
 
@@ -677,7 +677,7 @@ static int coretemp_cpu_offline(unsigned int cpu)
 	 */
 	target = cpumask_any_and(&pd->cpumask, topology_sibling_cpumask(cpu));
 	if (target >= nr_cpu_ids) {
-		coretemp_remove_core(pd, indx);
+		coretemp_remove_core(pd, index);
 	} else if (tdata && tdata->cpu == cpu) {
 		mutex_lock(&tdata->update_lock);
 		tdata->cpu = target;
-- 
2.25.1

