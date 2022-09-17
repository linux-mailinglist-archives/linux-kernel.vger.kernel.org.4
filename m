Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531145BB573
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 03:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiIQB7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 21:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiIQB7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 21:59:32 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C726E43;
        Fri, 16 Sep 2022 18:59:30 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MTvFv11TLzBsMr;
        Sat, 17 Sep 2022 09:57:23 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 17 Sep 2022 09:59:28 +0800
Received: from huawei.com (10.67.175.41) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 17 Sep
 2022 09:59:27 +0800
From:   Yipeng Zou <zouyipeng@huawei.com>
To:     <x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-csky@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <guoren@kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <hca@linux.ibm.com>, <gor@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <dave.hansen@linux.intel.com>,
        <hpa@zytor.com>, <naveen.n.rao@linux.ibm.com>,
        <anil.s.keshavamurthy@intel.com>, <mhiramat@kernel.org>,
        <namit@vmware.com>, <catalin.marinas@arm.com>,
        <peterz@infradead.org>, <mark.rutland@arm.com>
CC:     <liaochang1@huawei.com>, <chris.zjh@huawei.com>,
        <zouyipeng@huawei.com>
Subject: [PATCH 0/2] make weak attributes in {k,u}probes
Date:   Sat, 17 Sep 2022 09:55:20 +0800
Message-ID: <20220917015522.44583-1-zouyipeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.41]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have some function implementation under some arch does nothing.
We can mark it with weak attributes to improve.
1. arch_init_kprobes in kprobes
2. arch_uprobe_exception_notify in uprobes

Yipeng Zou (2):
  kprobes: make arch_init_kprobes as weak
  uprobes: make arch_uprobe_exception_notify as weak

 arch/arm/probes/uprobes/core.c     | 6 ------
 arch/arm64/kernel/probes/uprobes.c | 6 ------
 arch/csky/kernel/probes/kprobes.c  | 5 -----
 arch/csky/kernel/probes/uprobes.c  | 6 ------
 arch/riscv/kernel/probes/kprobes.c | 5 -----
 arch/riscv/kernel/probes/uprobes.c | 6 ------
 arch/s390/kernel/kprobes.c         | 5 -----
 arch/x86/kernel/kprobes/core.c     | 5 -----
 kernel/events/uprobes.c            | 6 ++++++
 kernel/kprobes.c                   | 5 +++++
 10 files changed, 11 insertions(+), 44 deletions(-)

-- 
2.17.1

