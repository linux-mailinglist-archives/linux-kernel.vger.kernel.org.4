Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E102C63133F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 10:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiKTJuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 04:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKTJt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 04:49:59 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDE0140C2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 01:49:57 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id b2so6773406iof.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 01:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CeH73YP6L8/tKyBqkauv8yKtr7kbd62tDdWAPZkAPI=;
        b=CjxvDjAC682hi79CFVg17+4dp3JhMhAc40aEGnJ3NS481Pr3nGHUjwE8ClLB6CM9jH
         b1XnhdS0mGnc1T7nmV9lzCEYinDIcD4uhthvWkbozJfF4Ak9HpdoLr4ijZnczDh9J8Y2
         fY9BDgZmDzSAfs5akNVG3e65VheTKYLBypctBsos1CEoUgFM1tXgDv9NE5P9SRlT0X2p
         cqP7c7KgV5mCtxNxSL/MLFXqJc9GkOW4Gbh7QKYgt152wf+s0E993T8BE4tz07jEo87P
         bOGgc4+coqYoRgjvHk95fjDX1ycXC8nxeFC+NqzOavTOckzQu7elST8g5TSyR3OgHTZ1
         FFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9CeH73YP6L8/tKyBqkauv8yKtr7kbd62tDdWAPZkAPI=;
        b=KW0K4CoN+mrHUkOw/9ooaLOkYwpZ6W8VQlXy5aSQMn8URgsXmj2VTrCECfVrhO9qZ8
         KTDQzio4DGgS7zMN84zYlMzG8dJ1lEB6TfLJZ/dgO/GOKZc8JXaz/dsoLLI1xYyqL32s
         nmli5ThP0DsJyVA/mhYRVloSExTM/YlaJ1mVJatpmXZKr2Rhl0PQ13zClnu1ao/r9YI+
         nJ0c7xhvE9257UiCFDm66rkLMHMKswPUu7if6VjudaPdfw8Bsz/iYKr3/XfQhlD+ZPxI
         +8A/JgIxg3tFKHpk9c/Vf5/DcyxDQFLYOGUCmLhF39e+fIEl/V8ifW4xtlecR3b1TdCM
         xa/g==
X-Gm-Message-State: ANoB5pmHoll6aOtjS4kb3mNI7rYn68qnfvIpJAZA745O7qcCF7c7IC0Z
        9KH9/4zHqfWOje+UjSU0rJ400uwSDX14BaKT1c0brg==
X-Google-Smtp-Source: AA0mqf6EJwlob7+cyNsX1i1JLtvmQvzKc9pxIyX8dxiX2Sroa5FdLWco6awHIO6wNwy2ZmM1TEhEBhB0Yl/tJHSuqg8=
X-Received: by 2002:a02:6d54:0:b0:376:24f6:d0f4 with SMTP id
 e20-20020a026d54000000b0037624f6d0f4mr6421543jaf.206.1668937796820; Sun, 20
 Nov 2022 01:49:56 -0800 (PST)
MIME-Version: 1.0
References: <20221118224540.619276-1-uwe@kleine-koenig.org>
 <20221118224540.619276-187-uwe@kleine-koenig.org> <CAKv63uvVsLhbt9y0fWxPWp005rnWzCn6Vm0UmOnW08B87fkCzw@mail.gmail.com>
 <20221119100250.iw757ovgwjbwr2ho@pengutronix.de>
In-Reply-To: <20221119100250.iw757ovgwjbwr2ho@pengutronix.de>
From:   Crt Mori <cmo@melexis.com>
Date:   Sun, 20 Nov 2022 10:49:20 +0100
Message-ID: <CAKv63uti8o2i-SFsJ7iK+R0N1go1tzVKpWZHbaRD3Wta2mXuZQ@mail.gmail.com>
Subject: Re: [PATCH 186/606] iio: temperature: mlx90632: Convert to i2c's .probe_new()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa@kernel.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-i2c@vger.kernel.org, kernel@pengutronix.de,
        Grant Likely <grant.likely@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok. Acked-by: Crt Mori <cmo@melexis.com>
(resending since previous mail was not delivered because it was not plainte=
xt)

On Sat, 19 Nov 2022 at 11:02, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Sat, Nov 19, 2022 at 12:04:41AM +0100, Crt Mori wrote:
> > On Fri, 18 Nov 2022 at 23:46, Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.=
org> wrote:
> > >
> > > From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > >
> > > .probe_new() doesn't get the i2c_device_id * parameter, so determine
> > > that explicitly in the probe function.
> > >
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  drivers/iio/temperature/mlx90632.c | 12 ++++++++++--
> > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/tempera=
ture/mlx90632.c
> > > index f1f5ebc145b1..19e30cfca8a7 100644
> > > --- a/drivers/iio/temperature/mlx90632.c
> > > +++ b/drivers/iio/temperature/mlx90632.c
> > > @@ -1168,9 +1168,9 @@ static int mlx90632_enable_regulator(struct mlx=
90632_data *data)
> > >         return ret;
> > >  }
> > >
> > > -static int mlx90632_probe(struct i2c_client *client,
> > > -                         const struct i2c_device_id *id)
> > > +static int mlx90632_probe(struct i2c_client *client)
> > >  {
> > > +       const struct i2c_device_id *id =3D i2c_client_get_device_id(c=
lient);
> > >         struct mlx90632_data *mlx90632;
> > >         struct iio_dev *indio_dev;
> > >         struct regmap *regmap;
> > > @@ -1337,7 +1337,15 @@ static struct i2c_driver mlx90632_driver =3D {
> > >                 .of_match_table =3D mlx90632_of_match,
> > >                 .pm     =3D pm_ptr(&mlx90632_pm_ops),
> > >         },
> > > +<<<<<<< ours
> >
> > Maybe some of the merge artifacts left (also below)?
>
> *groan*, ok, thanks for pointing out the obvious. Fixed in my tree. Ftr,
> the fixup is:
>
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature=
/mlx90632.c
> index 19e30cfca8a7..753b7a4ccfdd 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -1337,15 +1337,7 @@ static struct i2c_driver mlx90632_driver =3D {
>                 .of_match_table =3D mlx90632_of_match,
>                 .pm     =3D pm_ptr(&mlx90632_pm_ops),
>         },
> -<<<<<<< ours
> -       .probe =3D mlx90632_probe,
> -||||||| base
> -       .probe =3D mlx90632_probe,
> -       .remove =3D mlx90632_remove,
> -=3D=3D=3D=3D=3D=3D=3D
>         .probe_new =3D mlx90632_probe,
> -       .remove =3D mlx90632_remove,
> ->>>>>>> theirs
>         .id_table =3D mlx90632_id,
>  };
>  module_i2c_driver(mlx90632_driver);
>
> When (and if) I'll resend the series, the fixed version will be
> included. (Unless someone picks up the broken patch with the above
> fixup of course :-)
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
