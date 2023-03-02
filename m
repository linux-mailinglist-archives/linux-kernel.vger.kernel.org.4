Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7D16A80BD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjCBLJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjCBLJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:09:44 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4214ECC;
        Thu,  2 Mar 2023 03:09:43 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id a25so3558454edb.0;
        Thu, 02 Mar 2023 03:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HoSGGNYUT4/xbw3atghaSHbQc9iKyRsggIVy3U9yZNI=;
        b=lP8Gza3confFH9Vf7PpoGuJ1EHy6c1D082gHDuDgz/R0/oBawed6QFc3XjCw8XObD0
         o9T6OuOYTbzTnBqlTg7idUJMSPWfYbUY2n5sjC5J33TwgesZJJeIQQIDxc7aqtKgmiNL
         laX5yV0gjeQURbiEWkITGlQWPu8pCr7MYsxofK/vHQ9kvRk67JRR0L9cdRLc7Oe3DDsf
         mgNGkGKFEgGpzwxpDMN7CSHVdWBDPcSUmL5aQ6X3g/DY6zqnVYLONU3oAvYuiD6bBcid
         UeYSVZrWrzW70D+2S1aVbC5TAFRn6NZdz7rd3q/yumo7gf3qciufULqP07k0knxmrcVj
         7zUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HoSGGNYUT4/xbw3atghaSHbQc9iKyRsggIVy3U9yZNI=;
        b=mc8hhtgPOKH56qWldILMJq3tJtuWa/S54HZaECJPNn9WnKr/yoVcgTxkAGyUPyUDXR
         ON+Hud3jE+sYgDutDrsXWyNmhHYQuVp4DqJHblAD5JB1Yl9FxUnxGL3o7A9fczPG/eix
         T+FURlbDHou7Vt5gG/PTdIu8UGwqkE22Ui+9ScF9ZiL5NoLpH6RDMnW318W//9cdNK3S
         dPOM604GvGM84090aX5OPQk5yz9eE+C8/+0hCsblox7tVzWgdo5g2oZyNknp1J/2CxPo
         vD5p7dGeOSV06vghqjKvvNGDOjIXfQZHBm2RZbB/H2gAU8Bmfeiu6+6AnZT3KxIi5Be6
         dMBg==
X-Gm-Message-State: AO0yUKXiFibIsC8B1Gm1YvRnANc8p8vfTnYz9PeqaNV8bpU6CgXhUhf0
        UVt5gcmXx3AyED9YOEQbI7ty97qIxH8v6d9TxF4=
X-Google-Smtp-Source: AK7set/UAUT0ZoleIEVhU1VALVQUYCYEbnO+s+Mj1UC156zCDiSwbMKkt5Z1Sjw+d0HwkQSlO+ZMlmsO2AAOYJ9vWhs=
X-Received: by 2002:a50:d547:0:b0:4ad:6fc8:69be with SMTP id
 f7-20020a50d547000000b004ad6fc869bemr5717563edj.4.1677755381914; Thu, 02 Mar
 2023 03:09:41 -0800 (PST)
MIME-Version: 1.0
References: <20230222111213.2241633-1-keguang.zhang@gmail.com>
 <20230222111213.2241633-2-keguang.zhang@gmail.com> <Y/YH20aKp+u+QEwA@surfacebook>
In-Reply-To: <Y/YH20aKp+u+QEwA@surfacebook>
From:   Kelvin Cheung <keguang.zhang@gmail.com>
Date:   Thu, 2 Mar 2023 19:09:25 +0800
Message-ID: <CAJhJPsVqPAC_GP0JE98nrpmvDTwXdt4m0z3SZQPX3GFCijT09w@mail.gmail.com>
Subject: Re: [PATCH 1/4] gpio: loongson1: Update copyright
To:     andy.shevchenko@gmail.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
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

On Wed, Feb 22, 2023 at 8:18=E2=80=AFPM <andy.shevchenko@gmail.com> wrote:
>
> Wed, Feb 22, 2023 at 07:12:10PM +0800, Keguang Zhang kirjoitti:
> > This patch updates copyright and author information.
>
> ...
>
> > +// SPDX-License-Identifier: GPL-2.0-or-later
>
> Have you talked to your lawers? This is an inequivalent to what was writt=
en
> below.
>
Yes.
> >  /*
> >   * GPIO Driver for Loongson 1 SoC
> >   *
> > - * Copyright (C) 2015-2016 Zhang, Keguang <keguang.zhang@gmail.com>
> > - *
> > - * This file is licensed under the terms of the GNU General Public
> > - * License version 2. This program is licensed "as is" without any
> > - * warranty of any kind, whether express or implied.
> > + * Copyright (C) 2015-2023 Keguang Zhang <keguang.zhang@gmail.com>
> >   */
>
> ...
>
> > -MODULE_AUTHOR("Kelvin Cheung <keguang.zhang@gmail.com>");
> > +MODULE_AUTHOR("Keguang Zhang <keguang.zhang@gmail.com>");
>
> So, which name here is in your official documents?
>
Keguang Zhang is my official.

> --
> With Best Regards,
> Andy Shevchenko
>
>


--
Best regards,

Kelvin Cheung
