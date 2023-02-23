Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F866A05B7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjBWKK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbjBWKKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:10:51 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A7B5191F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:10:35 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bo30so9666285wrb.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=236jNw2fdr9Ea0T8DRQtB95xL/LfM7SEmL07d5doxEI=;
        b=ZtE+5wrQI/aif/9mX+GzeECglq+rya2NBAbX4l/F8gOQuxQ64tRpYmvz2K+iPD+iRi
         FX2kjQlnERR3iD4J9hQcp7FC9vLxwzW9ysOx0CBBhx95BGmlo6YUtmW+nIKJS6vRF5lF
         v5SAdJrArDyAHgoRSHYNGfg+pkeqyivxvM7gdyOm7raI6+KDI+FWm2TvQ3kseNQ21HAw
         CyodKqSgbGdbk+hKzXfdQIib2y0x11z83OR/1nECGh27E0nBe3GhE5+nJTgxeXqnwfZ2
         leYq7e0iCLRZF1skW9jmfOEesbj7G7HXE5SgPzB9zgE8T1sgbFt6WZPvVZ7l0sz8SUGL
         NxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=236jNw2fdr9Ea0T8DRQtB95xL/LfM7SEmL07d5doxEI=;
        b=aRUu/cL4oiFl+I3f9VJIF54PBbsYcpHKkwwFWcHyG2i41VGV6O1FW5toiJ5FPA5aPO
         fwiVs4q0hWk+0C8Q9m+P23+815WFm5Pp0qQn+m6VwJ83Zdv/vdIBrbas579dk2PhmH46
         HHJaBjtMWsWweax/Mgg6VnTtUlKqLkVKv/kvkGCFlQpZCjZYpPNmNJyFUd6bUlakxBPq
         TSTXOP3deBw/l6m0+C6F9GQ+XkHRx1UssdlpXjMpPwxGS9OW84ljKyT0JrV8kL8vIySc
         ayeuqvp+yIWdMQjjVQ3rtl2RYf9YWUlEBDdjnbdGoB6blompXIJq8Z47Ifm/zdldb6eh
         /SYw==
X-Gm-Message-State: AO0yUKXH5ZD2E0DAce72p+4rISUXm2CpU+pwDD7Pm4wSQQnJjsVs81aR
        hG/+96Ucf/oQZieEqRbCoswfqcXFrSLLu7wN
X-Google-Smtp-Source: AK7set/V8KugWpjfN68Fyoyg3SD+cgyUxwVIdwLNmTr3PEuuNKfYqQ7a5WZX5OBj0FuoZwkno1MZZA==
X-Received: by 2002:a5d:6284:0:b0:2bd:d34e:5355 with SMTP id k4-20020a5d6284000000b002bdd34e5355mr9395008wru.20.1677147034466;
        Thu, 23 Feb 2023 02:10:34 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id s17-20020a5d4ed1000000b002c4084d3472sm6574836wrv.58.2023.02.23.02.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 02:10:34 -0800 (PST)
Message-ID: <d76f25ff-3c60-4e9b-87d7-8c4043b2e47f@linaro.org>
Date:   Thu, 23 Feb 2023 11:10:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 2/3] clk: starfive: Add StarFive JH7110 PLL clock
 driver
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
 <20230221141147.303642-3-xingyu.wu@starfivetech.com>
 <3f50066b-f967-b9fa-1e0d-5337ec1ed194@linaro.org>
 <5e4007b7-6522-4c81-ca15-15a98c586aad@starfivetech.com>
 <50b6fb73-afb2-051b-7969-d7fbbe1e6175@linaro.org>
 <f23b3755-e2dd-f858-02ad-3f1b58934bc6@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f23b3755-e2dd-f858-02ad-3f1b58934bc6@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2023 11:03, Xingyu Wu wrote:
> On 2023/2/23 17:35, Krzysztof Kozlowski wrote:
>> On 23/02/2023 10:32, Xingyu Wu wrote:
>>> On 2023/2/23 16:56, Krzysztof Kozlowski wrote:
>>>> On 21/02/2023 15:11, Xingyu Wu wrote:
>>>>> Add driver for the StarFive JH7110 PLL clock controller and
>>>>> modify the JH7110 system clock driver to rely on this PLL clocks.
>>>>>
>>>>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>>>>> ---
>>>>
>>>>
>>>>> +
>>>>> +static int jh7110_pll_clk_probe(struct platform_device *pdev)
>>>>> +{
>>>>> +	int ret;
>>>>> +	struct of_phandle_args args;
>>>>> +	struct regmap *pll_syscon_regmap;
>>>>> +	unsigned int idx;
>>>>> +	struct jh7110_clk_pll_priv *priv;
>>>>> +	struct jh7110_clk_pll_data *data;
>>>>> +	char *pll_name[JH7110_PLLCLK_END] = {
>>>>> +		"pll0_out",
>>>>> +		"pll1_out",
>>>>> +		"pll2_out"
>>>>> +	};
>>>>> +
>>>>> +	priv = devm_kzalloc(&pdev->dev,
>>>>> +			    struct_size(priv, data, JH7110_PLLCLK_END),
>>>>> +			    GFP_KERNEL);
>>>>> +	if (!priv)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	priv->dev = &pdev->dev;
>>>>> +	ret = of_parse_phandle_with_fixed_args(pdev->dev.of_node, "starfive,sysreg", 0, 0, &args);
>>>>
>>>> 1. Wrong wrapping. Wrap code at 80 as coding style asks.
>>>>
>>>> 2. Why you are using syscon for normal, device MMIO operation? Your DTS
>>>> also points that this is incorrect, hacky representation of hardware.
>>>> Don't add devices to DT to fake places and then overuse syscon to fix
>>>> that fake placement. The clock is in system registers, thus it must be
>>>> there.
>>>>
>>>> 3. Even if this stays, why so complicated code instead of
>>>> syscon_regmap_lookup_by_phandle()?
>>>>
>>>
>>> Thanks for your advice. Will use syscon_regmap_lookup_by_phandle instead it
>>> and remove useless part.
>>
>> So you ignored entirely part 2? This was the main comment... I am going
>> to keep NAK-ing it then.
> 
> What I understand to mean is that I cannot use a fake node to operate syscon
> registers. So I should move the PLL node under syscon node directly. Is it ok?

Yes, because it looks like entire PLL clock control is from the syscon
node, thus the clocks are there.

Best regards,
Krzysztof

