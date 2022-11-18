Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7290D62EE0F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 08:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241047AbiKRHCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 02:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240662AbiKRHCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 02:02:39 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAF51B9DF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 23:02:38 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so3371517wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 23:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=26hKBvJcF5CUHTUmsCq+huARsjmkGqI9lzieMyn9DLo=;
        b=Xx/l90wegiIP7sy0/amq6ND08TImtpP9P536H71U90mq3TLZE5AmTi9VOGqDgZxvts
         1eNEHWg6ietLCLW7LvNIxNSONbpnDptTiqxUPKuglJdy17HyrJI8cYBvMa/FoX+5Yz/S
         jTpKmJxPqtV1OUN0vFM25rF8WLwWv48nCfMON5JVq0bo+NXy8g/5S/M9FjRW8RXVV1S8
         4SQ0lTow3/1mAjE2PiJze24naqvDVHfc0KAQGbJJcdj+JTlngk39tjRnQm6alFUmVBwk
         PYdVyg/V+ouGAXQ9GnrfvySAceDsASAcJMBnfbBTqahaMBcfPGutfF6vw38R8ZJWkD5j
         hm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26hKBvJcF5CUHTUmsCq+huARsjmkGqI9lzieMyn9DLo=;
        b=lKgIzqWe3p2S+6DonBxdQe8y5W0CgG0qV/S0M5AI48KZ/sN3LNeHQrA2iPFfAKwHus
         j1udkafotVk5C6L55JQMhU0z4JHJtPb9oJapyIrzQUSl9viW4NJyZroBA0a8yG8WUqyp
         +ocToXFqOvATh3AEdYSuE6kyIOCfw4u1PUuJhu/N2jtLOgE5YUh+hS9Eoq0rb1qTxEby
         FsogyOVuS8VjHDw38J2Nqcz/OEqWA9x2JjcZ0Bv0w6IwZTqXA2PbK/1cWCLpiL9MmOny
         Hbv1Bklc2yRjsfUP17LufYzXpda/BNvsvfuaoMti2uoQYwYUD3IrVlHppJ/9NdeXuNID
         OTtw==
X-Gm-Message-State: ANoB5pkrzMahsIdium5qondhcMU5bDj2DRnULQJCam6uO9xziTC10AU5
        3/IZTqSVGs8ioCiLss456riFuA==
X-Google-Smtp-Source: AA0mqf58dgLUTsUC3FiqOzuNY3YY+BxeXPdO4wMVdVHin/vyF2Yj9CWK+59hwF/UbVGf48fiC3xyeQ==
X-Received: by 2002:a05:600c:500f:b0:3c7:135a:2e4f with SMTP id n15-20020a05600c500f00b003c7135a2e4fmr7639463wmr.30.1668754956393;
        Thu, 17 Nov 2022 23:02:36 -0800 (PST)
Received: from [192.168.22.132] ([167.98.215.174])
        by smtp.googlemail.com with ESMTPSA id w11-20020a1cf60b000000b003cfbe1da539sm3653646wmc.36.2022.11.17.23.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 23:02:35 -0800 (PST)
Message-ID: <8cf7f7ae-f2d3-56ad-021e-7cb478032291@linaro.org>
Date:   Fri, 18 Nov 2022 07:02:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] ASoC: codecs: va-macro: add npl clk
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
References: <20221115105541.16322-1-srinivas.kandagatla@linaro.org>
 <20221115105541.16322-3-srinivas.kandagatla@linaro.org>
 <090831eb-2c7a-56c2-601e-e910431a9403@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <090831eb-2c7a-56c2-601e-e910431a9403@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Krzysztof,

On 15/11/2022 14:23, Krzysztof Kozlowski wrote:
> On 15/11/2022 11:55, Srinivas Kandagatla wrote:
>> New versions of VA Macro has soundwire integrated, so handle the soundwire npl
>> clock correctly in the codec driver.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   sound/soc/codecs/lpass-va-macro.c | 41 +++++++++++++++++++++++++++++++
>>   1 file changed, 41 insertions(+)
>>
>> diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
>> index b0b6cf29cba3..d59af6d69c34 100644
>> --- a/sound/soc/codecs/lpass-va-macro.c
>> +++ b/sound/soc/codecs/lpass-va-macro.c
>> @@ -205,6 +205,7 @@ struct va_macro {
>>   	int dec_mode[VA_MACRO_NUM_DECIMATORS];
>>   	struct regmap *regmap;
>>   	struct clk *mclk;
>> +	struct clk *npl;
>>   	struct clk *macro;
>>   	struct clk *dcodec;
>>   	struct clk *fsgen;
>> @@ -1332,6 +1333,9 @@ static int fsgen_gate_enable(struct clk_hw *hw)
>>   	struct regmap *regmap = va->regmap;
>>   	int ret;
>>   
>> +	if (va->has_swr_master)
>> +		clk_prepare_enable(va->mclk);
> 
> No error path?
that is true, i missed this indeed, sending v2 with this and other ret = 
PTR_ERR(va->npl) change.

--srini
> 
>> +
>>   	ret = va_macro_mclk_enable(va, true);
>>   	if (!va->has_swr_master)
>>   		return ret;
>> @@ -1358,6 +1362,8 @@ static void fsgen_gate_disable(struct clk_hw *hw)
>>   			   CDC_VA_SWR_CLK_EN_MASK, 0x0);
>>   
>>   	va_macro_mclk_enable(va, false);
>> +	if (va->has_swr_master)
>> +		clk_disable_unprepare(va->mclk);
>>   }
>>   
>>   static int fsgen_gate_is_enabled(struct clk_hw *hw)
>> @@ -1386,6 +1392,9 @@ static int va_macro_register_fsgen_output(struct va_macro *va)
>>   	struct clk_init_data init;
>>   	int ret;
>>   
>> +	if (va->has_swr_master)
>> +		parent = va->npl;
>> +
>>   	parent_clk_name = __clk_get_name(parent);
>>   
>>   	of_property_read_string(np, "clock-output-names", &clk_name);
>> @@ -1512,6 +1521,14 @@ static int va_macro_probe(struct platform_device *pdev)
>>   	/* mclk rate */
>>   	clk_set_rate(va->mclk, 2 * VA_MACRO_MCLK_FREQ);
>>   
>> +	if (va->has_swr_master) {
>> +		va->npl = devm_clk_get(dev, "npl");
> 
> I think you miss:
> ret = PTR_ERR(va->npl);
> 
>> +		if (IS_ERR(va->npl))
>> +			goto err;
>> +
>> +		clk_set_rate(va->npl, 2 * VA_MACRO_MCLK_FREQ);
>> +	}
>> +
>>   	ret = clk_prepare_enable(va->macro);
>>   	if (ret)
>>   		goto err;
> 
> Best regards,
> Krzysztof
> 
