Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB986BAD0F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjCOKIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjCOKHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:07:38 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6BE768A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 03:07:20 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id x1so12360626uav.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 03:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678874840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyigarQn+rvlWVzaZJt6lzB3nSnmv4i4PbSGj6U4LOU=;
        b=zuFiSiIIrhw3nWDppsaWElTOS1A33AWw0K6PvCzOvRyGjaip0OfJpZF62gQdFwcwfr
         tBRQ4CUInQi27orQIIwRI8OB0MNZXOpjAr92CR7QcUW8Ibyw5gS0VAWG026/BKm0tafS
         UNqsBF8u0vLGIVgQaFc+1rBzZaANpqmty6bzWTGYH3FxceV9+rJzGFQfjcklf/+y/mbY
         arhaV/fmprdlf7ttJc0vstJcx6yJcP/o0HHYApvOhZTmjiYn9GWPemb0SQT9KGbribV2
         /gd3TSeEVTyVwYbYn2DFOV8XKlSKxqhER9bs1Y17zj6qLC6cEJHyaAR6nSRxrN7iYFVO
         +1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678874840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CyigarQn+rvlWVzaZJt6lzB3nSnmv4i4PbSGj6U4LOU=;
        b=YUWq4FKBnGGPiSFQtP0e8jQcJU2uhfi9ZBd+9nweFC3YTj+PygZ8BVakVB4xGPWj/c
         Jsvc93F0UNW23uq9FZZvWbc/sNrI3GKXhIKoUWAr6CLEGa+fhtSH1QNli3MNylrooYVU
         1rY1sDqolY0An3Q0ARQ9Uxghco3cvqpjD8nhCA52FU4LlSGN7Ju//wccSZzUPzAueEbp
         PtmO6cxzmF9VnATQ5ItGCxJHsnxMMeYwGNVHnc9k8bjuCNFPFHnjbl6cSI25wmBJ2Igm
         E4U+AQRT0g7LDMPde5yJd7wVOu82JbUA1DYFLKqiACts1/jr4igSGJ2cKW3PfBJLKt8b
         EerA==
X-Gm-Message-State: AO0yUKVRYR8K9gSTfb8HSVyvqx65bIK1zg3wkxFMNKITF1IrhNyO26Qo
        Kkji/LBhYgxWRWwDyZ+nNiWJ6xLjcFolw8MZRD143A==
X-Google-Smtp-Source: AK7set+z7nsb4uB5XY3/60G+34lN7fRDIHMYqwCKit0Ts11eK3Q5/wizsU0dtnwFq5awnatmC/4GWw6ctE5RV7do65M=
X-Received: by 2002:a9f:311a:0:b0:73f:f15b:d9e3 with SMTP id
 m26-20020a9f311a000000b0073ff15bd9e3mr9673311uab.0.1678874839852; Wed, 15 Mar
 2023 03:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221130155519.20362-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdYVU2KJMw=FRxCLXbpWY+42RGheHvnqzg2bo2=JjTRCOw@mail.gmail.com> <ZAtn+TIB/5ngaF7w@smile.fi.intel.com>
In-Reply-To: <ZAtn+TIB/5ngaF7w@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 15 Mar 2023 11:07:08 +0100
Message-ID: <CAMRc=MfOOCdBdLbirB-L7RyxuiE9TqztzQQd1Tjaio=GE2iY8A@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] Documentation: gpio: Input mode is not true Hi-Z
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 6:25=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sat, Dec 03, 2022 at 10:33:50AM +0100, Linus Walleij wrote:
> > On Wed, Nov 30, 2022 at 4:55 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> >
> > > The true Hi-Z (a.k.a. high impedance) mode is when pin is completely
> > > disconnected from the chip. This includes input buffer as well.
> > > Nevertheless, some hardware may not support that mode and they are
> > > considering input only as Hi-Z, but more precisely it is an equivalen=
t
> > > to that, in electronics it's basically "an antenna mode".
> > >
> > > Sligthly correct documentation to take the above into consideration.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Bart, can you apply only the first patch from the series, on which we hav=
e
> a consensus (I believe?).
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Applied, thanks!

Bart
