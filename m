Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BDE67F22F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 00:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbjA0XTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 18:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjA0XTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 18:19:38 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2FB7D97
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 15:19:37 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y11so6063026edd.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 15:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pzRNo8OLqN9/YsKPP6eMEHQodD41be26yWHySF2FqgE=;
        b=g5B1FomKgADwAni2Sc9ov8Gx/XZulz+R6EXepHpQqeHJUMar0n4JtTGf4W60fSFNw3
         RPqs22y9OpfBHMDkMwCIn+qiZEOxMYTTJPVO2472gtwJI2PODODwPa6jWuIy1JmH4mRy
         3kG2zZjSJ0NnZ8hLlPyIKTbU+Fo74leWtl3+iTeEimGIYq456EAXOney9/MNSJTrqHBf
         3K54aPMVc263PXw+bnQMvR21QGqQCOArNdXQJX3nHdfsAXXF3K+8nCi7Szhv9Iip5dsy
         1c6leS4kUNfrSxN4Np8Rwr0I9VboMdferXeUjWYZ0ddAAjsUfWxBC+z2kuvCZMnOYS7m
         FLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:subject:cc:to:date:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pzRNo8OLqN9/YsKPP6eMEHQodD41be26yWHySF2FqgE=;
        b=HT2UKrhCKN9nQYK098CP/hf/Jg1cURzdwxOt/hdgFqmhwVuvKpwDR5ZdyPZ/bvRBtM
         rYHEeyjFbCgumkSO4mFgiXtNLbRNRNRxiaQVPOAZr9COPnj10O8nuH2Xj1aZ60UF4c6h
         41HkEVXN427/5pCnuV06YTZMr17W07NWBZ0qtqwEUkvPmTFYICYypAFZdei/qv9t7wT7
         YGT/eM3L9sJlhuf6xP+MImmCE3v8ET33T9X/LvEnuYUbwjkuUHbHdxWFw//WQUdG8wV4
         HsQBrJp0lFvCIiYPbaC4z6IpYMi+98QxKY8x99VP98wAXzaGFCfT8kkCFeG6La4UsdkQ
         TtBQ==
X-Gm-Message-State: AO0yUKXIvVxshRTy9OQjvHmX6vDaCmh+UIitcp+d9uQE5aFpFJljNhDq
        q2Zv32kp1vKcOUKOxqkCQhJpsIkrIy5QKA==
X-Google-Smtp-Source: AK7set9ftkQkHn1YUY39ENogV4fSuQxQxjQMcWSnIJNbYDVHpZowXXW5aHEdAaRKKsOwAy35tuDT0g==
X-Received: by 2002:aa7:c584:0:b0:4a2:135e:67fe with SMTP id g4-20020aa7c584000000b004a2135e67femr2799847edq.19.1674861575718;
        Fri, 27 Jan 2023 15:19:35 -0800 (PST)
Received: from smurf (80.71.142.58.ipv4.parknet.dk. [80.71.142.58])
        by smtp.gmail.com with ESMTPSA id kv5-20020a17090778c500b0087c4f420af2sm1158164ejc.4.2023.01.27.15.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 15:19:35 -0800 (PST)
From:   Jesper Juhl <jesperjuhl76@gmail.com>
X-Google-Original-From: Jesper Juhl <jj@gmail.com>
Date:   Sat, 28 Jan 2023 00:19:16 +0100 (CET)
To:     linux-kernel@vger.kernel.org
cc:     trivial@kernel.org
Subject: [PATCH] Remove a number of duplicate includes
Message-ID: <b804ecf4-33a5-f443-14db-ff89d992a345@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a number of duplicate includes

Including the same header multiple times when there's no functional reason
to do so is just pointless clutter and potentially slows down builds.

