Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0267E623DFB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiKJIwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbiKJIwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:52:02 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2FF2EF74;
        Thu, 10 Nov 2022 00:51:59 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N7Fq415cSzpWSZ;
        Thu, 10 Nov 2022 16:48:16 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 16:51:57 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>, <liuqi6124@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <jonathan.cameron@huawei.com>, <bagasdotme@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@huawei.com>, <f.fangjian@huawei.com>,
        <prime.zeng@huawei.com>, <shenyang39@huawei.com>
Subject: [PATCH v2 4/4] Documentation: perf: Indent filter options list of hisi-pcie-pmu
Date:   Thu, 10 Nov 2022 16:51:09 +0800
Message-ID: <20221110085109.45227-5-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20221110085109.45227-1-yangyicong@huawei.com>
References: <20221110085109.45227-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bagas Sanjaya <bagasdotme@gmail.com>

The "Filter options" list have a rather ugly indentation. Also, the first
paragraph after list name is rendered without separator (as continuation
from the name).

Align the list by indenting the list items and add a blank line
separator for each list name.

Fixes: c8602008e247 ("docs: perf: Add description for HiSilicon PCIe PMU driver")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 .../admin-guide/perf/hisi-pcie-pmu.rst        | 80 ++++++++++---------
 1 file changed, 43 insertions(+), 37 deletions(-)

diff --git a/Documentation/admin-guide/perf/hisi-pcie-pmu.rst b/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
index b3615230a4f6..7e863662e2d4 100644
--- a/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
+++ b/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
@@ -48,62 +48,68 @@ Filter options
 --------------
 
 1. Target filter
-PMU could only monitor the performance of traffic downstream target Root Ports
-or downstream target Endpoint. PCIe PMU driver support "port" and "bdf"
-interfaces for users, and these two interfaces aren't supported at the same
-time.
 
--port
-"port" filter can be used in all PCIe PMU events, target Root Port can be
-selected by configuring the 16-bits-bitmap "port". Multi ports can be selected
-for AP-layer-events, and only one port can be selected for TL/DL-layer-events.
+   PMU could only monitor the performance of traffic downstream target Root
+   Ports or downstream target Endpoint. PCIe PMU driver support "port" and
+   "bdf" interfaces for users, and these two interfaces aren't supported at the
+   same time.
 
-For example, if target Root Port is 0000:00:00.0 (x8 lanes), bit0 of bitmap
-should be set, port=0x1; if target Root Port is 0000:00:04.0 (x4 lanes),
-bit8 is set, port=0x100; if these two Root Ports are both monitored, port=0x101.
+   - port
 
-Example usage of perf::
+     "port" filter can be used in all PCIe PMU events, target Root Port can be
+     selected by configuring the 16-bits-bitmap "port". Multi ports can be
+     selected for AP-layer-events, and only one port can be selected for
+     TL/DL-layer-events.
 
-  $# perf stat -e hisi_pcie0_core0/rx_mwr_latency,port=0x1/ sleep 5
+     For example, if target Root Port is 0000:00:00.0 (x8 lanes), bit0 of
+     bitmap should be set, port=0x1; if target Root Port is 0000:00:04.0 (x4
+     lanes), bit8 is set, port=0x100; if these two Root Ports are both
+     monitored, port=0x101.
 
--bdf
+     Example usage of perf::
 
-"bdf" filter can only be used in bandwidth events, target Endpoint is selected
-by configuring BDF to "bdf". Counter only counts the bandwidth of message
-requested by target Endpoint.
+       $# perf stat -e hisi_pcie0_core0/rx_mwr_latency,port=0x1/ sleep 5
 
-For example, "bdf=0x3900" means BDF of target Endpoint is 0000:39:00.0.
+   - bdf
 
-Example usage of perf::
+     "bdf" filter can only be used in bandwidth events, target Endpoint is
+     selected by configuring BDF to "bdf". Counter only counts the bandwidth of
+     message requested by target Endpoint.
+
+     For example, "bdf=0x3900" means BDF of target Endpoint is 0000:39:00.0.
 
-  $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,bdf=0x3900/ sleep 5
+     Example usage of perf::
+
+       $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,bdf=0x3900/ sleep 5
 
 2. Trigger filter
-Event statistics start when the first time TLP length is greater/smaller
-than trigger condition. You can set the trigger condition by writing "trig_len",
-and set the trigger mode by writing "trig_mode". This filter can only be used
-in bandwidth events.
 
-For example, "trig_len=4" means trigger condition is 2^4 DW, "trig_mode=0"
-means statistics start when TLP length > trigger condition, "trig_mode=1"
-means start when TLP length < condition.
+   Event statistics start when the first time TLP length is greater/smaller
+   than trigger condition. You can set the trigger condition by writing
+   "trig_len", and set the trigger mode by writing "trig_mode". This filter can
+   only be used in bandwidth events.
 
-Example usage of perf::
+   For example, "trig_len=4" means trigger condition is 2^4 DW, "trig_mode=0"
+   means statistics start when TLP length > trigger condition, "trig_mode=1"
+   means start when TLP length < condition.
 
-  $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,trig_len=0x4,trig_mode=1/ sleep 5
+   Example usage of perf::
+
+     $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,trig_len=0x4,trig_mode=1/ sleep 5
 
 3. Threshold filter
-Counter counts when TLP length within the specified range. You can set the
-threshold by writing "thr_len", and set the threshold mode by writing
-"thr_mode". This filter can only be used in bandwidth events.
 
-For example, "thr_len=4" means threshold is 2^4 DW, "thr_mode=0" means
-counter counts when TLP length >= threshold, and "thr_mode=1" means counts
-when TLP length < threshold.
+   Counter counts when TLP length within the specified range. You can set the
+   threshold by writing "thr_len", and set the threshold mode by writing
+   "thr_mode". This filter can only be used in bandwidth events.
 
-Example usage of perf::
+   For example, "thr_len=4" means threshold is 2^4 DW, "thr_mode=0" means
+   counter counts when TLP length >= threshold, and "thr_mode=1" means counts
+   when TLP length < threshold.
+
+   Example usage of perf::
 
-  $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,thr_len=0x4,thr_mode=1/ sleep 5
+     $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,thr_len=0x4,thr_mode=1/ sleep 5
 
 4. TLP Length filter
 
-- 
2.24.0

