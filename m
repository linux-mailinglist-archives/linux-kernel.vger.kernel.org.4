Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2B6675434
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjATMKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjATMKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:10:48 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B7E10AAC;
        Fri, 20 Jan 2023 04:10:47 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id k18so5152066pll.5;
        Fri, 20 Jan 2023 04:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EKSavZcLgXER2Rs1R2Q0x8yB6aB9z1+lbShiy/SvYys=;
        b=Zo3Ysk2ltDD5uVeoi1c0r1TnX+tcTOrp//osdZN4GUTjtHCDNpK9CstlqX3zrjJ0Ym
         GH9wl0Qh30NS/KzHGFrgBPnFaHfD92XXY79ka7WAhzkOgxjZQCEWWTjIabhPc8GNXevO
         ZzgCLIPk8vRxGjh3bu0cHEKz3cnoAocU12o6MwpGL7Aj0cViuVitSgaUNart0P1PkDId
         RvvkRy5XqpVFkmKy8rgeiHtBZXg4uPatXC5HQCId1EWn7rBKAEvuAw/taaeX1aZyJFSx
         Tx5713hXdgE7EyQMSHIxebs50ZJrVNtQXhzFxxLMWSIGbJYQ0CdUfTUPXMymD3pJbCH9
         JHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKSavZcLgXER2Rs1R2Q0x8yB6aB9z1+lbShiy/SvYys=;
        b=w1XboK6NnjUuJgeB/ra3HPHeefapl1gdbEeWygcMKcpDZ6e1SuuMq0kne3n5fvpWuc
         kQjL8eULVaoPh/mkhhK0cIiKvbOr1Tv7OUMtTGhboCsunKObHJJFQUvBKBTF2S+6fEe4
         ozhg70fMonykoEuV0BrMKFy/nQo3ZefJQ48nrVze0FDIVAnm+0pWgGRYQXGMxfknImTj
         KDeUk4j3fPlcdfzd69af1HJ866EobucekeuYr5Er6FzuCewQptO/i7JK0ezCTF4Wm68J
         H/7ezOLEVozQy14d6RfxtAR25wlN8gZVOLuPQsRxuoN9nSS3iCU7ISzl8hyLQ0iCQ/yi
         Mtag==
X-Gm-Message-State: AFqh2kq3kbZd/SRboZ1V7rXfmEVdbGEFEoJ9WIN1k8JrI5n/VMVwLDW9
        pQ8Cx06c/yE2/cEVlcafmek=
X-Google-Smtp-Source: AMrXdXspfd5ZJN1kn8YC0qz+35IV6j45HHmp/5WR4FbgQ3/MFKaCAjof+44x8SVDjo5vAh+Uvo+H9A==
X-Received: by 2002:a05:6a21:9993:b0:b6:1425:55df with SMTP id ve19-20020a056a21999300b000b6142555dfmr19047879pzb.59.1674216646665;
        Fri, 20 Jan 2023 04:10:46 -0800 (PST)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id r30-20020aa7989e000000b0058e12bbb560sm1594542pfl.15.2023.01.20.04.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 04:10:46 -0800 (PST)
Date:   Fri, 20 Jan 2023 20:10:39 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v7 1/2] dt-bindings: leds: backlight: Add Kinetic KTZ8866
 backlight
Message-ID: <Y8qEv9pUVA+1beTt@Gentoo>
References: <20230120094728.19967-1-lujianhua000@gmail.com>
 <a9c47e2f-aacb-4c8f-3a0b-67274ef15376@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9c47e2f-aacb-4c8f-3a0b-67274ef15376@linaro.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 11:18:56AM +0100, Krzysztof Kozlowski wrote:
> On 20/01/2023 10:47, Jianhua Lu wrote:
> > Add Kinetic KTZ8866 backlight binding documentation.
> > 
> > Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> > ---
> > Changes in v2:
> >   - Remove "items" between "compatible" and "const: kinetic,ktz8866".
> >   - Change "additionalProperties" to "unevaluatedProperties".
> > 
> > Changes in v3:
> >   - Add Krzysztof's R-b.
> > 
> > Changes in v4:
> >   - Drop Krzysztof's R-b.
> >   - Add some new properties.
> > 
> > Changes in v5:
> >   - Add missing enum under property description.
> >   - Rename uncorrect properties.
> > 
> > Changes in v6:
> >   - Correct wrong property suffix and description.
> > 
> > Changes in v7:
> >   - Add vddpos and vddeg supply.
> >   - Use enable-gpios instead of defining enable pin.
> > 
> >  .../leds/backlight/kinetic,ktz8866.yaml       | 74 +++++++++++++++++++
> >  1 file changed, 74 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
> > new file mode 100644
> > index 000000000000..b1d0ade0dfb6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
> > @@ -0,0 +1,74 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/leds/backlight/kinetic,ktz8866.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Kinetic Technologies KTZ8866 backlight
> > +
> > +maintainers:
> > +  - Jianhua Lu <lujianhua000@gmail.com>
> > +
> > +description: |
> > +  The Kinetic Technologies KTZ8866 is a high efficiency 6-channels-current-sinks
> > +  led backlight with dual lcd bias power.
> > +  https://www.kinet-ic.com/ktz8866/
> > +
> > +allOf:
> > +  - $ref: common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: kinetic,ktz8866
> > +
> > +  vddpos-supply:
> > +    description: positive boost supply regulator.
> > +
> > +  vddneg-supply:
> > +    description: negative boost supply regulator.
> > +
> > +  enable-gpios:
> > +    description: GPIO to use to enable/disable the backlight (HWEN pin).
> > +    maxItems: 1
> > +
> > +  current-num-sinks:
> > +    description: number of the LED current sinks' channels.
> > +    enum: [1, 2, 3, 4, 5, 6]
> > +
> > +  current-ramping-time-ms:
> > +    description: LED current ramping time in milliseconds.
> > +    enum: [2, 4, 8, 16, 32, 64, 128, 192, 256, 320, 384, 448, 512, 576, 640]
> 
> kinetic,current-ramp-delay-ms
> 
> > +
> > +  led-ramping-time-ms:
> 
> kinetic,led-enable-ramp-delay-ms
> 
> So both are similar to existing regulator properties.
> 
reasonable suggestion.
> Best regards,
> Krzysztof
> 
