Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412165FB859
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 18:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJKQi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 12:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJKQiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 12:38:24 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5F4A2231
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 09:38:21 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id bb5so3253035qtb.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 09:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QY6WyTHOtNVOWNT2T4wR6tUw0MK2Z6zU5+UbTJRR4tc=;
        b=LEg8IGV5qy1f4Ls0uTv3AByar4HiiDxIwsDKEhd1O3xBrraCFAScNYyn0CRQWX99TD
         ShlqA8pojnv0xNOdhZlj4K0NCqWlqdzblrcblq+HuJTHZvC2J4F5cn7BFcbgHDPYWHF7
         qHzdA9/fr79n+ObD0DllHTbQB4OH2+jcfYrj5heT+Ssk0cmsq6BGxhVAbWgyU/bZ1OBJ
         4Xw56h8FS775SUNOojVN+hK9z/twXXMQ0SkXkM2b2ZkT1df9zEBBJAXBMmFIflHUu2FR
         joWqB9dh6xRCkeK83NAvUkRsL6Ti980Daj99a6FoHp3T66M9ZlQbAQjF8tq15WmLfmFd
         LjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QY6WyTHOtNVOWNT2T4wR6tUw0MK2Z6zU5+UbTJRR4tc=;
        b=NsXfaCB9nFg+sHrzOi488V2QKWyZi9fCLdpeJkY2GhwEtjwi30+EdDUdrOZsTILs6R
         qb/Hj8GyO6kOyKSI75BsMTnBr55EM09aGiLwyLXW4NRzm8n3qZ0BqJtj+zvPQblFJftd
         osDbCOVOBp8R+PpXS4Ckz5ETP4NoLojn14Rj0MA3TYEtG4D3AfKWZdf0MAQjz42YcL3Q
         FcNxmU33Vla7DlUwdSPGk3Zdj+GT5Zzm3ljP2W/pARLozDkvEKn3CinK26XxYG4oLthS
         qvnALayw/f5Eh7VwYPQgCHazVAWGdd+8vy7CA+ePaEdEWXn/GDx7vC8J8Y5DOFXwj8HZ
         Ubtg==
X-Gm-Message-State: ACrzQf2ccjtn3dLKNpXo8wph+wu7lB3XQmSWCgGA9UPchXggr7E72DrC
        pwzpkoZUCad/CwhvsTI6M53cxQ==
X-Google-Smtp-Source: AMsMyM6ZR0Jj5RCA2gjlIscZ4R49LE0rwlWp+wlpIGZOb1PmOQmoWN5UpcMrnDWhs1cwnY4FWY3c0w==
X-Received: by 2002:a05:622a:2c6:b0:39c:42ee:932d with SMTP id a6-20020a05622a02c600b0039c42ee932dmr3355086qtx.156.1665506300783;
        Tue, 11 Oct 2022 09:38:20 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id i11-20020a05620a404b00b006a5d2eb58b2sm13979752qko.33.2022.10.11.09.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 09:38:20 -0700 (PDT)
Message-ID: <2f1d1afd-3c97-6ce0-8247-6e1c4a24e548@linaro.org>
Date:   Tue, 11 Oct 2022 12:36:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 12/30] dt-bindings: reset: Add starfive,jh7110-reset
 bindings
Content-Language: en-US
To:     Hal Feng <hal.feng@linux.starfivetech.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220929175147.19749-1-hal.feng@linux.starfivetech.com>
 <20220929184349.GA2551443-robh@kernel.org>
 <8BEAFAD2C4CE6E4A+0a00376c-1e3e-f597-bcf6-106ff294859a@linux.starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8BEAFAD2C4CE6E4A+0a00376c-1e3e-f597-bcf6-106ff294859a@linux.starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 11:30, Hal Feng wrote:
