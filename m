Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41BC7462BB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjGCSub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjGCSu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:50:26 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28B9AF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 11:50:24 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51d88f1c476so5381346a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 11:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688410223; x=1691002223;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v/Js8VLPKcY4R7tFeWhtxKSPO3UEHt5SG8Y0Ax2v4Pk=;
        b=bz2iuDPuHJBsvNjtnAu4HmNpZw1WcrDmPJXKR3ToKFAgVI7XKv3BQ5T+3a2waZItXZ
         rL4r/bqBKLhyLSg0aXINFXFz3FmgD7K53AOTHtphuY9fWwlsw7YKvjp3OjBm1RzCKBPF
         uVRDMrSRQndcqJElFlU2TOACtLq4RylhnyG2R1uAwFutB8KILKFZAugjrHv9sFMxNs3F
         gun2mkxmdncK35MdDInxMtPBSv5DH/Wm+AR3Fsz2cxz+ZKTa1v9MCT/EX7yyk4seqfsF
         55VL2lwf5rXYj9Dq3AqhWsHFdTWEp8KMJCmBDYO2cmcdPItjPm7oBls/zdYQPpydCKHc
         638A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688410223; x=1691002223;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v/Js8VLPKcY4R7tFeWhtxKSPO3UEHt5SG8Y0Ax2v4Pk=;
        b=UnuszYPwvJ9fEXzE4Nd+BoUSxKf36fk/MMlpvued2juh5qWd9GG9Ydu0sjCxoq2uba
         iQOJe2mnsKVR3iZYVzav3BhdXmoewqVPrXymAruA5mJBWoUJGdVseC9lwzB3HK1BYNaF
         SI8mw54DcEw1dFpkgLiajSc77Ao47trMTQqK2pVgAKZulpzPzvOnZ2pLqk9mo5q7Kk5u
         hHaZtRWmaS61S3VL56UNyiBySD0ZEP/afsTrAeUU6gZ6Ve6qzpO3p2NvP074JxOTW36F
         Ga3kqpud2vbT1HcC3kfufOoSzQt3tXdlqr1cOIWAu1A4nqZcACBEtdweviMzW9AtX34w
         nskg==
X-Gm-Message-State: ABy/qLZHbzjNDelA3nXjr/eZrAu3gPVvWM3H7mqQWiZFevnv12tqdh0s
        /W9C7JbElNOtZuDT86qBwwnki+nn0C5NeYVkLuvPOoZLErwFfg==
X-Google-Smtp-Source: APBJJlHlWDubw57xpNwRzg2IXLS0x+wS4I7tss9B6qPIsHdSp7wK+N7Kr2icyOdAnCZqUQD2qGEB8prmYuZmPuxOldU=
X-Received: by 2002:aa7:cc92:0:b0:51d:92bf:e6b9 with SMTP id
 p18-20020aa7cc92000000b0051d92bfe6b9mr7432164edt.34.1688410222987; Mon, 03
 Jul 2023 11:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230419-dynamic-vmon-v4-0-4d3734e62ada@skidata.com>
 <20230419-dynamic-vmon-v4-9-4d3734e62ada@skidata.com> <7097865e-d31b-099a-8b53-9e7264c64cd2@gmail.com>
In-Reply-To: <7097865e-d31b-099a-8b53-9e7264c64cd2@gmail.com>
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Mon, 3 Jul 2023 20:50:11 +0200
Message-ID: <CAJpcXm4oqNcmU5__w4apNwa32aNEpAEjOb=4bZbwTUhYMCjueQ@mail.gmail.com>
Subject: Re: [PATCH RFC v4 09/13] regulator: implement mon_disable_reg_disabled
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        support.opensource@diasemi.com,
        DLG-Adam.Ward.opensource@dm.renesas.com,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti!

On Mon, 3 Jul 2023 at 12:31, Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> I hope your train back to home was not delayed too much ;)

Yes, much better this time :)

> On 6/20/23 23:03, Benjamin Bara wrote:
> > From: Benjamin Bara <benjamin.bara@skidata.com>
> >
> > The mon_disable_reg_disabled
>
> The name of this always makes me to scratch my head a bit. (or, maybe it
> is just the sunburns at my bald).
>
> Do you think making it:
> mon_disable_at_reg_disable or mon_disable_when_reg_disabled would be too
> long?

mons_to_disable_while_reg_off maybe fits better, or mons_off_while_reg_off.
Still not satisfied though, I will think about it - maybe something
better comes to
my mind.

