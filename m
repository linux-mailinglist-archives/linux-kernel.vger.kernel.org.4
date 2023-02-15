Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AF3697F31
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 16:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjBOPN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 10:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjBOPN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:13:56 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091C386A1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:13:55 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id e1so7944051pgg.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1676474034;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oQ0LbCuOf0kYCLopxKDCXNwmSQOvf8luuEL4dfyG4EY=;
        b=muMKpgF9WDwVfhhpl/vcDJVk3jayRiebQqEw41vZyZ5mHxLcnEgoFtr1Ztoq2FO5Jh
         Ek/rn1emX1KnWj1MmbF4I6cSI51yh0IATR/l86lcncHYfIfmz1alhF9lpvk2+xa6IWZI
         yCQdjsodJMj/3qWN8LOowGkQ+oxHe7d+dGFstt/3y3grZN3pQC2k/3Y3E3pJcthzO3j3
         Y6gkKUygclE4u8jmdy5mIqxmiIMmbv4tNkS5m1J3VuFsrxlfMKstyJ6RZx9srlA2bXmF
         FWYcYymRmpRdNFu+ohN9nJIHPlZ+55TYJNfu2EtMVyGh4uJaTrNUpQvqpKCYhPy9lINj
         rDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676474034;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oQ0LbCuOf0kYCLopxKDCXNwmSQOvf8luuEL4dfyG4EY=;
        b=Ae5BljaJoo/xX/XuJ5lePWfx87FgAQjEm4ZAAE7pm4oLdbY5eNrGkzF3SqmLMiXK7J
         3AVUumKMBitfp4qecP/zNh/p7jGKiS+Zjh3ITJ541pQCRz7SToushhjUu7+bder5xYwi
         2hBCYNIwa96jkNqMaCoeh/1cpbFqCRerFMYqUojfPI1ddCoWqCPI8Y336J0zzrY9mR5l
         VJvLD37Mp5GdQwD9c0uOSizikhRu25BUMaJArZfKmntwsatDF7FrYpE90bTILql8bdb3
         CLki7W4RdY+9W7BepxKmHREzXl14kz7ItM3oSXAjPxLBNFkOLHjNj/cvoV2K/hT1blFY
         EgOg==
X-Gm-Message-State: AO0yUKXHKurkP2ZWEjve/w3pUicD/ZfmRaZvL/EyRO1fXJgJ7d+IYOb3
        J0cxUYO1mQpGVxFO8y4dDNplcPIFNVVEUWfz6hiehw==
X-Google-Smtp-Source: AK7set/g/eFa20gAKf3kxtsVZmUpCLaeNriXVYuX7Upgm3M4GNre3pJoEx60OEv1ljaKsk+is3qS/ltl6naAoP0gV24=
X-Received: by 2002:aa7:95a9:0:b0:5a8:ba5b:575 with SMTP id
 a9-20020aa795a9000000b005a8ba5b0575mr387240pfk.40.1676474034462; Wed, 15 Feb
 2023 07:13:54 -0800 (PST)
MIME-Version: 1.0
References: <20221021073025.18831-1-wenchao.chen666@gmail.com>
 <22499ab9-340d-7059-b3ff-45342b0810cf@intel.com> <CA+Da2qyx7McYStMysPdK-DV9qiOnb9rvXYqqugxsbVgqqX59VQ@mail.gmail.com>
 <CAPDyKFq8JXO6q+_JFhSGWoVfSUEtowUX85kJpsVMa0jmEEjOiQ@mail.gmail.com>
 <CAPDyKFqg5GuJ=ChPgtVPnhJiNT3=XHXR_q3vwLUFj4ZXoQK5-A@mail.gmail.com>
 <CAPDyKFrtF32AvBKCbMESP7oFT2aBhbce0KA2zzXq+szQnShbww@mail.gmail.com> <CA+Da2qzwKf6Nbz7YFj6i1Kj_3H8XKreapOHTBo+snNzMg2eW+g@mail.gmail.com>
In-Reply-To: <CA+Da2qzwKf6Nbz7YFj6i1Kj_3H8XKreapOHTBo+snNzMg2eW+g@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Feb 2023 16:13:15 +0100
Message-ID: <CAPDyKFohV6kzUgF=3-Zm_V3pWpj17b9LfTxcQ2mARrRh7RM9=A@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] mmc: block: Support Host to control FUA
To:     Wenchao Chen <wenchao.chen666@gmail.com>
Cc:     avri.altman@wdc.com, Adrian Hunter <adrian.hunter@intel.com>,
        orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, axboe@kernel.dk, kch@nvidia.com,
        CLoehle@hyperstone.com, vincent.whitchurch@axis.com,
        bigeasy@linutronix.de, s.shtylyov@omp.ru,
        michael@allwinnertech.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, megoo.tang@gmail.com,
        lzx.stg@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2023 at 09:21, Wenchao Chen <wenchao.chen666@gmail.com> wrote:
