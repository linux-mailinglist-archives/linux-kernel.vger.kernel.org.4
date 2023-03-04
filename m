Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CA16AA7C2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 04:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjCDDKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 22:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDDKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 22:10:40 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDA7D30D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 19:10:39 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id h14-20020aa786ce000000b005a89856900eso2258338pfo.14
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 19:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677899439;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s3BTWvMS4HbVHXG0hGuYCfsLy+8T8n3QOZ6K5OLKcZQ=;
        b=PYqykcRThs1t2MTEZDoAFl2N5+VjqJGMnW4HMnvWS5uOUbY6+X687w0oTX07D/azgz
         +9MjpV47JZw4tR4ecQ3S7yLACiD9m8QM1crbz18tu9WFwPuTN7MvLN8jkGt9DMdWbk55
         oju/xXXYD5qYZO6V9v5FSJWt9KBOZ5Kb8HkaIq8EbdSam0foeEdV9qIH0UYc8w1SyF/E
         Kevi/X8l+7oEpr3p9BGJvNBLne2WwG4/C42JbHnPNh76yw9vpytxaQBOEXnPEuWb6+Fk
         wxrLYk5D+aJjgWOBbt9ao0wkkJ1EM91CqdH5sHAUKGqpMm2xewGwnREgxkg/7lL5tLC8
         oVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677899439;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s3BTWvMS4HbVHXG0hGuYCfsLy+8T8n3QOZ6K5OLKcZQ=;
        b=i96JRE2SCJ705mdrEwxMr3d0dfYMvAPWxf/LXxdmKoWVWU6RaASOxssgXcNU7rj1jv
         ioUQUyykppJDn5wQS9ppDdR5uxTpHP3FyWgiSmr88PB21t30/omL01ydUagjcNZjUDv5
         QETvvudxNDVs5O8VRm3hm/VkzIpCgqs9zTT7sTCd4k7HLHNVyic+34j82FY1Mqju1qe5
         x2bG0/VmyIJ/YQA+VrSr6u3ZYhb+s10bICHbRCRgLZkIW7TFFur3P9D/IxZA8aC5ol4e
         GVnPWfiXURgDlMszWy83ZRRKMznXoLc0SB9+Fi1qic0AlZQFd0w/Lo3Mm+AIhr90j04t
         JkrA==
X-Gm-Message-State: AO0yUKW+YD/mKNLmIgf+DBCZDIKEAgORuZfGMjNe5Aw2x96gdlEUlsQt
        gKJLYdl2B+fPZrPkoIKiaQ3ZHHtJIh60p7L+yJnPXuWVVhmnhPAy8b7M7f8xHiUiy2zJ9Thml0Q
        E0TyVBhz+IjWeOIaueF5ehMXZewx/8ixM4sPKwYghymym4/3JRLovr6dcpqsP5w05/aki6OA=
X-Google-Smtp-Source: AK7set84JZ0dONAReFiSD1tjandDarkPmUACRbw07MLU8dza9zwdqMI1V7uoPqo7C/3teqgwwB046pAfYFxb
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:903:2587:b0:19a:9f86:adab with SMTP id
 jb7-20020a170903258700b0019a9f86adabmr1474639plb.7.1677899439077; Fri, 03 Mar
 2023 19:10:39 -0800 (PST)
Date:   Sat,  4 Mar 2023 03:10:29 +0000
In-Reply-To: <20230302062741.483079-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230302062741.483079-1-jstultz@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230304031029.3037914-1-jstultz@google.com>
Subject: [PATCH v2] pstore: Revert pmsg_lock back to a normal mutex
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

Normal mutexes can do adaptive spinning, which keeps the
contention overhead fairly low maybe adding on the order of 10s
of us delay waiting, but the slowpath w/ rt_mutexes makes the
blocked tasks sleep & wake. This makes matters worse when there
is heavy contentention, as it just allows additional threads to
run and line up to try to take the lock.

It devolves to a worse case senerio where the lock acquisition
and scheduling overhead dominates, and each thread is waiting on
the order of ~ms to do ~us of work.

Obviously, having tons of threads all contending on a single
lock for logging is non-optimal, so the proper fix is probably
reworking pstore pmsg to have per-cpu buffers so we don't have
contention.

But in the short term, lets revert the change to the rt_mutex
and go back to normal mutexes to avoid a potentially major
performance regression.

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
Tested-by: Chunhui Li <chunhui.li@mediatek.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
I know Steven is working on a fix to address the rtmutex not
spinning, but as the earlier version of it didn't resolve the
issue for Chunhui Li, I wanted to resend this out again w/
Tested-by tags, so it is ready to go if needed. I am looking
to get a local reproducer so I can help validate Steven's
efforts.

v2:
* Fix quoting around Chunhui Li's email name (so they are actually
  cc'ed)
* Added tested by tag
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
2.40.0.rc0.216.gc4246ad0f0-goog