> > property disables all dt-enabled monitors
> > before a regulator is disabled. If an error occurs while disabling the
> > regulator, the monitors are enabled again.
> >
> > Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> > ---
> >   drivers/regulator/core.c | 19 ++++++++++++++-----
> >   1 file changed, 14 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> > index 873e53633698..b37dcafff407 100644
> > --- a/drivers/regulator/core.c
> > +++ b/drivers/regulator/core.c
> > @@ -2965,7 +2965,7 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
> >
> >       trace_regulator_enable_complete(rdev_get_name(rdev));
> >
> > -     return 0;
> > +     return monitors_reenable(rdev, rdev->desc->mon_disable_reg_disabled);
>
> As I wrote in my comment to previous patch, I might find the logic a bit
> more clear if the condition check was done here. Eg:
>
>         if (rdev->desc->mon_disable_when_reg_disabled)
>                 return monitors_reenable(...);
>
>         return 0;

Yes, thanks. I applied this to all the mentioned occasions.

> >   }
> >
> >   /**
> > @@ -3124,8 +3124,13 @@ EXPORT_SYMBOL_GPL(regulator_enable);
> >
> >   static int _regulator_do_disable(struct regulator_dev *rdev)
> >   {
> > +     const struct regulator_desc *desc = rdev->desc;
> >       int ret;
> >
> > +     ret = monitors_disable(rdev, desc->mon_disable_reg_disabled);
> > +     if (ret)
> > +             return ret;
>
> Similarly, for me the logic would be easier to follow if this was:
>
>         if (desc->mon_disable_when_reg_disabled)
>                 monitors_disable(...);
>
> > +
> >       trace_regulator_disable(rdev_get_name(rdev));
> >
> >       if (rdev->ena_pin) {
> > @@ -3136,13 +3141,13 @@ static int _regulator_do_disable(struct regulator_dev *rdev)
> >                       rdev->ena_gpio_state = 0;
> >               }
> >
> > -     } else if (rdev->desc->ops->disable) {
> > -             ret = rdev->desc->ops->disable(rdev);
> > +     } else if (desc->ops->disable) {
> > +             ret = desc->ops->disable(rdev);
> >               if (ret != 0)
> >                       return ret;
> >       }
> >
> > -     if (rdev->desc->off_on_delay)
> > +     if (desc->off_on_delay)
> >               rdev->last_off = ktime_get_boottime();
> >
> >       trace_regulator_disable_complete(rdev_get_name(rdev));
> > @@ -3180,6 +3185,7 @@ static int _regulator_disable(struct regulator *regulator)
> >                               _notifier_call_chain(rdev,
> >                                               REGULATOR_EVENT_ABORT_DISABLE,
> >                                               NULL);
> > +                             monitors_reenable(rdev, rdev->desc->mon_disable_reg_disabled);
>
> same here,
>
> >                               return ret;
> >                       }
> >                       _notifier_call_chain(rdev, REGULATOR_EVENT_DISABLE,
> > @@ -3246,6 +3252,7 @@ static int _regulator_force_disable(struct regulator_dev *rdev)
> >               rdev_err(rdev, "failed to force disable: %pe\n", ERR_PTR(ret));
> >               _notifier_call_chain(rdev, REGULATOR_EVENT_FORCE_DISABLE |
> >                               REGULATOR_EVENT_ABORT_DISABLE, NULL);
> > +             monitors_reenable(rdev, rdev->desc->mon_disable_reg_disabled);
>
> here...
>
> >               return ret;
> >       }
> >
> > @@ -6422,8 +6429,10 @@ static int regulator_late_cleanup(struct device *dev, void *data)
> >                */
> >               rdev_info(rdev, "disabling\n");
> >               ret = _regulator_do_disable(rdev);
> > -             if (ret != 0)
> > +             if (ret != 0) {
> >                       rdev_err(rdev, "couldn't disable: %pe\n", ERR_PTR(ret));
> > +                     monitors_reenable(rdev, rdev->desc->mon_disable_reg_disabled);
>
> ... and here.
> > +             }
> >       } else {
> >               /* The intention is that in future we will
> >                * assume that full constraints are provided
> >
>
> These were just very minor things. Mostly looks good for me.

Thanks!
Benjamin

> Yours,
>         -- Matti
>
> --
> Matti Vaittinen
> Linux kernel developer at ROHM Semiconductors
> Oulu Finland
>
> ~~ When things go utterly wrong vim users can always type :help! ~~
>

On Mon, 3 Jul 2023 at 12:31, Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>
> Hi deeee Ho Benjamin,
>
> I hope your train back to home was not delayed too much ;)
>
> On 6/20/23 23:03, Benjamin Bara wrote:
> > From: Benjamin Bara <benjamin.bara@skidata.com>
> >
> > The mon_disable_reg_disabled
>
> The name of this always makes me to scratch my head a bit. (or, maybe it
> is just the sunburns at my bald).
>
> Do you think making it:
> mon_disable_at_reg_disable or mon_disable_when_reg_disabled would be too
> long?
>
> > property disables all dt-enabled monitors
> > before a regulator is disabled. If an error occurs while disabling the
> > regulator, the monitors are enabled again.
> >
> > Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> > ---
> >   drivers/regulator/core.c | 19 ++++++++++++++-----
> >   1 file changed, 14 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> > index 873e53633698..b37dcafff407 100644
> > --- a/drivers/regulator/core.c
> > +++ b/drivers/regulator/core.c
> > @@ -2965,7 +2965,7 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
> >
> >       trace_regulator_enable_complete(rdev_get_name(rdev));
> >
> > -     return 0;
> > +     return monitors_reenable(rdev, rdev->desc->mon_disable_reg_disabled);
>
> As I wrote in my comment to previous patch, I might find the logic a bit
> more clear if the condition check was done here. Eg:
>
>         if (rdev->desc->mon_disable_when_reg_disabled)
>                 return monitors_reenable(...);
>
>         return 0;
>
> >   }
> >
> >   /**
> > @@ -3124,8 +3124,13 @@ EXPORT_SYMBOL_GPL(regulator_enable);
> >
> >   static int _regulator_do_disable(struct regulator_dev *rdev)
> >   {
> > +     const struct regulator_desc *desc = rdev->desc;
> >       int ret;
> >
> > +     ret = monitors_disable(rdev, desc->mon_disable_reg_disabled);
> > +     if (ret)
> > +             return ret;
>
> Similarly, for me the logic would be easier to follow if this was:
>
>         if (desc->mon_disable_when_reg_disabled)
>                 monitors_disable(...);
>
> > +
> >       trace_regulator_disable(rdev_get_name(rdev));
> >
> >       if (rdev->ena_pin) {
> > @@ -3136,13 +3141,13 @@ static int _regulator_do_disable(struct regulator_dev *rdev)
> >                       rdev->ena_gpio_state = 0;
> >               }
> >
> > -     } else if (rdev->desc->ops->disable) {
> > -             ret = rdev->desc->ops->disable(rdev);
> > +     } else if (desc->ops->disable) {
> > +             ret = desc->ops->disable(rdev);
> >               if (ret != 0)
> >                       return ret;
> >       }
> >
> > -     if (rdev->desc->off_on_delay)
> > +     if (desc->off_on_delay)
> >               rdev->last_off = ktime_get_boottime();
> >
> >       trace_regulator_disable_complete(rdev_get_name(rdev));
> > @@ -3180,6 +3185,7 @@ static int _regulator_disable(struct regulator *regulator)
> >                               _notifier_call_chain(rdev,
> >                                               REGULATOR_EVENT_ABORT_DISABLE,
> >                                               NULL);
> > +                             monitors_reenable(rdev, rdev->desc->mon_disable_reg_disabled);
>
> same here,
>
> >                               return ret;
> >                       }
> >                       _notifier_call_chain(rdev, REGULATOR_EVENT_DISABLE,
> > @@ -3246,6 +3252,7 @@ static int _regulator_force_disable(struct regulator_dev *rdev)
> >               rdev_err(rdev, "failed to force disable: %pe\n", ERR_PTR(ret));
> >               _notifier_call_chain(rdev, REGULATOR_EVENT_FORCE_DISABLE |
> >                               REGULATOR_EVENT_ABORT_DISABLE, NULL);
> > +             monitors_reenable(rdev, rdev->desc->mon_disable_reg_disabled);
>
> here...
>
> >               return ret;
> >       }
> >
> > @@ -6422,8 +6429,10 @@ static int regulator_late_cleanup(struct device *dev, void *data)
> >                */
> >               rdev_info(rdev, "disabling\n");
> >               ret = _regulator_do_disable(rdev);
> > -             if (ret != 0)
> > +             if (ret != 0) {
> >                       rdev_err(rdev, "couldn't disable: %pe\n", ERR_PTR(ret));
> > +                     monitors_reenable(rdev, rdev->desc->mon_disable_reg_disabled);
>
> ... and here.
> > +             }
> >       } else {
> >               /* The intention is that in future we will
> >                * assume that full constraints are provided
> >
>
> These were just very minor things. Mostly looks good for me.
>
>
> Yours,
>         -- Matti
>
> --
> Matti Vaittinen
> Linux kernel developer at ROHM Semiconductors
> Oulu Finland
>
> ~~ When things go utterly wrong vim users can always type :help! ~~
>
