Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF64F6B5D9C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 17:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjCKQA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 11:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjCKQA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 11:00:57 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF8E199C1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 08:00:55 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id ek18so1347712edb.6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 08:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678550453;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zH3H4cxNgLOQ6PFJEhsV6rqCe5ksnzMYlcew81Qs5YU=;
        b=PngSGwZsDShXVr2eFlFeY3I3Tx3pEZMIXHzH2KD0FPx/YRHaQFK4BHmTnrdTZUZhu9
         EJsgCESZcnTR0HvbFH+XnfWR6n7Vnqo43C9o0+biTBKUI8RNSXsTyK0kWe+X3Xno8jmY
         tDCl4MwDroXcXFz+l6Uz++zEVfGuqjRf06N0Rq1QV+Quh8SUcDQfg19xsfkn1V0Giumd
         EsuZnnRxKdoKAYFjDHuc9Emk78nxs8+D0M86lo2RYxrBCmoKc14MiPtr0gugSY6onjtz
         QH9R9mSaCVOLd3GnF4c2/DYzkxXIPP4ZJ5zPYmjSQUjMQMz7IU3bpRtUmjv0WQdkhdud
         jPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678550453;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zH3H4cxNgLOQ6PFJEhsV6rqCe5ksnzMYlcew81Qs5YU=;
        b=RxLcfdnCIZiUmuL4GtkcpUVTIddhhKY0vOJ55NXTNmg+Uc75AieR061adQjvhe05Vw
         06VbGj3DA8XQAuZ08CounQmPYUjt/4sbgO0yrD93LG7RpHOHxYByvkXjgMQ5JxwtkaG7
         JlNlC/Xwwkn5cGmjPNPoRV4g7dh2d6VOrKNkFPPyvH3cXJxMqEx4rdUJQBGdc6dcPLgJ
         SV6dCSSlQ0xXZUCsKpVArcB55NQwIJO44KuSE3QwCwkqr8g7vsAB6/Tn3AIj00OBo4NM
         n12vSLZupWbs1S2w7Y1B6xygEByMibe+c2N85Ve4cM2bvcijDfiadkZL1gE7ajWTrDBw
         /g9g==
X-Gm-Message-State: AO0yUKXbJyFiK2TAmtp8X6zziIjc4G/kydkMsLgVz+fd170Z2DViMUrX
        MlBGzCvyew+Krd+S0cK979XBdrxFOlC7pnnFJ6pvTGYFb98=
X-Google-Smtp-Source: AK7set+TKUXSTGTiK6vs4/Gq44oEikuQzFpxn3fDuxxc/wOcRb/CJkPOocwIsXWXzOAOPvdq60nsIDFnb5YmDd+1kI0=
X-Received: by 2002:a50:baa6:0:b0:4ad:6052:ee90 with SMTP id
 x35-20020a50baa6000000b004ad6052ee90mr15939167ede.7.1678550453304; Sat, 11
 Mar 2023 08:00:53 -0800 (PST)
MIME-Version: 1.0
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Sat, 11 Mar 2023 21:30:40 +0530
Message-ID: <CAHP4M8UEnLeTbrR1fZOJ2KkRAHLJLewjT2xg78AzzoXPYcz-hA@mail.gmail.com>
Subject: How to resolve "nptl-signals.h : no such file or directory"
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All.

(Sorry had to write to this list, as the subscription to
gdb@sourcewave.org seemingly went successful, but never got the
confirmation email. Even sending emails get bounced).


I have been trying to analyze a core, but unable to receive the
complete backtrace due to following error :

#######################################
#0  0x0088ad6c in __libc_signal_restore_set (set=0xf48f2a78) at
../sysdeps/unix/sysv/linux/nptl-signals.h:79
79 ../sysdeps/unix/sysv/linux/nptl-signals.h: No such file or directory.
#######################################


Following is the (incomplete) backtrace :

#######################################
[Current thread is 1 (LWP 7491)]
(gdb) bt
#0  0x0088ad6c in __libc_signal_restore_set (set=0xf48f2a78) at
../sysdeps/unix/sysv/linux/nptl-signals.h:79
#1  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:48
#2  0x0088cb78 in __GI_abort () at abort.c:89
#3  <frame with modified names> 0x049b3a54 in func_1 (ffp=<optimized
out>, base_name=<optimized out>, max_size=<optimized out>,
file_type=<optimized out>)  at a/b/c/d/e:58
#4  0x00000270 in ?? ()
(gdb)
#######################################


Since GDB is able to find raise.c, I did a full base-machine search
for it, via :

#######################################
find / -name raise.c 2> /dev/null
#######################################

but could not find raise.c either on the base-machine filesystem.


So, following are my queries :

1.
Where are raise.c, nptl-signals.h etc. supposed to reside?

2.
How can we bring back the missing nptl-signals.h file?


Will be grateful for pointers.


Thanks and Regards,
Ajay
