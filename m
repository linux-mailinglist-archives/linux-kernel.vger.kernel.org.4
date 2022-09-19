Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6017D5BD44F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 20:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiISSAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 14:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiISSAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 14:00:25 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCDFE019
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 11:00:24 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-11eab59db71so487683fac.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 11:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=tEIs68WPX2uvipp125B48aqh0bfmh+wQV9ksUWd9SVo=;
        b=qNir+J9O8F4LyGFvxa8ugiu0xA9D2Ihgv3ALdOuQZ+lePvk+zVsTBvMpcy2pGZUoEl
         7L4jf8wUJ+1XXw/rJwjO9d9FgqqmO8igXnocxy+0PJh7kZMe5lV4+PokzLWxzUTqkNfa
         MJxl/aaaNQwOGutFe7ZvibN05xadknqiEQ/5vSSYjpKuFD33MhB/iX/1WjE4lAqUPd6A
         kuCo4VPsvhpNmueBpwBt7HdTuJHbw5TT2wQ3H8uywgSbTqwic0V5Oz8UxOVi1a7McJrH
         HkRnEakICDjLLEthMK0JctOFSSI5fY4fnhUD2BMPMmxCLSrvkxhEgkrPQf6lCS+eXEH2
         qniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=tEIs68WPX2uvipp125B48aqh0bfmh+wQV9ksUWd9SVo=;
        b=TeOB3N53PwHNfxCLuuYoHy3HBNh1tLdFRNCof9vLKTMv3lBuMQPMdWu0Y/sUtZvojo
         l935D91WJRPaleDaS+XMq6YPwx3S5mWbZOIbXihO/TjHwTm60Kq/fH80OM6O39aFYwNr
         2ABPjSEFrA4YGuI2IrknnqPyu156/5X/YvLnz0SRw0XpjMoKYEIqzauAgSmwaV9ddufM
         9FxU8hMrtmka4RtajGHisPmbeH/1Xf5a5Stc5nYVOjglCamqYdfn9LIDWsFh9yNu8/9C
         HV6nFCkqqOoI+/zezs3Yk7kuR5mDzFuGimawE2cEBDMVDg4R/+a/jurRGuG0hILl/rMO
         G4fg==
X-Gm-Message-State: ACrzQf1cLWm1cM5w0gyzosUOBOvR/UuHUOeAN/CuNHEz+sVvSGqlZj3B
        wmveSn9wKs5WrScCSj0OjkoZBDbOoriZJTIeGxQPLw==
X-Google-Smtp-Source: AMsMyM5D7J7kacN+vMB7918d0FUlee8JZbF0HU6ajCxGVOMgT8VCVud31CztIxwSVTHiziDhf3zMIBDNSqo8ctxq8yA=
X-Received: by 2002:a05:6870:88a8:b0:12c:d54d:8978 with SMTP id
 m40-20020a05687088a800b0012cd54d8978mr5496662oam.7.1663610423695; Mon, 19 Sep
 2022 11:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1663577091.git.cmo@melexis.com> <dadcba138c48286944cc03563967de9b4daddaaa.1663577091.git.cmo@melexis.com>
 <20220919172420.1a6fd52f@jic23-huawei> <CAKv63usAjTh9b-HuVdikbtdPKeyFYPy0kENQpkGo6jWXkE_Quw@mail.gmail.com>
 <20220919183048.00c68a04@jic23-huawei>
In-Reply-To: <20220919183048.00c68a04@jic23-huawei>
From:   Crt Mori <cmo@melexis.com>
Date:   Mon, 19 Sep 2022 19:59:47 +0200
Message-ID: <CAKv63uvDNbwn=Jb9Ee0fhSEBPJx94ckZTRCTQw7PfAH4UdN2Dg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] iio: temperature: mlx90632 Add runtime
 powermanagement modes
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sept 2022 at 19:30, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 19 Sep 2022 19:09:13 +0200
> Crt Mori <cmo@melexis.com> wrote:
>
> > On Mon, 19 Sept 2022 at 18:24, Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > On Mon, 19 Sep 2022 10:48:16 +0200
> > > cmo@melexis.com wrote:
> > >
> > > > From: Crt Mori <cmo@melexis.com>
> > > >
> > > > measurements in lower power mode (SLEEP_STEP), with the lowest refresh
> > > > rate (2 seconds).
> > > Hi Crt,
> > >
> > > I'm a little nervous about one change in the flow from earlier versions.
> > > I'm assuming you are sure it is always fine though!
> > >
> > > Previously before calling the _sleep() in remove we ensured the device
> > > was powered up. Now that's no longer true. If runtime pm has it in
> > > a low power state it will remain in that state at the point where we call
> > > _sleep().
> > >
> > > One note/question on original code...  Why bother marking regcache dirty when
> > > we are going down anyway?  It's not wrong as such, just probably not
> > > that useful unless I'm missing something.  Same in the *_wakeup()
> > > that puts the cache back but is only called in probe now.
> >
> > Previously when powered on the device the cache was not updated
>
> ah. Got it.  Doing this makes sense if we don't provide the default register
> values as there is nothing else to get them from.
>
> However, I think the regmap core does this for us if defaults are not provided:
> https://elixir.bootlin.com/linux/v6.0-rc5/source/drivers/base/regmap/regcache.c#L180
>
> Does that not work here for some reason?  If so add a comment.

