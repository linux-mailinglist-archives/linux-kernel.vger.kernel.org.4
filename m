Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F157D5B38FD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiIIN2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiIIN21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:28:27 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A487E1251B5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 06:28:25 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id e17so2514477edc.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 06:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=gfSvNnyw89kAsYLOqBGUS9Q38ES5erLlgILEt2LXtNg=;
        b=AGRDJK2E6kfYpWJks9PCE0F0RiNB0x0nf4nfyvSoKAEKvdAJL7usiUNEB+A8xrQqi3
         hciQw71NR40Oo+Fs4p4crCRly+neaf0ZHKnj5mYiHkunHYP3V6lrj9MMGDOrlFjMUZBv
         08iGzJUcvzC9HvF2T4nxOVLYWl3/l8K/yf0DzltfGrtOcKGto3zPKaslKnEUhkmX0bOP
         xX+loQkL8SSB4cz8o4wsZdPAbZBPa1gMF04eond1jGG2y4ZCepsBQmZBdnrwr+d+lGCa
         VSnu6xq9+GIwW13cATQEOvmVHkx8voUDr0DrL21CTxPm82iDiSEFX0ZMSUXX6Up7N37B
         yeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=gfSvNnyw89kAsYLOqBGUS9Q38ES5erLlgILEt2LXtNg=;
        b=dAsrmHPvb7JxtRLY4rZiH8FTWM+0vGVBzXJQlvbBmz+Zh+pz3ffnz5+Hl1NGDu8Q6W
         V5AguSUv2mmr3vQW9UrQ3WISI525Gf6v8rGbYI1O6rJnOhRDyMVt4hO8rNbANya9V6oZ
         tQK/UcTREGyoOBl/GIaTKks5v7iUpUmi7yP7RU9dTgkjsUVS1jBJ2prbwPy0EuFOQJ7n
         5JAaxG4FmcR/jW9/gKnaeyCQ99b9TJW0YY5AfxnMo/CbPx6Lkqq+7EfxSLKyvi06jN5r
         o/Y1F0INMkZmuS4ZGgUQA72/+vganFMsnerMy6tW+/4neBXgTczdhlU+0yAAL8hXmz6l
         ytnA==
X-Gm-Message-State: ACgBeo0G8wd9F1A0ksZ/ln091pUxSzKwgxtoRiZu77h0k5Yxk5AnlDzf
        V0VaIKrj4NYyNlU8MyXrxKZSOagJFVlOJxj5yeozbQ==
X-Google-Smtp-Source: AA6agR5IwMlz93euC4bO/DIhTf/mcNQqSD+TO1F3Egad69/4+n/rSI3JaqiU31Z2PUY3rF9ZF/2wYcFvAMjSypLByFc=
X-Received: by 2002:aa7:dd02:0:b0:44e:f7af:b996 with SMTP id
 i2-20020aa7dd02000000b0044ef7afb996mr11649989edv.422.1662730104183; Fri, 09
 Sep 2022 06:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220906082820.4030401-1-martyn.welch@collabora.co.uk> <CAMRc=Mek_oaZA7c2Pb1Fueyp7pz-4txKQY+JPCxK0KUoX=k+9g@mail.gmail.com>
In-Reply-To: <CAMRc=Mek_oaZA7c2Pb1Fueyp7pz-4txKQY+JPCxK0KUoX=k+9g@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 9 Sep 2022 15:28:13 +0200
Message-ID: <CAMRc=MfAEk+YEW_-5cfqZuJ9j22V=7O2k4_p2EXqqY5bd=vXbg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: vendor-prefixes: add Diodes
To:     Martyn Welch <martyn.welch@collabora.co.uk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martyn Welch <martyn.welch@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 9, 2022 at 3:27 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Tue, Sep 6, 2022 at 10:28 AM Martyn Welch
> <martyn.welch@collabora.co.uk> wrote:
> >
> > From: Martyn Welch <martyn.welch@collabora.com>
> >
> > Diodes Incorporated is a manufacturer of application specific standard
> > products within the discrete, logic, analog, and mixed-signal semiconductor
> > markets.
> >
> > https://www.diodes.com/
> >
> > Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >
> > Changes in v2:
> >  - None
> >
> >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > index 2f0151e9f6be..7ee9b7692ed1 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -328,6 +328,8 @@ patternProperties:
> >      description: Digi International Inc.
> >    "^digilent,.*":
> >      description: Diglent, Inc.
> > +  "^diodes,.*":
> > +    description: Diodes, Inc.
> >    "^dioo,.*":
> >      description: Dioo Microcircuit Co., Ltd
> >    "^dlc,.*":
> > --
> > 2.35.1
> >
>
> Picked up the entire series, thanks!
>
> Bart

Scratch that, missed Rob's comment under the other patch.

Bart
