Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A566C7EF6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjCXNkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjCXNkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:40:33 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C373F198D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:40:28 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id o7so1845252wrg.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679665227;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uxks+D7tg270m56Qm6LTgOFJlR4Rk4z9TE/pG/DVRoE=;
        b=I957oSLb8E9prHBNoUFuYzolJE2VO72+Aj4jDBverK28uMV4CljU3GWMVxlFYTQ59u
         glZR7UWPXBCtNMOsvTaRT8h/IpFrunpAMcwxe4zauSKBBNRoQybvcgUCXDa629HhLKlT
         xHC6zHYViekDH17izfTIeFHSXp36x8uVmMc0QTPjXKLgzZuAoHpPc8hWou08L+lkqtTr
         e/9vQfJUBesQBkG72s+okJm4NnzBGm4jojexSHGcmw88sAJzEMqtxgiSL5SpwWBxJ4cU
         pOz1wuysL9/H6lh3jEZvyhqtTuYYvPDWR/Fe1Cw4zF6LaynMMpbM9kewLkEkxK9biWsh
         q1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679665227;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uxks+D7tg270m56Qm6LTgOFJlR4Rk4z9TE/pG/DVRoE=;
        b=dpPz5vNJJKuxz6oBqxVjm421qzkKDlHUpzfksSSBzrf3ec9HZDBWa80w4hpFGuLQbZ
         TrlIdyT1zM4ce3SrzMUo/2Yn8yw01uzuEN6siNwWj5h+hK8opRZl46noUJMSHj47Xzbp
         Q0dOMuZCieJJYY80bKddxBIoBuXBjMKUy529qkDkaqfYjZlMlo3+0Y/066zGSdI/+o32
         UXwG5bS4ND+BOL45LgGo/cjXNgq4BcaZf0qUZAvs3LKLsc8pNO1p9O3EuLHppMnr/mMm
         iNisxlNG1X1Ugqh+gcJ4MQ4DkzRj4JzMfDbG8cajKAOYJ9HNsHj+yjNGX6a0/tKlxB60
         9sbA==
X-Gm-Message-State: AAQBX9f6m2DSKyOcO2Vyy13TuNkmCDK7fAM0WEbyftS+yr76BYRmNhh3
        JFwV/JUeRdGMHbKTfZV6eBvusQ==
X-Google-Smtp-Source: AKy350YXgCiosthQyol/32xZCHPbha/J33aIMAs8KVyL3Kk35ZLSAdsCtEAE72q7wAnC1xRR+gMnig==
X-Received: by 2002:adf:e887:0:b0:2d8:1a74:9b94 with SMTP id d7-20020adfe887000000b002d81a749b94mr2156578wrm.68.1679665227198;
        Fri, 24 Mar 2023 06:40:27 -0700 (PDT)
Received: from [10.11.120.160] ([81.145.206.54])
        by smtp.googlemail.com with ESMTPSA id a8-20020a056000100800b002d8566128e5sm10012253wrx.25.2023.03.24.06.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 06:40:26 -0700 (PDT)
Message-ID: <e782e78c-422f-fbf9-94a3-3557c9f7fc7e@linaro.org>
Date:   Fri, 24 Mar 2023 13:40:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 5/8] ASoC: codecs: lpass: register mclk after runtime pm
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>, broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        steev@kali.org, johan+linaro@kernel.org, quic_bjorande@quicinc.com
References: <20230209122806.18923-1-srinivas.kandagatla@linaro.org>
 <20230209122806.18923-6-srinivas.kandagatla@linaro.org>
 <CREKOWOABXLP.28VKF824CFB3O@otso>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <CREKOWOABXLP.28VKF824CFB3O@otso>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On 24/03/2023 11:22, Luca Weiss wrote:
> Hi Srinivas,
> 
> On Thu Feb 9, 2023 at 1:28 PM CET, Srinivas Kandagatla wrote:
>> move mclk out registration after runtime pm is enabled so that the
>> clk framework can resume the codec if it requires to enable the mclk out.
>>
>> Fixes: c96baa2949b2 ("ASoC: codecs: wsa-macro: add runtime pm support")
>> Fixes: 72ad25eabda0 ("ASoC: codecs: va-macro: add runtime pm support")
>> Fixes: 366ff79ed539 ("ASoC: codecs: rx-macro: add runtime pm support")
>> Fixes: 1fb83bc5cf64 ("ASoC: codecs: tx-macro: add runtime pm support")
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> I see the following remoteproc crash with this patch in on
> sm6350/sm7225-fairphone-fp4.
> 
> To be clear, all the audio parts for that SoC are not upstream (yet) and
> there's still many issues to solve so not sure if it's actually my fault.
> 

please try this patch Amit did report this issue before

https://lore.kernel.org/lkml/20230323110125.23790-1-srinivas.kandagatla@linaro.org/


