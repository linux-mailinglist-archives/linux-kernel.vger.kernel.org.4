Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E246BB393
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjCOMtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbjCOMtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:49:09 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516B06421E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:49:07 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id o2so16819006vss.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678884546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyeo9bZDdUn8Ag++MxxQW4gy5l8ih4AUy9Ax3AbAFac=;
        b=5Z6F7G8o1cvgOSQSrP+FSL6jy8y+0ZtBg5RwdH+p2pR1mEKk6vhPNQlicw47hvE7F9
         +aW66gdb9GQp9geeeQUv80sWk66VcgBqwH7ZOnOhvpn6G/h1Ap50o6nCAnyOGDJkbYcz
         TdzK2CwTF0Y1ooUFCZaB9oUyqAy9nzu4IYX8lXLQBRyP8qEyjek1H1g6KPelJrPHcEMt
         sQ7qLXYnEpIaqD/307em+QbENU/vDiEi82jxsLvPIIhl9JyXpDuH1TornsAfKAjFI/Tf
         lpKhdLehSzl8sLVFWriCl1iPaw9CnSPe+fUNNVN+E9glZxjinnVBzZvJB+sFcCIeTXoP
         VAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678884546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tyeo9bZDdUn8Ag++MxxQW4gy5l8ih4AUy9Ax3AbAFac=;
        b=Nf6suNEVimbBY71mOzPDEL2yywnwB5YRb980MfuY2LNfkAL0XHYU0scNHtYnBxS5i9
         hjmkMgZ58d9hJ9YPN0E+INWKI2CY6JneLgXisGiHSe2e6/Jk5PSWmrfscydaJV5rHCun
         zkOPQRHxnNEHFAurF327XtvrK8obAiD0oa6bNz3LxvRWZla1lHnJLVPInpDiTeoXOXC3
         BASKBQTWNfsNefjFBIzdrr2krVaQBGnabOvWqpp67N3QbAk1MZTO+peGbuNUYuCMEkUk
         0CT0TyQT2u4NVrYPPQFBJyxMR7uVFwFMVIS5inL84lTcbc+1Kukeh8HKjDP3pY2kd/e2
         GFEQ==
X-Gm-Message-State: AO0yUKVn6T5b/8cHKVo0T8kB7QP6jCjOJUv6wkgD9/aCZvux/6bl7TTy
        7X/rMZxYwvCcafWqgadogFtzefSPkT/CmCr1x6Y5WA==
X-Google-Smtp-Source: AK7set+864Q3cBxX613w2AgbDemFRJUVS4DrOSx/mi7YYQodmoOzm/NQfQbJsSqoHEgFU0UqYnkST/nLys9rt12Xq1I=
X-Received: by 2002:a67:df8e:0:b0:411:b4c2:c6c0 with SMTP id
 x14-20020a67df8e000000b00411b4c2c6c0mr26516691vsk.0.1678884546416; Wed, 15
 Mar 2023 05:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230313170950.256964-1-francesco@dolcini.it> <20230313170950.256964-3-francesco@dolcini.it>
 <CAHp75VetwU3pr59sE5zHPf5jPxYb6yJnXZWpD_qn4o6d5Dnmog@mail.gmail.com> <ZA9iPnmgNO7PSv6O@francesco-nb.int.toradex.com>
In-Reply-To: <ZA9iPnmgNO7PSv6O@francesco-nb.int.toradex.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 15 Mar 2023 13:48:55 +0100
Message-ID: <CAMRc=Me4vBGCL0ctm87Xioky55gnsUm0DkmJkN8V6XRLSEkJNw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] gpio: fxl6408: add I2C GPIO expander driver
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 6:49=E2=80=AFPM Francesco Dolcini <francesco@dolcin=
i.it> wrote:
>
> On Mon, Mar 13, 2023 at 07:35:20PM +0200, Andy Shevchenko wrote:
> > On Mon, Mar 13, 2023 at 7:09=E2=80=AFPM Francesco Dolcini <francesco@do=
lcini.it> wrote:
> > >
> > > From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > >
> > > Add minimal driver for Fairchild FXL6408 8-bit I2C-controlled GPIO ex=
pander
> > > using the generic regmap based GPIO driver (GPIO_REGMAP).
> > >
> > > The driver implements setting the GPIO direction, reading inputs
> > > and writing outputs.
> > >
> > > In addition to that the FXL6408 has the following functionalities:
> > > - allows to monitor input ports for data transitions with an interrup=
t pin
> > > - all inputs can be configured with pull-up or pull-down resistors
> >
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> Thanks for the review, appreciated.
>
> > > +#include <linux/err.h>
> > > +#include <linux/gpio/regmap.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/i2c.h>
> >
> > Seems unordered?
>
> Whoops :-/
>
> Bartosz: if you or others have additional comments I'll change this for
> sure, if not up to you - please let me know.
>
> Francesco
>

I ordered them manually and applied the series.

Bart
