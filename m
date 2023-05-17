Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BC3706A66
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjEQOAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjEQOAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:00:35 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2B67292;
        Wed, 17 May 2023 07:00:28 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-61b5a653df7so6681576d6.0;
        Wed, 17 May 2023 07:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684332028; x=1686924028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kF/bfVMkR2h3+gHlTD2VrM3fzaZfhgR5R+8jewhi4kQ=;
        b=f79+NO3WafffxprPEUX+MpIWRo6r4PqFlcXxubPrc5PoTBP656Fn9Mcm7a2mwB5G7C
         w5UPPUw1EMxkhtW6Zv4TXzVfEg5MZrMiduqd66tOriGLtyCimkn9S3lGxNBnKtYQM3+G
         +pwFiCW5l91dJjXzmS0TzXb2KtnyyCo685VDetUFEshUciT7yPMPbB68DIrs3wtHC3VG
         3wG3jdPdkaBHkOdGh7NDRnIsj4vwiuqnHYsMfDz++4ij673rakRNl8aEW4I9PSMiTuUD
         5l/IqeFpNgqz7FYStFzg/tpoDw+DOHF0/ExUT2Fn/t9nV0oF9qRRSmsogt3yNtf+S7/o
         M0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684332028; x=1686924028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kF/bfVMkR2h3+gHlTD2VrM3fzaZfhgR5R+8jewhi4kQ=;
        b=IXG0KDX8L0bP3EriR/dl3WK+Ic5teW3Oa3NKgGS9aZiAshGnxb07Xi5FKooTDUxSfP
         SDppVS3lr5HGo4+x6dkWup4qkCw3UZ8wcDXg4Zxg4XDmo4wnV5S1HTRlaWuFwGpvSujp
         9OuGZGPaGOMqtEPgeQS3INX6wHDvUfuWgvKndLtvk5qSRZIGCUdoPzs5lkxcnm+oFb39
         pePcLHgozGpIzHJvemld7unYbnBAW34qUk6bY3RbhqNfdrfPv9925gxNV3WnNFcGM/3I
         dGQVOq6ITFNDSGljR2oeZc8qw/WYRY0JJbtPSbJeByLLDCkIT2y2LX0c4ujOaRirM3Wt
         8y+A==
X-Gm-Message-State: AC+VfDzw4mYw3m7vcMRFvA8X80Rcv1nVi73sK5GZAMXyZ7p3g3JnuZd6
        EPOjiBQlsCOfY7+heniyj8uLUNmevs//Y0WAmiU=
X-Google-Smtp-Source: ACHHUZ5dgDWb+fDdj9ateE9Q5/4olnyjZM5M0pe72NMZbgcEFxb1cJTJVSxAul4O+5JAir2aZNO7h0ejLa3/duMEZP8=
X-Received: by 2002:a05:6214:d03:b0:623:46d8:535 with SMTP id
 3-20020a0562140d0300b0062346d80535mr24128643qvh.34.1684332026063; Wed, 17 May
 2023 07:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-9-ckeepax@opensource.cirrus.com> <ZF6RMqElYZVMpWRt@surfacebook>
 <20230515101350.GS68926@ediswmail.ad.cirrus.com> <CAHp75Vcizrucc-2KFdFNeHNrxCzz4GwX1OzZYyjPH7P9RgnKYQ@mail.gmail.com>
 <20230517101301.GV68926@ediswmail.ad.cirrus.com>
In-Reply-To: <20230517101301.GV68926@ediswmail.ad.cirrus.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 17 May 2023 16:59:50 +0300
Message-ID: <CAHp75VchpbiYcd2yaP1WTjX17P0hg3qON5JGAXu08aDVw6Ydkw@mail.gmail.com>
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

On Wed, May 17, 2023 at 1:13=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> On Tue, May 16, 2023 at 10:03:45PM +0300, Andy Shevchenko wrote:
> > On Mon, May 15, 2023 at 1:13=E2=80=AFPM Charles Keepax
> > <ckeepax@opensource.cirrus.com> wrote:
> > > On Fri, May 12, 2023 at 10:19:14PM +0300, andy.shevchenko@gmail.com w=
rote:
> > > > Fri, May 12, 2023 at 01:28:36PM +0100, Charles Keepax kirjoitti:
> > > > > +   if (!of_property_read_bool(dev_of_node(cs42l43->dev), "gpio-r=
anges")) {
> > > > > +           ret =3D gpiochip_add_pin_range(&priv->gpio_chip, priv=
->gpio_chip.label,
> > > > > +                                        0, 0, CS42L43_NUM_GPIOS)=
;
> > > > > +           if (ret) {
> > > > > +                   dev_err(priv->dev, "Failed to add GPIO pin ra=
nge: %d\n", ret);
> > > > > +                   goto err_pm;
> > > > > +           }
> > > > > +   }
> > > >
> > > > Besides the fact that we have a callback for this, why GPIO library=
 can't
> > > > handle this for you already?
> > >
> > > Apologies but I am not quite sure I follow you, in the device
> > > tree case this will be handled by the GPIO library. But for ACPI
> > > this information does not exist so has to be called manually, the
> > > library does not necessarily know which values to call with,
> > > although admittedly our case is trivial but not all are.
> >
> > Why can't the firmware provide this information? _DSD() is a part of
> > ACPI v5.1 IIRC.
>
> I am very very far from confident we can guarantee that will be
> present in the ACPI. The ACPI is typically made for and by the
> Windows side.

Why? You may insist firmware vendors / OEMs to use that as a
requirement to the platforms that would like to use your chip. The
_DSD() is part of the specification, I don't see how the above can be
an argument.

The times when ACPI =3D=3D Windows are quite behind.

> > Although it might require moving some code from gpiolib-of.c to
> > gpiolib.c with replacing OF APIs with agnostic ones.
>
> I really think if we want to start doing things that way on ACPI
> platforms someone with a little more clout than us needs to start
> doing it first. If Intel or someone was doing it that way it
> might give us a little more levelage to push it as being the
> "correct" way to do it.

So, we have the meta-acpi [1] project which contains dozens of
examples on how ACPI DSD is being used for real devices, besides some
documentation in the Linux kernel.

> I will switch to the callback, but really don't think we can rely
> on this being in DSD yet.

Why not?

...

> > > I had missed there are now devm_pm_runtime calls,

Btw, even if there is no such API one can always call
devm_add_action() / devm_add_action_or_reset() to open code such a
call.

> > > I will switch
> > > to that. But I would like to understand the wrong order, remove
> > > will be called before the devm bits are destroyed and it seems
> > > reasonable to disable the pm_runtime before destroying the
> > > pinctrl device. What exactly would run in the wrong order here?
> >
> > At the ->remove() stage after this call an IRQ can be fired (or on SMP
> > systems any other APIs can be called), for example. So, would it be a
> > problem to service it with PM disabled?
> >
> > But in any case the shuffling ordering like this is prone to subtle
> > bugs. I prefer to have strict ordering if there is nothing preventing
> > from doing that way.
>
> Yeah happy enough to use devm_ here, just didn't know it existed
> and wanted to better understand your concerns as I was having
> difficulty seeing the issue.

Ah, you are welcome!

...

[1]: https://github.com/westeri/meta-acpi/tree/master/recipes-bsp/acpi-tabl=
es/samples
(mostly under edison/ folder)

--=20
With Best Regards,
Andy Shevchenko
