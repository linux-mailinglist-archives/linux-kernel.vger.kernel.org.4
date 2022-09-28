Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAAE5EC01D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbiI0Kt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiI0Kts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:49:48 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B93113EBE
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 03:49:37 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4McGXl2XLrzHqBT;
        Tue, 27 Sep 2022 18:47:19 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 18:49:35 +0800
Received: from huawei.com (10.67.174.191) by dggpeml500018.china.huawei.com
 (7.185.36.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 27 Sep
 2022 18:49:35 +0800
From:   Zhang Qiao <zhangqiao22@huawei.com>
To:     <gregkh@linuxfoundation.org>, <arve@android.com>,
        <tkjos@android.com>, <maco@android.com>, <joel@joelfernandes.org>,
        <brauner@kernel.org>, <cmllamas@google.com>, <surenb@google.com>
CC:     <linux-kernel@vger.kernel.org>, <zhangqiao22@huawei.com>
Subject: [PATCH -next] android: binder: Remove comments about tsk fields
Date:   Wed, 28 Sep 2022 08:46:10 +0800
Message-ID: <20220928004610.58756-1-zhangqiao22@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.191]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a0c2baaf81bd ("android: binder: Don't get mm
from task") remove the binder_alloc struct's tsk, but
didn't remove the header commment about '@tsk'.
So this patch remove it.

Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
---
 drivers/android/binder_alloc.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index 1e4fd37af5e0..fe0738fb9c8c 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -76,8 +76,6 @@ struct binder_lru_page {
  * struct binder_alloc - per-binder proc state for binder allocator
  * @vma:                vm_area_struct passed to mmap_handler
  *                      (invarient after mmap)
- * @tsk:                tid for task that called init for this proc
- *                      (invariant after init)
  * @vma_vm_mm:          copy of vma->vm_mm (invarient after mmap)
  * @buffer:             base of per-proc address space mapped via mmap
  * @buffers:            list of all buffers for this proc
-- 
2.17.1

