Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C7A67F69A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 10:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjA1JM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 04:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjA1JMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 04:12:25 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5EB81CAFC;
        Sat, 28 Jan 2023 01:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
        Content-Type; bh=+vDrkP2F8VPkWsCf/ZbZMm5gtlkYDS7DkNhsTVZw5f0=;
        b=OgPWOZLE249HCw312oGXeYyjXFbXtal64QKrQrJL/odJtT0genuQaYD1AaZG/4
        pxf10s77OzZHpyBTXSGNnCjvEAKj1TFnaD6eYcD+DDK/XJUwBKelBK0eXBUgxuTc
        tN1Od3Iba6VES1iJc7fyAgqrYZo00fqqZ1lmvDwfFLb5c=
Received: from localhost (unknown [49.235.41.28])
        by zwqz-smtp-mta-g0-0 (Coremail) with SMTP id _____wCXxR7U5tRj9TjLBw--.29123S2;
        Sat, 28 Jan 2023 17:11:48 +0800 (CST)
Date:   Sat, 28 Jan 2023 17:11:48 +0800
From:   Hui Su <suhui_kernel@163.com>
To:     sj@kernel.org, corbet@lwn.net, alexs@kernel.org,
        siyanteng@loongson.cn, rppt@kernel.org, bobwxc@email.cn,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Doc/damon: fix the data path error
Message-ID: <Y9Tm1FiKBPKA2Tcx@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCXxR7U5tRj9TjLBw--.29123S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFW3CF17ZrWrAF13Xr4DXFb_yoWrCryUpF
        93tryIq3yxJF9Igws7AanrWF15AayIkFWYqFWfW3Z7ZFs0qa4vyF13Kr1Yk3WkZryrGa15
        Zan3GryUuFy7A3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UEZXrUUUUU=
X-Originating-IP: [49.235.41.28]
X-CM-SenderInfo: 5vxk3xhbnh20lho6il2tof0z/xtbCfhAFbWDcMzXLngAAsp
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

%s/modules/module/

Signed-off-by: Hui Su <suhui_kernel@163.com>
---
 Documentation/admin-guide/mm/damon/lru_sort.rst               | 4 ++--
 Documentation/admin-guide/mm/damon/reclaim.rst                | 4 ++--
 .../translations/zh_CN/admin-guide/mm/damon/reclaim.rst       | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
index c09cace80651..7b0775d281b4 100644
--- a/Documentation/admin-guide/mm/damon/lru_sort.rst
+++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
@@ -54,7 +54,7 @@ that is built with ``CONFIG_DAMON_LRU_SORT=y``.
 To let sysadmins enable or disable it and tune for the given system,
 DAMON_LRU_SORT utilizes module parameters.  That is, you can put
 ``damon_lru_sort.<parameter>=<value>`` on the kernel boot command line or write
-proper values to ``/sys/modules/damon_lru_sort/parameters/<parameter>`` files.
+proper values to ``/sys/module/damon_lru_sort/parameters/<parameter>`` files.
 
 Below are the description of each parameter.
 
@@ -283,7 +283,7 @@ doesn't make progress and therefore the free memory rate becomes lower than
 20%, it asks DAMON_LRU_SORT to do nothing again, so that we can fall back to
 the LRU-list based page granularity reclamation. ::
 
-    # cd /sys/modules/damon_lru_sort/parameters
+    # cd /sys/module/damon_lru_sort/parameters
     # echo 500 > hot_thres_access_freq
     # echo 120000000 > cold_min_age
     # echo 10 > quota_ms
diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index 4f1479a11e63..d2ccd9c21b9a 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -46,7 +46,7 @@ that is built with ``CONFIG_DAMON_RECLAIM=y``.
 To let sysadmins enable or disable it and tune for the given system,
 DAMON_RECLAIM utilizes module parameters.  That is, you can put
 ``damon_reclaim.<parameter>=<value>`` on the kernel boot command line or write
-proper values to ``/sys/modules/damon_reclaim/parameters/<parameter>`` files.
+proper values to ``/sys/module/damon_reclaim/parameters/<parameter>`` files.
 
 Below are the description of each parameter.
 
@@ -251,7 +251,7 @@ therefore the free memory rate becomes lower than 20%, it asks DAMON_RECLAIM to
 do nothing again, so that we can fall back to the LRU-list based page
 granularity reclamation. ::
 
-    # cd /sys/modules/damon_reclaim/parameters
+    # cd /sys/module/damon_reclaim/parameters
     # echo 30000000 > min_age
     # echo $((1 * 1024 * 1024 * 1024)) > quota_sz
     # echo 1000 > quota_reset_interval_ms
diff --git a/Documentation/translations/zh_CN/admin-guide/mm/damon/reclaim.rst b/Documentation/translations/zh_CN/admin-guide/mm/damon/reclaim.rst
index c976f3e33ffd..d15a2f20bb11 100644
--- a/Documentation/translations/zh_CN/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/translations/zh_CN/admin-guide/mm/damon/reclaim.rst
@@ -45,7 +45,7 @@ DAMON_RECLAIM找到在特定时间内没有被访问的内存区域并分页。
 
 为了让系统管理员启用或禁用它，并为给定的系统进行调整，DAMON_RECLAIM利用了模块参数。也就
 是说，你可以把 ``damon_reclaim.<parameter>=<value>`` 放在内核启动命令行上，或者把
-适当的值写入 ``/sys/modules/damon_reclaim/parameters/<parameter>`` 文件。
+适当的值写入 ``/sys/module/damon_reclaim/parameters/<parameter>`` 文件。
 
 注意，除 ``启用`` 外的参数值只在DAMON_RECLAIM启动时应用。因此，如果你想在运行时应用新
 的参数值，而DAMON_RECLAIM已经被启用，你应该通过 ``启用`` 的参数文件禁用和重新启用它。
@@ -218,7 +218,7 @@ nr_quota_exceeds
 就开始真正的工作。如果DAMON_RECLAIM没有取得进展，因此空闲内存率低于20%，它会要求
 DAMON_RECLAIM再次什么都不做，这样我们就可以退回到基于LRU列表的页面粒度回收了::
 
-    # cd /sys/modules/damon_reclaim/parameters
+    # cd /sys/module/damon_reclaim/parameters
     # echo 30000000 > min_age
     # echo $((1 * 1024 * 1024 * 1024)) > quota_sz
     # echo 1000 > quota_reset_interval_ms
-- 
2.34.1

