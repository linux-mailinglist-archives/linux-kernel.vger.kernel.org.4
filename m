Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254DF5EF294
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbiI2JrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234864AbiI2Jqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:46:37 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C8479A5B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:45:23 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MdT1g4d4jzHqJp;
        Thu, 29 Sep 2022 17:43:03 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 17:45:21 +0800
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 17:45:20 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>
CC:     <rostedt@goodmis.org>, <mingo@redhat.com>, <Julia.Lawall@inria.fr>,
        <akpm@linux-foundation.org>, <andreyknvl@gmail.com>,
        <elver@google.com>, <wangkefeng.wang@huawei.com>,
        <zhouchengming@bytedance.com>, <ardb@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <lihuafei1@huawei.com>
Subject: [PATCH 0/3] arm64: module/ftrace: Fix mcount-based ftrace initialization failure
Date:   Thu, 29 Sep 2022 17:41:31 +0800
Message-ID: <20220929094134.99512-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is mainly to fix the mcount-based ftrace initialization
failure during module loading (see patch 3). The first two are cleanup
patches.

Li Huafei (3):
  arm64: module: Make plt_equals_entry() static
  arm64: module: Remove unused plt_entry_is_initialized()
  arm64: module/ftrace: Fix mcount-based ftrace initialization failure

 arch/arm64/include/asm/module.h | 13 +++++++------
 arch/arm64/kernel/ftrace.c      | 29 ++++++++++++++++++++++++++++-
 arch/arm64/kernel/module-plts.c | 19 ++++++++++++++++++-
 arch/arm64/kernel/module.c      | 11 +++++++++++
 4 files changed, 64 insertions(+), 8 deletions(-)


base-commit: c3e0e1e23c70455916ff3472072437b3605c6cfe
-- 
2.17.1

