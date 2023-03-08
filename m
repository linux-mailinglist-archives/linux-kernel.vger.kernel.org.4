Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5477A6B1340
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 21:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjCHUlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 15:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjCHUk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 15:40:59 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD716A2C9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 12:40:48 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id a10-20020a056a000c8a00b005fc6b117942so30406pfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 12:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678308048;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1lXNZUhLpOh6e+rINxcOot9fxcAhpOKtr/aU78Uw0nU=;
        b=Gnh8nE+mOsQp771T8QfzpKbDCUZMn1El6aeX2Gjj/EBTULwl48Eq/bJXrndjQTqeN5
         SEUJDm1Sj4hpjYkzlYRXUN7eNhXzeCRv2PqEj/NH75B8bqmyMsugSQoF8rn7hls2ti1y
         xUY8TcQBvol9sjdD8alH5m4Rv31cupnlprFsT1mlOtQdtGjO0PR9DpKQVx6RgmsA1azy
         iIwuBFIHWFJ2LFay8HxTQXOZbp0k+6GsfVrEGHTbNtZLqi5fLnPO9Iuid2HxmTPk6E9k
         WMh17w0/drOBRddWeUn01zRfqD2nJk9C5ClaiUxSXt8Gg260j9c559Trd5+Pz90c9OOG
         jjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678308048;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lXNZUhLpOh6e+rINxcOot9fxcAhpOKtr/aU78Uw0nU=;
        b=fzwzzg8VVKRYOXoNxPzl/JPs7TR52R4R1gPGHqeO719yKVofBuZGetsxjnMFNLjOeU
         c0EIfnYjZujDeOlJz/stcmDOEExRqrXqTlQZyqnqByyfDUo/U2Hr4Ckjfin9y/mcglUt
         kSklAtnYvMk3bS9WkxF/tL7JIIDlD0ayosMiqYYfZ8AYVQTCNkCa6zi4f49f/p3c9Yyl
         +O2n4tGU8aHy8i6Txj66s076Xaz5ArVzu9D1ED/Up4czTZpcskT3zEZa7Qn1UJY9P5Az
         nmkvI8EgPjbiC3rS5u0vd3fC5ax/O8agip5cpb8qZvo8tW2fLA1ahkKClQVYVJhb/MRG
         DMvA==
X-Gm-Message-State: AO0yUKVGj6sR45EFO2GjKeQi5LuX1cZ5QW0w184CgDNoZE1Fk4HNa/1L
        0UiEySAkt+x6kqTJOHwfF2R2ro9gOEwgqDfpZGrl8Ot+Py+iLq8nw/OYZRpe4djvRb7GIBLm5SP
        TWe0kAhUJVzWWXVgpx8ZRT9dSuXtJ3M6GFF6gKe8uHnWLfNx0iQEYctBWZyLJrTjIz+rZalo=
X-Google-Smtp-Source: AK7set/WKRC2bUjVE8m1yPnPm36IEU4SXV6lijramT+kTCUEE+ZHzvqx/X3+r6/UEZMbwu84aPlqBCIVw9B2
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a62:8348:0:b0:5ef:95c9:6a88 with SMTP id
 h69-20020a628348000000b005ef95c96a88mr8102134pfe.5.1678308048333; Wed, 08 Mar
 2023 12:40:48 -0800 (PST)
Date:   Wed,  8 Mar 2023 20:40:43 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230308204043.2061631-1-jstultz@google.com>
Subject: [PATCH v3] pstore: Revert pmsg_lock back to a normal mutex
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>, Wei Wang <wvw@google.com>,
        Midas Chien <midaschieh@google.com>,
        "=?UTF-8?q?Chunhui=20Li=20=28=E6=9D=8E=E6=98=A5=E8=BE=89=29?=" 
        <chunhui.li@mediatek.com>, Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tony Luck <tony.luck@intel.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 76d62f24db07f22ccf9bc18ca793c27d4ebef721.

So while priority inversion on the pmsg_lock is an occasional
problem that an rt_mutex would help with, in uses where logging
is writing to pmsg heavily from multiple threads, the pmsg_lock
can be heavily contended.

After this change landed, it was reported that cases where the
mutex locking overhead was commonly adding on the order of 10s
of usecs delay had suddenly jumped to ~msec delay with rtmutex.

It seems the slight differences in the locks under this level
of contention causes the normal mutexes to utilize the spinning
optimizations, while the rtmutexes end up in the sleeping
slowpath (which allows additional threads to pile on trying
to take the lock).

In this case, it devolves to a worse case senerio where the lock
acquisition and scheduling overhead dominates, and each thread
is waiting on the order of ~ms to do ~us of work.

Obviously, having tons of threads all contending on a single
lock for logging is non-optimal, so the proper fix is probably
reworking pstore pmsg to have per-cpu buffers so we don't have
contention.

Additionally, Steven Rostedt has provided some furhter
optimizations for rtmutexes that improves the rtmutex spinning
path, but at least in my testing, I still see the test tripping
into the sleeping path on rtmutexes while utilizing the spinning
path with mutexes.

But in the short term, lets revert the change to the rt_mutex
and go back to normal mutexes to avoid a potentially major
performance regression. And we can work on optimizations to both
rtmutexes and finer-grained locking for pstore pmsg in the
future.

Cc: Wei Wang <wvw@google.com>
Cc: Midas Chien<midaschieh@google.com>
Cc: "Chunhui Li (=E6=9D=8E=E6=98=A5=E8=BE=89)" <chunhui.li@mediatek.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Anton Vorontsov <anton@enomsg.org>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: kernel-team@android.com
Fixes: 76d62f24db07 ("pstore: Switch pmsg_lock to an rt_mutex to avoid prio=
rity inversion")
Reported-by: "Chunhui Li (=E6=9D=8E=E6=98=A5=E8=BE=89)" <chunhui.li@mediate=
k.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Fix quoting around Chunhui Li's email name (so they are actually
  cc'ed)
* Added tested by tag
v3:
* Reworded commit message per Steven's feedback and provided more
  context for reverting in the short term.
---
 fs/pstore/pmsg.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/pstore/pmsg.c b/fs/pstore/pmsg.c
index ab82e5f05346..b31c9c72d90b 100644
--- a/fs/pstore/pmsg.c
+++ b/fs/pstore/pmsg.c
@@ -7,10 +7,9 @@
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/uaccess.h>
-#include <linux/rtmutex.h>
 #include "internal.h"
=20
-static DEFINE_RT_MUTEX(pmsg_lock);
+static DEFINE_MUTEX(pmsg_lock);
=20
 static ssize_t write_pmsg(struct file *file, const char __user *buf,
 			  size_t count, loff_t *ppos)
@@ -29,9 +28,9 @@ static ssize_t write_pmsg(struct file *file, const char _=
_user *buf,
 	if (!access_ok(buf, count))
 		return -EFAULT;
=20
-	rt_mutex_lock(&pmsg_lock);
+	mutex_lock(&pmsg_lock);
 	ret =3D psinfo->write_user(&record, buf);
-	rt_mutex_unlock(&pmsg_lock);
+	mutex_unlock(&pmsg_lock);
 	return ret ? ret : count;
 }
=20
--=20
2.40.0.rc1.284.g88254d51c5-goog

