Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAE76B5625
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjCKAFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjCKAFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:05:46 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFDB12FD2E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:05:42 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id g17so8802224lfv.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678493141;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T17C6AbEDanaE3OC9jdvhLuitHG1FgTsryu1IqeVsX0=;
        b=xRzDE0GHqxVuGmVNO9r5OlwPRKhvm7KRve8tWzEXn7DSUgBQfqVs6PjrYcEbGgn+eP
         lxY/rHmUbVbp2bE0/rPwQhbYviEo9qcwK0F6NRdudSe+XvRDNTH2lNou9bakygUd9xXY
         +i7jaf97J7VKCv8aofkpNphOeKWUyZ9MHW7942WbVgD+3RZB6pmE19hu05IIF/LCf8kI
         aOBY49mbv5C7b38GhxxwxvOmvJAZOhgnz8JhtSthzT5kfJYNNdIqtidsxjSMu7Qb/EjT
         uwSuQABVWfQjzzi1spc0APb5KDVvJNyJq9cTPOVsamyaJG/ZdujWML/s7lLUqo1m1OWG
         0JDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678493141;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T17C6AbEDanaE3OC9jdvhLuitHG1FgTsryu1IqeVsX0=;
        b=DuhpBxPug3DmTL8QwrlUzZVaaplIY+R8YuPq3J9APunEwWI5JQjeLbfiwSaMjmxhkP
         XQFvapOgMqqU63byCijIht1CWtR2xMWByE7WOHlOTH6q9MSNMZwNYTlj5c/85loPwMOy
         1/+wiOBleBObCrG0UgPIcuJBMN6mR8g4qCP1JR5D00h7vc4JiInw3CGU2JLC9WvCIVyU
         G+ZGqMkfxJM4OVdT3ohMw6kcUmdqZW1zTwX5kkS/eaWocG1N5c6otoZypxPEJCoQPZvC
         DQ4dEefna5y2ICBAjbPwGqv4eenT1tQoLxVD+4FDzs0F9j2bAlNDoSnGWpd2qwBIXhxX
         ONgw==
X-Gm-Message-State: AO0yUKX7CBTsE/TapgPzM2AspvTY/J91yLfTcoZhqE9K0adl+o3wUzmv
        h0rPCgnePZawNsv7ejkMeVM9HXNIS5AonMKJvZY=
X-Google-Smtp-Source: AK7set8tg0bj5lBzuTDSjBLrOIrpFkJZZ8PzZptoC7RHpuh5Ow8EmZMntmqHajGCODMyuB4GKuQB3A==
X-Received: by 2002:ac2:51b3:0:b0:4dd:a445:e69d with SMTP id f19-20020ac251b3000000b004dda445e69dmr7605410lfk.26.1678493141329;
        Fri, 10 Mar 2023 16:05:41 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id w25-20020ac25999000000b004e811e3554dsm128199lfn.185.2023.03.10.16.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 16:05:40 -0800 (PST)
Message-ID: <3ea91330-d49a-6b6a-f213-6f49a69b9d9b@linaro.org>
Date:   Sat, 11 Mar 2023 01:05:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] soc: qcom: gsbi: mark OF related data as maybe unused
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230310214413.275054-1-krzysztof.kozlowski@linaro.org>
 <a5f943d0-1653-3269-32c1-d879bc333ded@linaro.org>
In-Reply-To: <a5f943d0-1653-3269-32c1-d879bc333ded@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.03.2023 01:04, Konrad Dybcio wrote:
> 
> 
> On 10.03.2023 22:44, Krzysztof Kozlowski wrote:
>> The driver can be compile tested with !CONFIG_OF making certain data
>> unused:
>>
>>   drivers/soc/qcom/qcom_gsbi.c:117:34: error: ‘tcsr_dt_match’ defined but not used [-Werror=unused-const-variable=]
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
> Shouldn't this driver depend on OF?
> 
Nevermind, can't read.

Konrad
> Konrad
>>  drivers/soc/qcom/qcom_gsbi.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/qcom/qcom_gsbi.c b/drivers/soc/qcom/qcom_gsbi.c
>> index 290bdefbf28a..f1742e5bddb9 100644
>> --- a/drivers/soc/qcom/qcom_gsbi.c
>> +++ b/drivers/soc/qcom/qcom_gsbi.c
>> @@ -114,7 +114,7 @@ struct gsbi_info {
>>  	struct regmap *tcsr;
>>  };
>>  
>> -static const struct of_device_id tcsr_dt_match[] = {
>> +static const struct of_device_id tcsr_dt_match[] __maybe_unused = {
>>  	{ .compatible = "qcom,tcsr-ipq8064", .data = &config_ipq8064},
>>  	{ .compatible = "qcom,tcsr-apq8064", .data = &config_apq8064},
>>  	{ .compatible = "qcom,tcsr-msm8960", .data = &config_msm8960},
