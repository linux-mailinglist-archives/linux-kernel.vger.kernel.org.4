Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DF85B8508
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiINJdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiINJdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:33:16 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60D378BD4;
        Wed, 14 Sep 2022 02:25:51 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bj12so33203541ejb.13;
        Wed, 14 Sep 2022 02:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=f91nI9a9P/rz6jigHLe0JwBmL/nvLne+WOMNOvAxTEU=;
        b=PRotcdMFmvmLdtVHJam6WtAHNvNFHNc05yVDgO8NUVV6g6CLikshU/8CrKwd7yx94f
         uiWAsJcoer5hoIJvGbLwQFqqrEIQqNbwBa4uE2TIuiHr5FpmfKfD6JgkGJberJPiTFim
         iLlydQrBMSMEdImuLcqdylBiJWi4nBD+AKORUVjU/Td6pN3URiZPTyeTl2iy4TZ34UXp
         fZqe2n+Ye/Z8+m/FmQHDpA3aU+tjw8pGJy+Vbpk8iveAmej+TIClQCuyQlp1653ds2o0
         9dOTthkWZDugptWcDi8JwoscOOMTWYtLbnKo/nrVSHOZ5J9F8DJ5S0Zk6dk/fabE48xr
         XyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=f91nI9a9P/rz6jigHLe0JwBmL/nvLne+WOMNOvAxTEU=;
        b=Dzn3RHxXMUo3WUlf9ZVTURWRpSmsRSKB2sMmX53/50ro+V4CUXGlx5p6dr7QjuSnau
         XO6T5sOpFRTQu6mO6A9+MEm485Iq+43uF8eXnfzSQeWdXFf/SHSuAsxRpW6BIqNye9Z/
         ZJtrU0qj10755s5ijwhRgAJtV/hf7fEOLlEuxf8COLb+MiVSRHP8R+g3tkXmLw1wexfH
         mbAvBU3sChEY2z3gMSrmo4VCq1SFkXIALvfLJPUaWBZKDhCTg2L73egaHexMj2j71hFt
         sHz6D3VJBz2XOR7nSuuiO8rsE+grxmsFOMmBlZZAnY2IZjpRb5xbPfqI2zB+rXmwXdYn
         J8eA==
X-Gm-Message-State: ACgBeo2rqg5f4StaOhmzOPn/a/kPfvFeoEg0ngrpFgjAlvH/1WdOq9jR
        AQtrX6IZ2mVpFcI5EOXWNfQ=
X-Google-Smtp-Source: AA6agR40eeXb4zpmw4i9qjHMaoxtTOGI6hd5lDVJv8VCDKHWZH//zmNJiDc9wDyn2UgqlO/rmKTOTQ==
X-Received: by 2002:a17:907:6ea1:b0:77e:4c93:130a with SMTP id sh33-20020a1709076ea100b0077e4c93130amr8727419ejc.482.1663147550260;
        Wed, 14 Sep 2022 02:25:50 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id x24-20020a50d618000000b0044e01e2533asm9611121edi.43.2022.09.14.02.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 02:25:49 -0700 (PDT)
Message-ID: <aa1fc003-eef9-13bb-b21b-ebccb12dc257@gmail.com>
Date:   Wed, 14 Sep 2022 11:25:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v1] dt-bindings: clock: convert rockchip,rk3128-cru.txt to
 YAML
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        heiko@sntech.de
Cc:     zhangqing@rock-chips.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <76d87f49-6a44-0a05-c9dc-af870fade924@gmail.com>
 <14d7bbb5-51c4-8fc0-2303-f5164c6da903@linaro.org>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <14d7bbb5-51c4-8fc0-2303-f5164c6da903@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/12/22 12:51, Krzysztof Kozlowski wrote:
> On 11/09/2022 23:20, Johan Jonker wrote:
>> Convert rockchip,rk3128-cru.txt to YAML.
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> 
> Thank you for your patch. There is something to discuss/improve.
> 
>> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.yaml
>> new file mode 100644
>> index 000000000..03e5d7f0e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.yaml
>> @@ -0,0 +1,73 @@
>> +# SPDX-License-Identifier: GPL-2.0
> 

> Can't it be Dual licensed?

That depends on Heiko and Rockchip.
I can produce the patch for it, but I'm not in control whether they reply or not. 

===============

dt-bindings: add bindings for px30 clock controller
@mmind
Elaine Zhang authored and mmind committed on Jul 3, 2018 

dt-bindings: add documentation for rk1108 cru
@shawn1221
@mmind
shawn1221 authored and mmind committed on Nov 16, 2016 

dt-bindings: add documentation of rk3036 clock controller
@acgzx
@mmind
acgzx authored and mmind committed on Nov 23, 2015 

dt-bindings: add documentation for rk3188 clock and reset unit
@mmind
mmind authored and Mike Turquette committed on Jul 13, 2014 

