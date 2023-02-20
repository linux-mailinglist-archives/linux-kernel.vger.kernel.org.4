Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0BB69CAEA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 13:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjBTM0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 07:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbjBTM0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:26:42 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5B71C5A9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 04:26:00 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id ck15so5208878edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 04:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=EynXUdhr4SzeElz1eUHPbvQuXV4RNv2h58STo+TjxMM=;
        b=GiTK1w5Z+YcYQzbcxnKXsM9caMz7CXXQYbr6qfxlY6WJg/ZWJYsVUeWwPf3t6/EqfQ
         FtAhAJQSW+9qbYqGMsKX1UXiA2jSnLcv0SFFllIiOCzWa/mSdmz10WyUN1UG0O6ZpOHJ
         XPouP61z3KCTTSB0YYHwO7/JibmjfLTiS4+JUWoj5/QiMbFC9AfYfZMVrtLUPyarXg0u
         iutZ8+VYcN8W6cwHB/KFVNAkdyGcBDkIrInYOwj4mq4QPpHSiqFRcaYBglKUI3JCP5sT
         6tgnwlGBd6UqKvR6nqKtGQs4GwfS3XT4orAsYznPYbIX6gsbtoB/zyNzRnlI0pdIzC7z
         R4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EynXUdhr4SzeElz1eUHPbvQuXV4RNv2h58STo+TjxMM=;
        b=j9zCFuOun0EW85Mp7LB7BtRO6A9TFfHDy/qLFMs9eHjCdGbm2oShn9IjbOfKxU4P1l
         SFWVtsG3CM29zcUqcMTXlhLYb1tICM5afBrc6W4+F5jMyDwRMBv/YKkZJM6mvTIgQdaP
         ccxEx9YOHS6fDiu3TvcXHFpIuxhCbPAeZ6+u24qQe5PAEUcEocOK0T/GXvDFMd8E9HyJ
         sL943C3+eV7/D5AAfuJKQPu7eq8Wz/GdHPY3vIiakafoQRQzZns7G2BC7tbzDBGxwBtd
         5fGopbK1pnzeT4b36EOkURmJ3lZik7BvQ/+oVAEqVIaSK8FegOPrFY0rlo4kIZDYaZhd
         IIXQ==
X-Gm-Message-State: AO0yUKU37+xUDPfs+z6MJPpMflf1xksKe2cJ3XxiITvMpYP8P9MGO7fn
        hQ+QwQMIEATRGo1h0Wfj0OI=
X-Google-Smtp-Source: AK7set+pQn0BPSscW+Pg1PYHUKNWDNrBX010kvZDmZBoDAavK0KSLo/kbPxRt0m5j0vXTKOSj8KWhQ==
X-Received: by 2002:a17:906:f0ca:b0:8b2:37b5:cc4 with SMTP id dk10-20020a170906f0ca00b008b237b50cc4mr11994036ejb.7.1676895957189;
        Mon, 20 Feb 2023 04:25:57 -0800 (PST)
Received: from gmail.com ([31.46.241.99])
        by smtp.gmail.com with ESMTPSA id u18-20020a50c052000000b004ace62d6eaesm74990edd.57.2023.02.20.04.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 04:25:56 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 20 Feb 2023 13:25:50 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] locking changes for v6.3
Message-ID: <Y/NmzouehvMWTPVZ@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5eMDYABnSszN9/s@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the latest locking tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2023-02-20

   # HEAD: 3b4863fa5b7dd50dab1b10abbed938efd203752f vduse: Remove include of rwlock.h

Updates for this cycle were:

 - rwsem micro-optimizations
 - spinlock micro-optimizations
 - cleanups, simplifications

 Thanks,

	Ingo

------------------>
Guo Ren (1):
      locking/qspinlock: Micro-optimize pending state waiting for unlock

Sebastian Andrzej Siewior (2):
      locking/lockdep: Remove lockdep_init_map_crosslock.
      vduse: Remove include of rwlock.h

Uros Bizjak (2):
      x86/PAT: Use try_cmpxchg() in set_page_memtype()
      x86/ACPI/boot: Use try_cmpxchg() in __acpi_{acquire,release}_global_lock()

Waiman Long (3):
      locking/rwsem: Prevent non-first waiter from spinning in down_write() slowpath
      locking/rwsem: Disable preemption in all down_read*() and up_read() code paths
      locking/rwsem: Disable preemption in all down_write*() and up_write() code paths


 arch/x86/kernel/acpi/boot.c          | 16 +++----
 arch/x86/mm/pat/memtype.c            |  4 +-
 drivers/vdpa/vdpa_user/iova_domain.h |  1 -
 include/linux/lockdep.h              |  1 -
 kernel/locking/qspinlock.c           |  4 +-
 kernel/locking/rwsem.c               | 87 +++++++++++++++++++++---------------
 6 files changed, 64 insertions(+), 49 deletions(-)
