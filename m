Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2E762B9E8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238663AbiKPKrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239111AbiKPKrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:47:21 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C8445EE7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:35:10 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id cl5so29173829wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:reply-to:organization:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sQgFoK8cOPk+aS6uvHgGsxqyaP/eeSCg5EmIN7/zyIQ=;
        b=oSgWTksrFOQyCIHLqT1fD98tKsflrC4rq+dc06OSRC7CEnIttQYkvjcdc+ebABf4Sm
         TjDupkAZLp/9qwNBxz/zpjab+P2h+MnZ7hZIk/NA3LtTgcoBkPWRVntiHRZ+K4uSg74/
         wTSOpg0Mm8xTryJ4ML4Ld5jxZ3fBG6PtPqRhVrplc1NaKxuGlHC7FPaIQOYk8V9YMsSD
         +SIT2ra6pqrLlkPAk2qp+XmM/l0qf1wsRDiT/sshQn+bWVlO8FZazH1t3E9PCCEi64Yy
         LrFLB+6vtbuc0FyPvUdLJXEGXV8gtvxdfhyRG4xyRKtwfWZI/SPT6wLtMZH46bI8uTNA
         mqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:reply-to:organization:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQgFoK8cOPk+aS6uvHgGsxqyaP/eeSCg5EmIN7/zyIQ=;
        b=G/v1GSEs80GEzODunuJImblJV75iV8ay4maIAdhn7edth+sUsTRruE7OJ+NiX63cu5
         7yajmTgWpCvhJ/GKmTWeTmSel6H5Zsm8ROkBOHqKt15BI7frwO2OaqOfnLCZbcnwqzH9
         M5H93nVtdSO9RXIFWFJPf75h2Q/JPpLhToMlh98ek1UpRj3g0LGIW7Y2kTx9ojnIxlR5
         wDu0g0iVVUXir22QalZ1xHtu3atwaY+NSLKuYASHvSAFh2wA4Eet+iVP5oFoOxCWDAvI
         WKQvsIu5FGxBLWiUFS+0P0At0+jGBGomqWBQ2FLDzkcZCx6Ub/05Gb7Au1H3R6TxMlHT
         rNRA==
X-Gm-Message-State: ANoB5pm5dktvVkHhFUUw0IzzOjq/AFr+WtA2zxwUi6zXmWdFZFOGeLDw
        VkVmcRfazAgt5ZHHw2a+YHXlAQ==
X-Google-Smtp-Source: AA0mqf71a/71TLKyRyM8vG9iLuHPkKm/gjm9e18hX4KS/ptMHJEPv25qtY7A4tiwpbqv5x9+ukzfmA==
X-Received: by 2002:a05:6000:1373:b0:236:c206:b2b1 with SMTP id q19-20020a056000137300b00236c206b2b1mr13293273wrz.624.1668594908845;
        Wed, 16 Nov 2022 02:35:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:2a03:71a6:7a9d:9c71? ([2a01:e0a:982:cbb0:2a03:71a6:7a9d:9c71])
        by smtp.gmail.com with ESMTPSA id by11-20020a056000098b00b002258235bda3sm14842417wrb.61.2022.11.16.02.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 02:35:08 -0800 (PST)
Message-ID: <9572fc1b-3b13-bb7b-bfdd-3e06a46dedf0@linaro.org>
Date:   Wed, 16 Nov 2022 11:35:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 7/7] pinctrl: qcom: spmi-gpio: add support for pmr735d
 gpio control
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20221114-narmstrong-sm8550-upstream-spmi-v1-0-6338a2b4b241@linaro.org>
 <20221114-narmstrong-sm8550-upstream-spmi-v1-7-6338a2b4b241@linaro.org>
 <16de0a02-e7d7-87d1-c877-e32de46bfc28@linaro.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
Reply-To: neil.armstrong@linaro.org
In-Reply-To: <16de0a02-e7d7-87d1-c877-e32de46bfc28@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16/11/2022 11:22, Konrad Dybcio wrote:
> 
> 
> On 16/11/2022 11:11, Neil Armstrong wrote:
>> Add support for the pmr735d gpio controller providing GPIO control over SPMI.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
> Any particular reason this could not be a part of the previous patch?

I thought it would be cleaner splitting them by family names, but yeah they could be squashed, same for bindings.

> 
> For the addition itself:
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Thanks!
Neil
> 
> Konrad
>>   drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
>> index f758522d035e..66d6d7ffbd43 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
>> +++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
>> @@ -1242,6 +1242,7 @@ static const struct of_device_id pmic_gpio_of_match[] = {
>>       { .compatible = "qcom,pmp8074-gpio", .data = (void *) 12 },
>>       { .compatible = "qcom,pmr735a-gpio", .data = (void *) 4 },
>>       { .compatible = "qcom,pmr735b-gpio", .data = (void *) 4 },
>> +    { .compatible = "qcom,pmr735d-gpio", .data = (void *) 2 },
>>       /* pms405 has 12 GPIOs with holes on 1, 9, and 10 */
>>       { .compatible = "qcom,pms405-gpio", .data = (void *) 12 },
>>       /* pmx55 has 11 GPIOs with holes on 3, 7, 10, 11 */
>>