dt-bindings: add documentation of rk3228 clock controller
@JeffyCN
@mmind
JeffyCN authored and mmind committed on Dec 12, 2015 

dt-bindings: add documentation for rk3288 cru
@mmind
mmind authored and Mike Turquette committed on Jul 13, 2014 

dt-bindings: add documentation of rk3668 clock controller
@mmind
@bebarino
mmind authored and bebarino committed on Jul 7, 2015 

dt-bindings: Add bindings for rk3308 clock controller
@finley1226
@mmind
finley1226 authored and mmind committed on Sep 5, 2019 

dt-bindings: add bindings for rk3328 clock controller
@mmind
Elaine Zhang authored and mmind committed on Jan 5, 2017 

dt-bindings: add documentation of rk3668 clock controller
@mmind
@bebarino
mmind authored and bebarino committed on Jul 7, 2015 

dt-bindings: add bindings for rk3399 clock controller
@acgzx
@mmind
acgzx authored and mmind committed on Mar 28, 2016 


> 
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/rockchip,rk3128-cru.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Rockchip RK3126/RK3128 Clock and Reset Unit (CRU)
>> +
>> +maintainers:
>> +  - Elaine Zhang <zhangqing@rock-chips.com>
>> +  - Heiko Stuebner <heiko@sntech.de>
>> +
>> +description: |
>> +  The RK3126/RK3128 clock controller generates and supplies clock to various
>> +  controllers within the SoC and also implements a reset controller for SoC
>> +  peripherals.
>> +  Each clock is assigned an identifier and client nodes can use this identifier
>> +  to specify the clock which they consume. All available clocks are defined as
>> +  preprocessor macros in the dt-bindings/clock/rk3128-cru.h headers and can be
>> +  used in device tree sources. Similar macros exist for the reset sources in
>> +  these files.
>> +  There are several clocks that are generated outside the SoC. It is expected
>> +  that they are defined using standard clock bindings with following
>> +  clock-output-names:
>> +    - "xin24m"     - crystal input       - required
>> +    - "ext_i2s"    - external I2S clock  - optional
>> +    - "gmac_clkin" - external GMAC clock - optional
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - rockchip,rk3126-cru
>> +      - rockchip,rk3128-cru
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  "#clock-cells":
>> +    const: 1
>> +
>> +  "#reset-cells":
>> +    const: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    const: xin24m
> 

> More clocks were mentioned in old binding.

We go for a slow approach.
The man with the hammer syndrome thinks that every hardware needs to described with the DT method.
For clocks we do that in the clock driver with macros and structures.
This works fine for Rockchip. If the need arises further proposals will be submitted.
So thanks, but no thanks!


In U-boot we can't filter clocks with exception for the cru node, so DTOC adds them to dt-plat.c with tpl size increase.
When syncing DT changes must be made all over the place.

static struct dtd_fixed_clock dtv_oscillator = {
	.clock_frequency	= 0x16e3600,
	.clock_output_names	= "xin24m",
};
U_BOOT_DRVINFO(oscillator) = {
	.name		= "fixed_clock",
	.plat		= &dtv_oscillator,
	.plat_size	= sizeof(dtv_oscillator),
	.parent_idx	= -1,
};

static struct dtd_rockchip_rk3066a_cru dtv_clock_controller_at_20000000 = {
	.clocks			= {
			{3, {}},},
	.reg			= {0x20000000, 0x1000},
	.rockchip_grf		= 0x9,
};
U_BOOT_DRVINFO(clock_controller_at_20000000) = {
	.name		= "rockchip_rk3066a_cru",
	.plat		= &dtv_clock_controller_at_20000000,
	.plat_size	= sizeof(dtv_clock_controller_at_20000000),
	.parent_idx	= -1,
};

Comment by Heiko:

In the discussion Stephen had comments about the optional clocks, that
have a circular dependency (xin24m -> cru -> i2c -> rtc -> xin32k -> cru) .
After everyone put in their argument, the discussion itself just stopped.

I've picked up the conversion patches anyway, as this is the status-quo
in terms of modelling clocks on Rockchip, so the yaml conversion doesn't
change anything in either direction and just transforms what is in the
kernel right now into the yaml format which will improve devicetree checks
a lot and also reduce the number of warnings emitted by the checker.

https://lore.kernel.org/linux-rockchip/5781991.QJadu78ljV@phil/

> 
>> +
>> +  rockchip,grf:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      Phandle to the syscon managing the "general register files" (GRF),
>> +      if missing pll rates are not changeable, due to the missing pll
>> +      lock status.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - "#clock-cells"
>> +  - "#reset-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    cru: clock-controller@20000000 {
>> +      compatible = "rockchip,rk3128-cru";
>> +      reg = <0x20000000 0x1000>;
>> +      rockchip,grf = <&grf>;
>> +      #clock-cells = <1>;
>> +      #reset-cells = <1>;
>> +    };
> 
> 
> Best regards,
> Krzysztof
