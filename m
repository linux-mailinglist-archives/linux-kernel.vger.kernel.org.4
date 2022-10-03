Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A305F2C42
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 10:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJCIoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 04:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiJCInz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 04:43:55 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359031DA54
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 01:20:55 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-131dda37dddso11185741fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 01:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=eeOP76qilVDoKN6hbUCrPoCX6Cv4rNDPUv2ZrQEEc7o=;
        b=G+DZzrg/pPAkDweW+0Wuo/OgHDY8mXb1rvpL++BBZlcPl59Farl7hTSoXctp4SIUAZ
         DeCevIbgE8IrtE2zN8vJOjejPzdxyN9GSSZxNB/JpVIXXIa19hqWgq8uPdqdIG2I7k7v
         SNbnAqoD8Wkxujs5lkfbEbwdE/yjO7IpvL0k0SNOL+kj2cIhIJzSuifPjCZHnIHf/kWo
         +KcZhDQocqPVHYolOicFtVhvfXz+flbhhWHidQpb+9AXdpe5W4ngKx2vMW2QkMleUBzn
         MDgUDlJGEUMfKRkYIhhr5Eo44TJYhA4ZheoZKLafvaakO0ypl+VxAsXO71miEaxR0AI7
         R/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=eeOP76qilVDoKN6hbUCrPoCX6Cv4rNDPUv2ZrQEEc7o=;
        b=cNb/atCJmAmdy4HR0+BIebfnuPezaknVtnIinMNLmVJq5JA1GFAkNk2uNqVOOeLK/J
         o90zHjfhpeLIFYrnychV4NGMskQAxuwqR//nLcG/Jg3wtqyfLZPnXTivIrcWLHRnIUCP
         We6mrpfraWh0m+ZfdWo5dLajA8ZzBpExVexGA6Bw4y5qXxRELR1V1Spcc4EXFQWMam5Z
         YxOBLUrnC8MRhqa1325QP0Zab6KqN2OLtoMgCSSB+TuVu7YYdyRDX13kbBO/JWYCZeyo
         xddgEtkFPpaBwGwwu6t6LTikiaJUlRsAZU0AnpFxZiCJnkK9G6U0U/rgrEFJG1yAhtkQ
         +rZg==
X-Gm-Message-State: ACrzQf2I1iwX+hLquIiwyp89vnD2/s2qEtHMTuxOXEixk3Q+xo82/uqr
        iBx07nvytzqWhm2OPs5k8c+MNakl7L8cefpzehlzOEZMJ7k=
X-Google-Smtp-Source: AMsMyM61KQsMrmECoJXfi+oTTnSjQpMLejz2xyGgNEqCvf2KuLArxN+dYV0b2s86nwVSP5vZitBqd/rRW7df8gm6YBA=
X-Received: by 2002:a05:6870:d6a9:b0:127:fb20:c5c0 with SMTP id
 z41-20020a056870d6a900b00127fb20c5c0mr4852830oap.175.1664785254539; Mon, 03
 Oct 2022 01:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1663834141.git.cmo@melexis.com> <be405068f081f2d518843897b13cd0289c280b5d.1663834141.git.cmo@melexis.com>
 <a11b83a9-9e25-bbb5-2556-f5244119e3dc@wanadoo.fr>
In-Reply-To: <a11b83a9-9e25-bbb5-2556-f5244119e3dc@wanadoo.fr>
From:   Crt Mori <cmo@melexis.com>
Date:   Mon, 3 Oct 2022 10:20:18 +0200
Message-ID: <CAKv63ut4DJCLQP8ckOsC+K4DGy+v2Y5ghfoTjQoyg4CvditW6Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] iio: temperature: mlx90632 Add runtime
 powermanagement modes
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     andy.shevchenko@gmail.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Oct 2022 at 18:09, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 22/09/2022 =C3=A0 10:13, cmo-fc6wVz46lShBDgjK7y7TUQ@public.gmane.org a=
 =C3=A9crit :
> > From: Crt Mori <cmo-fc6wVz46lShBDgjK7y7TUQ@public.gmane.org>
> > measurements in lower power mode (SLEEP_STEP), with the lowest refresh
> > rate (2 seconds).
>
> Hi,
>
> should there be a v7, a few nitpick below.
>
It was already applied, but I can spin a new patch for the suggested
changes (the s32 is mostly there because before this patch it was
returning value for further bit manipulation).

> >
> > +     ret =3D regmap_read_poll_timeout(data->regmap, MLX90632_REG_STATU=
S,
> > +                                    reg_status,
> > +                                    (reg_status & MLX90632_STAT_BUSY) =
=3D=3D 0,
> > +                                    10000, 100 * 10000);
> > +     if (ret < 0) {
> > +             dev_err(&data->client->dev, "data not ready");
> > +             return -ETIMEDOUT;
>
> Why not "return ret;"?
>
If you came to this point there were already several i2c reads, so I
think it is more important to convert those to timeout.

> >       mutex_lock(&data->lock);
> > -     measurement =3D mlx90632_perform_measurement(data);
> > -     if (measurement < 0) {
> > -             ret =3D measurement;
> > +     ret =3D mlx90632_set_meas_type(data, MLX90632_MTYP_MEDICAL);
> > +     if (ret < 0)
> > +             goto read_unlock;
> > +
> > +     switch (data->powerstatus) {
> > +     case MLX90632_PWR_STATUS_CONTINUOUS:
> > +             measurement =3D mlx90632_perform_measurement(data);
>
>    ret =3D mlx90632_perform_measurement(data);
> and
>    measurement =3D ret;
> on success would be less verbose (no need for {}, and save 1 LoC) and
> more in line with mlx90632_calculate_dataset_ready_time() above.
>
I wanted to change as few lines as possible to avoid clogging the
patch with unrelated changes. Also in most cases, we will be
in-success here, so limiting the number of variable copies in the
success path should be the priority.
