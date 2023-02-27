Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F886A4D7C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 22:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjB0Voh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 16:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjB0Voe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 16:44:34 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66A44C36
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 13:44:33 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-536bf92b55cso214719117b3.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 13:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7No/fb1hUqIlhOqsZxkPFtEz/yzx2+/L+vbOcQnjALk=;
        b=zLa/3OsQm1HKMbIaXKi9ROoXPdZs7bgb2MnADumYHiQolo9XMnVtNZYAr3ty12zmzh
         nfZWcsrK/5FxJbSwe+99jxxN2XewjfAsFWPdXLUjOMF3De/YVmqEnCBdzv2kIn1uDNfr
         /3lsSRGLQeJl5Jw0t7JnvuvqXp+kjKnLs3PYm+SdvZxJotPDs9c3vgbV1VaeBgSjnFom
         whwJXUd/Lu34PYQJ5nuD+eAweUg7+CD/h2pwLFNzN+cdJP8wJ8WeL/Wmo6noGJNEkld5
         m5Wj9v9xiW9F/euKA6n7ozamUzQ+Lri6oHKUjUmzu+feffJNsdxBHf57pH+NLPxxgA5j
         6yyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7No/fb1hUqIlhOqsZxkPFtEz/yzx2+/L+vbOcQnjALk=;
        b=bg7sUo2WIlB3+psaL/8gt0eXQohgoQ5lFIZunPzGv/yMsF1PD3L6UaJLslmsnDLIHL
         xYOpyR2BzvA1ESho8IyfBK367TGhbBYAhPvoQRLGjOSnlAO0X82jI8T61Q71yLeTQc4U
         ehXfN3qihGlPXuIclXiyw3rOKyXP5505IsMLXa6JqAw3J7rYbMcjMf+pGY6n/YTfr+sh
         sNprK0pWDVfWgbBFy5Ic6ID5WtxqhFdVl2ltub9Mznhk7//U4Xvjk/xCYPqTgrBvWK1J
         5tkHsMEVsvWhcZpHm99WQ52mhwrNv20foSOVeGk4PqQHj1rCCGcSG+UwI5ykEMoB4Iwc
         WRzQ==
X-Gm-Message-State: AO0yUKXmuLqeF4ve3A7OaB2WhlD/JiFbQKxy0UO9aCRpIm91LVu0+0Z7
        R/0+/zEyDHwrG88YQfrJVfGeb4SIIFsNZ5s3p2H4z25TPMmcWvZH
X-Google-Smtp-Source: AK7set9eFDf0u1cBMbwGxzDIQC4P3inkWglv5zgbTE9OZ8lTga0W94bHFi4pm4X/gFztHclTn/5sbSBUmeYrGjqyLeY=
X-Received: by 2002:a81:b664:0:b0:52e:cea7:f6e3 with SMTP id
 h36-20020a81b664000000b0052ecea7f6e3mr110408ywk.10.1677534272923; Mon, 27 Feb
 2023 13:44:32 -0800 (PST)
MIME-Version: 1.0
References: <20230215134242.37618-1-andriy.shevchenko@linux.intel.com>
 <20230215134242.37618-6-andriy.shevchenko@linux.intel.com>
 <be808124-f350-125c-9c74-5a3f87db32af@microchip.com> <Y+9sKN2QcBV2VYKC@smile.fi.intel.com>
In-Reply-To: <Y+9sKN2QcBV2VYKC@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 27 Feb 2023 22:44:21 +0100
Message-ID: <CACRpkdbbJUc+ciknee8puu4-gEPU+PJp3GvpJcKGiW+O0JPaWA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] pinctrl: at91: Utilise temporary variable for
 struct device
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Claudiu.Beznea@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ludovic.Desroches@microchip.com, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 12:59 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Fri, Feb 17, 2023 at 11:54:02AM +0000, Claudiu.Beznea@microchip.com wrote:
> > On 15.02.2023 15:42, Andy Shevchenko wrote:
> > > @@ -1758,7 +1750,7 @@ static int at91_gpio_of_irq_setup(struct platform_device *pdev,
> > >         if (!gpiochip_prev) {
> > >                 girq->parent_handler = gpio_irq_handler;
> > >                 girq->num_parents = 1;
> > > -               girq->parents = devm_kcalloc(&pdev->dev, 1,
> > > +               girq->parents = devm_kcalloc(dev, girq->num_parents,
> >
> > There is still the change of the 2nd argument of devm_kcalloc() from 1 ->
> > girq->num_parents (no functional change, though) which doesn't match the
> > purpose of the patch and is not specified anywhere. Other than this:
> >
> > Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> >
> > >                                              sizeof(*girq->parents),
> > >                                              GFP_KERNEL);
>
> Thanks for review. I have no time to fix this. So if Linus is okay to take
> the first 4 patches, I'm fine. You or somebody else can submit an updated
> 5th patch later on.

I applied all 5 patches. The num_parents is set to 1 on the line right
above and it's the right thing to do, and has a reviewed tag so I don't
see the problem with this patch, let's not overinvest in process.

Thanks for the very nice cleanups!

I applied it locally so it won't be in linux-next until after the merge
window closes.

Yours,
Linus Walleij