Signed-off-by: Jesper Juhl <jesperjuhl76@gmail.com>
---
  drivers/base/node.c                     | 1 -
  drivers/bus/bt1-apb.c                   | 1 -
  drivers/char/hw_random/core.c           | 1 -
  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 -
  drivers/gpu/drm/drm_gem_shmem_helper.c  | 1 -
  fs/fscache/io.c                         | 1 -
  fs/overlayfs/inode.c                    | 1 -
  kernel/sched/build_utility.c            | 1 -
  kernel/sched/core.c                     | 3 ---
  kernel/sched/fair.c                     | 2 --
  10 files changed, 13 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index faf3597a96da..4306611ac092 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -20,7 +20,6 @@
  #include <linux/pm_runtime.h>
  #include <linux/swap.h>
  #include <linux/slab.h>
-#include <linux/hugetlb.h>

  static struct bus_type node_subsys = {
  	.name = "node",
diff --git a/drivers/bus/bt1-apb.c b/drivers/bus/bt1-apb.c
index 63b1b4a76671..fd198577cdb3 100644
--- a/drivers/bus/bt1-apb.c
+++ b/drivers/bus/bt1-apb.c
@@ -22,7 +22,6 @@
  #include <linux/clk.h>
  #include <linux/reset.h>
  #include <linux/time64.h>
-#include <linux/clk.h>
  #include <linux/sysfs.h>

  #define APB_EHB_ISR			0x00
diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index f34d356fe2c0..ead998ca0c40 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -21,7 +21,6 @@
  #include <linux/sched/signal.h>
  #include <linux/miscdevice.h>
  #include <linux/module.h>
-#include <linux/random.h>
  #include <linux/sched.h>
  #include <linux/slab.h>
  #include <linux/uaccess.h>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 55e0284b2bdd..f99251861c08 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -43,7 +43,6 @@
  #include <linux/sizes.h>
  #include <linux/module.h>

-#include <drm/drm_drv.h>
  #include <drm/ttm/ttm_bo_api.h>
  #include <drm/ttm/ttm_bo_driver.h>
  #include <drm/ttm/ttm_placement.h>
diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index b602cd72a120..6f794db17059 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -10,7 +10,6 @@
  #include <linux/shmem_fs.h>
  #include <linux/slab.h>
  #include <linux/vmalloc.h>
-#include <linux/module.h>

  #ifdef CONFIG_X86
  #include <asm/set_memory.h>
diff --git a/fs/fscache/io.c b/fs/fscache/io.c
index 0d2b8dec8f82..ac9f19388bfb 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -9,7 +9,6 @@
  #include <linux/uio.h>
  #include <linux/bvec.h>
  #include <linux/slab.h>
-#include <linux/uio.h>
  #include "internal.h"

  /**
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index ee6dfa577c93..e6aba8c21efc 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -8,7 +8,6 @@
  #include <linux/slab.h>
  #include <linux/cred.h>
  #include <linux/xattr.h>
-#include <linux/posix_acl.h>
  #include <linux/ratelimit.h>
  #include <linux/fiemap.h>
  #include <linux/fileattr.h>
diff --git a/kernel/sched/build_utility.c b/kernel/sched/build_utility.c
index 99bdd96f454f..80a3df49ab47 100644
--- a/kernel/sched/build_utility.c
+++ b/kernel/sched/build_utility.c
@@ -34,7 +34,6 @@
  #include <linux/nospec.h>
  #include <linux/proc_fs.h>
  #include <linux/psi.h>
-#include <linux/psi.h>
  #include <linux/ptrace_api.h>
  #include <linux/sched_clock.h>
  #include <linux/security.h>
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e838feb6adc5..f3bba4b8c430 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -84,12 +84,9 @@

  #include "sched.h"
  #include "stats.h"
-#include "autogroup.h"
-
  #include "autogroup.h"
  #include "pelt.h"
  #include "smp.h"
-#include "stats.h"

  #include "../workqueue_internal.h"
  #include "../../io_uring/io-wq.h"
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0f8736991427..e6a11380b47b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -50,8 +50,6 @@

  #include <asm/switch_to.h>

-#include <linux/sched/cond_resched.h>
-
  #include "sched.h"
  #include "stats.h"
  #include "autogroup.h"
-- 
2.39.1

