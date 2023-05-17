Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D704706C24
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjEQPGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjEQPF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:05:58 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BA5AD27;
        Wed, 17 May 2023 08:05:19 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-6235aac00edso7908956d6.1;
        Wed, 17 May 2023 08:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684335919; x=1686927919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUgd8Z8Cw7pZWL5d1d5CDdQgCXfcppP5cODXNK/F1Es=;
        b=ARYpi0qG8DajvRnCV3QeKksPSfank93Wms0UWUi1jyw7RT7jDq4ikQpHdX5cb6olx4
         KNnZDqs+eViGPMYyWeorWoZFw/9MiF1ul5Agj5hsAGK8j0Wspfisn4rG8A5Zuu6FqiNI
         ka/prXZu9ywe9w/vc/QaYRAX6PSLYEx889ZOFHElh+4lnHJOeAQ7SOrpB2EWrTKbpi0c
         m/7xGJbPbjqbLbw6CimM+D2P6q5Qy8FDuZKg9J/mD+hAyqsgcTAQtBsw4mDvQql1+XQE
         ow5jt8tvrlAToU7y1R5lyn+f+kCbpkQXjfJCyErXrjoK7EKlaNDV2z7M9CIObslIcZRG
         Op2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335919; x=1686927919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUgd8Z8Cw7pZWL5d1d5CDdQgCXfcppP5cODXNK/F1Es=;
        b=OWdE7Ozeitc+4GQrRC41zD1iEFSrxLImQQJO1smd3CPjY302etdSvNBz07sNs7vGl8
         jFMcYmOK84HVV6jspwbzW/mb3mQd1/hrSEZqUIJdcIi0t2DkCnBr4OMXZK4pQMApSF8p
         1qOynoo+vwXkOpkVb0UUw+VW4V7AgiyiOrMd1HIqiN0GH0Zz1gxg0X+sL6f12sVHIUE5
         +pVwrABGG6IlSsRfICRntcboPAfWZ5fUsUAV2noNVM3mv+aU3dRN8tc/l0kTM9vcgppm
         Hy7F/JnKPQabYmWkzox+8ixJI+HyQv3goBuvjljIgxH+0bKBqjVLuaEUEp5RBM2O8szL
         L+6Q==
X-Gm-Message-State: AC+VfDw3WyKL3d8lrgeE4t8FKHGiDPIfmA+BIysinRkcEELDfzGAsX84
        th0P6ppYIITHY/x5tdBFRTxEo3fMSmmoZwEpM7w=
X-Google-Smtp-Source: ACHHUZ6mfAVYa+QMLH/avsDaoMdqB9wda5rGDnXcHLXzYgKy9oNT/orTQQgI8Lizixn+DFstVUAdkbwxmfXgGEYMPYM=
X-Received: by 2002:a05:6214:260e:b0:616:5c8b:582 with SMTP id
 gu14-20020a056214260e00b006165c8b0582mr76388369qvb.37.1684335918724; Wed, 17
 May 2023 08:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230512141755.1712358-1-eblanc@baylibre.com> <20230512141755.1712358-3-eblanc@baylibre.com>
 <ZF5yb4DbVDbfxVU4@surfacebook> <CSNQ2RRG7XDC.164H6P357UHSR@burritosblues>
 <CAHp75VdNgBv5yVTXzDpY3rrF31p=p99cfXdEs0q7m8VmLLJwbg@mail.gmail.com>
 <CSOGQIRNP61G.1Q2A4ZXB43YYQ@burritosblues> <CAHp75Vc-c=VU5Bfy5097z4wm43=bZ4LG83QBYV19YOrC7zSGag@mail.gmail.com>
 <CSOMS0W9MIUG.2MN43QZO9EX7Q@burritosblues>
In-Reply-To: <CSOMS0W9MIUG.2MN43QZO9EX7Q@burritosblues>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 17 May 2023 18:04:41 +0300
Message-ID: <CAHp75VeNvfDqkQZq_ghiv8vb2NaogKqkiFi9i0N3yLgA=ZTDbA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] pinctrl: tps6594: Add driver for TPS6594 pinctrl
 and GPIOs
To:     Esteban Blanc <eblanc@baylibre.com>
Cc:     linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com, sterzik@ti.com,
        u-kumar1@ti.com
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

On Wed, May 17, 2023 at 5:43=E2=80=AFPM Esteban Blanc <eblanc@baylibre.com>=
 wrote:
> On Wed May 17, 2023 at 3:51 PM CEST, Andy Shevchenko wrote:
> > On Wed, May 17, 2023 at 12:58=E2=80=AFPM Esteban Blanc <eblanc@baylibre=
.com> wrote:
> > > On Tue May 16, 2023 at 6:48 PM CEST, Andy Shevchenko wrote:
> > > > On Tue, May 16, 2023 at 4:05=E2=80=AFPM Esteban Blanc <eblanc@bayli=
bre.com> wrote:
> > > > > On Fri May 12, 2023 at 7:07 PM CEST,  wrote:
> > > > > > Fri, May 12, 2023 at 04:17:54PM +0200, Esteban Blanc kirjoitti:

...

> > > > > > > -#define TPS6594_REG_GPIOX_CONF(gpio_inst)          (0x31 + (=
gpio_inst))
> > > > > > > +#define TPS6594_REG_GPIO1_CONF                             0=
x31
> > > > > > > +#define TPS6594_REG_GPIOX_CONF(gpio_inst)  (TPS6594_REG_GPIO=
1_CONF + (gpio_inst))
> > > > > >
> > > > > > Why? The original code with parameter 0 will issue the same.
> > > > >
> > > > > I felt that replacing 0x31 with a constant would make the computa=
tion
> > > > > in TPS6594_REG_GPIOX_CONFIG more understandable. What do you thin=
k?
> > > >
> > > > The question is why that register is so special that you need to ha=
ve
> > > > it as a constant explicitly?
> > >
> > > It is not special, it's just the first one of the serie of config
> > > registers. I felt like just having 0x31 without context was a bit wei=
rd
> >
> > I'm not sure I understand what 'context' you are talking about.
> I was trying to convey the fact that 0x31 was representing
> TPS6594_REG_GPIO1_CONF address. This way when looking at
> TPS6594_REG_GPIOX_CONF(...), one will better understand that this macro
> is just about offsetting from the first GPIO_CONF register.

You can add a comment on top of the macro, so anybody can read and see
what this macro is doing.

> > This is pretty normal to have two kind of definitions (depending on the=
 case):
> > 1/
> >
> >   #define FOO_1 ...
> >   #define FOO_2 ...
> >
> > and so on
> >
> > 2/
> >
> >   #define FOO(x)  (... (x) ...)
> >
> > Having a mix of them seems quite unusual.
> I did not know that. I will revert this change for next version then.

Don't get me wrong, it's possible to have, but since it's unusual it
needs to be well justified. In the change you proposed you have
changed that, but I haven't seen where the new definition is used  (in
*.c files).

--=20
With Best Regards,
Andy Shevchenko