thanks,
srini
> Anyways, getting this crash after starting adsp.
> 
> [   97.212943] qcom_q6v5_pas 3000000.remoteproc: fatal error received: ABT_dal.c:287:ABTimeout: AHB Bus hang is detected, Number of bus hang detected := 1 , addr0 = 0x3370000 , addr1 = 0x0!!!
> [   97.212995] remoteproc remoteproc0: crash detected in 3000000.remoteproc: type fatal error
> [   97.213015] remoteproc remoteproc0: handling crash #1 in 3000000.remoteproc
> [   97.213022] remoteproc remoteproc0: recovering 3000000.remoteproc
> 
> This happens just after some clocks on the adsp get disabled, this is
> from my own debug prints:
> [   97.189097] q6afe_set_lpass_clock: clk_id=780, attri=1, clk_root=0, freq=0
> [   97.189426] q6afe_set_lpass_clock: clk_id=781, attri=1, clk_root=0, freq=0
> 
> And then a couple of seconds later the whole phone just crashes into the
> 900e mode.
> 
> Regards
> Luca
> 
> 
>> ---
>>   sound/soc/codecs/lpass-rx-macro.c  |  8 ++++----
>>   sound/soc/codecs/lpass-tx-macro.c  |  8 ++++----
>>   sound/soc/codecs/lpass-va-macro.c  | 20 ++++++++++----------
>>   sound/soc/codecs/lpass-wsa-macro.c |  9 ++++-----
>>   4 files changed, 22 insertions(+), 23 deletions(-)
>>
>> diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
>> index a9ef9d5ffcc5..dd6970d5eb8d 100644
>> --- a/sound/soc/codecs/lpass-rx-macro.c
>> +++ b/sound/soc/codecs/lpass-rx-macro.c
>> @@ -3601,10 +3601,6 @@ static int rx_macro_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		goto err_fsgen;
>>   
>> -	ret = rx_macro_register_mclk_output(rx);
>> -	if (ret)
>> -		goto err_clkout;
>> -
>>   	ret = devm_snd_soc_register_component(dev, &rx_macro_component_drv,
>>   					      rx_macro_dai,
>>   					      ARRAY_SIZE(rx_macro_dai));
>> @@ -3618,6 +3614,10 @@ static int rx_macro_probe(struct platform_device *pdev)
>>   	pm_runtime_set_active(dev);
>>   	pm_runtime_enable(dev);
>>   
>> +	ret = rx_macro_register_mclk_output(rx);
>> +	if (ret)
>> +		goto err_clkout;
>> +
>>   	return 0;
>>   
>>   err_clkout:
>> diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
>> index 2ef62d6edc30..b9475ba55e20 100644
>> --- a/sound/soc/codecs/lpass-tx-macro.c
>> +++ b/sound/soc/codecs/lpass-tx-macro.c
>> @@ -2036,10 +2036,6 @@ static int tx_macro_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		goto err_fsgen;
>>   
>> -	ret = tx_macro_register_mclk_output(tx);
>> -	if (ret)
>> -		goto err_clkout;
>> -
>>   	ret = devm_snd_soc_register_component(dev, &tx_macro_component_drv,
>>   					      tx_macro_dai,
>>   					      ARRAY_SIZE(tx_macro_dai));
>> @@ -2052,6 +2048,10 @@ static int tx_macro_probe(struct platform_device *pdev)
>>   	pm_runtime_set_active(dev);
>>   	pm_runtime_enable(dev);
>>   
>> +	ret = tx_macro_register_mclk_output(tx);
>> +	if (ret)
>> +		goto err_clkout;
>> +
>>   	return 0;
>>   
>>   err_clkout:
>> diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
>> index b0b6cf29cba3..1623ba78ddb3 100644
>> --- a/sound/soc/codecs/lpass-va-macro.c
>> +++ b/sound/soc/codecs/lpass-va-macro.c
>> @@ -1524,16 +1524,6 @@ static int va_macro_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		goto err_mclk;
>>   
>> -	ret = va_macro_register_fsgen_output(va);
>> -	if (ret)
>> -		goto err_clkout;
>> -
>> -	va->fsgen = clk_hw_get_clk(&va->hw, "fsgen");
>> -	if (IS_ERR(va->fsgen)) {
>> -		ret = PTR_ERR(va->fsgen);
>> -		goto err_clkout;
>> -	}
>> -
>>   	if (va->has_swr_master) {
>>   		/* Set default CLK div to 1 */
>>   		regmap_update_bits(va->regmap, CDC_VA_TOP_CSR_SWR_MIC_CTL0,
>> @@ -1560,6 +1550,16 @@ static int va_macro_probe(struct platform_device *pdev)
>>   	pm_runtime_set_active(dev);
>>   	pm_runtime_enable(dev);
>>   
>> +	ret = va_macro_register_fsgen_output(va);
>> +	if (ret)
>> +		goto err_clkout;
>> +
>> +	va->fsgen = clk_hw_get_clk(&va->hw, "fsgen");
>> +	if (IS_ERR(va->fsgen)) {
>> +		ret = PTR_ERR(va->fsgen);
>> +		goto err_clkout;
>> +	}
>> +
>>   	return 0;
>>   
>>   err_clkout:
>> diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
>> index 5cfe96f6e430..c0b86d69c72e 100644
>> --- a/sound/soc/codecs/lpass-wsa-macro.c
>> +++ b/sound/soc/codecs/lpass-wsa-macro.c
>> @@ -2451,11 +2451,6 @@ static int wsa_macro_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		goto err_fsgen;
>>   
>> -	ret = wsa_macro_register_mclk_output(wsa);
>> -	if (ret)
>> -		goto err_clkout;
>> -
>> -
>>   	ret = devm_snd_soc_register_component(dev, &wsa_macro_component_drv,
>>   					      wsa_macro_dai,
>>   					      ARRAY_SIZE(wsa_macro_dai));
>> @@ -2468,6 +2463,10 @@ static int wsa_macro_probe(struct platform_device *pdev)
>>   	pm_runtime_set_active(dev);
>>   	pm_runtime_enable(dev);
>>   
>> +	ret = wsa_macro_register_mclk_output(wsa);
>> +	if (ret)
>> +		goto err_clkout;
>> +
>>   	return 0;
>>   
>>   err_clkout:
>> -- 
>> 2.21.0
> 