It did not work in past, but I can make a few tests and file a bug
later on if indeed we should not need to mark cache refresh at
startup. I would here keep it as it was, because I remember having a
big headache trying to figure out what I was missing with regmap_read
conversion (I remember I started with simple i2c reads).

>
> We do need the dance in the suspend and resume though as regcache code has no
> way to know if the values are retained or not so we have to let it know.
>
> >, so I
> > added the marking of regcache at wakeup and saw that the same thing
> > happens when in resume after powering on. I should keep this
> > assumption still, so I will re-add the wakeup to resume (not runtime
> > resume). I did not test this part as I focused on runtime resume so
> > thanks for noticing.
> >
> > >
> > > Which then raises question of why we don't need to deal with the regcache
> > > any more when we turn power off in suspend?
> > >
> >
> > It just did not work properly without this. Not correct EEPROM
> > coefficients were used for calculations.
> >
> > > So either we need a statement of why the register state is maintained,
> > > or add the maintenance for that.  Also probably makes sense to drop
> > > the left over maintenance from the probe() and remove() (via devm) paths.
> > >
> > I thought I did that by completely removing _remove() and using
> > devm_actions for cleanup. Do you see a spot I missed?
> >
>
> I don't think marking the regcache dirty in remove (via the _sleep() call)
> does anything useful.  On fresh probe of the driver, we get a new regcache which
> we can then sync as you are doing - so no point in marking the one we are about
> to delete as dirty that I can see.
>

So you would rather that I make a new function which basically will be
a wrapper around mlx90632_pwr_set_sleep_step (as I don't want to
change that function to return nothing and take a void pointer)
instead of using mlx90632_sleep in remove (beside using it in
pm_suspend after this change)?

>
> > > Jonathan
> > >
> > > >
> > > > -static int __maybe_unused mlx90632_pm_resume(struct device *dev)
> > > > +static int mlx90632_pm_resume(struct device *dev)
> > > >  {
> > > > -     struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> > > > -     struct mlx90632_data *data = iio_priv(indio_dev);
> > > > +     struct mlx90632_data *data = iio_priv(dev_get_drvdata(dev));
> > > > +
> > > > +     return mlx90632_enable_regulator(data);
> > > > +}
> > > > +
> > > > +static int mlx90632_pm_runtime_suspend(struct device *dev)
> > > > +{
> > > > +     struct mlx90632_data *data = iio_priv(dev_get_drvdata(dev));
> > > >
> > > > -     return mlx90632_wakeup(data);
> > > Previously we called wakeup here which writes the regcache back to
> > > the device. Now I'm not seeing that happening anywhere in new code.
> > > Why is it not needed?
> > >
> > I had the same question before, why cache was needed to be marked
> > dirty, but without it, CPU did not properly obtain the calculation
> > coefficients. What happens now is that we are in step_sleep mode so
> > measurements are triggered and it also takes the 2 seconds before they
> > are updated. I did not check the line with scope, but I have yet to
> > see the strange temperature output which would indicate that not
> > proper EEPROM data is used. But I did focus on sleep mostly, so deeper
> > sleep I did not retest.
>
> I'd hope runtime pm doesn't need the dance with the cache as the
> values should be retained.  It's the deeper sleep that is where I'd
> see potential problems as you observed.

You are correct - runtime_pm never needed any of the cache stuff.

>
> Jonathan
>
> >
> > > > +     return mlx90632_pwr_set_sleep_step(data->regmap);
> > > >  }
> > >
>
