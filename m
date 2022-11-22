Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D47E63379A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbiKVI4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbiKVI4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:56:14 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D8429C88
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:56:13 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id b131so16556152yba.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GVeVcflRAlez27e6Yy1ej41kSFbKOaeqYstwBqo0sw0=;
        b=PaUNwz0VYHtE6CPNRMm2gZkdyXsq8HQ1P4c9sII85PHztyT9vrnhW/QlE1KcPbH+ct
         6J510/5JrRMGsUX9+xm+2+ykGmm0WX78iFF5vaqy8rpi7crfzZlRl+klNoDPjRR+ubPu
         WPRpAp0PzbHvSGNYL/Fa7W5wZ3m40XaKf1pNJcKOGrz9Z1oZh2bILgm4ulJMm2AiBf31
         qf8sq+sZ+6c6+sJ1lzORaHt1ezEOq/lauj6uG2j4Jbd3rmbE+a/H2AYbPiicEYPQLDsW
         Gcm9hDb72ZvHgN13fHb0L7575BprVXa6QYw/iILFb0sMYYqAVUvVdAczjiaCgfoPm9V9
         Amdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GVeVcflRAlez27e6Yy1ej41kSFbKOaeqYstwBqo0sw0=;
        b=tPWxR8bJHzvmEeee/DlR5kCyRmxnkm1Odnora0+Q5J5JlEuZ864jRWlFjiO5/rVbd8
         0rrIwAj7Bw0ijVkpAepLoP7hQ/aLmdS24++sLCkY95SRgiDgh2YTzG5KBjlYhGKwwkDm
         kEx65DQgZdJn1Ah9bdm2a7x/zbg5b84B2HvoRnas6fWz9SrBMsJYA+UB8DtQdTmHJmTG
         sD8YPUuajRAVwNXDRh17Juta+Q3TM+hiHmzJtLDV3c7DdcvezUlljMpWoMyWnPMIx6kT
         0RSELJDyj22mN1zPBNiTirWtkrDkUQBP44oTMzXkpswDMBxEtmgeJBiQdiY+jJAVRaLG
         mIJA==
X-Gm-Message-State: ANoB5pmHVedlfmLBzI1hZdeCaN9Ul8p8ox8kMQSl0CBEfxikCuOIO33y
        SiEK9R2in935OiJwx/WN221D3YvQdxtRhxHH3DiSsGmx+Mmkrg==
X-Google-Smtp-Source: AA0mqf6gXyRoaLsmsKdjMs5vZkTYy1/+xlLFyoGarIw4fHvarDkkVPUtMpBnRPyuGmUd6U0DHMMLsnZ7CxWTMrmX1SU=
X-Received: by 2002:a25:d9d8:0:b0:6e4:c5c4:a62b with SMTP id
 q207-20020a25d9d8000000b006e4c5c4a62bmr3915756ybg.560.1669107371684; Tue, 22
 Nov 2022 00:56:11 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 22 Nov 2022 14:26:00 +0530
Message-ID: <CA+G9fYv-DpXNR846B0-K9wsDJVZVYE3KwioUYYLMd_Ts=gP-3w@mail.gmail.com>
Subject: next: mips: gcc-12-bcm63xx_defconfig failed
To:     open list <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org, lkft-triage@lists.linaro.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today's Linux next 20221122 tag mips bcm63xx_defconfig build fails,

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/build ARCH=mips
CROSS_COMPILE=mips-linux-gnu- 'CC=sccache mips-linux-gnu-gcc'
'HOSTCC=sccache gcc'
io_uring/io_uring.c: In function 'io_eventfd_ops':
io_uring/io_uring.c:498:17: error: implicit declaration of function
'eventfd_signal_mask'; did you mean 'eventfd_signal'?
[-Werror=implicit-function-declaration]
  498 |                 eventfd_signal_mask(ev_fd->cq_ev_fd, 1,
EPOLL_URING_WAKE);
      |                 ^~~~~~~~~~~~~~~~~~~
      |                 eventfd_signal
cc1: some warnings being treated as errors
make[3]: *** [scripts/Makefile.build:252: io_uring/io_uring.o] Error 1

log:
https://builds.tuxbuild.com/2HtTq82BIEEuUvHRpsnQuSFdite/

Build history:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221122/testrun/13121877/suite/build/test/gcc-12-bcm63xx_defconfig/history/


--
Linaro LKFT
https://lkft.linaro.org
