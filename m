Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8361263D0DB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbiK3Ii4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbiK3Iiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:38:52 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C3213F95;
        Wed, 30 Nov 2022 00:38:51 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id c129so18049316oia.0;
        Wed, 30 Nov 2022 00:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uC/UArEcgpKpph4bJxT7wEjXZbjXvymdCdz7vGSqQtc=;
        b=mLtuX4cfzQXLt8gLePA7UBJgao8qylxC3w5INwzHbsaLSvTwEdhKZQC3Meoi7lMStB
         bmaMXSgGlJh8w4bwQElmXaswRyQFVPnaJ6AC3Q4RfPwzrFRqiBmofbvaIA5pdXBRzw9h
         f5/mbq1Wm/rrUfXeYZh8jPN+laHcS/981ek+mjZU2CmOTNB0IZa7Co3lGRXPWU2S9zzX
         v+i1+iBQgZ1AagrTNSEl4pCR8tEywyG4dicRSUb9K/M1eWLakHOLnK1PIKoQzHGJDX7p
         1vrCvw3Q/ZWAaIXvbIhDLvXj+mxPW1GLbaWoYC+wCD/Iyxgaw0Cd2TKRmu5YFJi0/Amd
         xTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uC/UArEcgpKpph4bJxT7wEjXZbjXvymdCdz7vGSqQtc=;
        b=47X37RgdErE+Gsj/1qudM2yLz2PMIX3chhFzc9Cz+VQBDuEODg2677DGyUElaGf3DV
         jjrQ522jhbz3GHyUQzuWae4GnLBK6HzdNjoZmx1iDmDV9ssHEAreO8TCbN5bky6pdTjp
         HLtNkldShn5ThTKQmzwgO1j4Q6UCSBLem6UrbcdptFZYCOOLbiNg1onKlMB3/dTM7c1Y
         5fPhN9fVst8Vv0JCyS6mLYC6FzXttt+f2BHhppwBF7eigwJHzbxC1VmKGhes2CJwf2ai
         /jCNJodcOcbW01ntaBqU4kdAWRYIQotkLq5oIH5/kLLt2rcsHO5VG0f3cAVPOBAcwf1N
         xMzA==
X-Gm-Message-State: ANoB5pmomnurwYvh0z8aCLZv8PfnNtxfsfITX8eCkQSbUKBK9Rr4FGz2
        005WNVkbRysmQ6+cgknsuWuDLBqMUzE7QZIvxpI=
X-Google-Smtp-Source: AA0mqf7g5OYxXzKTWvPQS9hE42X+5T7OGVOtIImiVoUjf1nZA7rf5u6hrnyZQ11Mqb+p90ekE53jQ9rX/i3AInTn+AU=
X-Received: by 2002:a05:6808:2ca:b0:359:ca42:419 with SMTP id
 a10-20020a05680802ca00b00359ca420419mr30871759oid.98.1669797531045; Wed, 30
 Nov 2022 00:38:51 -0800 (PST)
MIME-Version: 1.0
References: <20221129140955.137361-1-gch981213@gmail.com> <20221129140955.137361-3-gch981213@gmail.com>
 <98b72494-3188-76d5-2e24-9dc127a8b31a@linaro.org> <20221130001459.3wyxnwpjaxvla6oj@mercury.elektranox.org>
 <08bd485b-51f6-8249-63a7-a6864a431276@linaro.org>
In-Reply-To: <08bd485b-51f6-8249-63a7-a6864a431276@linaro.org>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Wed, 30 Nov 2022 16:38:39 +0800
Message-ID: <CAJsYDVJHa9qoBp0Em+Waj1TpAgHy0N504zHGkFEf+3VNA42omw@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: leds: add dt schema for worldsemi,ws2812b-spi
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-leds@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, Nov 30, 2022 at 4:33 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> >> What controls the intensity? Don't you have PWM there?
> >
> > WS2812 is a RGB led, which contains a small Microcontroller. The =C2=B5=
C
> > takes 24 byte intensity data from a serial input and then passes on
> > any following bits to the next LED. SPI clk and chip-select are
> > ignored (chip-select support can be trivially added though).
> >
> > You can find them everywhere nowadays, since they are quite cheap
> > (a few cents per LED) and need only one MOSI pin to control hundreds
> > of LEDs.
>
> OK. This should be anyway existing property, so default-brightness.

default-intensity is a different property. Intensity controls only the
color for a multicolor led. The final brightness is calculated with
this intensity value with the single brightness value of the current
LED. (See my previous mail.)

--=20
Regards,
Chuanhong Guo
