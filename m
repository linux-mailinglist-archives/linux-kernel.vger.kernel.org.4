Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44946C81BC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjCXPrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjCXPrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:47:01 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DCA1BD8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:46:57 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5416698e889so40437747b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679672817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NbMU26KvuDhxRgS5BOOObuB6VM/WTbVMpAKkjnkzln4=;
        b=tDh/YhuOk5MCCESde0mwLUN2BM1Dl78t7pzTqGBP9gGT6jOMYEpc+CRHwZX5mzF8k8
         G3yLu/rV1fzHghME0JzOx5ym1akTHmDTITeWXNib3v8Girj/HudNG0P3TRI6UkSD8LYa
         ohvdkjbro+niCkywe81tZrIVijZfwEFwlzEEoKz8DJAR5vYY6W9GtvRvS7dkQy9NEolC
         CHjWutu/1tUWd8Q/iODL4HUNL0U+VshrMfE1bGDkbYL8iro6rEfRXrli2843wuaF0ibK
         pLrdgjdb7P4RdOR0e4XVJmJQosMHFo6mcEgsCbw0pZQFBhZfdzVqOHIjFmREgMdXWaql
         aDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679672817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NbMU26KvuDhxRgS5BOOObuB6VM/WTbVMpAKkjnkzln4=;
        b=LL1RQ5+4TR38wfk9/ia5PBa62Toeg4FNNCWkSP5C76TpiCImm7YZukp9QFf2kCGoXE
         Ub13xX81vAImq1Trsx0IvN5v7QTXzLDNzaFYp/tLaJVXRDFbBW7LZLqDiz9B7g+EPjFi
         K2Zz6f5eu33/LjMKBUHQLMqtUqOpbtQksVHZsZHvAvPw3nvZc4sR0RZznF6jApVlecI1
         5IWtylSp018VfIN0QNHg9BYG3fLpegeAnK2idNgYRn7W3YtjLs3FRFErCXgksgcLSRoC
         H3R2ZpgmgEY9i+lvws5o1KyhPaMiZ1+Eg3ayXLI26Cnf5f58tPod43JLFjOgtKreoNHe
         08fA==
X-Gm-Message-State: AAQBX9cmwFH17zgg3v2CWZvfflHqASbXT8bRTsjOjpnZhxRsEbVcHk9K
        62bq2iuul5CwEd37yWW/8lWR67JKbT2xHzmR0eEH6Q==
X-Google-Smtp-Source: AKy350ZrRmEOfSH9HdqIpxODwcFPtiWHoT78R7Alcg8WWhH4HeDKnIqzoPGfqP55wsLi0hO4jXGqCNIiHfxxN53t7AM=
X-Received: by 2002:a81:ae23:0:b0:52b:fd10:4809 with SMTP id
 m35-20020a81ae23000000b0052bfd104809mr1306472ywh.0.1679672815533; Fri, 24 Mar
 2023 08:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230324132858eucas1p25cdd6af81a14bf40474f58fa16d087f5@eucas1p2.samsung.com>
 <20230317064729.24407-1-yuzhe@nfschina.com> <5b555935-5657-3f38-8a55-906dd32ad052@samsung.com>
In-Reply-To: <5b555935-5657-3f38-8a55-906dd32ad052@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 24 Mar 2023 16:46:19 +0100
Message-ID: <CAPDyKFotp50rbyFqBzk28iXFVqUnXry5XzyA-jrBKVrDW3_a-A@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: remove unnecessary (void*) conversions
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Yu Zhe <yuzhe@nfschina.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        liqiong@nfschina.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Mar 2023 at 14:28, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> On 17.03.2023 07:47, Yu Zhe wrote:
> > Pointer variables of void * type do not require type cast.
> >
> > Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
> > ---
> >   drivers/mmc/core/debugfs.c  | 2 +-
> >   drivers/mmc/core/host.c     | 2 +-
> >   drivers/mmc/core/mmc_test.c | 6 +++---
> >   3 files changed, 5 insertions(+), 5 deletions(-)
> ...
> > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > index 096093f7be00..76900f67c782 100644
> > --- a/drivers/mmc/core/host.c
> > +++ b/drivers/mmc/core/host.c
> > @@ -590,7 +590,7 @@ EXPORT_SYMBOL(mmc_alloc_host);
> >
> >   static void devm_mmc_host_release(struct device *dev, void *res)
> >   {
> > -     mmc_free_host(*(struct mmc_host **)res);
> > +     mmc_free_host(res);
>
> The above chunk is wrong and causes following regression on today's
> Linux next-20230324:
>
> Unable to handle kernel paging request at virtual address 0000000000001020
> Mem abort info:
> meson-gx-mmc ffe07000.mmc: allocated mmc-pwrseq
> ...
> [0000000000001020] user address but active_mm is swapper
> Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 3 PID: 10 Comm: kworker/u12:0 Not tainted 6.3.0-rc3-next-20230324+
> #13452
> Hardware name: Khadas VIM3 (DT)
> Workqueue: events_unbound async_run_entry_fn
> pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : mmc_pwrseq_free+0x1c/0x38
> lr : devm_mmc_host_release+0x1c/0x34
> ...
> Call trace:
>   mmc_pwrseq_free+0x1c/0x38
>   devm_mmc_host_release+0x1c/0x34
>   release_nodes+0x5c/0x90
>   devres_release_all+0x8c/0xdc
>   device_unbind_cleanup+0x18/0x68
>   really_probe+0x11c/0x2b4
>   __driver_probe_device+0x78/0xe0
>   driver_probe_device+0xd8/0x160
>   __device_attach_driver+0xb8/0x138
>   bus_for_each_drv+0x84/0xe0
>   __device_attach_async_helper+0xb0/0xd4
>   async_run_entry_fn+0x34/0xe0
>   process_one_work+0x288/0x5c0
>   worker_thread+0x74/0x450
>   kthread+0x124/0x128
>   ret_from_fork+0x10/0x20
> Code: f9000bf3 aa0003f3 f9424c00 b4000080 (f9401000)
> ---[ end trace 0000000000000000 ]---
>
> Ulf: do You want me to send a partial revert or will you handle it by
> dropping this patch?

Thanks for the report, I will simply drop the patch!

Kind regards
Uffe
