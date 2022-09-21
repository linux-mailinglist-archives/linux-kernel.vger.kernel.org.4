Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFC25BF316
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 03:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiIUBtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 21:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiIUBs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 21:48:59 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE797C1D3;
        Tue, 20 Sep 2022 18:48:57 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id ay9so3206024qtb.0;
        Tue, 20 Sep 2022 18:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=30wLobZRnFv5zggcZVF2u6wy/96nEdpY/Ifl53dhDFM=;
        b=KPvreMS9cTD4YrMaMm0W35RXTuEm5G6cH9FqS5KKO/LdRVMrIzDCLbnnVsrr0aTF+M
         N637xD82AWRAKw0fe2ZZFejrBD5iZfaLPj7akR8TDl8QqRK0Yc5StwWzkJAPUv82OBe5
         /c2X2yf41KWii3ok0Kn/9kOU36HeBguY2Dz/Nekfnnij3EQIY9nBLl/PaKGQDi4oi4Pv
         sFFueSJMtV98szCHTj+aEUPa7E9SkqEuBaE5mBsjXhajCK1zmtmoHLWetEldHrvED/r1
         niPKxhRbwuOMZGoYphFO68twpl4C32uW7DWmlFLSVhE+W8Kl2AE0vv97jtpm6LZp1X+0
         OkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=30wLobZRnFv5zggcZVF2u6wy/96nEdpY/Ifl53dhDFM=;
        b=4MXmWQ8o6VB7a7PHM66oXmBJE7SyE4b8MhskixzkslgKDYI9gVaujUjD+kceTgFJsX
         3FMSWvly2HZOPTxP1YxOpQHtS1xv0BW+9Q45ET8gspfWBcnD9YJ8iiMt4X/pD/NsttyG
         5fVoAKozHSX6BM4AKnTkVevrYPFu5oepYFdUur4m4O6j/bqucRn4Vw3eqDSLsVLMyAZn
         S9qq3GnYLZ1TY+Ag1ekEmaEBDzoYaIoLvMFE6bJ/51XbOLqgNA5tagY3Iw5EE/dicpvE
         1ijm4ArWEKiijXZple/mYW/WrsTFoIfROmgurK3bJdZU+P4LKxo/N7SGNwxvV8/NtmLF
         XPDw==
X-Gm-Message-State: ACrzQf2G9o9MmC1j8yGLRU8ULiWDQfFWm1hS953zimbK4J6G5UYNtsGA
        d0vYI1oGPMCNLZFOd+c/b6OlUjtSPqrR1U9sbkA=
X-Google-Smtp-Source: AMsMyM7bBhxaQAfT+rCoAiTyYG/eF3l1J9PoSVv3K9nIjI5BkzQczZAqbJin74KiibXz/4K0z0LmAcynXI+rqdfngVA=
X-Received: by 2002:a05:622a:48c:b0:35c:d99a:3002 with SMTP id
 p12-20020a05622a048c00b0035cd99a3002mr17703201qtx.564.1663724937128; Tue, 20
 Sep 2022 18:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220830034042.9354-2-peterwu.pub@gmail.com> <20220830034042.9354-10-peterwu.pub@gmail.com>
 <CAPOBaE7rz2F-sij-LbYau6TRxFoOfmoUc=R__Z7iUrFWmZPgrg@mail.gmail.com>
In-Reply-To: <CAPOBaE7rz2F-sij-LbYau6TRxFoOfmoUc=R__Z7iUrFWmZPgrg@mail.gmail.com>
From:   ChiaEn Wu <peterwu.pub@gmail.com>
Date:   Wed, 21 Sep 2022 09:48:21 +0800
Message-ID: <CABtFH5+PuK4vptVNmpn4h2FCxNFp3wWvhUrOxgqArx4YxCY99w@mail.gmail.com>
Subject: Re: [PATCH v9 09/10] leds: flash: mt6370: Add MediaTek MT6370
 flashlight support
To:     Han Jingoo <jingoohan1@gmail.com>
Cc:     lee@kernel.org, Daniel Thompson <daniel.thompson@linaro.org>,
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
        szuni chen <szunichen@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
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

On Sun, Sep 18, 2022 at 3:22 AM Han Jingoo <jingoohan1@gmail.com> wrote:
>
> On Mon, Aug 29, 2022 ChiaEn Wu <peterwu.pub@gmail.com> wrote:

...

> > +#define MT6370_ITORCH_MIN_uA           25000
> > +#define MT6370_ITORCH_STEP_uA          12500
> > +#define MT6370_ITORCH_MAX_uA           400000
> > +#define MT6370_ITORCH_DOUBLE_MAX_uA    800000
> > +#define MT6370_ISTRB_MIN_uA            50000
> > +#define MT6370_ISTRB_STEP_uA           12500
> > +#define MT6370_ISTRB_MAX_uA            1500000
> > +#define MT6370_ISTRB_DOUBLE_MAX_uA     3000000
>
> Use upper letters as below:
>
> #define MT6370_ITORCH_MIN_UA           25000
> #define MT6370_ITORCH_STEP_UA          12500
> #define MT6370_ITORCH_MAX_UA           400000
> #define MT6370_ITORCH_DOUBLE_MAX_UA    800000
> #define MT6370_ISTRB_MIN_UA            50000
> #define MT6370_ISTRB_STEP_UA           12500
> #define MT6370_ISTRB_MAX_UA            1500000
> #define MT6370_ISTRB_DOUBLE_MAX_UA     3000000
>
>
> > +#define MT6370_STRBTO_MIN_US           64000
> > +#define MT6370_STRBTO_STEP_US          32000
> > +#define MT6370_STRBTO_MAX_US           2432000
> > +

Hi Jingoo,

This coding style is in accordance with Andy's opinion in this mail:
https://lore.kernel.org/linux-arm-kernel/CAHp75Vciq4M4kVrabNV9vTLLcd1vR=bMe8JLEdAF9MkRTpcB5g@mail.gmail.com/

And I will revise other parts in v12.
Thanks for your review!

--
Best Regards,
ChiaEn Wu
