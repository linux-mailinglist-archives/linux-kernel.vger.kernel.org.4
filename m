Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1733F726110
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240471AbjFGNUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240621AbjFGNTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:19:49 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5ADC1993
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 06:19:47 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-30ad458f085so494507f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 06:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686143986; x=1688735986;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mnNtcdYl7FWB9vVI15co5MeYmaXJVC+s1x+N4tvXfWY=;
        b=W5rWw52uP2J5P8VZi5+rmvcoUJ5m9ynK8S0KkE5V84ZaqoSK2Crc9krqvZby91MWEr
         ZSA0moTfIV9aUT84Q0uNcuQGp1sXhG6a/TqQsqZMIoI3NHx8VA7PRXhKOwuwj1S6UHJS
         lbkHivgTqNR4Nw99i/i5xfXB3essZLeGI66BDmEYEeLcgp+SHNXE3JskESna/3alaMtg
         tlEnbg2UE5abmA93Gc3HB/T4lHsaX/sTUguiZacyEBMY+tjzo0nkZNulBfOs+HSOiKxg
         ZqRcxaUyax79NGs3ytKIvKNyR45yzQ8BNjnhJ+XRcJe584z8EV7VnTqK398OY2o6+mSC
         w02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686143986; x=1688735986;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mnNtcdYl7FWB9vVI15co5MeYmaXJVC+s1x+N4tvXfWY=;
        b=BH6VuQ/SDukxtg+tz6J9UmGNbVj5oDy4cqYw9ji2diEkT3jbktRXsE8FcLaoLifbib
         mEMnSd5a2jLtaES4XWQDwqh1tI1aX+NUw4kPK7akG7HBAIhYpW86beKPqp5wsg2ddPnq
         tEjq9vY7iLoyv/NEmSqa366gQIrF6zgQ6VuflE4zbF1biaI7K/A7HlqTQyGkQs0iAirj
         aP0cMqH5gSjsPFxU90xy6PFHJgUvi5WY5ddb2ERbL3BA4HYvN1I6wjw6LNCKxniupDHf
         BRwtOiojfNmTxUmanU8Hyk3d0tnW+iLEkdJbh9FZhOuwiZg5WH+9ww6kFZmr9i1Tl3Un
         v9EQ==
X-Gm-Message-State: AC+VfDxKBXPLtaca4WGaeWkqEyLrOJaASVFH2HZi/0uvbJnT7y13gq5d
        rXY4dLtLN5UAYdU6jSY6atvMtg==
X-Google-Smtp-Source: ACHHUZ7ILsrllirxXgRGCNpr+8QXW/gchSLvNycTUayot7lajmlutG7p1RjL23aGnaOssGNvxAWa7w==
X-Received: by 2002:adf:fec3:0:b0:30a:e8ac:90c1 with SMTP id q3-20020adffec3000000b0030ae8ac90c1mr10941158wrs.19.1686143986059;
        Wed, 07 Jun 2023 06:19:46 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id b3-20020a5d4d83000000b0030c4d8930b1sm15457081wru.91.2023.06.07.06.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 06:19:45 -0700 (PDT)
Message-ID: <b01ca147-c2bd-1044-22c5-5b54a0f108c0@linaro.org>
Date:   Wed, 7 Jun 2023 14:19:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/6] clk: qcom: Add lpass clock controller driver for
 SC8280XP
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     johan+linaro@kernel.org, agross@kernel.org,
        konrad.dybcio@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230525122930.17141-1-srinivas.kandagatla@linaro.org>
 <20230525122930.17141-4-srinivas.kandagatla@linaro.org>
 <098883dd-f517-d541-de00-1a7fc0ada017@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <098883dd-f517-d541-de00-1a7fc0ada017@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/05/2023 21:01, Krzysztof Kozlowski wrote:
> On 25/05/2023 14:29, Srinivas Kandagatla wrote:
>> Add support for the lpass clock controller found on SC8280XP based devices.
>> This would allow lpass peripheral loader drivers to control the clocks and
>> bring the subsystems out of reset.
>>
>> Currently this patch only supports resets as the Q6DSP is in control of
>> LPASS IP which manages most of the clocks via Q6PRM service on GPR rpmsg
>> channel.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/clk/qcom/Kconfig            |  8 ++++
>>   drivers/clk/qcom/Makefile           |  1 +
>>   drivers/clk/qcom/lpasscc-sc8280xp.c | 63 +++++++++++++++++++++++++++++
>>   3 files changed, 72 insertions(+)
>>   create mode 100644 drivers/clk/qcom/lpasscc-sc8280xp.c
>>
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index 85869e7a9f16..e25993abb519 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -523,6 +523,14 @@ config SC_LPASSCC_7280
>>   	  Say Y if you want to use the LPASS branch clocks of the LPASS clock
>>   	  controller to reset the LPASS subsystem.
>>   
>> +config SC_LPASSCC_8280XP
>> +	tristate "SC8280 Low Power Audio Subsystem (LPASS) Clock Controller"
> 
> depends on ARM64 || COMPILE_TEST

Thanks, Will do that in v3.

--srini
> 
> Best regards,
> Krzysztof
> 
