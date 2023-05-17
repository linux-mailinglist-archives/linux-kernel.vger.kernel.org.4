Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAD170746A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjEQVgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEQVgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:36:40 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23808173F
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:36:39 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-561b50c1856so15823377b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684359398; x=1686951398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cY/eQ57fs7dlsVatS+jhyTGHg7yG2gHeDPH1M03tXUo=;
        b=irhJRAZwAa+Gz1ebjP8wNR2BRjZ5Zj07hEtQe4UvjcUFgzjGovspvZeA/w3QdqXsS+
         lJJbkj+3CaoQ+fAEvdkw4718cc3C3dx6NYhWfOJ1i8oYKYlkR9TPkLuiYZLgdW8hsG8t
         XWe9WwmmeT20MQwLbZ6Q3D3vHXl93BrmscrfPN0tDA1Tx+CkAI/aN+Ci8Ak6Rl0iS9Pn
         idxE4AUkf+FVu7lfpHsVt+wtoFI81duKbgfNn3xHbH5V+Me84d6ISJVf37U5UU+1m4AU
         ieEV8WtukMZAEkzoJzomR6uwI8vYg8OVdyOorRQU3YNGZ11A8/p8eTt9YQEojj4/AEWh
         F5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684359398; x=1686951398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cY/eQ57fs7dlsVatS+jhyTGHg7yG2gHeDPH1M03tXUo=;
        b=lYcGlvct5Our1usPyp1XO1Rm87IL98aOZVc8DPVvQ8lFcmvbZNZfLfK6nbhsTMOd8m
         r2q4I5rkbxUG3qxpTtYfpKEG05Y5h7AU5CsgfmUaoo5xsXDx0Dq/+GYrFsviPXpKRitw
         e7Krd5M+Hl4ZMHRCgmzPTWBFs7lrjKMN/+i/ojAP5WjsOvZ8L8NCW+0kADAUCgEejiBB
         Y+Z1Xxhu80hyfkFPOTsUdkvD5jCx3GcRW9qa2PhdW0MD0V6myDAal2SxwC60Joa7fmWD
         Mq7uJte+0bdXFkKmQBvsNLrt9JZxb1+6RZHHN1s2B3zgfBrjCIGnoA2cfmRe8pfwylh4
         IeZQ==
X-Gm-Message-State: AC+VfDxCOGzKmzz4urNm78UUoUSSykUVEShnW1Wz1aNssVOn6k+NAxrm
        Ilx1pPY4RajNcHLaEB7p4+dTWi/3/E3VVPBMMBAYQg==
X-Google-Smtp-Source: ACHHUZ4pIBn19+BLD6UElqlgO1dKdZPd0Ga1Aky4aWI+i3dEfXBJQZ1abYF5itannmQlr0DCkYCOVvzdFktxBrZVq/A=
X-Received: by 2002:a0d:cc56:0:b0:561:e7bb:1b20 with SMTP id
 o83-20020a0dcc56000000b00561e7bb1b20mr1351592ywd.34.1684359398379; Wed, 17
 May 2023 14:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230430-nokia770-regression-v4-0-9b6dc5536b17@linaro.org>
 <20230430-nokia770-regression-v4-2-9b6dc5536b17@linaro.org> <20230517203011.GH271152@darkstar.musicnaut.iki.fi>
In-Reply-To: <20230517203011.GH271152@darkstar.musicnaut.iki.fi>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 17 May 2023 23:36:26 +0200
Message-ID: <CACRpkdb0uSkfQZxZ_mpesGSjvf0gZzaZyw5iV1haAovH8cfngA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] ARM/mmc: Convert old mmci-omap to GPIO descriptors
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Helge Deller <deller@gmx.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 10:30=E2=80=AFPM Aaro Koskinen <aaro.koskinen@iki.f=
i> wrote:

> This one has some issue as mmci-omap is unable to find the GPIOs on 770.
>
> On Mon, May 08, 2023 at 11:20:07PM +0200, Linus Walleij wrote:
> > +static struct gpiod_lookup_table nokia770_mmc_gpio_table =3D {
> > +     .dev_id =3D "mmci-omap",
>
> Changing this to "mmci-omap.1" helped, not sure if that is a correct way.
> Most likely N800 and N810 are broken as well.

Yep looked over it, OMAP1 has mmci-omap.1 and OMAP2 has
mmci-omap.0.

Yours,
Linus Walleij
