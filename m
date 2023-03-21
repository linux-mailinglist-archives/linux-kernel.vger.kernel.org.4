Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A824E6C3D67
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 23:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjCUWIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 18:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjCUWI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 18:08:29 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D696ACC20;
        Tue, 21 Mar 2023 15:08:27 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id p20-20020a056830319400b0069f914e5c74so1117048ots.3;
        Tue, 21 Mar 2023 15:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679436507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpDMWU1r+Zt8jZrtXFc2D2tco7/VMKbA4jzzKhsFGCA=;
        b=WBya72RTjhbb7R5dPkjv+WPWNTE2xUJDKvVoZmX78LOaNMI9eMb4mN7u0N7W+5sRVA
         T4kRpnpV/FGv+U6Y5tmGvJe3lVKzp87DqRXi29e3EteLXTrODt8+BPeI4CbuzXcwQkJ0
         GuWW5o/iHmGQFsKjZhOrYq/9yJqIYz3btl7kWFdHTWOhMQ0khvxwJ6jg1uNNotjIjp6w
         168UcYdRoXlvizhFjmKMz4OgQF1zMB35/jjX7smzL7ZTRT8Nhj2SscNv2stx9gjVoZzH
         a9AMFM2hojnV3FsxgZrfuOsflgsQhatXXi+y2Chi3KhNS3jPQt8FBXu9Q/Qu0cY1zOPy
         iisg==
X-Gm-Message-State: AO0yUKVy+rS1nFvAP4sNrAlAu2KwKbW2Z+HTLG7dNmfuOeZ5zXnrsN8i
        /zPAIWFi0OgCyB85FM2lyWAXyyOSZw==
X-Google-Smtp-Source: AK7set+96sV7YUNKjhPVEomctIU42GJayDjjb8XCwvoVE0twKuMLd+lcSJ8FKJwNdgf4/oaqvJA4uQ==
X-Received: by 2002:a05:6830:2009:b0:69f:2774:b60 with SMTP id e9-20020a056830200900b0069f27740b60mr408963otp.8.1679436507024;
        Tue, 21 Mar 2023 15:08:27 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t26-20020a05683014da00b0068d752f1870sm5626034otq.5.2023.03.21.15.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 15:08:26 -0700 (PDT)
Received: (nullmailer pid 1740280 invoked by uid 1000);
        Tue, 21 Mar 2023 22:08:25 -0000
Date:   Tue, 21 Mar 2023 17:08:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Travkin <nikita@trvn.ru>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 1/2] dt-bindings: leds: aw2013: Document vddio-supply
Message-ID: <20230321220825.GA1685482-robh@kernel.org>
References: <20230320174949.174600-1-linmengbo0689@protonmail.com>
 <20230320175131.174657-1-linmengbo0689@protonmail.com>
 <922eab51-6931-8533-db51-51cd911a36b3@linaro.org>
 <ZBitAGOmF/hyxDYP@gerhold.net>
 <94cdb512-b168-6ffe-73c1-caf23bb79d6f@linaro.org>
 <ZBoR0DPQ+AufzKHk@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBoR0DPQ+AufzKHk@gerhold.net>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 09:21:36PM +0100, Stephan Gerhold wrote:
