Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4CD6B4CCC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjCJQZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjCJQY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:24:57 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC7312E17C;
        Fri, 10 Mar 2023 08:21:11 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id d10so3337805pgt.12;
        Fri, 10 Mar 2023 08:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678465270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tce33vCbFy2piWYjszLGPYr26Mk1bkIeMdGc2bqTnCY=;
        b=V8ePciQ5nJnjCh+YmazeiTonIq0t2zqt++Ap6PBwZdnAYYFwCHKUBLMzz0sSc3rpvC
         9NICRaidcyhGUbDeEDjZevkYRJd45qG6wQ4Hd9OfX5r5KaAantg5jnwlWX+Lvs1cm0Pz
         us0Z6ngc4+sDdZlzqOGKQRN2ITUXFCB1fNXDjPS3++4yhQhod+bRUYbdfe/Ip0NKckDy
         /CAp7Xbw42aOd7QOBehQH2HXhNL4ehzETi45Q6dzXJd9AYZBPG02YL3VMguSJSNGCRv/
         l4AGZFUVAWqCb5R8CXsXA7bsltCzW6xGwaeCpbtda6HzEsqaLbVy+ew/u4SUsqOHto9V
         /xug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678465270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tce33vCbFy2piWYjszLGPYr26Mk1bkIeMdGc2bqTnCY=;
        b=zT1NZI/YCnKvRCMKrwxLcUqJli0HIzWJ/n2xPoIsasNvEgwQpk5xrMvshZxtvfVnhr
         8JgKgHHXfoty6Fj+YRarvUTMXksAQD6qB1jubZB6Ek7O5tvQBsNKq+C+0ct1KeGklldI
         QrF90syRL8F1rAewg7+eRdJEC2pFKjHfrv/8qjwod5hwpL2j+4r+Lt+54GLtfRdv9Uz2
         zKTwZ6nd85S+GPojjdRGUBFRbo5hmYeX1bY8RLpN8m/VJWuJbwb9qp2iH4ZjLxLJh1Ez
         rA98ahN+EYdQt9Ldc1gNWX8NEuEQu/ICszZshc2+4ttnRDg0wjkgW2gNwOghmJGaOV1B
         uCyA==
X-Gm-Message-State: AO0yUKU0zdjBGbrKI9YM1vOBMSF2nCLdx3b8b/RLP5u/DDxmfiRQ6nM7
        Un8qn/RQ9j9gFzVEhuZ+kwrgMbz6NDdcHX9KXrQ=
X-Google-Smtp-Source: AK7set9Sb8LBI2AA+UOnwXJRH1Ba+Ey+Cfe/tFhR7YNvszZRy/uKp2U0hS4KuDrki3gn+ogO5kZNUNvWO0OSP2G7NlE=
X-Received: by 2002:a63:7f1a:0:b0:4d9:8f44:e1d7 with SMTP id
 a26-20020a637f1a000000b004d98f44e1d7mr9265257pgd.4.1678465270216; Fri, 10 Mar
 2023 08:21:10 -0800 (PST)
MIME-Version: 1.0
References: <20230307164338.1246287-1-zyytlz.wz@163.com> <CAPDyKFoV9aZObZ5GBm0U_-UVeVkBN_rAG-kH3BKoP4EXdYM4bw@mail.gmail.com>
In-Reply-To: <CAPDyKFoV9aZObZ5GBm0U_-UVeVkBN_rAG-kH3BKoP4EXdYM4bw@mail.gmail.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Sat, 11 Mar 2023 00:20:57 +0800
Message-ID: <CAJedcCxrXuDjj_hGz7wizmfu1A9PNguNRNT85YVmkAHCG7ynYQ@mail.gmail.com>
Subject: Re: [PATCH] memstick: r592: Fix UAF bug in r592_remove due to race condition
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Zheng Wang <zyytlz.wz@163.com>, maximlevitsky@gmail.com,
        oakad@yahoo.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ulf Hansson <ulf.hansson@linaro.org> =E4=BA=8E2023=E5=B9=B43=E6=9C=889=E6=
=97=A5=E5=91=A8=E5=9B=9B 23:02=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 7 Mar 2023 at 17:44, Zheng Wang <zyytlz.wz@163.com> wrote:
> >
> > In r592_probe, dev->detect_timer was bound with r592_detect_timer.
> > In r592_irq function, the timer function will be invoked by mod_timer.
> >
> > If we remove the module which will call hantro_release to make cleanup,
> > there may be a unfinished work. The possible sequence is as follows,
> > which will cause a typical UAF bug.
> >
> > Fix it by canceling the work before cleanup in r592_remove.
> >
> > CPU0                  CPU1
> >
> >                     |r592_detect_timer
> > r592_remove         |
> >   memstick_free_host|
> >   put_device;       |
> >   kfree(host);      |
> >                     |
> >                     | queue_work
> >                     |   &host->media_checker //use
> >
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
>
> Applied for next, thanks!
>
Sorry for my late reply and thanks for your effort!

Best regards,
Zheng
>
>
> > ---
> >  drivers/memstick/host/r592.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.=
c
> > index 1d35d147552d..2bfa7eaae80a 100644
> > --- a/drivers/memstick/host/r592.c
> > +++ b/drivers/memstick/host/r592.c
> > @@ -829,7 +829,7 @@ static void r592_remove(struct pci_dev *pdev)
> >         /* Stop the processing thread.
> >         That ensures that we won't take any more requests */
> >         kthread_stop(dev->io_thread);
> > -
> > +       del_timer_sync(&dev->detect_timer);
> >         r592_enable_device(dev, false);
> >
> >         while (!error && dev->req) {
> > --
> > 2.25.1
> >
