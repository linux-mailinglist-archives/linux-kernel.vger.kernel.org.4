Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CD06D3EBA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 10:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjDCIPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 04:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDCIPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:15:41 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE744ECB
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 01:15:39 -0700 (PDT)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PqkC35NVQz17PNM;
        Mon,  3 Apr 2023 16:12:15 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 3 Apr 2023 16:15:37 +0800
From:   Junhao He <hejunhao3@huawei.com>
To:     <jonathan.cameron@huawei.com>, <will@kernel.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
        <kernel-team@android.com>, <linuxarm@huawei.com>,
        <yangyicong@huawei.com>, <f.fangjian@huawei.com>,
        <shenyang39@huawei.com>, <prime.zeng@hisilicon.com>,
        <hejunhao3@huawei.com>
Subject: [PATCH 0/2]Fix NULL pointer and doing cleanup
Date:   Mon, 3 Apr 2023 16:14:21 +0800
Message-ID: <20230403081423.62460-1-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix NULL pointer and cleanup redundant initialized.

Junhao He (2):
  drivers/perf: hisi: Remove redundant initialized of pmu->name
  drivers/perf: hisi: add NULL check for name

 drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c  |  2 +-
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 19 +++++++++++--------
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  |  9 ++++++---
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c  | 13 ++++++-------
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c   |  2 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.c      |  4 +---
 drivers/perf/hisilicon/hisi_uncore_pmu.h      |  3 +--
 drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c |  2 +-
 8 files changed, 28 insertions(+), 26 deletions(-)

-- 
2.33.0

