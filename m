Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8B55E8500
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 23:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbiIWVe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 17:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiIWVeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 17:34:21 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F88274CC1;
        Fri, 23 Sep 2022 14:34:20 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id y8so1830539edc.10;
        Fri, 23 Sep 2022 14:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=2tSqnggIyDo6YUr0zNltSFoKVKbExYQv0L5PsQaqx/s=;
        b=mC5OTEroAwnh1aV0/k1oPe+NXV0TA7Ze+A1xSqjAYtWFHQmQllTO2D5NFTgRNAaYmT
         9ftX5WSLtzU2ypfDMT3O8sHcHAnbhOQyP3iw/qBmEo1MS7KrHK9T7qMSNgKzSJ+gKYID
         /abixiX9djqlc0Y/J/wim5USaRy8aF+H2vHddS2/BtkRSL/9hE50+MF2PbOdi3Sk2Gl6
         VosQoBRGmWXFe5bsDbIbt+mPWxWzs9fsS3VkuvMuKTsQce3IGe9Tc+oS/HXH/f+GD3ev
         uHxxaisRU0SVBPc0aV+ppRW6J8ERcyNX4rsfpw6JIQ1m3AX4/2lvWnFKGIrpL0hEOzl5
         cXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=2tSqnggIyDo6YUr0zNltSFoKVKbExYQv0L5PsQaqx/s=;
        b=dyMjkE7b/TvmkmZl4axMAolpsFsoiL3ibg5RNQzAARoTsZhPA6rX96M+GJtt+mYSgr
         DGcuPNeaMApNymSNCXnB3AlXVz3f5u2zniamtO+NhxJwjdPK1sFj4TaE6FCvHAru5jiZ
         +DE/vtUyCW9LDV1i8bUqn/sCK3d0W8cGLQ0btzsf5jUOSpHPE01n8ooRT8d/CDpX/Uro
         P09eoV5ulAoNT+5SHngJzuOTdYuL2Y3ne22JboNk8m/YwEVVnGTzS2l2i7zTkdrlsr/z
         /XcSGVO4hRPa6nmr29WdqptfgCVcYDtjJ/Eo2KdVUgrL8Thy5Eg7k7CFZGubhh89JTRz
         rCLA==
X-Gm-Message-State: ACrzQf3iabMzNgr3frTTu6vgCeoH6qEtYwHqqz/UCTrxkHr6Sp+m3I2k
        dTFVpHipqawoSsYyndYwo67lmXKTPIRFH53uJOk=
X-Google-Smtp-Source: AMsMyM5IZsfJ8dcFfC0J6aK5kWjLl/L84uf2axz39u9HVDC/sm5vNCQLHxNNHmrmfV4MxviVVR/a5HiZQAJ2yKDCUpw=
X-Received: by 2002:a05:6402:1e8c:b0:44f:f70:e75e with SMTP id
 f12-20020a0564021e8c00b0044f0f70e75emr10298957edf.405.1663968858816; Fri, 23
 Sep 2022 14:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220830034042.9354-2-peterwu.pub@gmail.com> <20220830034042.9354-10-peterwu.pub@gmail.com>
 <CAPOBaE7rz2F-sij-LbYau6TRxFoOfmoUc=R__Z7iUrFWmZPgrg@mail.gmail.com>
 <CABtFH5+PuK4vptVNmpn4h2FCxNFp3wWvhUrOxgqArx4YxCY99w@mail.gmail.com> <CAHp75VeRgRdv54yO51nBwKx8O2pNLvOD2mrqn31zvx4ffSpCHw@mail.gmail.com>
In-Reply-To: <CAHp75VeRgRdv54yO51nBwKx8O2pNLvOD2mrqn31zvx4ffSpCHw@mail.gmail.com>
From:   Han Jingoo <jingoohan1@gmail.com>
Date:   Fri, 23 Sep 2022 14:34:07 -0700
Message-ID: <CAPOBaE7mcNqgQvsPpqewmq=Na9MC9RH5AW8CHn5ZJFAUsq6_eg@mail.gmail.com>
Subject: Re: [PATCH v9 09/10] leds: flash: mt6370: Add MediaTek MT6370
 flashlight support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        torvalds@linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>, Julia.Lawall@inria.fr,
        krzysztof.kozlowski@linaro.org
Cc:     ChiaEn Wu <peterwu.pub@gmail.com>, lee@kernel.org,
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Wed, Sep 21, 2022 at 4:48 AM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
> > On Sun, Sep 18, 2022 at 3:22 AM Han Jingoo <jingoohan1@gmail.com> wrote:
> > > On Mon, Aug 29, 2022 ChiaEn Wu <peterwu.pub@gmail.com> wrote:
>
> > > > +#define MT6370_ITORCH_MIN_uA           25000
> > > > +#define MT6370_ITORCH_STEP_uA          12500
> > > > +#define MT6370_ITORCH_MAX_uA           400000
> > > > +#define MT6370_ITORCH_DOUBLE_MAX_uA    800000
> > > > +#define MT6370_ISTRB_MIN_uA            50000
> > > > +#define MT6370_ISTRB_STEP_uA           12500
> > > > +#define MT6370_ISTRB_MAX_uA            1500000
> > > > +#define MT6370_ISTRB_DOUBLE_MAX_uA     3000000
> > >
> > > Use upper letters as below:
>
> For microseconds (and other -seconds) the common practice (I assume
> historically) is to use upper letters, indeed. But for current it's
> more natural to use small letters for unit multiplier as it's easier
> to read and understand.

(CC'ed Linus Torvalds, Andrew Morton, Joe Perches, Julia Lawall,
Krzysztof Kozlowski,)

Yep, it is common practice. Long time ago, I met the same problem on
how to present micro-ampere:
visibility vs coding practice. At that time, I followed the coding
practice. So, was there anyone who
rejected this decision to mix upper and lower letters when you gave
your comment last July?
If there is no objection, or most of maintainers and long-term
contributors agree with that,
I am ok with that.

To Tovalds, Andrew, Joe, Julia, Krzysztof,

I just need your feedback on coding styles. Are you ok with mixing
upper and lower letters for visibility
to present micro-seconds or micro-ampere? Andy (one of very-active
contributors) gives his opinion that
mixing upper and lower letters can be acceptable. I remain neutral on
this coding style issue.

e.g., #define MT6370_ITORCH_DOUBLE_MAX_uA    800000

Thank you.

Best regards,
Jingoo Han

>
> > > #define MT6370_ITORCH_MIN_UA           25000
> > > #define MT6370_ITORCH_STEP_UA          12500
> > > #define MT6370_ITORCH_MAX_UA           400000
> > > #define MT6370_ITORCH_DOUBLE_MAX_UA    800000
> > > #define MT6370_ISTRB_MIN_UA            50000
> > > #define MT6370_ISTRB_STEP_UA           12500
> > > #define MT6370_ISTRB_MAX_UA            1500000
> > > #define MT6370_ISTRB_DOUBLE_MAX_UA     3000000
> > >
> > > > +#define MT6370_STRBTO_MIN_US           64000
> > > > +#define MT6370_STRBTO_STEP_US          32000
> > > > +#define MT6370_STRBTO_MAX_US           2432000
> >
> > Hi Jingoo,
> >
> > This coding style is in accordance with Andy's opinion in this mail:
> > https://lore.kernel.org/linux-arm-kernel/CAHp75Vciq4M4kVrabNV9vTLLcd1vR=bMe8JLEdAF9MkRTpcB5g@mail.gmail.com/
>
> True.
>
> --
> With Best Regards,
> Andy Shevchenko
