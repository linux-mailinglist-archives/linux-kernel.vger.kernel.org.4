Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876D2723B2B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235898AbjFFISG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235893AbjFFISB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:18:01 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8728D123
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 01:17:58 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-30e5289105cso54583f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 01:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686039477; x=1688631477;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cSpRJEPqPVqhoSAFcxKLrdKHmoUN6BNCQfphia1KCDc=;
        b=Mpc+MQI1MneytiHZlBGaFATUvZ2D7UN1Dd8CesjFWTyP49rsZyjD8jnaaR2NWOdDYa
         ipHtgV6xxEWHjDPiqr2vBbciA3+K0fJJ7K1xXjC7+LEEVocVIIUJi94ZOqHXXoTSgzrG
         mxeqOJel8vvWWKD6+i5csIDgelH/jVykDsjgcbudQFFfZ7CAf/f920BH4IoknBSQ53hq
         hYHtrf7a3GRFH2D0iZ/WCyHV6yJHs8gv/lj4ehZmceJwESSII8vcD1ixg8gZhNul0KKy
         68n7AIGGrWW/DnIWzedWWopU6PP+9paqpLoKdw2Qdi7FG3cHOBeBfAZJZ1pCvU6/Hl6d
         tABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686039477; x=1688631477;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cSpRJEPqPVqhoSAFcxKLrdKHmoUN6BNCQfphia1KCDc=;
        b=AwUyFOmoeZxMd/jGnlxnnJ3muD1hYg0aVSI3zRGKH7lJrxFh0Aw10Ry2wNCele2kFi
         sJGNHQDsfEiBWruET4WNCypYqi4+67WkaGEv5eShvSloviOCll4zSY3jWCnoikpBWJ5b
         8DasVUQXeL/tPy74hQlhN65pyVNoSZPfYfYVQxhj1b0yavX5Sw47Ai58Qb06pohH7/9+
         5sT9X/c37pGzn1n+uD++pUeAlNPkd8VtH1rWlnnBIcffOmaCaQCzGirDOx0O1BPBwcae
         KJAE3GlxJ+GyOweW+BhVVSOgAaOzMbofNwMZ/MHbuspKWOONHCXU+tLDi11dMzvhyE6E
         yB5A==
X-Gm-Message-State: AC+VfDzs1zPcwzHAHqtJ+NsCkgaQVlV67q8cdfeeZpfDTu1BuDdC52Z6
        GI8WSNLuOsAmCBvPr3bpxvNKow==
X-Google-Smtp-Source: ACHHUZ7IXBOZigfcocE6Us3xOMsMk/mjRsDKCskt5eDsJGA9seSXJvit+vkIb+CpvRFtcFD997m2jg==
X-Received: by 2002:adf:e446:0:b0:2fe:e455:666c with SMTP id t6-20020adfe446000000b002fee455666cmr8811328wrm.33.1686039476965;
        Tue, 06 Jun 2023 01:17:56 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d4cc1000000b002fda1b12a0bsm11907760wrt.2.2023.06.06.01.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 01:17:56 -0700 (PDT)
Date:   Tue, 6 Jun 2023 09:17:54 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v1 1/1] backlight: hx8357: Convert to agnostic GPIO API
Message-ID: <20230606081754.GA218497@aspen.lan>
References: <20230317185230.46189-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdYXTk2pzXEM9MTjt=oT-CbhENABSLeb9dN7ZvEy8oqiag@mail.gmail.com>
 <ZBhJctqSkdtoUmBi@smile.fi.intel.com>
 <ZH4IPJuPoX3gi5Ga@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZH4IPJuPoX3gi5Ga@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 07:07:24PM +0300, Andy Shevchenko wrote:
> On Mon, Mar 20, 2023 at 01:54:26PM +0200, Andy Shevchenko wrote:
> > On Fri, Mar 17, 2023 at 09:53:40PM +0100, Linus Walleij wrote:
> > > On Fri, Mar 17, 2023 at 7:51 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > > The of_gpio.h is going to be removed. In preparation of that convert
> > > > the driver to the agnostic API.
> > > >
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >
> > > Thanks for fixing this Andy!
> > >
> > > > -#if !IS_ENABLED(CONFIG_LCD_HX8357)
> > > > +#if IS_ENABLED(CONFIG_LCD_HX8357)
> > > >                 /*
> > > >                  * Himax LCD controllers used incorrectly named
> > > >                  * "gpios-reset" property and also specified wrong
> > > > @@ -452,7 +452,7 @@ static struct gpio_desc *of_find_gpio_rename(struct device_node *np,
> > > >                  */
> > > >                 const char *compatible;
> > > >         } gpios[] = {
> > > > -#if !IS_ENABLED(CONFIG_LCD_HX8357)
> > > > +#if IS_ENABLED(CONFIG_LCD_HX8357)
> > > >                 /* Himax LCD controllers used "gpios-reset" */
> > > >                 { "reset",      "gpios-reset",  "himax,hx8357" },
> > > >                 { "reset",      "gpios-reset",  "himax,hx8369" },
> > >
> > > Eh what happened here .. it's even intuitively wrong.
> >
> > I believe it had to be something  like
> >
> > 	#if 0 && IS_ENABLED()
> >
> > to show that this change is for the future.
> > Currently it does something unneeded for the kernels with that option off.
> >
> > > I would add
> > > Fixes: fbbbcd177a27 ("gpiolib: of: add quirk for locating reset lines
> > > with legacy bindings")
> >
> > I'm not sure. But it's fine, I can add it. Just want to double confirm
> > you really want this Fixes tag.
> >
> > > It wasn't used until now it seems so not a regression and no
> > > need for a separate patch.
> >
> > Exactly why I'm not sure about the tag :-)
> >
> > > Other than that it looks correct.
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Thank you!
>
> Lee, is anything I can do here to move this forward?

Backlight code looks OK to me (although I might regard the Fixes:
discussion as unresolved)there is an unresolved):
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
