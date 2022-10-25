Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDC660CAF5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiJYLd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbiJYLdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:33:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3A6123454;
        Tue, 25 Oct 2022 04:33:20 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MxV7H1q3QzmVJ8;
        Tue, 25 Oct 2022 19:28:27 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 19:33:19 +0800
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
Subject: [PATCH 2/3] docs: perf: Fix PMU instance name of hisi-pcie-pmu
Date:   Tue, 25 Oct 2022 19:32:41 +0800
Message-ID: <20221025113242.58271-3-yangyicong@huawei.com>
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

The PMU instance will be called hisi_pcie<sicl>_core<core> rather than
hisi_pcie<sicl>_<core>. Fix this in the documentation.

Fixes: c8602008e247 ("docs: perf: Add description for HiSilicon PCIe PMU driver")
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 .../admin-guide/perf/hisi-pcie-pmu.rst        | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/perf/hisi-pcie-pmu.rst b/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
index 294ebbdb22af..bbe66480ff85 100644
--- a/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
+++ b/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
@@ -15,10 +15,10 @@ HiSilicon PCIe PMU driver
 The PCIe PMU driver registers a perf PMU with the name of its sicl-id and PCIe
 Core id.::
 
-  /sys/bus/event_source/hisi_pcie<sicl>_<core>
+  /sys/bus/event_source/hisi_pcie<sicl>_core<core>
 
 PMU driver provides description of available events and filter options in sysfs,
-see /sys/bus/event_source/devices/hisi_pcie<sicl>_<core>.
+see /sys/bus/event_source/devices/hisi_pcie<sicl>_core<core>.
 
 The "format" directory describes all formats of the config (events) and config1
 (filter options) fields of the perf_event_attr structure. The "events" directory
@@ -33,13 +33,13 @@ monitored by PMU.
 Example usage of perf::
 
   $# perf list
-  hisi_pcie0_0/rx_mwr_latency/ [kernel PMU event]
-  hisi_pcie0_0/rx_mwr_cnt/ [kernel PMU event]
+  hisi_pcie0_core0/rx_mwr_latency/ [kernel PMU event]
+  hisi_pcie0_core0/rx_mwr_cnt/ [kernel PMU event]
   ------------------------------------------
 
-  $# perf stat -e hisi_pcie0_0/rx_mwr_latency/
-  $# perf stat -e hisi_pcie0_0/rx_mwr_cnt/
-  $# perf stat -g -e hisi_pcie0_0/rx_mwr_latency/ -e hisi_pcie0_0/rx_mwr_cnt/
+  $# perf stat -e hisi_pcie0_core0/rx_mwr_latency/
+  $# perf stat -e hisi_pcie0_core0/rx_mwr_cnt/
+  $# perf stat -g -e hisi_pcie0_core0/rx_mwr_latency/ -e hisi_pcie0_core0/rx_mwr_cnt/
 
 The current driver does not support sampling. So "perf record" is unsupported.
 Also attach to a task is unsupported for PCIe PMU.
@@ -64,7 +64,7 @@ bit8 is set, port=0x100; if these two Root Ports are both monitored, port=0x101.
 
 Example usage of perf::
 
-  $# perf stat -e hisi_pcie0_0/rx_mwr_latency,port=0x1/ sleep 5
+  $# perf stat -e hisi_pcie0_core0/rx_mwr_latency,port=0x1/ sleep 5
 
 -bdf
 
@@ -76,7 +76,7 @@ For example, "bdf=0x3900" means BDF of target Endpoint is 0000:39:00.0.
 
 Example usage of perf::
 
-  $# perf stat -e hisi_pcie0_0/rx_mrd_flux,bdf=0x3900/ sleep 5
+  $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,bdf=0x3900/ sleep 5
 
 2. Trigger filter
 Event statistics start when the first time TLP length is greater/smaller
@@ -90,7 +90,7 @@ means start when TLP length < condition.
 
 Example usage of perf::
 
-  $# perf stat -e hisi_pcie0_0/rx_mrd_flux,trig_len=0x4,trig_mode=1/ sleep 5
+  $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,trig_len=0x4,trig_mode=1/ sleep 5
 
 3. Threshold filter
 Counter counts when TLP length within the specified range. You can set the
@@ -103,4 +103,4 @@ when TLP length < threshold.
 
 Example usage of perf::
 
-  $# perf stat -e hisi_pcie0_0/rx_mrd_flux,thr_len=0x4,thr_mode=1/ sleep 5
+  $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,thr_len=0x4,thr_mode=1/ sleep 5
-- 
2.24.0

