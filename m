Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6E8686D76
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 18:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjBARzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 12:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjBARzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 12:55:07 -0500
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132697E061;
        Wed,  1 Feb 2023 09:55:06 -0800 (PST)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-16346330067so24557049fac.3;
        Wed, 01 Feb 2023 09:55:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEDXzkUnTaGxqSEpoBtaF5rFfC7AazGaCNNqR0PWFh8=;
        b=LKfCsGkOYfTWWZH+TN8KbDhSja85sTmHOPYJli7iCyg2WzfyrkFLppJ5GK/5535rwJ
         lugJM6Yel+8yTdi06Zl7d6iAj7xI/ILrRB9gWTznQq3GoiNnL/cQwqoriflo66MwdvHI
         W5b3m5WnOLrpA07TsTyy8VUlzdiNej/F+SU9VSOpGlAVEMeRPasgvF+JZV1Z2hgVb/1W
         RLf4E0XLQ/poBuYBlYC9hJ5lnelxCP2c/Ldw8afGtAzTyTVksg4oaSquMPTUu6JwQr8A
         b34CMvl7uIjHZt+rsVptV9hsaLXVZR4v49LeFyteqUE8KpMtpTqzNX0BssfW/gDY81P0
         BQvA==
X-Gm-Message-State: AO0yUKXcjggvaQh1PuJAysoi0fPQue3wyjJFA6lGt2fFWbL8tc8aOm8P
        L7DXz1PuQIgugoGvXH0VocV9CTC/hA==
X-Google-Smtp-Source: AK7set/2t6g8eqTss4lchvXfIxSzxti/TyKEgsDavfk/quCjCWN+kHo7xEEkmJlRAqdAbLF5kJSKyQ==
X-Received: by 2002:a05:6870:c69b:b0:163:def0:60b9 with SMTP id cv27-20020a056870c69b00b00163def060b9mr3805824oab.5.1675274105271;
        Wed, 01 Feb 2023 09:55:05 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cd26-20020a056830621a00b0068be61a7ac6sm1778573otb.56.2023.02.01.09.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 09:55:04 -0800 (PST)
Received: (nullmailer pid 4084519 invoked by uid 1000);
        Wed, 01 Feb 2023 17:55:04 -0000
Date:   Wed, 1 Feb 2023 11:55:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: rtc: moxart: use proper names for gpio
 properties
Message-ID: <20230201175504.GA4075318-robh@kernel.org>
References: <20230201054815.4112632-1-dmitry.torokhov@gmail.com>
 <20230201054815.4112632-2-dmitry.torokhov@gmail.com>
 <31e979dd-f4e9-081e-1bf2-e44dffc4e70f@linaro.org>
 <Y9qQHj70SN/3fZCc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9qQHj70SN/3fZCc@google.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 08:15:26AM -0800, Dmitry Torokhov wrote:
> On Wed, Feb 01, 2023 at 08:38:48AM +0100, Krzysztof Kozlowski wrote:
> > On 01/02/2023 06:48, Dmitry Torokhov wrote:
> > > MOXA ART RTC driver has been switched to gpiod API and is now using
> > > properly named properties for its gpios (with gpiolib implementing a
> > > quirk to recognize legacy names). Change binding document to use
> > > proper names as well.
> > > 
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > ---
> > >  .../devicetree/bindings/rtc/moxa,moxart-rtc.txt      | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/rtc/moxa,moxart-rtc.txt b/Documentation/devicetree/bindings/rtc/moxa,moxart-rtc.txt
> > > index c9d3ac1477fe..1374df7bf9d6 100644
> > > --- a/Documentation/devicetree/bindings/rtc/moxa,moxart-rtc.txt
> > > +++ b/Documentation/devicetree/bindings/rtc/moxa,moxart-rtc.txt
> > > @@ -3,15 +3,15 @@ MOXA ART real-time clock
> > >  Required properties:
> > >  
> > >  - compatible : Should be "moxa,moxart-rtc"
> > > -- gpio-rtc-sclk : RTC sclk gpio, with zero flags
> > > -- gpio-rtc-data : RTC data gpio, with zero flags
> > > -- gpio-rtc-reset : RTC reset gpio, with zero flags
> > > +- rtc-sclk-gpios : RTC sclk gpio, with zero flags
> > > +- rtc-data-gpios : RTC data gpio, with zero flags
> > > +- rtc-reset-gpios : RTC reset gpio, with zero flags
> > 
> > Your driver breaks the ABI, doesn't it? If not, how are the old
> > properties parsed?
> 
> It does not. As I mentioned in the driver code patch, commit
> eaf1a29665cd ("gpiolib: of: add a quirk for legacy names in MOXA ART
> RTC") makes sure gpiolib falls back to trying old variants if it can't
> locate properly formatted names.

A dtb with the new names and a kernel without the gpiod conversion would 
be broken. Up to the platform whether they care really.

Rob
