Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C21367350E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjASKFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjASKE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:04:28 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865546C557
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:03:30 -0800 (PST)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NyJ4c5H7ZzJqDR;
        Thu, 19 Jan 2023 17:59:12 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 19 Jan 2023 18:03:28 +0800
From:   Junhao He <hejunhao3@huawei.com>
To:     <will@kernel.org>, <linux-kernel@vger.kernel.org>,
        <jonathan.cameron@huawei.com>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <zhangshaokun@hisilicon.com>, <catalin.marinas@arm.com>,
        <kernel-team@android.com>, <linuxarm@huawei.com>,
        <yangyicong@huawei.com>, <f.fangjian@huawei.com>,
        <shenyang39@huawei.com>, <prime.zeng@hisilicon.com>,
        <hejunhao3@huawei.com>
Subject: [PATCH 0/3] Setting the pmu::capability and modify some code styles
Date:   Thu, 19 Jan 2023 18:03:04 +0800
Message-ID: <20230119100307.3660-1-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Advertise the PERF_PMU_CAP_NO_EXCLUDE capability.

And modify some code style, include the following:
1) Simplify the parameters of hisi_pmu_init() function.
2) Use hisi_pmu_init() function to simplify initialization of "hisi_pmu->pmu".

Junhao He (3):
  drivers/perf: hisi: Advertise the PERF_PMU_CAP_NO_EXCLUDE capability
  drivers/perf: hisi: Simplify the parameters of hisi_pmu_init()
  drivers/perf: hisi: Extract initialization of "cpa_pmu->pmu"

 drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c  | 16 +---------------
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c |  2 +-
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  |  2 +-
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c  |  2 +-
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c   |  2 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.c      |  9 ++++++---
 drivers/perf/hisilicon/hisi_uncore_pmu.h      |  4 ++--
 drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c |  2 +-
 8 files changed, 14 insertions(+), 25 deletions(-)

-- 
2.33.0

