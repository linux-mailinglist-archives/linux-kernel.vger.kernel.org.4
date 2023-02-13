Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F89C693F7A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 09:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjBMIVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 03:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjBMIVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 03:21:47 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9A5CA1F;
        Mon, 13 Feb 2023 00:21:46 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id g18so12931932qtb.6;
        Mon, 13 Feb 2023 00:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SV07xYdDklkuzdL5Z08+pIir+ky3HbZtGe5XwggEBHU=;
        b=WMBZSy4WJMXN788KWoT29tcP/HB76TvoadjQ9xlNoBsa8VpJILF5pc6uyqONokOfVm
         beMFkoCaQnzE/MUpnSoPdWMAnSjw2OlEygZgU0MgGIsPMBpD1Vp9C1au57QjrwfTYyOT
         2pCpVQt+d9yOEDyea4oUgtextXm/B3XbZnxJdfGOL0G+4jMu12pO833hIwVdG947tUDA
         YhsFDIX8xhpU5OONuGrS4dyYTM51hq0MhX7UOQ1pQnpO49vu1A/fthM8e5XKvbShC+9Z
         MCvJ2dmItot4Q9EtPWXZDgFGH7wnZlE0uS9sWjDMkAemX8KeTEFLxWd2KpkDGulLi+Xg
         jBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SV07xYdDklkuzdL5Z08+pIir+ky3HbZtGe5XwggEBHU=;
        b=DzsQ4fOCrf2U34Hc1y0PjWgQSOTZMYzK9y0aFh727Cv8XR6QZWHAUWq2M6uIQuzkOe
         yosvrbbtlFpRTRkzUpLZIM1cdz2LEqDuDneFA2+bCUAcl7nIHkiNWGnKaZ7daYPU1WXJ
         TtfetAUtflaVRxu8BQhm0USbSaanMcshifJiWkWMFzw2HrxzctNFLIjFpS2t9YHfOwlL
         M0GM3mFcBBl12u62pmcjYakHQRPjaH8yB/XRXY4mRGCIb3dnw4JOKHSfAsd23fSJiZko
         HVgsoR7y7iVqfGQvwL6bnHcn+c/YzJLtceJvmTX8r+0uMFwadYTNHQHWxbasq7bEguAo
         2iKw==
X-Gm-Message-State: AO0yUKU2qa/JuLHVX1+RH2o0vC/8twiYwxuaOdGfSCO7nMlHJv/bvILf
        B6DZBzDoYhwYUuqFV5SVX46NyZk/8JniAlyESajo8wGvA20=
X-Google-Smtp-Source: AK7set8iEspafJIcB6kRGu7OFKyB/hfLkFaU0T0JGToJsS5AsEbKMKVm/TQGBWBBHnpPxs8iuSWRNFZytYYNFD66iU0=
X-Received: by 2002:a05:622a:11ca:b0:3b9:b35f:b4b4 with SMTP id
 n10-20020a05622a11ca00b003b9b35fb4b4mr4031279qtk.143.1676276505345; Mon, 13
 Feb 2023 00:21:45 -0800 (PST)
MIME-Version: 1.0
References: <20221021073025.18831-1-wenchao.chen666@gmail.com>
 <22499ab9-340d-7059-b3ff-45342b0810cf@intel.com> <CA+Da2qyx7McYStMysPdK-DV9qiOnb9rvXYqqugxsbVgqqX59VQ@mail.gmail.com>
 <CAPDyKFq8JXO6q+_JFhSGWoVfSUEtowUX85kJpsVMa0jmEEjOiQ@mail.gmail.com>
 <CAPDyKFqg5GuJ=ChPgtVPnhJiNT3=XHXR_q3vwLUFj4ZXoQK5-A@mail.gmail.com> <CAPDyKFrtF32AvBKCbMESP7oFT2aBhbce0KA2zzXq+szQnShbww@mail.gmail.com>