> On Thu, 29 Sep 2022 13:43:49 -0500, Rob Herring wrote:
>> On Fri, Sep 30, 2022 at 01:51:47AM +0800, Hal Feng wrote:
>>> Add bindings for the reset controller on the JH7110 RISC-V
>>> SoC by StarFive Technology Ltd.
>>>
>>> Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
>>> ---
>>>  .../bindings/reset/starfive,jh7110-reset.yaml | 54 +++++++++++++++++++
>>>  1 file changed, 54 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/reset/starfive,jh7110-reset.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/reset/starfive,jh7110-reset.yaml b/Documentation/devicetree/bindings/reset/starfive,jh7110-reset.yaml
>>> new file mode 100644
>>> index 000000000000..bb0010c200f9
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/reset/starfive,jh7110-reset.yaml
>>> @@ -0,0 +1,54 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/reset/starfive,jh7110-reset.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: StarFive JH7110 SoC Reset Controller Device Tree Bindings
>>> +
>>> +maintainers:
>>> +  - Emil Renner Berthing <kernel@esmil.dk>
>>> +  - Hal Feng <hal.feng@linux.starfivetech.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - starfive,jh7110-reset
>>
>> 'reg' needed? Is this a sub-block of something else?
> 
> Yes, the reset node is a child node of the syscon node, see patch 27 for detail.
> You might not see the complete patches at that time due to technical issue of
> our smtp email server. Again, I feel so sorry about that.
> 
> 	syscrg: syscrg@13020000 {
> 		compatible = "syscon", "simple-mfd";
> 		reg = <0x0 0x13020000 0x0 0x10000>;
> 
> 		syscrg_clk: clock-controller@13020000 {
> 			compatible = "starfive,jh7110-clkgen-sys";
> 			clocks = <&osc>, <&gmac1_rmii_refin>,
> 				 <&gmac1_rgmii_rxin>,
> 				 <&i2stx_bclk_ext>, <&i2stx_lrck_ext>,
> 				 <&i2srx_bclk_ext>, <&i2srx_lrck_ext>,
> 				 <&tdm_ext>, <&mclk_ext>;
> 			clock-names = "osc", "gmac1_rmii_refin",
> 				"gmac1_rgmii_rxin",
> 				"i2stx_bclk_ext", "i2stx_lrck_ext",
> 				"i2srx_bclk_ext", "i2srx_lrck_ext",
> 				"tdm_ext", "mclk_ext";
> 			#clock-cells = <1>;
> 		};
> 
> 		syscrg_rst: reset-controller@13020000 {
> 			compatible = "starfive,jh7110-reset";
> 			#reset-cells = <1>;

So the answer to the "reg needed?" is what? You have unit address but no
reg, so this is not correct.

> 			starfive,assert-offset = <0x2F8>;
> 			starfive,status-offset= <0x308>;
> 			starfive,nr-resets = <JH7110_SYSRST_END>;
> 		};
> 	};
> 
> In this case, we get the memory mapped space through the parent node with syscon
> APIs. You can see patch 13 for detail.
> 
> static int reset_starfive_register(struct platform_device *pdev, const u32 *asserted)
> {


(...)

> 
>>
>>> +
>>> +  "#reset-cells":
>>> +    const: 1
>>> +
>>> +  starfive,assert-offset:
>>> +    description: Offset of the first ASSERT register
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +
>>> +  starfive,status-offset:
>>> +    description: Offset of the first STATUS register
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>
>> These can't be implied from the compatible string?
> 
> These two properties are the key differences among different reset controllers.

Different as in different compatibles? Please answer the questions...

> There are five memory regions for clock and reset in StarFive JH7110 SoC. They
> are "syscrg", "aoncrg", "stgcrg", "ispcrg" and "voutcrg". Each memory region
> has different reset ASSERT/STATUS register offset and different number of reset
> signals. 

Then these are not exactly the same devices, so using one compatible for
them does not look correct.

> After storing them in dt, the reset driver can register all reset
> controllers with the same compatible string. 

Which is not how the compatible should be used...

> All we expect is that all reset
> controllers in a single SoC use the same compatible string for matching and the
> reset driver can be applied to all StarFive SoCs using different compatible strings.

Keep driver out of the talks.

> Just like

Existing bad pattern is not an argument to keep it going. Fix bad
patterns instead.

> 
> arch/riscv/boot/dts/starfive/jh7100.dtsi:
> 
> 	rstgen: reset-controller@11840000 {
> 		compatible = "starfive,jh7100-reset";
> 		reg = <0x0 0x11840000 0x0 0x10000>;
> 		#reset-cells = <1>;
> 		starfive,assert-offset = <0x0>;
> 		starfive,status-offset= <0x10>;
> 		starfive,nr-resets = <JH7100_RSTN_END>;
> 	};
> 
> arch/riscv/boot/dts/starfive/jh7110.dtsi:
> 
> 	syscrg: syscrg@13020000 {
> 		compatible = "syscon", "simple-mfd";
> 		reg = <0x0 0x13020000 0x0 0x10000>;
> 
> 		syscrg_clk: clock-controller@13020000 {
> 			compatible = "starfive,jh7110-clkgen-sys";
> 			...
> 		};
> 
> 		syscrg_rst: reset-controller@13020000 {
> 			compatible = "starfive,jh7110-reset";
> 			#reset-cells = <1>;
> 			starfive,assert-offset = <0x2F8>;
> 			starfive,status-offset= <0x308>;
> 			starfive,nr-resets = <JH7110_SYSRST_END>;
> 		};
> 	};
> 
> 	aoncrg: aoncrg@17000000 {
> 		compatible = "syscon", "simple-mfd";
> 		reg = <0x0 0x17000000 0x0 0x10000>;
> 
> 		aoncrg_clk: clock-controller@17000000 {
> 			compatible = "starfive,jh7110-clkgen-aon";
> 			...
> 		};
> 
> 		aoncrg_rst: reset-controller@17000000 {
> 			compatible = "starfive,jh7110-reset";
> 			#reset-cells = <1>;
> 			starfive,assert-offset = <0x38>;
> 			starfive,status-offset= <0x3C>;
> 			starfive,nr-resets = <JH7110_AONRST_END>;
> 		};
> 	};
> 
> 	stgcrg: stgcrg@10230000 {	//Not submmited yet
> 		compatible = "syscon", "simple-mfd";
> 		reg = <0x0 0x10230000 0x0 0x10000>;
> 
> 		stgcrg_clk: clock-controller@10230000 {
> 			compatible = "starfive,jh7110-clkgen-stg";
> 			...
> 		};
> 
> 		stgcrg_rst: reset-controller@10230000 {
> 			compatible = "starfive,jh7110-reset";
> 			#reset-cells = <1>;
> 			starfive,assert-offset = <0x74>;
> 			starfive,status-offset= <0x78>;
> 			starfive,nr-resets = <JH7110_STGRST_END>;
> 		};
> 	};
> 	...
> 
>>
>>> +
>>> +  starfive,nr-resets:
>>> +    description: Number of reset signals
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>
>> Why do you need this? Most bindings don't. If just to validate 'resets' 
>> args, then don't.
> 
> Can be removed. Instead, the reset driver should includes some related
> binding headers or defines some macros for pointing out the number of
> reset signals of each reset controller.
> 
> Best regards,
> Hal
> 
>>
>>
>>> +
>>> +required:
>>> +  - compatible
>>> +  - "#reset-cells"
>>> +  - starfive,assert-offset
>>> +  - starfive,status-offset
>>> +  - starfive,nr-resets
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/reset/starfive-jh7110.h>
>>> +
>>> +    syscrg_rst: reset-controller@13020000 {

Please test your patches.


Best regards,
Krzysztof

