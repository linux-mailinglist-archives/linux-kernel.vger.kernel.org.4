Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AE15BFD52
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 13:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiIULt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 07:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiIULtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 07:49:24 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B63495E49;
        Wed, 21 Sep 2022 04:48:24 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id a20so3810283qtw.10;
        Wed, 21 Sep 2022 04:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=HcWKSOQfnh3ALysQmzthyFKSaMJvE4eOBrZ5WykYnf0=;
        b=HfVB+cBHeUsQkTV1IF9sAKMKS/kfT/Ev0F60sC685i2kFcutzNrfuaR5hD53IQByBD
         9jivhTdsPvvs9lm5s9kXj+as2t8kAgL1f43MFcqX9USDOu2lzD+2ybZqMBbG4XjQgQ4Y
         jgCd4dOsRnsjo+D/4PaHD504CDzEYM9SJ2KgM046n1ux86DUbQlEjZm/iIajLF0rSeEV
         P//RD6N416qpoC6TwB3WBhbRgASsfx49tC7zYBmYWU1FUcKvYqXMPYCf8BhyzBlmv2s2
         9Zr3PFAQ2AikJFRKDDuta9GMnT5+GY/mdV/Fqdk13QWG5P6njup+PIsHziVHd+GZKtJz
         y93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=HcWKSOQfnh3ALysQmzthyFKSaMJvE4eOBrZ5WykYnf0=;
        b=t1KWZ3zTwyO/XVYH9VuY6mGtk7eJzlqsNwemTDPChMdc6/D4I+b/A4QNx200EEB4Hs
         IOL9CKXwCOf3DrRPKD7lfSNkZ4QLX0BkF4h8z+RAxcrWbFdOCPnQCfxvIp8T7IgXCgEx
         A6cBV85TslTyL3Rg8ZWzOGmjk/v2jcgMlpVAe/rB11ketIUCOXqrV/u8wO3NcHaToZXW
         ZRtu7ZQwlJck8FXrDrNc6xxEioVHH/Lyy3+0lkc8oTAP3YxN8k7Nj475ygrjBSlTlZ6D
         xeo3CVOjR9T8FOx7cvhtbMuAAyhRJDGW8kIq2KC4MbrEqg99XjOtpyDe9tq5vl96pKYQ
         mQOg==
X-Gm-Message-State: ACrzQf3mzjaIgCA/IXIesECcVYpiw8opqdb1xl/IoUyA5Ycma0BJVIf3
        9O/1trs1RtuzzNp7/g2SwwD1ZHu8FEZRyGtx+t8=
X-Google-Smtp-Source: AMsMyM6G55bRb+0Lbv2MWoChlYMO/VkxvcVvZF6+qxE/8auesJXC3OqMo6uD5hrChQNEavPXUJ5w0Du+HXIis6UE2X0=
X-Received: by 2002:ac8:5e07:0:b0:35c:e7fd:1e94 with SMTP id
 h7-20020ac85e07000000b0035ce7fd1e94mr12904471qtx.384.1663760894316; Wed, 21
 Sep 2022 04:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220830034042.9354-2-peterwu.pub@gmail.com> <20220830034042.9354-10-peterwu.pub@gmail.com>
 <CAPOBaE7rz2F-sij-LbYau6TRxFoOfmoUc=R__Z7iUrFWmZPgrg@mail.gmail.com> <CABtFH5+PuK4vptVNmpn4h2FCxNFp3wWvhUrOxgqArx4YxCY99w@mail.gmail.com>
In-Reply-To: <CABtFH5+PuK4vptVNmpn4h2FCxNFp3wWvhUrOxgqArx4YxCY99w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 21 Sep 2022 14:47:38 +0300
Message-ID: <CAHp75VeRgRdv54yO51nBwKx8O2pNLvOD2mrqn31zvx4ffSpCHw@mail.gmail.com>
Subject: Re: [PATCH v9 09/10] leds: flash: mt6370: Add MediaTek MT6370
 flashlight support
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     Han Jingoo <jingoohan1@gmail.com>, lee@kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Helge Deller <deller@gmx.de>, Mark Brown <broonie@kernel.org>,
        mazziesaccount@gmail.com, andriy.shevchenko@linux.intel.com,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Alice Chen <alice_chen@richtek.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        szuni chen <szunichen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 4:48 AM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
> On Sun, Sep 18, 2022 at 3:22 AM Han Jingoo <jingoohan1@gmail.com> wrote:
> > On Mon, Aug 29, 2022 ChiaEn Wu <peterwu.pub@gmail.com> wrote:

> > > +#define MT6370_ITORCH_MIN_uA           25000
> > > +#define MT6370_ITORCH_STEP_uA          12500
> > > +#define MT6370_ITORCH_MAX_uA           400000
> > > +#define MT6370_ITORCH_DOUBLE_MAX_uA    800000
> > > +#define MT6370_ISTRB_MIN_uA            50000
> > > +#define MT6370_ISTRB_STEP_uA           12500
> > > +#define MT6370_ISTRB_MAX_uA            1500000
> > > +#define MT6370_ISTRB_DOUBLE_MAX_uA     3000000
> >
> > Use upper letters as below:

For microseconds (and other -seconds) the common practice (I assume
historically) is to use upper letters, indeed. But for current it's
more natural to use small letters for unit multiplier as it's easier
to read and understand.

> > #define MT6370_ITORCH_MIN_UA           25000
> > #define MT6370_ITORCH_STEP_UA          12500
> > #define MT6370_ITORCH_MAX_UA           400000
> > #define MT6370_ITORCH_DOUBLE_MAX_UA    800000
> > #define MT6370_ISTRB_MIN_UA            50000
> > #define MT6370_ISTRB_STEP_UA           12500
> > #define MT6370_ISTRB_MAX_UA            1500000
> > #define MT6370_ISTRB_DOUBLE_MAX_UA     3000000
> >
> > > +#define MT6370_STRBTO_MIN_US           64000
> > > +#define MT6370_STRBTO_STEP_US          32000
> > > +#define MT6370_STRBTO_MAX_US           2432000
>
> Hi Jingoo,
>
> This coding style is in accordance with Andy's opinion in this mail:
> https://lore.kernel.org/linux-arm-kernel/CAHp75Vciq4M4kVrabNV9vTLLcd1vR=bMe8JLEdAF9MkRTpcB5g@mail.gmail.com/

True.

-- 
With Best Regards,
Andy Shevchenko