In-Reply-To: <CAPDyKFrtF32AvBKCbMESP7oFT2aBhbce0KA2zzXq+szQnShbww@mail.gmail.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Mon, 13 Feb 2023 16:21:34 +0800
Message-ID: <CA+Da2qzwKf6Nbz7YFj6i1Kj_3H8XKreapOHTBo+snNzMg2eW+g@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] mmc: block: Support Host to control FUA
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        axboe@kernel.dk, avri.altman@wdc.com, kch@nvidia.com,
        CLoehle@hyperstone.com, vincent.whitchurch@axis.com,
        bigeasy@linutronix.de, s.shtylyov@omp.ru,
        michael@allwinnertech.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, megoo.tang@gmail.com,
        lzx.stg@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 9, 2023 at 10:51 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 11 Nov 2022 at 13:04, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > [...]
> >
> > > >
> > > > Considering the data integrity, we did a random power-down test, and
> > > > the experimental results were good.
> > > >
> > > > FUA can only reduce data loss under abnormal conditions, but cannot
> > > > prevent data loss under abnormal conditions.
> > > >
> > > > I think there should be a balance between FUA and NO FUA, but
> > > > filesystems seem to favor FUA.
> > > >
> > > > FUA brings a drop in random write performance. If enough tests are
> > > > done, NO FUA is acceptable.
> > >
> > > Testing this isn't entirely easy. It requires you to hook up
> > > electrical switches to allow you to automate the powering on/off of
> > > the platform(s). Then at each cycle, really make sure to stress test
> > > the data integrity of the flash memory. Is that what the tests did -
> > > or can you elaborate a bit on what was really tested?
> > >
> > > In any case, the performance impact boils down to how each eMMC/SD
> > > card internally manages reliable writes vs regular writes. Some
> > > vendors may treat them very similarly, while others do not.
> > >
> > > That said, trying to disable REQ_FUA from an mmc host driver is the
> > > wrong approach, as also pointed out by Adrian above. These types of
> > > decisions belong solely in the mmc core layer.
> > >
> > > Instead of what the $subject series proposes, I would rather suggest
> > > we discuss (and test) whether it could make sense to disable REQ_FUA -
> > > *if* the eMMC/SD card supports a write-back-cache (REQ_OP_FLUSH) too.
> > > Hence, the mmc core could then announce only REQ_OP_FLUSH.
> > >
> >
> > Below is a simple patch that does the above. We may not want to enable
> > this for *all* eMMC/SD cards, but it works fine for testing and to
> > continue the discussions here.
> >
> >
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Date: Fri, 11 Nov 2022 12:48:02 +0100
> > Subject: [PATCH] mmc: core: Disable REQ_FUA if the card supports an internal
> >  cache
> >
> > !!!! This is not for merge, but only for test and discussions!!!
> >
> > It has been reported that REQ_FUA can be costly on some eMMC devices. A
> > potential option that could mitigate this problem, is to rely solely on
> > REQ_OP_FLUSH instead, but that requires the eMMC/SD to support an internal
> > cache. This is an attempt to try this out to see how it behaves.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/mmc/core/block.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > index db6d8a099910..197e9f6cdaad 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -2494,15 +2494,15 @@ static struct mmc_blk_data
> > *mmc_blk_alloc_req(struct mmc_card *card,
> >                         md->flags |= MMC_BLK_CMD23;
> >         }
> >
> > -       if (md->flags & MMC_BLK_CMD23 &&
> > -           ((card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN) ||
> > -            card->ext_csd.rel_sectors)) {
> > +       if (mmc_cache_enabled(card->host)) {
> > +               cache_enabled  = true;
> > +       } else if (md->flags & MMC_BLK_CMD23 &&
> > +                 (card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN ||
> > +                  card->ext_csd.rel_sectors)) {
> >                 md->flags |= MMC_BLK_REL_WR;
> >                 fua_enabled = true;
> >                 cache_enabled = true;
> >         }
> > -       if (mmc_cache_enabled(card->host))
> > -               cache_enabled  = true;
> >
> >         blk_queue_write_cache(md->queue.queue, cache_enabled, fua_enabled);
> >
> > --
> > 2.34.1
>
> Wenchao,
>
> Did you manage to try the above patch to see if that could improve the
> situation?
>

Hi Uffe,
Yes, it can solve my problem. Thank you very much.

> Kind regards
> Uffe