>
> On Thu, Feb 9, 2023 at 10:51 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Fri, 11 Nov 2022 at 13:04, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > [...]
> > >
> > > > >
> > > > > Considering the data integrity, we did a random power-down test, and
> > > > > the experimental results were good.
> > > > >
> > > > > FUA can only reduce data loss under abnormal conditions, but cannot
> > > > > prevent data loss under abnormal conditions.
> > > > >
> > > > > I think there should be a balance between FUA and NO FUA, but
> > > > > filesystems seem to favor FUA.
> > > > >
> > > > > FUA brings a drop in random write performance. If enough tests are
> > > > > done, NO FUA is acceptable.
> > > >
> > > > Testing this isn't entirely easy. It requires you to hook up
> > > > electrical switches to allow you to automate the powering on/off of
> > > > the platform(s). Then at each cycle, really make sure to stress test
> > > > the data integrity of the flash memory. Is that what the tests did -
> > > > or can you elaborate a bit on what was really tested?
> > > >
> > > > In any case, the performance impact boils down to how each eMMC/SD
> > > > card internally manages reliable writes vs regular writes. Some
> > > > vendors may treat them very similarly, while others do not.
> > > >
> > > > That said, trying to disable REQ_FUA from an mmc host driver is the
> > > > wrong approach, as also pointed out by Adrian above. These types of
> > > > decisions belong solely in the mmc core layer.
> > > >
> > > > Instead of what the $subject series proposes, I would rather suggest
> > > > we discuss (and test) whether it could make sense to disable REQ_FUA -
> > > > *if* the eMMC/SD card supports a write-back-cache (REQ_OP_FLUSH) too.
> > > > Hence, the mmc core could then announce only REQ_OP_FLUSH.
> > > >
> > >
> > > Below is a simple patch that does the above. We may not want to enable
> > > this for *all* eMMC/SD cards, but it works fine for testing and to
> > > continue the discussions here.
> > >
> > >
> > > From: Ulf Hansson <ulf.hansson@linaro.org>
> > > Date: Fri, 11 Nov 2022 12:48:02 +0100
> > > Subject: [PATCH] mmc: core: Disable REQ_FUA if the card supports an internal
> > >  cache
> > >
> > > !!!! This is not for merge, but only for test and discussions!!!
> > >
> > > It has been reported that REQ_FUA can be costly on some eMMC devices. A
> > > potential option that could mitigate this problem, is to rely solely on
> > > REQ_OP_FLUSH instead, but that requires the eMMC/SD to support an internal
> > > cache. This is an attempt to try this out to see how it behaves.
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >  drivers/mmc/core/block.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > > index db6d8a099910..197e9f6cdaad 100644
> > > --- a/drivers/mmc/core/block.c
> > > +++ b/drivers/mmc/core/block.c
> > > @@ -2494,15 +2494,15 @@ static struct mmc_blk_data
> > > *mmc_blk_alloc_req(struct mmc_card *card,
> > >                         md->flags |= MMC_BLK_CMD23;
> > >         }
> > >
> > > -       if (md->flags & MMC_BLK_CMD23 &&
> > > -           ((card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN) ||
> > > -            card->ext_csd.rel_sectors)) {
> > > +       if (mmc_cache_enabled(card->host)) {
> > > +               cache_enabled  = true;
> > > +       } else if (md->flags & MMC_BLK_CMD23 &&
> > > +                 (card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN ||
> > > +                  card->ext_csd.rel_sectors)) {
> > >                 md->flags |= MMC_BLK_REL_WR;
> > >                 fua_enabled = true;
> > >                 cache_enabled = true;
> > >         }
> > > -       if (mmc_cache_enabled(card->host))
> > > -               cache_enabled  = true;
> > >
> > >         blk_queue_write_cache(md->queue.queue, cache_enabled, fua_enabled);
> > >
> > > --
> > > 2.34.1
> >
> > Wenchao,
> >
> > Did you manage to try the above patch to see if that could improve the
> > situation?
> >
>
> Hi Uffe,
> Yes, it can solve my problem. Thank you very much.

Okay, that's very interesting news. I will prepare a formal patch and
make a new submission soon. Let's continue the discussion then.

Kind regards
Uffe
