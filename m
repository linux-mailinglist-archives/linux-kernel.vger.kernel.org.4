Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AA867F6DF
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 11:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbjA1KGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 05:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjA1KGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 05:06:11 -0500
Received: from sender3-op-o18.zoho.com (sender3-op-o18.zoho.com [136.143.184.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BEE1E5D5;
        Sat, 28 Jan 2023 02:06:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1674900354; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=TmvaFX7FiCJ0asOwwaDfNVWp0fGokR6Uz7XFzELfF2870ILH2lWHpevCwbHKp56sgCB9iYi2YyLoZF1tOs+i/K2xf5C3VRscooWlbWk9wOUNECOpvvjBBnQ6PFIuZyJDFt9VycEBjVCcQYP6zSs7wNk2fQwm5GNGdZBE/bIGS3E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1674900354; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=j5nGUkI38D1MQpVdEyrHttbcAiB8ENVVDLRJhTAndkA=; 
        b=kULu0tb/33i5OSYXRTitlnbFY1Hz9xpF0/QarJbKYb+gsVlZTjbDGgOQtlka7rIBkWOy7HBpZp4kYKMCctjpY9qvivZmtvxBbbxq4zDKvWahbv8m9oV9U/wYhZFQxVzy98Otiwcy8lpp6455ZrJOZIBT+7CAnX9ImvupLF1Z48U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1674900354;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=j5nGUkI38D1MQpVdEyrHttbcAiB8ENVVDLRJhTAndkA=;
        b=t8bWmI6kg7WfW2v2CtmQw4umaMX2LguJCiieRH8xhx9L8ix/RX1xhQGPOnHPdmDP
        MCknYaT/jRJ/td/Grw6+4+P/2+Ezx20UbgjeeXHGVXJStOwVo4tdm/IWgH78NP76/t2
        EvghwW1bWkcdk5u4TsrV/yiTS7uE1UryrYo0n6II=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1674900352501560.8186083550721; Sat, 28 Jan 2023 02:05:52 -0800 (PST)
Date:   Sat, 28 Jan 2023 18:05:52 +0800
From:   Li Chen <me@linux.beauty>
To:     "Linus Walleij" <linus.walleij@linaro.org>
Cc:     "li chen" <lchen@ambarella.com>,
        "rob herring" <robh+dt@kernel.org>,
        "krzysztof kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:arm/ambarella soc support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:pin control subsystem" <linux-gpio@vger.kernel.org>,
        "open list:open firmware and flattened device tree bindings" 
        <devicetree@vger.kernel.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>
Message-ID: <185f7d72de2.c88b8fe6489519.2797878078784039860@linux.beauty>
In-Reply-To: <CACRpkdYVGv=YM6cvtXVxNW42uM+dW_Zv-BkrDyMX+DB73w=2nA@mail.gmail.com>
References: <20230123073305.149940-1-lchen@ambarella.com> <20230123073305.149940-14-lchen@ambarella.com> <CACRpkdYVGv=YM6cvtXVxNW42uM+dW_Zv-BkrDyMX+DB73w=2nA@mail.gmail.com>
Subject: Re: [PATCH 13/15] dt-bindings: pinctrl: add support for Ambarella
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Sorry for my late reply.

 ---- On Mon, 23 Jan 2023 20:32:28 +0800  Linus Walleij  wrote --- 
 > Hi Li,
 > 
 > thanks for your patch!
 > 
 > It's nice to see Ambarella working with the kernel community.
 > 
 > On Mon, Jan 23, 2023 at 8:41 AM Li Chen lchen@ambarella.com> wrote:
 > 
 > > +properties:
 > > +  compatible:
 > > +    items:
 > > +      - const: ambarella,pinctrl
 > 
 > I bet there will be more instances of pin controllers from Ambarella, so I would
 > use this only as a fallback, so the for should likely be:
 > 
 > compatible = "ambarella,-pinctrl", "ambarella,pinctrl";
 > 
 > we need to establish this already otherwise "ambarella,pinctrl" just becomes
 > the "weird name of the first ambarella SoC supported by standard DT bindings".
 
There is only single "ambarella,pinctrl" in Ambarella downstream kernels, and we use soc_device_attribute->data
and soc_device_attribute->soc_id/family to get correct SoC-specific information like reg offset and etc.

Krzysztof has taught me that this way is wrong and
SoC is required in compatible: https://www.spinics.net/lists/arm-kernel/msg1043145.html

So I will update this property to "ambarella,s6lm-pinctrl" in the new version.

 > > +  amb,pull-regmap:
 > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
 > > +    items:
 > > +      maxItems: 1
 > > +
 > > +  amb,ds-regmap:
 > > +    items:
 > > +      maxItems: 1
 > 
 > Interesting that these registers are elsewhere, but I bet there is an
 > engineering
 > explanation for this :)
 > 
 > > +    properties:
 > > +      amb,pinmux-ids:
 > > +        description: |
 > > +          an integer array. Each integer in the array specifies a pin
 > > +          with given mux function, with pin id and mux packed as:
 > > +          mux << 12 | pin id
 > > +          Here mux means function of this pin, and pin id is identical to gpio id. For
 > > +          the SoC supporting IOMUX, like S2L, the maximal value of mux is 5. However,
 > > +          for the SoC not supporting IOMUX, like A5S, S2, the third or fourth function
 > > +          is selected by other "virtual pins" setting. Here the "virtual pins" means
 > > +          there is no real hardware pins mapping to the corresponding register address.
 > > +          So the registers for the "virtual pins" can be used for the selection of 3rd
 > > +          or 4th function for other real pins.
 > 
 > I think you can use the standard bindings for this if you insist on
 > using the "magic
 > numbers" scheme.
 > 
 > (I prefer function names and group names as strings, but I gave up on trying
 > to convince the world to use this because people have so strong opions about
 > it.)
 > 
 > From Documentation/devicetree/bindings/pinctrl/pinmux-node.yaml:
 > 
 >   pinmux:
 >     description:
 >       The list of numeric pin ids and their mux settings that properties in the
 >       node apply to (either this, "pins" or "groups" have to be specified)
 >     $ref: /schemas/types.yaml#/definitions/uint32-array
 > 

Well noted, I will switch to pinmux in v2.

 > > +      amb,pinconf-ids:
 > > +        description: |
 > > +          an integer array. Each integer in the array specifies a pin
 > > +          with given configuration, with pin id and config packed as:
 > > +            config << 16 | pin id
 > > +          Here config is used to configure pull up/down and drive strength of the pin,
 > > +          and it's orgnization is:
 > > +          bit1~0: 00: pull down, 01: pull up, 1x: clear pull up/down
 > > +          bit2:   reserved
 > > +          bit3:   0: leave pull up/down as default value, 1: config pull up/down
 > > +          bit5~4: drive strength value, 0: 2mA, 1: 4mA, 2: 8mA, 3: 12mA
 > > +          bit6:   reserved
 > > +          bit7:   0: leave drive strength as default value, 1: config drive strength
 > 
 > I would be very happy if I could convince you to use the standard (string)
 > bindings for this.
 > And from Documentation/devicetree/bindings/pinctrl/pincfg-node.yaml
 > 
 > For each config node this means using strings such as
 > bias-high-impedance; etc in the device tree pin config node.
 > 
 > Following that scheme just makes life so much easier for maintainers and
 > reviewers: very few people reviewing or debugging the system will think
 > it is easy to read a magic number and then (in their head) mask out the
 > bits to see that "OK this is drive strength 8mA" and then have energy and
 > memory enough in their head to remember that "wait a minute, that is supposed
 > to be 12mA in this design", leading to long review and development
 > cycles.
 > 
 > By using:
 > 
 > drive-push-pull;
 > drive-strength = ;
 > 
 > you make the cognitive load on the people reading the device tree much
 > lower and easier to write, maintain and debug for humans.
 > 
 > The tendency to encode this info in terse bitfields appear to be done for either
 > of these reasons:
 > 
 > - Footprint / memory usage
 > - Adopt the users to the way the machine thinks instead of the other way around
 > - "We always did it this way"
 > 
 > Neither is a very good argument on a new 64bit platform.

Thanks for your detailed explanation. I totally agree with you and I also really hate
magic number haha.

I will convert it to standard binding after convincing my manager.

Regards,
Li