> On Tue, Mar 21, 2023 at 07:42:37AM +0100, Krzysztof Kozlowski wrote:
> > On 20/03/2023 19:59, Stephan Gerhold wrote:
> > > On Mon, Mar 20, 2023 at 07:04:22PM +0100, Krzysztof Kozlowski wrote:
> > >> On 20/03/2023 18:55, Lin, Meng-Bo wrote:
> > >>> Some LEDs controllers are used with external pull-up for the interrupt
> > >>> line and the I2C lines, so we might need to enable a regulator to bring
> > >>> the lines into usable state.
> > >>
> > >> Not a property of this device.
> > >>
> > >>> Otherwise, this might cause spurious
> > >>> interrupts and reading from I2C will fail.
> > >>>
> > >>> Document support for "vddio-supply" that is enabled by the aw2013 driver
> > >>> so that the regulator gets enabled when needed.
> > >>>
> > >>> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
> > >>> ---
> > >>>  Documentation/devicetree/bindings/leds/leds-aw2013.yaml | 5 +++++
> > >>>  1 file changed, 5 insertions(+)
> > >>>
> > >>> diff --git a/Documentation/devicetree/bindings/leds/leds-aw2013.yaml b/Documentation/devicetree/bindings/leds/leds-aw2013.yaml
> > >>> index 08f3e1cfc1b1..79b69cf1d1fe 100644
> > >>> --- a/Documentation/devicetree/bindings/leds/leds-aw2013.yaml
> > >>> +++ b/Documentation/devicetree/bindings/leds/leds-aw2013.yaml
> > >>> @@ -23,6 +23,11 @@ properties:
> > >>>    vcc-supply:
> > >>>      description: Regulator providing power to the "VCC" pin.
> > >>>  
> > >>> +  vddio-supply:
> > >>> +    description: |
> > >>> +      Optional regulator that provides digital I/O voltage,
> > >>
> > >> NAK. I responded to your patch and you just send a v2 without explanation.
> > >>
> > >> The device does not have VDDIO pin, either.
> > >>
> > > 
> > > The power supply Lin is trying to add here is basically the "VIO1"
> > > example in "Figure 1 AW2013 Typical Application Circuit" on page 1 of
> > > the AW2013 datasheet [1]. The I2C pins and the interrupt output are both
> > > open-drain and therefore require external pull-up resistors, connected
> > > to a power supply that might not be always on.
> > > 
> > > Because of the open-drain pins AW2013 does indeed not have a dedicated
> > > input pin for the I/O supply voltage. However, it is still necessary to
> > > describe the power supply _somewhere_, to ensure that it is enabled when
> > > needed.
> > > 
> > > It is hard to model this properly but it's generally easiest to handle
> > > this inside the peripheral driver since it knows exactly when I2C and/or
> > > interrupt lines are currently needed or not. This situation is fairly
> > > common for I2C devices so there are several precedents, e.g.:
> > > 
> > >   1. cypress,tm2-touchkey.yaml: "vddio-supply"
> > >      https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3e730ec11d51283ad62a98436967c01b718132ab
> > >   2. goodix,gt7375p.yaml: "mainboard-vddio-supply"
> > >      https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1d18c1f3b7d938bdefc44289d137b4e6c7a3d502
> > 
> > Both are mistaken. How can you enumerate or autodetect a device if its
> > regulator pulling up I2C are not on?
> 
> You don't. By design I2C does not support enumeration or autodetection.
> Nothing we implement in software can change that.
> 
> I2C devices have all sorts of requirements before they show up on the
> bus at all (power supplies, enable GPIOs, clocks, ...). All these are
> currently modelled as part of the consumer IC.
> 
> > What's more, on I2C lines you could have more devices, so you expect
> > each of them having the supply?
> 
> Yes, I don't think this is a problem since it's typical for regulators
> to be shared. If at least one of the I2C devices is active, the bus will
> be active as well.
> 
> > These are properties of I2C controller, not the consumer. I2C controller
> > should enable any regulators necessary for the IO pins.
> 
> In general I agree with you here. But as I mentioned already there is
> usually more than just the I2C I/O lines. For AW2013 there is at least
> also the open-drain interrupt line. On other ICs there could also be
> arbitrary GPIO lines that are used in open-drain mode. Those are
> completely unrelated to the I2C controller.
> 
> Do you have any suggestions how to handle the power supply for those?
> 
> IMO for interrupts lines the pull-up I/O supply is hardly a property of
> the interrupt controller. It just cares that a line switches from high
> to low. It's not exactly a property of the consumer IC either. However,
> since operating the interrupt line in open-drain mode is part of the
> consumer IC specification I would say that the I/O supply for interrupt
> lines is better described on the consumer side.
> 
> For sake of completeness we could additionally describe the supply for
> the I2C lines on the I2C controller, but then we still need this patch
> or something else for the interrupt lines.

I think a supply on the device side is fine here. Just be clear in the 
description about its purpose. We have much worse abuses than this 
(random bus clocks added to SoC devices).

Rob

