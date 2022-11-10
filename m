Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36550623F1A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiKJJym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiKJJyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 04:54:39 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF3E66CAD;
        Thu, 10 Nov 2022 01:54:38 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id s4so640147qtx.6;
        Thu, 10 Nov 2022 01:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apaad6mmMC/hBO6ENkJzg34TPo62eDb6xWvAxgQ8q2k=;
        b=gwLkEwMJ83iRaBIRuj8qrLigTcdTjN4+W1yKV/RxAQW0V4hFw3PByyRrzgOvPuu8Iz
         730jH7aM+t/J+zhnNwMwDLTOpVKn6Y3hd899W2W9cFQVYD0cAlVa4quyctGUxkoS/DEf
         FYFgy5q5xBS2dyHiiH0csiTRjX/BolwYYrXjeCSdcOu/4mpaBugDCPTvEsGDUT0Lj8gn
         GeT0DlIVi2FqjgcVCPHdVXm5QJWxfOZJK7/2tTXHcOcrpqyz9jZLDsaBchapLYmX6x8f
         6CNsIVKd05+Fn+zuM97toun4NAcuLiQQ0e603AkSt1X0+Z+yx8GQHhAtr+d+Q+mL02x/
         sgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=apaad6mmMC/hBO6ENkJzg34TPo62eDb6xWvAxgQ8q2k=;
        b=Y2bRBfUtYYdhyZhlq2KGx928IWeP2lyIJ14lM4LmR+Osi1y7LdkLA2D+OciKvYUhar
         4Pgs0JpTOmPUBei6LULwKCSqh4JTuqslM1yAlIDSorJUwrpetGXt/phoi52xlJqzlsoB
         /HkWIZasVvjQI0IpW5bkGlr3uzv+I9ePpWMvMA6p+qqGek3wPUtUYjvJ9R5K015Jujt1
         4ypnwFgVMnzwMeNnacQFYZr3KjI/GnTJeBq5uNqJ62WRJaRPCiOWIISK1Fbkaj5f3GyT
         M7n0HnSNju2cHklKzK/T4oy1KFVVq6OHEKqbPC8GcIxdyfghru1bdNgVum+sgmYTCbKN
         yv+A==
X-Gm-Message-State: ANoB5plJ3VzQDi/CzvsXj62jKwpzmDuXrme+iS8+Nu9BFwXblKFUldB0
        RgI70QrX1LFMsp19YKF/r01EUoNFIm8MkVD5c60=
X-Google-Smtp-Source: AA0mqf5EHK/W+Bz+DLFmNlYdzGihQ/Q4/OTfpkz6MoQT97k/xeaclw4u95WDUy8yyJIkOb7jnWCxfVst/AC53T2Kt78=
X-Received: by 2002:a05:622a:1c1:b0:3a5:8416:690d with SMTP id
 t1-20020a05622a01c100b003a58416690dmr17512047qtw.61.1668074077602; Thu, 10
 Nov 2022 01:54:37 -0800 (PST)
MIME-Version: 1.0
References: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com>
 <20221108142226.63161-4-andriy.shevchenko@linux.intel.com> <20221110072144.2s37r52qcpi6utgh@pengutronix.de>
In-Reply-To: <20221110072144.2s37r52qcpi6utgh@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Nov 2022 11:53:59 +0200
Message-ID: <CAHp75VenLc-QfuD3rHPh=5nu_SqWvEnsePbNMsBA4R-Zs+nvrw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] pwm: lpss: Include headers we are direct user of
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 9:22 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Tue, Nov 08, 2022 at 04:22:23PM +0200, Andy Shevchenko wrote:
> > For the sake of integrity, include headers we are direct user of.
> >
> > While at it, move the struct pwm_lpss_chip to be after
> > the struct pwm_lpss_boardinfo as the former uses pointer
> > to the latter.
>
> That part is fine.
>
> > Replace device.h with a forward declaration in order to improve
> > the compilation time due to reducing overhead of device.h parsing
> > with entire train of dependencies.
>
> Together with "For the sake of integrity, include headers we are direct
> user of." this makes an a bit schizophrenic impression on me. You add
> <linux/types.h> because the file is a direct user of it, but you drop
> <linux/device.h> despite being a direct user.

But we don't use device.h.

> If you adapt the reasoning to something like:
>
> Replace the inclusion of <linux/device.h> by a forward declaration of
> struct device plus a (cheaper) #include of <linux/types.h> as
> <linux/device.h> is an expensive include (measured in compiler effort).

Fine with me, thanks for the draft.

> I could better live with it. I would even split this into two patches
> then. (i.e. move struct pwm_lpss_chip vs the include and forward change)

I think for this small change for a driver that hasn't been modified
often it's fine to have them in one. But tell me if you are insisting
on a split, I can do that.

--=20
With Best Regards,
Andy Shevchenko
