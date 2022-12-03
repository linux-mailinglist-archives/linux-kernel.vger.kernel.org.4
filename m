Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4D964171D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 14:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiLCNqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 08:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiLCNqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 08:46:14 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7C9A1B8;
        Sat,  3 Dec 2022 05:46:13 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1441d7d40c6so8521858fac.8;
        Sat, 03 Dec 2022 05:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UZUeqVR+YNS254T8ghrOY0br3+YG9kpDkIyVm5x/F6Y=;
        b=qRGRjM8J5rb2ZDwDTRn79jhnQNreMJM4+wgZxFQ2ktqCJa5uoCvkJLyYapat94blo+
         ZFkjUp1v6+Akll140+hFahBUvNiKiJkPQMsUzAOPyraZ/nmbz0FYawnmYknzZ4YQg0l2
         HDg5r3YdkBd1xhewe58Saj9dRAHIvEIJqEflYBzGFYvcmSsl90pynLeWVXk6Ff03KF7J
         rO2At1ZzLaa9QB1RseJ/uTrF6UW45GEQZnC1fvSALcTSmeR7GckKZiscnyl+7qrddx7H
         u+jdfXZZ9HpY7APpffFpVkZRjvhISzSOR9rBYHEWEdA7bRdfrnxnALavioLZk0yytspW
         cGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UZUeqVR+YNS254T8ghrOY0br3+YG9kpDkIyVm5x/F6Y=;
        b=nDo1jasWAoadzY+QcAAFypfwmatD3aUFgwT/7183u6/swN5kUgDkkxig94fLYEG69f
         bi0ltX6k7x6a38VEH1BiPDkI0w2fx/xeowQ7ZuiTc+jxXeDjJuV6b+QFw1JhHK0J4yYe
         rJROzjsXojY7/LqCeZJ7hc4q1tjBaVbvbiDQVtK2fCLLJS+D9ziwxs/Gi59ZDGpzmnAf
         zV3gCgsqB04MEKG8IlUVXBYgijkrFH7NCjakkZB4FWep03SE+3DFPHIo7JMb0g5rkXvT
         mUBPD5RriZdJUJ68gOx11P8z3XH7gqH1ac9brLdbzMdggXIGB6B4lzvvayJHGLBS7W5/
         kPPA==
X-Gm-Message-State: ANoB5pknbd8CJWrjyLkcgmFj4l1sCp7lGy6LReNtIi9oRuIUMv86uvY1
        mBPrIuCQzlBb4sLdiI+NJZT/QlJVBtITrSTRK0k=
X-Google-Smtp-Source: AA0mqf7WM7gwxmrkTyxIs8uTreJx+nLeBeWG+Yvq9dufiFgID0aEFwuQfJwhWKSa1r92UD+zvhhjlhh8IU17p80NCo4=
X-Received: by 2002:a05:6870:ab86:b0:13c:5763:9411 with SMTP id
 gs6-20020a056870ab8600b0013c57639411mr41158023oab.288.1670075172372; Sat, 03
 Dec 2022 05:46:12 -0800 (PST)
MIME-Version: 1.0
References: <20221202034240.455831-1-gch981213@gmail.com> <20221202034240.455831-3-gch981213@gmail.com>
 <df8a683a-0df9-c32a-4272-19e7313ef7d7@linaro.org> <CAJsYDVLwyCG2xnWXDo72H-T4Tk7Edxmv_GSfJFvvWKrXZgBtCA@mail.gmail.com>
 <783fd2ff-cf7a-d820-6be7-9863e1786349@linaro.org> <CAJsYDVLuXG9UiOixxs997QdfeQVitFhhRDRbJ-uQ4Agz7LuMAQ@mail.gmail.com>
 <b4f881aa-a0a6-1ee1-5346-cfc31ab6c1e7@linaro.org>
In-Reply-To: <b4f881aa-a0a6-1ee1-5346-cfc31ab6c1e7@linaro.org>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Sat, 3 Dec 2022 21:46:01 +0800
Message-ID: <CAJsYDV+hZFVej2fk41TphgAbv+zsRKG+KOLjJJCJ9eiuGrOLhw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: leds: add dt schema for worldsemi,ws2812b-spi
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Sat, Dec 3, 2022 at 8:25 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> >>>>> +        maxItems: 3
> >>>>> +        items:
> >>>>> +          minimum: 0
> >>>>> +          maximum: 255
> >>>>> +
> >>>>> +      reg:
> >>>>> +        description: |
> >>>>> +          Which LED this node represents. The reg of the first LED on the chain
> >>>>> +          is 0.
> >>>>> +        maxItems: 1
> >>>>> +
> >>>>> +    required:
> >>>>> +      - reg
> >>>>> +      - color
> >>>>> +      - function
> >>>>> +
> >>>>> +required:
> >>>>> +  - compatible
> >>>>> +
> >>>>> +additionalProperties: false
> >>>>> +
> >>>>> +examples:
> >>>>> +  - |
> >>>>> +    #include <dt-bindings/leds/common.h>
> >>>>> +    spi {
> >>>>> +        #address-cells = <1>;
> >>>>> +        #size-cells = <0>;
> >>>>> +
> >>>>> +        leds@0 {
> >>>>
> >>>> git grep leds@ -- Documentation/devicetree/ | wc -l
> >>>> 1
> >>>> git grep led@ -- Documentation/devicetree/ | wc -l
> >>>> 165
> >>>>
> >>>> so rather not the first one ("leds").
> >>>
> >>> As you can see, this node describes a chain of LEDs, not
> >>> a single LED, so the plural form is more appropriate than
> >>> the singular form.
> >>>
> >>>>
> >>>> There is also:
> >>>> git grep led-controller@ -- Documentation/devicetree/ | wc -l
> >>>> 30
> >>>
> >>> This also isn't appropriate. WS2812B is a single LED package
> >>> of 3 diodes and a microcontroller. If we treat every package
> >>> as a LED, the SPI MOSI is connected directly to the LED
> >>> packages themselves with no controller in between.
> >>> If we treat the microcontroller as a led-controller, every
> >>> LED contains its own controller, instead of one controller
> >>> controlling all LEDs, and the parent node still shouldn't
> >>> be called a led-controller.
> >>>
> >>> Here's a picture of the WS2812B LED package:
> >>> https://cdn-shop.adafruit.com/970x728/1655-00.jpg
> >>> and a chain of them:
> >>> https://cdn-shop.adafruit.com/970x728/1463-00.jpg
> >>
> >> Then your bindings and DTS do not represent the hardware.
> >
> > How should this hardware be represented, then?
> >
> > The connection can be:
> >
> > SPI-MOSI---LED1---LED2---LED3---...---LEDN
> >
> > or
> >
> > SPI-MOSI---Tri-state signal gate---LED1---LED2---LED3---...---LEDN
> > SPI-CS-----|
>
> I would look at it this as either of:
> 1. serially linked separate LED controllers (so multiple device nodes)
>
> 2. one LED controller handling the entire LED system of many
> sub-controllers.
>
> For the (2) I proposed the name led-controller. If you think this is not
> (2), then looks like (1) and you should have many devices... which
> probably is not doable on itself. And how to call this entire set of
> separate LED controllers? Heh, can be also some controller, like
> led-controller.

OK. I'll name it led-controller in the next version.

-- 
Regards,
Chuanhong Guo
