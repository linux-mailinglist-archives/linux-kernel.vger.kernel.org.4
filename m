Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B986A046D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 10:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbjBWJE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 04:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbjBWJE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:04:56 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DFC1EFF2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:04:55 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id o12so40073620edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8RmO4b5hhwebSj5Cj50iTEF8PxEqggdJHWYbDNzOlRM=;
        b=O+4WkHK2t+oozA7GD5sbtbrdpKW4pqbPFGy6aDnYXl9BzRPgRkKmX7qCo6iDFyJVvb
         Qfr4AHufrzEOqYmHDTbP4QbQgGQOXVzmQMb84SjZrALszYSSA658zSP0quiqlu/62Qjz
         A6+4wAB/wMnSRzmAE04EwuXoWGxOFJL7Xs91N94iY2ZraaAgdB8/H5r0WwNiSvhlalc8
         Nn+9SquFmNLf7/KcZ6LqMEcioiRTWxdlqmDqeqVkFOpOjbysj/GvLF6KyMyZJ7Nx8OR8
         vQEpYg43Cbn32zSWbsMF6PFBIiHx8n5NFI4SDWhkhKSIF20qXgB5bD9BKAml7wwXjXJQ
         nB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8RmO4b5hhwebSj5Cj50iTEF8PxEqggdJHWYbDNzOlRM=;
        b=dX+M0O4bVdkZ5WV68WkHag+mavF+0bJhQOa/w3UdZrCMibi6O18LaHUSCIVBatQm1e
         uSk4pIUkesC2TwIfv2Oi10oeiUcMq1aAYyB4cYeYIiPQu1X5SjU0pytT/x0TggP55NYr
         Kw4SQFNWphhiv8a9sUxx/kildDS2IW47IuL0HbLjk4LTZrDJlNYA1boJw61scllqzJu6
         jfEOMWLecxHpZUmOdAXmDaSo25M3/+zdO3/TIG1p+6KL831h33Q934vxU5cHgz/Q68Wr
         SBixZ0G0poNhL8P/KTyxhSFCxi64t0sKRhB1fMEft8R52LLQSzUdH+MomJiuitjDtQ1w
         xz5g==
X-Gm-Message-State: AO0yUKWOTyQ70FBCWczJmJYVaw+bIF8bROanOyzWsJUOmQWZ2Avq8Vmc
        UGcWZqhwf1PArgNCYcvY2bbMAQ==
X-Google-Smtp-Source: AK7set+3/2aqYsFGt0VD4bmZlatErnbLDJU/4VZzq7ckU0T/EaM6DW2wHb7xPgo8rQ5md5gIhk/yqg==
X-Received: by 2002:a17:907:2da8:b0:8b1:7274:1a72 with SMTP id gt40-20020a1709072da800b008b172741a72mr19780103ejc.6.1677143093583;
        Thu, 23 Feb 2023 01:04:53 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b42-20020a509f2d000000b004ad72045ed9sm4325306edf.65.2023.02.23.01.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 01:04:52 -0800 (PST)
Message-ID: <3dd8c78b-20ea-24c8-4019-cc03ebbcad71@linaro.org>
Date:   Thu, 23 Feb 2023 10:04:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 3/3] riscv: dts: starfive: jh7110: Add PLL clock node
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20230221141147.303642-1-xingyu.wu@starfivetech.com>
 <20230221141147.303642-4-xingyu.wu@starfivetech.com>
 <a799e064-b0ac-7300-b706-0c33e2d3610a@linaro.org>
 <842e5825-07ad-1806-d969-f54d9a9eed5a@starfivetech.com>
 <a8f723cf-d120-0102-d9b2-d40bfbf78349@linaro.org>
 <84a785bb-8a48-fa55-ea64-29c21ac42cf8@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <84a785bb-8a48-fa55-ea64-29c21ac42cf8@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2023 10:03, Xingyu Wu wrote:
> On 2023/2/23 16:52, Krzysztof Kozlowski wrote:
>> On 23/02/2023 09:47, Xingyu Wu wrote:
>>> On 2023/2/22 17:09, Krzysztof Kozlowski wrote:
>>>> On 21/02/2023 15:11, Xingyu Wu wrote:
>>>>> Add the PLL clock node for the Starfive JH7110 SoC and
>>>>> modify the SYSCRG node to add PLL clocks.
>>>>>
>>>>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>>>>> ---
>>>>>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 15 +++++++++++++--
>>>>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>>>>> index b6612c53d0d2..0cb8d86ebce5 100644
>>>>> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
>>>>> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>>>>> @@ -461,12 +461,16 @@ syscrg: clock-controller@13020000 {
>>>>>  				 <&gmac1_rgmii_rxin>,
>>>>>  				 <&i2stx_bclk_ext>, <&i2stx_lrck_ext>,
>>>>>  				 <&i2srx_bclk_ext>, <&i2srx_lrck_ext>,
>>>>> -				 <&tdm_ext>, <&mclk_ext>;
>>>>> +				 <&tdm_ext>, <&mclk_ext>,
>>>>> +				 <&pllclk JH7110_CLK_PLL0_OUT>,
>>>>> +				 <&pllclk JH7110_CLK_PLL1_OUT>,
>>>>> +				 <&pllclk JH7110_CLK_PLL2_OUT>;
>>>>>  			clock-names = "osc", "gmac1_rmii_refin",
>>>>>  				      "gmac1_rgmii_rxin",
>>>>>  				      "i2stx_bclk_ext", "i2stx_lrck_ext",
>>>>>  				      "i2srx_bclk_ext", "i2srx_lrck_ext",
>>>>> -				      "tdm_ext", "mclk_ext";
>>>>> +				      "tdm_ext", "mclk_ext",
>>>>> +				      "pll0_out", "pll1_out", "pll2_out";
>>>>>  			#clock-cells = <1>;
>>>>>  			#reset-cells = <1>;
>>>>>  		};
>>>>> @@ -476,6 +480,13 @@ sys_syscon: syscon@13030000 {
>>>>>  			reg = <0x0 0x13030000 0x0 0x1000>;
>>>>>  		};
>>>>>  
>>>>> +		pllclk: pll-clock-controller {
>>>>
>>>> Does not look like you tested the DTS against bindings. Please run `make
>>>> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
>>>> for instructions). You should see here warnings of mixing non-MMIO nodes
>>>> in MMIO-bus.
>>>>
>>>
>>> Oh I cherry-pick the commit of syscon node and it also include the MMC node.
>>> I will remove the MMC node. 
>>> I used dtbs_check and get the error 'should not be valid under {'type': 'object'}',
>>> If I move this node out of the 'soc' node, the dtbs_check will be pass.
>>> Is it OK to move the PLL node out of the 'soc' node? Thanks.
>>
>> Shall it be out side of soc? How it can then do anything with registers?
>> This does not look like correct representation of hardware.
> 
> The error appears to be due to a lack of reg base about PLL node. PLL do something with register
> by 'sys_syscon' node and the syscon node is in the soc node.

Again: And how is this correct representation of hardware?

Best regards,
Krzysztof

