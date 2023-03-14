Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181706B9BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjCNQpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjCNQpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:45:31 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35A6A64AD;
        Tue, 14 Mar 2023 09:45:26 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id cu4so8254646qvb.3;
        Tue, 14 Mar 2023 09:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678812326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdH/5tiGslIXjo9pRAgsvefM7NtTI9gCyWlT7umnQ1M=;
        b=pdvazNzlt9asPbITncS0bwvm7VfDGEnWgTIlviEmJ1GZwBuK3YnlZFRCIb0lkG2qAj
         PMRkVhMdP/rvK/yOWxnV6zhuhxUErynmKworzO2jbRAaJhvwskZclT9HkbsMAMgSwGj9
         3RrgxGCjazsXUHzbA+Z6RD2bQLAghRODxb80cWfmXH5BwjuX+0jBOqk0A0jv71RA+Lot
         SWgbDOahxsLvHmQpp3++Ygew1YmZGvvJ4Demqj8yMrYuzl4SDrYYQ4M0L9X+k5YGHNin
         vAhQsK8Yl4GFrJwl5/EeB5qd6JELrGeDAOJ4nT1xMTb6l6gklqSSwpz/G/dmtBLBO3uv
         bibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678812326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VdH/5tiGslIXjo9pRAgsvefM7NtTI9gCyWlT7umnQ1M=;
        b=soQHuEbWl2EB03i4nHr9bTDTg/oNVfeXVC4ImaKOsUKphhinQ4vktm4aNMoJFqeTvp
         T4ljLiMkC0OTGXHekBPYkznJPSqMi1hY/VaHwsf3wClzcxnmaYWLwK0yaPLTNOCgShyU
         o1iCPhq7Q/jjr+TKoxd8Z/oby3zGlJgawJEClXq3EUjvM5KNkwJQA7Jed3ymiPhGj5YC
         ODbiwg3p58ZogviVJr8v8Jud1QicLdk5WmHMc42GeGvQhcStNuPKtmHlKaDbJhae+keK
         8G/FtclYqXyY2mGJUe6NuqX4a9bLRGYEVY9uHFfog8yLA57Q9/LR++Bu2BL7Q/Q74np0
         0vqg==
X-Gm-Message-State: AO0yUKWjVNNdyl5e/KNGVB7HN0Lno1jCME6r+xWSqUOBE8yVnvCxColZ
        GJ5Sy2IFING57yHj+Cf8Gm93PiZiyEdiLKnuh0g=
X-Google-Smtp-Source: AK7set+N1LCjbpqURs62eAi7MdOfmfP1ucOIy/8fsKu4jag6zGzk/aq51CcQNf0qTslP9ffYaiek/RS/tonm4ppvXGc=
X-Received: by 2002:ad4:5a03:0:b0:56e:9104:ee7 with SMTP id
 ei3-20020ad45a03000000b0056e91040ee7mr2947112qvb.10.1678812325704; Tue, 14
 Mar 2023 09:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230314120252.48263-1-mmkurbanov@sberdevices.ru> <20230314120252.48263-3-mmkurbanov@sberdevices.ru>
In-Reply-To: <20230314120252.48263-3-mmkurbanov@sberdevices.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Mar 2023 18:44:49 +0200
Message-ID: <CAHp75Vfuf0HYfEy88g6srrVnxAgS42SzF06AVzSuACN_a9pqJg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] leds: add aw20xx driver
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, devicetree@vger.kernel.org
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

On Tue, Mar 14, 2023 at 2:03=E2=80=AFPM Martin Kurbanov
<mmkurbanov@sberdevices.ru> wrote:
>
> This commit adds support for AWINIC AW20036/AW20054/AW20072 LED driver.
> This driver supports following AW200XX features:
>   - Individual 64-level DIM currents

As said, please give a chance reviewer to answer your questions before
issuing a new version. You will save yours time in the first place and
reviewer's and others' at the second.


...

> +config LEDS_AW200XX
> +       tristate "LED support for Awinic AW20036/AW20054/AW20072"
> +       depends on LEDS_CLASS
> +       depends on I2C

> +       depends on OF

I don't see any dependency. Do you?

...

> +#include <linux/bitfield.h>

bits.h needs to be included, it's not guaranteed to be by any of the
present headers in this list.

> +#include <linux/i2c.h>
> +#include <linux/leds.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>

+ container_of.h

...

> +#define AW200XX_PAT0_T2_LT_MSB(x)   ((x) >> 8)
> +#define AW200XX_PAT0_T3_LT_LSB(x)   ((x) & 0xFF)
> +#define AW200XX_PAT0_T_LT(msb, lsb) ((msb) << 8 | (lsb))

