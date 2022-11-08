Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15212620D87
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 11:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbiKHKky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 05:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbiKHKkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 05:40:52 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C873317EF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 02:40:50 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N64PN4p8szHvdx;
        Tue,  8 Nov 2022 18:40:24 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 18:40:48 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH] perf/x86/amd: Remove the repeated declaration
Date:   Tue, 8 Nov 2022 18:41:17 +0800
Message-ID: <20221108104117.46642-1-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function 'amd_brs_disable_all' is declared twice in
    
    commit ada543459cab ("perf/x86/amd: Add AMD Fam19h Branch Sampling support").

Remove one of them.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 arch/x86/events/perf_event.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 332d2e6d8ae4..2aaa492b70b2 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1322,7 +1322,6 @@ void amd_brs_enable_all(void);
 void amd_brs_disable_all(void);
 void amd_brs_drain(void);
 void amd_brs_lopwr_init(void);
-void amd_brs_disable_all(void);
 int amd_brs_hw_config(struct perf_event *event);
 void amd_brs_reset(void);
 
-- 
2.33.0

