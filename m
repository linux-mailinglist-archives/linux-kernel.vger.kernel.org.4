Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25836072D7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiJUIsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiJUIsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:48:15 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46729253BE4;
        Fri, 21 Oct 2022 01:48:06 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id i3-20020a17090a3d8300b00212cf2e2af9so1050490pjc.1;
        Fri, 21 Oct 2022 01:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtFbzFGEgnj8MZvcD2zUFjT9a7Kw7sLl1qbikDMo00I=;
        b=X133mTcEPtp6eTo/SanlPmhp2PBSPplBCPSH7T13JNOuobEB+iX+lBflUKGe5CrvsQ
         FuuL9BFCpfDFoPhF3WveZI/nf9B/iFn4pajVNWy/DILU9k8D4uvNjjhU77pN+H7aTws8
         cd+jUa2aTkph9WPdKGe3Tfo8DpNuxyDXSafmzW5JlCVrExSEswULg3q3wz9gjSDRDUAA
         +Wb3ZKHrUUek6R+Edkqic7i/6kLAHiszx2/Xm/YeOI4gg9BjTX8aRdyE6VzkN8C4+cob
         cuo7r3NaQmd32Ix/mq1QK5rT8Y2R/UBL16VgG+uYGb3pOQsAwlQ1TXPJMUYk15P40xsX
         Nb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtFbzFGEgnj8MZvcD2zUFjT9a7Kw7sLl1qbikDMo00I=;
        b=dPH8Zl+xiVCIBmIPGQGkeeYp1iR9X+Ya7lWqPOqGnBGOg71lRVAj3Z0+ggfGfKsvWw
         W3AjC45pNK0x/HRjfL4XZgI4EJB6wiEeGsP9glzxg3WBjwK06CZx/BqKr7/Z5Fkf54js
         mbDoSNGorDM/7bEDQtWM2mgEs9RrQJfLLSJN85XpbcCC5Wl4K6znF8wEuhuHtPB9d3gU
         9TqogUX+5tNm+z/VJyy8g+t43JuiH/5iDYGFBPVTwp4LZS3oP+Gh0OqChbMdCsIxsE+e
         MkiF7EmGzyvHBFvn3uDkIX0R0ngnel37kNqvuLIp3kjq69n+A1Bz5GtXnrJDyUcuJw01
         5Mow==
X-Gm-Message-State: ACrzQf19CpcDaUxsi2Zyu8Zcf6GpvJN/2TdLgZnCR4vRd9kT1Jr/fejU
        onH0PBlptIT00gtNvgmSlPPR9lmqjtvahFoh2C5ZL+vUWC8NN3fO
X-Google-Smtp-Source: AMsMyM6wajgVqmmPPm5R4ssMTt4qm+Q3WnKjidXw2HcN+UuQPjYJidvAU1kfnymddIGWBIqN2lgamOMDjtk+fdXGyS4=
X-Received: by 2002:a17:90b:390c:b0:211:6e5:6351 with SMTP id
 ob12-20020a17090b390c00b0021106e56351mr11042927pjb.158.1666342085190; Fri, 21
 Oct 2022 01:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221021073025.18831-1-wenchao.chen666@gmail.com>
 <20221021073025.18831-2-wenchao.chen666@gmail.com> <DM6PR04MB6575FC4EF5E3CF08A90279F7FC2D9@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB6575FC4EF5E3CF08A90279F7FC2D9@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Fri, 21 Oct 2022 16:47:43 +0800
Message-ID: <CA+Da2qwei0=0EH57pCC+4StijJ_NxSqHv1SkPj_PS-yzZh6hnw@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] mmc: block: Support Host to control FUA
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "kch@nvidia.com" <kch@nvidia.com>,
        "CLoehle@hyperstone.com" <CLoehle@hyperstone.com>,
        "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "s.shtylyov@omp.ru" <s.shtylyov@omp.ru>,
        "michael@allwinnertech.com" <michael@allwinnertech.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "megoo.tang@gmail.com" <megoo.tang@gmail.com>,
        "lzx.stg@gmail.com" <lzx.stg@gmail.com>
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

Avri Altman <Avri.Altman@wdc.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=8821=E6=97=
=A5=E5=91=A8=E4=BA=94 15:53=E5=86=99=E9=81=93=EF=BC=9A
>
> > From: Wenchao Chen <wenchao.chen@unisoc.com>
> >
> > This patch introduces host->fua_disable for MMC host controller.
> > The host can turn off FUA to improve performance.
> >
> > Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> > ---
> > V1 -> V2
> > Address Chaitanyak's suggestions
> > Address Avri's suggestions
> > ---
> >  drivers/mmc/core/block.c | 3 ++-
> >  include/linux/mmc/host.h | 3 +++
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
> > 54cd009aee50..333e819e077a 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -2490,7 +2490,8 @@ static struct mmc_blk_data
> > *mmc_blk_alloc_req(struct mmc_card *card,
> >             ((card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN) ||
> >              card->ext_csd.rel_sectors)) {
> >                 md->flags |=3D MMC_BLK_REL_WR;
> > -               fua_enabled =3D true;
> > +               if (!card->host->fua_disable)
> > +                       fua_enabled =3D true;
> >                 cache_enabled =3D true;
> >         }
> >         if (mmc_cache_enabled(card->host)) diff --git a/include/linux/m=
mc/host.h
> > b/include/linux/mmc/host.h index 8fdd3cf971a3..16a5bee3eeae 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -517,6 +517,9 @@ struct mmc_host {
> >         struct blk_crypto_profile crypto_profile;  #endif
> >
> > +       /* Host FUA support */
> > +       bool                    fua_disable;
> Why do you need to invent a LLD mechanism, when you already have a block =
api (QUEUE_FLAG_FUA) for that?
> Which is actually misleading, since /sys/block/mmcblk0/queue/fua will sti=
ll reads 0.
>
> Thanks,
> Avri
>
Hi Avri
The code expands as follows:
static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
      struct device *parent,
      sector_t size,
      bool default_ro,
      const char *subname,
      int area_type,
      unsigned int part_type)
{
...
if (md->flags & MMC_BLK_CMD23 &&
    ((card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN) ||
     card->ext_csd.rel_sectors)) {
md->flags |=3D MMC_BLK_REL_WR;
if (!card->host->fua_disable) <<<Allow chip manufacturers whether to use FU=
A.
fua_enabled =3D true;
cache_enabled =3D true;
}
if (mmc_cache_enabled(card->host))
cache_enabled  =3D true;

blk_queue_write_cache(md->queue.queue, cache_enabled, fua_enabled); <<<
...
}

void blk_queue_write_cache(struct request_queue *q, bool wc, bool fua)
{
if (wc)
blk_queue_flag_set(QUEUE_FLAG_WC, q);
else
blk_queue_flag_clear(QUEUE_FLAG_WC, q);
if (fua)
blk_queue_flag_set(QUEUE_FLAG_FUA, q);  <<<
else
blk_queue_flag_clear(QUEUE_FLAG_FUA, q);

wbt_set_write_cache(q, test_bit(QUEUE_FLAG_WC, &q->queue_flags));
}

Also, echo 0 > fua is forbidden regardless of permissions.
Do you have any better suggestions?

> > +
> >         /* Host Software Queue support */
> >         bool                    hsq_enabled;
> >
> > --
> > 2.17.1
>
