Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C517056AC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 21:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjEPTEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 15:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjEPTE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 15:04:28 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1DD9EDC;
        Tue, 16 May 2023 12:04:22 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7576deacbd6so627639685a.3;
        Tue, 16 May 2023 12:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684263862; x=1686855862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZX3aJGWh9j6fi4Zbxck+TdbVfuJLOzsnRuRtmwi0h5g=;
        b=YCIgNOuRxAGICG9PO3E4TWClRO4dC2m/394gwLQCEMGSCGSS4Fnoeaw3K+gtklgHAg
         MdrbkFj/7njcvYzyOUWGHe1FncyZ8sq1k7sX/eLBXRPeYSVFEHNLNt/Xma/Q0PYH5neW
         gPimepduH6uaEniGwLeolbNIZGqj2ov/0L0Mzq0xwUsDQ1q0lhiFZSlUDE96O3qJMO+Z
         g0sDwu5o68R0llVAr/YZibnTjl/qi8g6CnDNRA4M9d0t3wBJjSAP2Fk+7atKWiG4eokF
         s1yhRCh9YfhruWLp2AoNq/KkzLaNtN0cbBTCR6CCgIVoCEelGe7WhJ8eaGpCkVKE6di4
         fjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684263862; x=1686855862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZX3aJGWh9j6fi4Zbxck+TdbVfuJLOzsnRuRtmwi0h5g=;
        b=d7gxWN9gSWNzZngevixOudlrKYfd2I9WFAmdQnyGBxzZw2cBZyyV9Y29irT1F3+CIh
         auxuOnmsgDpIuPcLNqhCEdiMksMJ+ayjvjFmvFZK4bKQ9XWu4t/bsbSVOUFstl0dpIld
         7Rs32rEA9G8kuwhfXlUG3OIM/bTXFvxRe+5gwEnQQhOebJnxKf2bVTsYeoZ+/qqS/mwz
         XTwlAeVWIq0bjqq9vlnYUrwqYTyODoKtnXIstPD1QAPVhQB6Xg4gkXla8OE9xXYIwRY0
         DKClHdrVn79zQClakgQvYrjaHBh7ZFXZdAyAc9HMMtYtDaC+ehEGPnM3D5wnW4X279cj
         B1PA==
X-Gm-Message-State: AC+VfDzs899MM9ZWpCAhty9PGeu2i8Xs9dQ/dTM93BlJT21xrjLdM3bg
        YVcgfRoV8LA9nx+nA2bfjjwXheRCaU0yn8mDWVY=
X-Google-Smtp-Source: ACHHUZ7o8SFUdFq9oKXTGUhKpKM024MomgycM5cRyraXgXMUY8hYYFWGvp2kmKAoXAMuXsr50mnQ+x3iKUkHuJVog/Q=
X-Received: by 2002:ad4:5dc9:0:b0:623:557d:91a9 with SMTP id
 m9-20020ad45dc9000000b00623557d91a9mr17484711qvh.31.1684263861900; Tue, 16
 May 2023 12:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-9-ckeepax@opensource.cirrus.com> <ZF6RMqElYZVMpWRt@surfacebook>
 <20230515101350.GS68926@ediswmail.ad.cirrus.com>
In-Reply-To: <20230515101350.GS68926@ediswmail.ad.cirrus.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 May 2023 22:03:45 +0300
Message-ID: <CAHp75Vcizrucc-2KFdFNeHNrxCzz4GwX1OzZYyjPH7P9RgnKYQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] pinctrl: cs42l43: Add support for the cs42l43
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     broonie@kernel.org, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, linus.walleij@linaro.org,
        vkoul@kernel.org, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 1:13=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> On Fri, May 12, 2023 at 10:19:14PM +0300, andy.shevchenko@gmail.com wrote=
:
> > Fri, May 12, 2023 at 01:28:36PM +0100, Charles Keepax kirjoitti:

...

> > > +   dev_dbg(priv->dev, "Setting gpio%d to %s\n",
> > > +           offset + 1, input ? "input" : "output");
> >
> > How ' + 1' part won't be confusing?
>
> Kinda an un-avoidable confusion somewhere, the GPIOs in the datasheet are
> numbered from one. So this makes the debug print match the
> datasheet name for the pin, which is used in the pinctrl strings
> as well.

The problem here is that the entire Linux pin control and GPIO cores
in their debug/info/error messages will use offset + 0. With the above
invention it will well make users confused a lot. I think you need a
Linus W blessing for this.

...

> > > +   if (!of_property_read_bool(dev_of_node(cs42l43->dev), "gpio-range=
s")) {
> > > +           ret =3D gpiochip_add_pin_range(&priv->gpio_chip, priv->gp=
io_chip.label,
> > > +                                        0, 0, CS42L43_NUM_GPIOS);
> > > +           if (ret) {
> > > +                   dev_err(priv->dev, "Failed to add GPIO pin range:=
 %d\n", ret);
> > > +                   goto err_pm;
> > > +           }
> > > +   }
> >
> > Besides the fact that we have a callback for this, why GPIO library can=
't
> > handle this for you already?
>
> Apologies but I am not quite sure I follow you, in the device
> tree case this will be handled by the GPIO library. But for ACPI
> this information does not exist so has to be called manually, the
> library does not necessarily know which values to call with,
> although admittedly our case is trivial but not all are.

Why can't the firmware provide this information? _DSD() is a part of
ACPI v5.1 IIRC.

Although it might require moving some code from gpiolib-of.c to
gpiolib.c with replacing OF APIs with agnostic ones.

...

> > > +static int cs42l43_pin_remove(struct platform_device *pdev)
> > > +{
> > > +   pm_runtime_disable(&pdev->dev);
> >
> > This is simply wrong order because it's a mix of non-devm_*() followed =
by
> > devm_*() calls in the probe.
> >
>
> I had missed there are now devm_pm_runtime calls, I will switch
> to that. But I would like to understand the wrong order, remove
> will be called before the devm bits are destroyed and it seems
> reasonable to disable the pm_runtime before destroying the
> pinctrl device. What exactly would run in the wrong order here?

At the ->remove() stage after this call an IRQ can be fired (or on SMP
systems any other APIs can be called), for example. So, would it be a
problem to service it with PM disabled?

But in any case the shuffling ordering like this is prone to subtle
bugs. I prefer to have strict ordering if there is nothing preventing
from doing that way.

--=20
With Best Regards,
Andy Shevchenko
