Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D3668F15F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 15:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjBHOzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 09:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjBHOzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 09:55:36 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A464B770
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 06:55:31 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id u7so148211ybk.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 06:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C9FYaHZff0n04HIlu0pgHp/yoYQMAR6EN4kK+A76acU=;
        b=IIUuXKjbtNG+brYJkm3mEz/Fq2Pb+VqZxm9M/D7mrcI0D62GgsPuJzrGVbt3bjOgAe
         FKHgjDRBffBmgUhp+Zqa3GhW+SJYVkyXIOx4UZjGR/NTZwRH+8Ec9dhaymaPJYoDF/ul
         uhZIWfEjC/tNp17EsrH4ckdmUbeyIs5G5o9m7zp+yGzEj3sRZGfW5ns8qaXo3UmiN25P
         jXTHx/9TXUF8ZpeVstcTHKPqER+clJey1/KPBN1LViaw99zwQggNemG7kwAykjT9Ya89
         TEAScCGhuWQAgdfnh+kSg3K5nsReT9OKxs5o5HSi74s3waAxRJs36+1uPauU5VDw9KHc
         l0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9FYaHZff0n04HIlu0pgHp/yoYQMAR6EN4kK+A76acU=;
        b=aaxIxeaOEFIJomDu0ZUw9ptOk1fGcd96kPHHHIUVOLfNSw9PkZnbeVBniVydSixiXR
         BPPg6hhfiUydQJSKkFaVKbCOfwwvWD7daA+2q9ClgTN9G6ww31WBnBe4gsvBBJj/pWoP
         cDuKD6Oxytv7GsXpRe0zQ2re9qwfdEsJNOLC2AN2anNK1CR+Q2qn6t7W/+d1GDRA5pYy
         OSm4j/+0SwdnGDUVwdxR146eKOdfocnii+7O0wrniPaa+XrZ/s/bZYDtzNi0jlIx54w7
         ZSaEflH7Ah35Dh55cqDjQ566PpWBwBq1T9liNS79EuZ8Z7VLppaXmkc+aoh9yW1jWXpH
         QXYA==
X-Gm-Message-State: AO0yUKW+51zHoaGhtkD71GnfBiHR9w3ZZU3EIM56tJLCFLMthb0mwxad
        Wu5SrofU08InsJSbpl0QrUkZKew06+wY9WdGy558JGz9qlb8ww==
X-Google-Smtp-Source: AK7set9QWN7XZu0/Jygke0mZWpl6dDT6sBRDV263lswVqW9oVhi8Kruq1x//EDsHd+Bda51X+66lj6ea/+9i3ige8Q4=
X-Received: by 2002:a5b:6c5:0:b0:88f:946:bd98 with SMTP id r5-20020a5b06c5000000b0088f0946bd98mr1003903ybq.24.1675868130850;
 Wed, 08 Feb 2023 06:55:30 -0800 (PST)
MIME-Version: 1.0
References: <20230207142952.51844-1-andriy.shevchenko@linux.intel.com>
 <20230207142952.51844-7-andriy.shevchenko@linux.intel.com>
 <CACRpkdaPgjDijPjCdinWy5_Rd8g3idv-8K=YPTv5iTfJKFuJfw@mail.gmail.com>
 <Y+LWyc4rqCVq5hEi@smile.fi.intel.com> <Y+O2/dVDcvnXByc+@smile.fi.intel.com>
In-Reply-To: <Y+O2/dVDcvnXByc+@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 8 Feb 2023 15:55:19 +0100
Message-ID: <CACRpkdacHyxPKg=Dw4xdpOPZUMMNsFAuVRuSo1093E_j4a+W-Q@mail.gmail.com>
Subject: Re: [PATCH v3 06/12] gpiolib: split linux/gpio/driver.h out of linux/gpio.h
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-input@vger.kernel.org,
        linux-media@vger.kernel.org, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 8, 2023 at 3:51 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Wed, Feb 08, 2023 at 12:55:06AM +0200, Andy Shevchenko wrote:
> > On Tue, Feb 07, 2023 at 03:55:23PM +0100, Linus Walleij wrote:
> > > On Tue, Feb 7, 2023 at 3:29 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > > From: Arnd Bergmann <arnd@arndb.de>
> > > >
> > > > Almost all gpio drivers include linux/gpio/driver.h, and other
> > > > files should not rely on includes from this header.
> > > >
> > > > Remove the indirect include from here and include the correct
> > > > headers directly from where they are used.
> >
> > ...
> >
> > > Make sure you push this to the kernel.org build servers (zeroday builds),
> >
> > Of course, that is the purpose of publishing this before the release (so we
> > will have some TODO list that eventually this can be applied for v6.4-rc1).
> >
> > > I think this patch needs to hit some more files, in my tests with a similar
> > > patch at least these:
> >
> > Right. I forgot to also incorporate your stuff into this series.
> > Do you have anything that I can take as is?
>
> I'm going to incorporate the following:
>
>         gpio: Make the legacy <linux/gpio.h> consumer-only
>         ARM: s3c24xx: Use the right include
>         ARM: orion/gpio: Use the right include
>         hte: tegra-194: Use proper includes
>         pcmcia: pxa2xx_viper: Include dependency

Excellent, thanks. I don't care about being credited, just want things
to go smooth so you run into less snags.

Yours,
Linus Walleij
