Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0537193DD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 09:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjFAHEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 03:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjFAHEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 03:04:31 -0400
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E49FA3;
        Thu,  1 Jun 2023 00:04:28 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net [IPv6:2a02:6b8:c18:3487:0:640:5432:0])
        by forward501a.mail.yandex.net (Yandex) with ESMTP id A33605EE0A;
        Thu,  1 Jun 2023 10:04:26 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id P4IRAYoDXOs0-7BUpyIGU;
        Thu, 01 Jun 2023 10:04:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1685603065;
        bh=Y48w3RfdouMEBAttizmhtYFS6zbWc27iEQuMvlUUoGg=;
        h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
        b=uL8paNxv2DSBun6aTURLX5NRZdVWu/3ip2GGql3JJjep3xMrpY1LC3a8+V+P2+EH6
         dVVFl3ZOLegJy4jtoyzSQx6rkgI/zujrGd1O6hha6KMBPmkxQVp75LlqKGt/JLggaX
         Ky+kt3Aakbwxk+k/HmXpDLcF+3WpSRvpqWF7yFfE=
Authentication-Results: mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Date:   Thu, 1 Jun 2023 10:04:24 +0300
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v1 02/43] dt-bindings: soc: Add Cirrus EP93xx
Message-ID: <20230601100424.4e8914a7@redslave.neermore.group>
In-Reply-To: <1c70bb0a-e682-0917-c464-4748a292e90f@linaro.org>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
        <20230601053546.9574-3-nikita.shubin@maquefel.me>
        <1c70bb0a-e682-0917-c464-4748a292e90f@linaro.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof!

On Thu, 1 Jun 2023 08:37:02 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 01/06/2023 07:33, Nikita Shubin wrote:
> > This adds device tree bindings for the Cirrus Logic EP93xx.
> > 
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>  
> 
> You already sent v1. This patchset is attached to the previous thread
> making it more complicated for me to process. This buries it deep in
> the mailbox and might interfere with applying entire sets.

Sorry for that, i've already realized my mistake looking at my own
mailbox.

> 
> Is this the next version, so v3? You already had at least two versions
> before, so this cannot be v1.

It's second on the mail lists, the first one was closed RFC.

The first was without any version, i.e. v0, this one is v1 (should be
v2).

I promise to be more careful next series.

All other comments acknowledged.

> 
> > ---
> > 
> > Notes:
> >     v0 -> v1:
> >     
> >     - fixed compatible - now it specifies three boards
> >     	- ts7250
> >     	- bk3
> >     	- edb9302
> >     - fixed identation in example
> >     - dropped labels
> > 
> >  .../devicetree/bindings/arm/ep93xx.yaml       | 107
> > ++++++++++++++++++ .../dt-bindings/clock/cirrus,ep93xx-clock.h   |
> > 53 +++++++++ 2 files changed, 160 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/arm/ep93xx.yaml create mode
> > 100644 include/dt-bindings/clock/cirrus,ep93xx-clock.h
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/ep93xx.yaml
> > b/Documentation/devicetree/bindings/arm/ep93xx.yaml new file mode
> > 100644 index 000000000000..bcf9754d0763
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/ep93xx.yaml
> > @@ -0,0 +1,107 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/ep93xx.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Cirrus Logic EP93xx device tree bindings  
> 
> No improvements.
> 
> > +
> > +description: |+  
> 
> no improvements. Do not need '|+' unless you need to preserve
> formatting.
> 
> 
> > +  The EP93xx SoC is a ARMv4T-based with 200 MHz ARM9 CPU.
> > +
> > +maintainers:
> > +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> > +  - Nikita Shubin <nikita.shubin@maquefel.me>
> > +
> > +properties:
> > +  $nodename:
> > +    const: '/'
> > +  compatible:
> > +    oneOf:
> > +      - description: The TS-7250 is a compact, full-featured
> > Single Board Computer (SBC)
> > +          based upon the Cirrus EP9302 ARM9 CPU
> > +        items:
> > +          - const: technologic,ts7250
> > +          - const: cirrus,ep9301
> > +
> > +      - description: The Liebherr BK3 is a derivate from ts7250
> > board
> > +        items:
> > +          - const: liebherr,bk3
> > +          - const: cirrus,ep9301
> > +
> > +      - description: EDB302 is an evaluation board by Cirrus Logic,
> > +          based on a Cirrus Logic EP9302 CPU
> > +        items:
> > +          - const: cirrus,edb9302
> > +          - const: cirrus,ep9301
> > +
> > +  soc:
> > +    type: object
> > +    patternProperties:
> > +      "^.*syscon@80930000$":
> > +        type: object
> > +        properties:
> > +          compatible:
> > +            items:
> > +              - const: cirrus,ep9301-syscon
> > +              - const: syscon
> > +              - const: simple-mfd
> > +          ep9301-reboot:
> > +            type: object
> > +            properties:
> > +              compatible:
> > +                const: cirrus,ep9301-reboot
> > +        required:
> > +          - compatible
> > +          - reg
> > +          - ep9301-reboot
> > +
> > +      "^.*timer@80810000$":
> > +        type: object
> > +        properties:
> > +          compatible:
> > +            const: cirrus,ep9301-timer
> > +
> > +    required:
> > +      - syscon@80930000
> > +      - timer@80810000  
> 
> I don't understand what are you putting here. Why addresses are in
> bindings (they should not be), why some nodes are documented in
> top-level compatible. Drop all this.
> 
> Open existing files and look how it is done there.
> 
> > +
> > +required:
> > +  - compatible
> > +  - soc> +
> > +additionalProperties: true
> > +
> > +examples:
> > +  - |
> > +    / {
> > +      compatible = "technologic,ts7250", "cirrus,ep9301";
> > +      model = "TS-7250 SBC";
> > +      #address-cells = <1>;
> > +      #size-cells = <1>;
> > +      soc {
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +        ranges;
> > +        compatible = "simple-bus";
> > +
> > +        syscon@80930000 {
> > +          compatible = "cirrus,ep9301-syscon",
> > +                        "syscon", "simple-mfd";
> > +          reg = <0x80930000 0x1000>;
> > +
> > +          ep9301-reboot {
> > +            compatible = "cirrus,ep9301-reboot";
> > +          };
> > +        };
> > +
> > +        timer@80810000 {
> > +          compatible = "cirrus,ep9301-timer";
> > +          reg = <0x80810000 0x100>;
> > +          interrupt-parent = <&vic1>;
> > +          interrupts = <19>;
> > +        };
> > +      };
> > +    };  
> 
> Drop all this. There is no existing binding like that.
> 
> > +
> > +...
> > diff --git a/include/dt-bindings/clock/cirrus,ep93xx-clock.h
> > b/include/dt-bindings/clock/cirrus,ep93xx-clock.h  
> 
> Not related to top level compatible.
> 
> > new file mode 100644
> > index 000000000000..6a8cf33d811b
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/cirrus,ep93xx-clock.h
> > @@ -0,0 +1,53 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */  
> 
> Dual license.
> 
> > +#ifndef DT_BINDINGS_CIRRUS_EP93XX_CLOCK_H
> > +#define DT_BINDINGS_CIRRUS_EP93XX_CLOCK_H
> > +
> > +#define EP93XX_CLK_XTALI	0
> > +  
> 
> 
> Best regards,
> Krzysztof
> 

