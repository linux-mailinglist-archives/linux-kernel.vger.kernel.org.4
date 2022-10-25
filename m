Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FD660CAF4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiJYLda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiJYLdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:33:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6779122772;
        Tue, 25 Oct 2022 04:33:20 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MxVDf69LGzHtpH;
        Tue, 25 Oct 2022 19:33:06 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 19:33:18 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>, <liuqi6124@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Garry <john.garry@huawei.com>,
        <jonathan.cameron@huawei.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linuxarm@huawei.com>,
        <f.fangjian@huawei.com>, <prime.zeng@huawei.com>
Subject: [PATCH 1/3] drivers/perf: hisi: Fix some event id for hisi-pcie-pmu
Date:   Tue, 25 Oct 2022 19:32:40 +0800
Message-ID: <20221025113242.58271-2-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20221025113242.58271-1-yangyicong@huawei.com>
References: <20221025113242.58271-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

Some event id of hisi-pcie-pmu is incorrect, fix them.

Fixes: 8404b0fbc7fb ("drivers/perf: hisi: Add driver for HiSilicon PCIe PMU")
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/perf/hisilicon/hisi_pcie_pmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index 21771708597d..071e63d9a9ac 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -693,10 +693,10 @@ static struct attribute *hisi_pcie_pmu_events_attr[] = {
 	HISI_PCIE_PMU_EVENT_ATTR(rx_mrd_cnt, 0x10210),
 	HISI_PCIE_PMU_EVENT_ATTR(tx_mrd_latency, 0x0011),
 	HISI_PCIE_PMU_EVENT_ATTR(tx_mrd_cnt, 0x10011),
-	HISI_PCIE_PMU_EVENT_ATTR(rx_mrd_flux, 0x1005),
-	HISI_PCIE_PMU_EVENT_ATTR(rx_mrd_time, 0x11005),
-	HISI_PCIE_PMU_EVENT_ATTR(tx_mrd_flux, 0x2004),
-	HISI_PCIE_PMU_EVENT_ATTR(tx_mrd_time, 0x12004),
+	HISI_PCIE_PMU_EVENT_ATTR(rx_mrd_flux, 0x0804),
+	HISI_PCIE_PMU_EVENT_ATTR(rx_mrd_time, 0x10804),
+	HISI_PCIE_PMU_EVENT_ATTR(tx_mrd_flux, 0x0405),
+	HISI_PCIE_PMU_EVENT_ATTR(tx_mrd_time, 0x10405),
 	NULL
 };
 
-- 
2.24.0

