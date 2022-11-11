Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E86625A33
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 13:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbiKKMGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 07:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbiKKMFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 07:05:53 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA4787B32
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 04:04:38 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 130so4256114pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 04:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hNKvnx1A72K5RwpAXHyS/gpOr76KNxIuGWIGiUa+K1o=;
        b=gzpggyiSqnZoj8wbagPpUeQrhKwZVe+qS/vT3nYkezfED8RCwe0pMVog0fegpaMFAP
         xTwBZNrvq45s+fgofs7bRuvR9mLZNcWDmXYoyauOBKx2Vu/a6LIBLz34dIoUCTPYI36d
         bqIdfgUIZkuFV4eL6x0P0jvFcMSxk6tP0tZ9Sahs+ngiQlAtQrMz0Efd6D+0L9lKY4W0
         cuXjq60owHV2g82j2/RuMq3N75w5Y8vkOBxVVSLPvYXP47daAilDXwZ+dl+izSPXao3N
         XWgHwTIrK8pheUCnHAb6IMfrqYTrBnJhBdkD7HxHkultAXrghuuND63g+q0CmBgeuySf
         Q6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hNKvnx1A72K5RwpAXHyS/gpOr76KNxIuGWIGiUa+K1o=;
        b=dUQBHjeRX13Vf30LHJOudS5p0Uqrjktqdv1OvsaaxdLgAmm1b0zy3DrSC1xR3M4FdN
         sGOaHivN+mnLXEZq2gKJn1oJmWlv8nYX7LbPpmKO4+o3tpDtnHv4u2SrKuwNShaoPwVK
         76MKWUw6WrbwFtGrbqp/CZSsPaaVbU0RBUCKKPPWwp39xBs/4RM59L92Eukj9QcPZD5x
         vogEk15QN1Gz3MYNP2+PMoOWApknBZtth/Ju0cZEkM0DKno/oBXtlWgJUzlev4EyWqpy
         9sqJcV5hT6RglYw7+1j/nMF6LoA42JpJklgbDH+CHcGGjylmTAit9hQ8k2l29yzF8X41
         c/6A==
X-Gm-Message-State: ANoB5ply6hktiYqIa5cp6seqJxvSQgWKk7D7XmykHvpdgSHRHvrrBLa3
        OrqNdd2l8fxhknVR+VoYw7VHLRhT75dKBcptNWVl+w==
X-Google-Smtp-Source: AA0mqf6OV3Lj+l536SEMd+RUIiFfQ+EczjE5C2Sx0bPEOUGzr4mOu7cum0OwLHtbCDdjacvWoC/q2slWzH+7iobFtk0=
X-Received: by 2002:a63:db03:0:b0:470:4f30:f743 with SMTP id
 e3-20020a63db03000000b004704f30f743mr1382087pgg.434.1668168278472; Fri, 11
 Nov 2022 04:04:38 -0800 (PST)
MIME-Version: 1.0
References: <20221021073025.18831-1-wenchao.chen666@gmail.com>
 <22499ab9-340d-7059-b3ff-45342b0810cf@intel.com> <CA+Da2qyx7McYStMysPdK-DV9qiOnb9rvXYqqugxsbVgqqX59VQ@mail.gmail.com>
 <CAPDyKFq8JXO6q+_JFhSGWoVfSUEtowUX85kJpsVMa0jmEEjOiQ@mail.gmail.com>
In-Reply-To: <CAPDyKFq8JXO6q+_JFhSGWoVfSUEtowUX85kJpsVMa0jmEEjOiQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 11 Nov 2022 13:04:01 +0100
Message-ID: <CAPDyKFqg5GuJ=ChPgtVPnhJiNT3=XHXR_q3vwLUFj4ZXoQK5-A@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] mmc: block: Support Host to control FUA
To:     Wenchao Chen <wenchao.chen666@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, axboe@kernel.dk, avri.altman@wdc.com,
        kch@nvidia.com, CLoehle@hyperstone.com,
        vincent.whitchurch@axis.com, bigeasy@linutronix.de,
        s.shtylyov@omp.ru, michael@allwinnertech.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        megoo.tang@gmail.com, lzx.stg@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> >
> > Considering the data integrity, we did a random power-down test, and
> > the experimental results were good.
> >
> > FUA can only reduce data loss under abnormal conditions, but cannot
> > prevent data loss under abnormal conditions.
> >
> > I think there should be a balance between FUA and NO FUA, but
> > filesystems seem to favor FUA.
> >
> > FUA brings a drop in random write performance. If enough tests are
> > done, NO FUA is acceptable.
>
> Testing this isn't entirely easy. It requires you to hook up
> electrical switches to allow you to automate the powering on/off of
> the platform(s). Then at each cycle, really make sure to stress test
> the data integrity of the flash memory. Is that what the tests did -
> or can you elaborate a bit on what was really tested?
>
> In any case, the performance impact boils down to how each eMMC/SD
> card internally manages reliable writes vs regular writes. Some
> vendors may treat them very similarly, while others do not.
>
> That said, trying to disable REQ_FUA from an mmc host driver is the
> wrong approach, as also pointed out by Adrian above. These types of
> decisions belong solely in the mmc core layer.
>
> Instead of what the $subject series proposes, I would rather suggest
> we discuss (and test) whether it could make sense to disable REQ_FUA -
> *if* the eMMC/SD card supports a write-back-cache (REQ_OP_FLUSH) too.
> Hence, the mmc core could then announce only REQ_OP_FLUSH.
>

Below is a simple patch that does the above. We may not want to enable
this for *all* eMMC/SD cards, but it works fine for testing and to
continue the discussions here.


From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 11 Nov 2022 12:48:02 +0100
Subject: [PATCH] mmc: core: Disable REQ_FUA if the card supports an internal
 cache

!!!! This is not for merge, but only for test and discussions!!!

It has been reported that REQ_FUA can be costly on some eMMC devices. A
potential option that could mitigate this problem, is to rely solely on
REQ_OP_FLUSH instead, but that requires the eMMC/SD to support an internal
cache. This is an attempt to try this out to see how it behaves.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/block.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index db6d8a099910..197e9f6cdaad 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2494,15 +2494,15 @@ static struct mmc_blk_data
*mmc_blk_alloc_req(struct mmc_card *card,
                        md->flags |= MMC_BLK_CMD23;
        }

-       if (md->flags & MMC_BLK_CMD23 &&
-           ((card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN) ||
-            card->ext_csd.rel_sectors)) {
+       if (mmc_cache_enabled(card->host)) {
+               cache_enabled  = true;
+       } else if (md->flags & MMC_BLK_CMD23 &&
+                 (card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN ||
+                  card->ext_csd.rel_sectors)) {
                md->flags |= MMC_BLK_REL_WR;
                fua_enabled = true;
                cache_enabled = true;
        }
-       if (mmc_cache_enabled(card->host))
-               cache_enabled  = true;

        blk_queue_write_cache(md->queue.queue, cache_enabled, fua_enabled);

-- 
2.34.1

Kind regards
Uffe
