Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A1E734243
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 18:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjFQQeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 12:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjFQQeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 12:34:44 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370D41B5;
        Sat, 17 Jun 2023 09:34:40 -0700 (PDT)
Received: from i53875b22.versanet.de ([83.135.91.34] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qAYsg-0007Kt-6E; Sat, 17 Jun 2023 18:34:30 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Maximilian Weigand <mweigand2017@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Maximilian Weigand <mweigand@mweigand.net>
Subject: Re: [PATCH 2/3] dt-bindings: backlight: lm3630a: add entries to control boost
 frequency
Date:   Sat, 17 Jun 2023 18:34:28 +0200
Message-ID: <7491264.lOV4Wx5bFT@diego>
In-Reply-To: <17576d81-a342-0b77-367a-eb9f2b97b734@linaro.org>
References: <20230602-lm3630a_boost_frequency-v1-0-076472036d1a@mweigand.net>
 <20230602-lm3630a_boost_frequency-v1-2-076472036d1a@mweigand.net>
 <17576d81-a342-0b77-367a-eb9f2b97b734@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 17. Juni 2023, 12:12:17 CEST schrieb Krzysztof Kozlowski:
> On 14/06/2023 21:08, Maximilian Weigand wrote:
> > From: Maximilian Weigand <mweigand@mweigand.net>
> > 
> > Add 'ti,boost_use_1mhz' to switch between 500 kHz and 1 MHz boost
> > converter switching frequency, and add 'ti,boost_frequency_shift' to
> > activate a frequency shift to 560 kHz or 1.12 MHz, respectively.
> > 
> > Signed-off-by: Maximilian Weigand <mweigand@mweigand.net>
> > ---
> >  .../bindings/leds/backlight/lm3630a-backlight.yaml           | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> > index 3c9b4054ed9a..ef7ea0ad2d25 100644
> > --- a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> > +++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> > @@ -33,6 +33,18 @@ properties:
> >      description: GPIO to use to enable/disable the backlight (HWEN pin).
> >      maxItems: 1
> >  
> > +  ti,boost_use_1mhz:
> 
> No underscores in property names.
> 
> > +    description: |
> 
> Do not need '|' unless you need to preserve formatting.
> 
> > +      If present, change the boost converter switching frequency from the
> > +      default 500 kHz to 1 MHz. Refer to data sheet for hardware requirements.
> > +    type: boolean
> > +
> > +  ti,boost_frequency_shift:
> > +    description: |
> > +      If present, change boost converter switching frequency from 500 kHz to
> > +      560 kHz or from 1 Mhz to 1.12 Mhz, respectively.
> 
> So just make it a property choosing the frequency, not bools, with
> proper unit suffix.

i.e.
ti,boost-frequency-hz = <x>;
with x being 500000, 560000, 1000000, 1120000

with the driver failing when the frequency is not achievable
with the two knobs of 1mhz and shift.