Are these being in use anyhow?

Please, do not add dead definitions if they are not currently in use
and do not add value to understanding how hardware works for the
implemented things.

...

> +/* Patern selection register*/

Pattern

...

> +/* Duty ratio of display scan (see p.15 of datasheet for formula) */
> +#define AW200XX_DUTY_RATIO(rows) \
> +       (((592UL * 1000000UL) / 600500UL) * (1000UL / (rows)) / 1000UL)

Instead of referring to a page in the datasheet, quote the formula and
a bit of text.

So, now as I read it I can tell how it can be improved.
The first six 0:s multiplier is actually USEC_PER_SEC in the kernel.

The 1000 is your addition which needs to be explained. It may be just
MILLI or KILO depending on what you have in mind with it.

...

> +struct aw200xx {
> +       const struct aw200xx_chipdef *cdef;
> +       struct i2c_client *client;

> +       struct regmap *regmap;

You may derive this from &client->dev, right? The API dev_get_regmap().

> +       struct mutex mutex;
> +       u32 num_leds;
> +       u32 display_rows;
> +       struct aw200xx_led leds[];
> +};

...

> +       if (sysfs_streq(buf, "auto")) {
> +               dim =3D -1;
> +       } else {
> +               ret =3D kstrtoint(buf, 0, &dim);
> +               if (ret)
> +                       return ret;
> +
> +               if (dim > AW200XX_DIM_MAX)
> +                       return -EINVAL;

And if dim is < 0, does ir mean "auto"? If so, is it documented?

> +       }

...

> +static DEVICE_ATTR(dim, 0644, aw200xx_dim_show, aw200xx_dim_store);

DEVICE_ATTR_RW() ?

...

> +       mutex_lock(&chip->mutex);
> +
> +       reg =3D AW200XX_REG_DIM(led->num, chip->cdef->display_size_column=
s);

> +       dim =3D led->dim;
> +

This blank line should go before a dim assignment.

> +       if (dim < 0) {

> +               dim =3D brightness / (AW200XX_FADE_MAX / AW200XX_DIM_MAX)=
;
> +               dim =3D max(dim, 1);

Can it be written in a single assignment?

  dim =3D max(brightness / (AW200XX_FADE_MAX / AW200XX_DIM_MAX), 1)

> +       }

...

> +error:

In one function it's called the exit, here it's the error, please be
consistent and I think the more precise is to use something like
'out_unlock'.

> +       mutex_unlock(&chip->mutex);
> +
> +       return ret;
> +}

...

> +       /* The output current of each LED (see p.14 of datasheet for form=
ula) */

Again, put more comments. Do not push the reader to find a Datasheet
which I do not see the link to in the commit message.

> +       return (duty * global_imax_uA) / 1000U;

So, this seems like the same meaning as 1000 in the macro, correct?
Please explain the use of it.
The best, if you think units.h doesn't provide it, define in your driver.

...

> +       /* The output current of each LED (see p.14 of datasheet for form=
ula) */
> +       return (led_imax_uA * 1000U) / duty;

All the same as per above.

...

> +       {
> +               { 8,  3300 },
> +               { 9,  6700 },
> +               { 0,  10000 },
> +               { 11, 13300 },
> +               { 1,  20000 },
> +               { 13, 26700 },
> +               { 2,  30000 },
> +               { 3,  40000 },
> +               { 15, 53300 },
> +               { 4,  60000 },
> +               { 5,  80000 },
> +               { 6,  120000 },
> +               { 7,  160000 },
> +       };

Yeah, as per previous email, use exactly what Datasheet provides you.
There is a clear pattern and clear math mistakes in the datasheet
itself.

...

> +static const struct regmap_config aw200xx_regmap_config =3D {
> +       .reg_bits =3D 8,
> +       .val_bits =3D 8,
> +       .max_register =3D AW200XX_REG_MAX,
> +       .ranges =3D aw200xx_ranges,
> +       .num_ranges =3D ARRAY_SIZE(aw200xx_ranges),
> +       .rd_table =3D &aw200xx_readable_table,
> +       .wr_table =3D &aw200xx_writeable_table,
> +       .volatile_table =3D &aw200xx_volatile_table,
> +       .cache_type =3D REGCACHE_RBTREE,

You have a mutex, why do you need to use regmap's lock?

> +};

...

> +       cdef =3D device_get_match_data(&client->dev);

Is it fine if it's NULL?

...

> +       chip->cdef =3D cdef;

Can it be assigned directly here w.o temporary variable?

--
With Best Regards,
Andy Shevchenko
