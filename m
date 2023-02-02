Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABC2688ACC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjBBX2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjBBX2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:28:42 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2132112;
        Thu,  2 Feb 2023 15:27:57 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id s124so2825508oif.1;
        Thu, 02 Feb 2023 15:27:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHvjgJWR/netkSjL2dqjCkxba3y55n8wa4csM2Y+3Jg=;
        b=vH5e0nMEckMA1tknk4wKZvXrMN5wSYZcxvqS7hTxTesmvnWfv0AFW1WpJoldPpKXl6
         R77wPYFptRS7GNVw5dwf1VbVDkDEwjooSduLO/5NxkGAZPQvxQ5qSNFH5fSX/6nL0dI1
         iuGgKWIx2muzcl+f0qcku2YLTRpV+H++Lt85sZ0/zmk/ssJcV35auKeYVneIqfwZHncN
         roeGoFu9VGVrZgjjdlckioM87w/zFyAdIEm9RzigO+tdn6i3gatRojhhPtmUzQv1vmvP
         Nd3DGM3Ti71i1DAbo/K33fO5r5fcxJYubj7y016gFLf1zNu8hcmI1AHF0jSXXNTRkkRZ
         Q/jQ==
X-Gm-Message-State: AO0yUKU+LgcxR+rLUjL38K20jK4LxQyKIw1cnZsczkwcDbxsGxH/dv7W
        rvtJCO4X/n0W80UoG0cD3F0Jmfxzgg==
X-Google-Smtp-Source: AK7set/+RI1xpnNSZzLqGcvwm4nz4nqML8jWdkfETq2qTLNo7VHzU21LzvSuoYRncxpgNJ22sPJ3Bg==
X-Received: by 2002:aca:110f:0:b0:378:477c:3e0e with SMTP id 15-20020aca110f000000b00378477c3e0emr3368090oir.45.1675380455727;
        Thu, 02 Feb 2023 15:27:35 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u18-20020a056808115200b003780e80fad6sm213109oiu.49.2023.02.02.15.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 15:27:35 -0800 (PST)
Received: (nullmailer pid 2898046 invoked by uid 1000);
        Thu, 02 Feb 2023 23:27:34 -0000
Date:   Thu, 2 Feb 2023 17:27:34 -0600
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
Message-ID: <20230202232734.GA2889187-robh@kernel.org>
References: <20230201054815.4112632-1-dmitry.torokhov@gmail.com>
 <20230201054815.4112632-2-dmitry.torokhov@gmail.com>
 <31e979dd-f4e9-081e-1bf2-e44dffc4e70f@linaro.org>
 <Y9qQHj70SN/3fZCc@google.com>
 <20230201175504.GA4075318-robh@kernel.org>
 <Y9q3T17r5G2PD9Gk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9q3T17r5G2PD9Gk@google.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 11:02:39AM -0800, Dmitry Torokhov wrote:
> On Wed, Feb 01, 2023 at 11:55:04AM -0600, Rob Herring wrote:
> > On Wed, Feb 01, 2023 at 08:15:26AM -0800, Dmitry Torokhov wrote:
> > > On Wed, Feb 01, 2023 at 08:38:48AM +0100, Krzysztof Kozlowski wrote:
> > > > On 01/02/2023 06:48, Dmitry Torokhov wrote:
> > > > > MOXA ART RTC driver has been switched to gpiod API and is now using
> > > > > properly named properties for its gpios (with gpiolib implementing a
> > > > > quirk to recognize legacy names). Change binding document to use
> > > > > proper names as well.
> > > > > 
> > > > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > > ---
> > > > >  .../devicetree/bindings/rtc/moxa,moxart-rtc.txt      | 12 ++++++------
> > > > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/rtc/moxa,moxart-rtc.txt b/Documentation/devicetree/bindings/rtc/moxa,moxart-rtc.txt
> > > > > index c9d3ac1477fe..1374df7bf9d6 100644
> > > > > --- a/Documentation/devicetree/bindings/rtc/moxa,moxart-rtc.txt
> > > > > +++ b/Documentation/devicetree/bindings/rtc/moxa,moxart-rtc.txt
> > > > > @@ -3,15 +3,15 @@ MOXA ART real-time clock
> > > > >  Required properties:
> > > > >  
> > > > >  - compatible : Should be "moxa,moxart-rtc"
> > > > > -- gpio-rtc-sclk : RTC sclk gpio, with zero flags
> > > > > -- gpio-rtc-data : RTC data gpio, with zero flags
> > > > > -- gpio-rtc-reset : RTC reset gpio, with zero flags
> > > > > +- rtc-sclk-gpios : RTC sclk gpio, with zero flags
> > > > > +- rtc-data-gpios : RTC data gpio, with zero flags
> > > > > +- rtc-reset-gpios : RTC reset gpio, with zero flags
> > > > 
> > > > Your driver breaks the ABI, doesn't it? If not, how are the old
> > > > properties parsed?
> > > 
> > > It does not. As I mentioned in the driver code patch, commit
> > > eaf1a29665cd ("gpiolib: of: add a quirk for legacy names in MOXA ART
> > > RTC") makes sure gpiolib falls back to trying old variants if it can't
> > > locate properly formatted names.
> > 
> > A dtb with the new names and a kernel without the gpiod conversion would 
> > be broken. Up to the platform whether they care really.
> 
> Seriously? And I guess devices with DTS do not work with kernels v2.0 so
> we should never have introduced it...

They would be fine because they would ignore the dtb. ;)

> I understand wanting backward compatibility, but asking for both
> backward and forward is a bit too much IMO.

Like I said, up to the platform to decide. I'm just defining what's an 
ABI break or not.

If the dtb ships with firmware, do you want new firmware with a newer 
dtb to break your OS? We can sometimes mitigate that with stable kernel 
updates. There are obvious cases that don't work such as adding 
providers such as clocks (instead of dummy fixed clocks) or pinctrl, 
where old kernels will never have the driver (but doesn't know that).

Rob
