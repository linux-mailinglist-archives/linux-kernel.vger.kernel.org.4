Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B0D6A0438
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbjBWIwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbjBWIwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:52:10 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C0A3A870
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 00:52:08 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id o12so39984046edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 00:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kARWkjDKq+Noo8lk+NWDkTGoxjUlcit/++E6qycI6sc=;
        b=gH1XO0dF11EU4Qw0NYaCkcjTVMmK8AgxltVhr8B/K1NFVruXZ+9+TPAuCYKxo7n8Ry
         QXfjV+KMjK2fb2qGdcOprXdHbkHtU9+wLqchNRiywwbZjHQMTNLjiOjh/dtbFgTTRUCE
         9Br8lgShjzpjY5+EiuiRhM4gYthP9kqMnFVL8qR5B7NQ+absw6dSwbZrGLnhdTU3fTxA
         XHPFWkPzPlo0EFeyyjlFqiFVMQ6ZQn4kfVRbXoJTqbRvUlbkOxbncRzDhZLeZxHEQOSI
         UkMCg7sTK5B5Y0pm/Rie9Ikh1dYnVwW0Zt0ZFZfiauLTE15qWb8fK5RKNoIj+zQXwWJ6
         9baQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kARWkjDKq+Noo8lk+NWDkTGoxjUlcit/++E6qycI6sc=;
        b=llwTHbHY63sG/WpKEJJoyOE+wwtxsSY9BJO92XpvEZdh9DY2BnqjO0jEUrv39Ctu3B
         Oev3Z+PT6JdSX3GXzQ+j7ilFNrXgZXJr9hUGgYPUOh/+0rhgMUtE3FOEhv5jQ1j/vVZK
         hCRW0Vhc9CH8YjgTGxhjZo2hmLGQAkuVKgIsu7HmeDTESWlTSnDTrpu2qcVf0zek0tKM
         CB1VB3T07aLm1zum6YUXHoqm9Abn3fgTpQZX56nHUx/0Zw8emWtWZ8HQdt85zUEk9dox
         ac0Kvw6iKusJ6XjSMmJTq81z1zf99RpaGHQ8s9dte1BlU/4G9ADQ+Wnuc28XvhxcHKQQ
         58kQ==
X-Gm-Message-State: AO0yUKUk4dquloaVwbEiOiBuGYK0UHceNbxZ2Ia2bGjPEGubQJyXAjRF
        H/NhXHlWrzokOXHorL+hUxfnNw==
X-Google-Smtp-Source: AK7set+xA5noulJ+d7bZ1DgrEI4firm9dkLQAGXGypj191Spet4/E5orCmtdDVL1pFvRcIaJYLdZ0w==
X-Received: by 2002:a17:906:ef8c:b0:8b1:806b:7dbb with SMTP id ze12-20020a170906ef8c00b008b1806b7dbbmr20696575ejb.51.1677142326927;
        Thu, 23 Feb 2023 00:52:06 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id bh13-20020a170906a0cd00b008d9ddd2da88sm4123884ejb.6.2023.02.23.00.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 00:52:06 -0800 (PST)
Message-ID: <a8f723cf-d120-0102-d9b2-d40bfbf78349@linaro.org>
Date:   Thu, 23 Feb 2023 09:52:04 +0100
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <842e5825-07ad-1806-d969-f54d9a9eed5a@starfivetech.com>
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

On 23/02/2023 09:47, Xingyu Wu wrote:
> On 2023/2/22 17:09, Krzysztof Kozlowski wrote:
>> On 21/02/2023 15:11, Xingyu Wu wrote:
>>> Add the PLL clock node for the Starfive JH7110 SoC and
>>> modify the SYSCRG node to add PLL clocks.
>>>
>>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>>> ---
>>>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 15 +++++++++++++--
>>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>>> index b6612c53d0d2..0cb8d86ebce5 100644
>>> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
>>> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>>> @@ -461,12 +461,16 @@ syscrg: clock-controller@13020000 {
>>>  				 <&gmac1_rgmii_rxin>,
>>>  				 <&i2stx_bclk_ext>, <&i2stx_lrck_ext>,
>>>  				 <&i2srx_bclk_ext>, <&i2srx_lrck_ext>,
>>> -				 <&tdm_ext>, <&mclk_ext>;
>>> +				 <&tdm_ext>, <&mclk_ext>,
>>> +				 <&pllclk JH7110_CLK_PLL0_OUT>,
>>> +				 <&pllclk JH7110_CLK_PLL1_OUT>,
>>> +				 <&pllclk JH7110_CLK_PLL2_OUT>;
>>>  			clock-names = "osc", "gmac1_rmii_refin",
>>>  				      "gmac1_rgmii_rxin",
>>>  				      "i2stx_bclk_ext", "i2stx_lrck_ext",
>>>  				      "i2srx_bclk_ext", "i2srx_lrck_ext",
>>> -				      "tdm_ext", "mclk_ext";
>>> +				      "tdm_ext", "mclk_ext",
>>> +				      "pll0_out", "pll1_out", "pll2_out";
>>>  			#clock-cells = <1>;
>>>  			#reset-cells = <1>;
>>>  		};
>>> @@ -476,6 +480,13 @@ sys_syscon: syscon@13030000 {
>>>  			reg = <0x0 0x13030000 0x0 0x1000>;
>>>  		};
>>>  
>>> +		pllclk: pll-clock-controller {
>>
>> Does not look like you tested the DTS against bindings. Please run `make
>> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
>> for instructions). You should see here warnings of mixing non-MMIO nodes
>> in MMIO-bus.
>>
> 
> Oh I cherry-pick the commit of syscon node and it also include the MMC node.
> I will remove the MMC node. 
> I used dtbs_check and get the error 'should not be valid under {'type': 'object'}',
> If I move this node out of the 'soc' node, the dtbs_check will be pass.
> Is it OK to move the PLL node out of the 'soc' node? Thanks.

Shall it be out side of soc? How it can then do anything with registers?
This does not look like correct representation of hardware.

Best regards,
Krzysztof

