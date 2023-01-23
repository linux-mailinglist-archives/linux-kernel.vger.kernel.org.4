Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DF06785DB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjAWTL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjAWTL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:11:26 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79F64201
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 11:11:24 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id rl14so29864862ejb.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 11:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VTgfQuOsmh7vjgkxhuSVXobpiXcrEh67Jxe/HpZBj34=;
        b=zE7VPg2fziZ5ITyaLO0x9pxpTopn0zh6qZM9xHxie0hpl60u8R7DXHx7j4TilLjGX7
         BvKFaeZCIRORQGBaDE6kgXKPo74RYpvrXYKMF0K36WcR2Rexu+xOu8AzAPPlBFY00Sn7
         tSj5BLPHdjEPtejXaUZNqNHkjk/j1yHUo2JHQGoCeDnEVEaUHlKbBmUcYWOqjWWqLFaC
         e10RXE8FzfudGuq+PotI/bFnSeeGHwDDuoVoKdhLNvsbW7/ZfzFlbelBAju+vBfMfHAQ
         RD8NCzYg2c63MfpscVi9wu3CIAAPrSN4+QRenjeAvM/ncbrW4JCzepF3C4+CSySVsVYD
         wMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VTgfQuOsmh7vjgkxhuSVXobpiXcrEh67Jxe/HpZBj34=;
        b=C+SxuhHz9oHNHDncM4y9yuyLfBXpfLwty7I5O0Qqf8CyNtD3cTIk9K9+wXTx7AUG7K
         WUhAhB1gWKXss8OhsZTZxUQCTFVpvTtwka+8O/ATk1RCNGBBPMJ5cUer/q9arWutrJMs
         77Pn8l3Bk146fm419GkrjsdPG2X5h6nmOEW8+3pzR+/UhGVVuPXnaVhL9a4rqosplokZ
         qDPXzTR1eoMqm1vk3VRKBylF/d5z3ht8m735T/6BneX0NR3P1j0dG0gdtIC2D4a6+CZh
         1xfRXgDqGh6nXFy5GjKWYaxRSBzaTxdWvovhCLXtv5ubaTyLWbm84nKvijxyJyJo0hzf
         SdTg==
X-Gm-Message-State: AFqh2krzof5tWVOcctkmYTgc1SGmdlyCO+Np6eD15tWBceiDpnk58pvK
        2hahyHlKOTQGR1xloDeRhlfUUw==
X-Google-Smtp-Source: AMrXdXsb/vuiOrI+Q50hcrg4EbClN2vPr3UA9jJ6Rxnvdr9HixhD8Y5DGs4AWYEwJrUVoTXxOq1Nzg==
X-Received: by 2002:a17:906:6d7:b0:7c1:22a9:ba8b with SMTP id v23-20020a17090606d700b007c122a9ba8bmr38898359ejb.50.1674501083426;
        Mon, 23 Jan 2023 11:11:23 -0800 (PST)
Received: from [192.168.1.101] (abxi24.neoplus.adsl.tpnet.pl. [83.9.2.24])
        by smtp.gmail.com with ESMTPSA id s17-20020a1709060c1100b0084d21db0691sm22656785ejf.179.2023.01.23.11.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 11:11:23 -0800 (PST)
Message-ID: <179bf38e-2b4b-3c8d-6dd3-33cd33883118@linaro.org>
Date:   Mon, 23 Jan 2023 20:11:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v3 9/9] interconnect: qcom: rpm: Don't use
 clk_get_optional for bus clocks anymore
Content-Language: en-US
To:     Arnaud Vrac <rawoul@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        marijn.suijten@somainline.org, bryan.odonoghue@linaro.org,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230116132152.405535-1-konrad.dybcio@linaro.org>
 <20230116132152.405535-10-konrad.dybcio@linaro.org>
 <CAN5H-g54j7kA0+7fmoyj+gOKENycOxJjpHiqbgfM_bYZXj2ofA@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAN5H-g54j7kA0+7fmoyj+gOKENycOxJjpHiqbgfM_bYZXj2ofA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.01.2023 19:41, Arnaud Vrac wrote:
> Hi Konrad,
> 
> With this series on a db820c, I get an error on boot when probing
> a0noc because no "bus" clock is defined. If I revert this patch it
> works again.
> 
> -Arnaud
Ouch! Thanks for testing and catching this, definitely an edge
case, as we usually expect there's an interconnect bus and bus_a
clock.. but that can be worked around!

Konrad
> 
> Le lun. 16 janv. 2023 à 14:31, Konrad Dybcio
> <konrad.dybcio@linaro.org> a écrit :
>>
>> Commit dd42ec8ea5b9 ("interconnect: qcom: rpm: Use _optional func for provider clocks")
>> relaxed the requirements around probing bus clocks. This was a decent
>> solution for making sure MSM8996 would still boot with old DTs, but
>> now that there's a proper fix in place that both old and new DTs
>> will be happy about, revert back to the safer variant of the
>> function.
>>
>> Fixes: dd42ec8ea5b9 ("interconnect: qcom: rpm: Use _optional func for provider clocks")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/interconnect/qcom/icc-rpm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
>> index 343e6021a93a..8cff724661f2 100644
>> --- a/drivers/interconnect/qcom/icc-rpm.c
>> +++ b/drivers/interconnect/qcom/icc-rpm.c
>> @@ -522,7 +522,7 @@ int qnoc_probe(struct platform_device *pdev)
>>         }
>>
>>  regmap_done:
>> -       ret = devm_clk_bulk_get_optional(dev, qp->num_bus_clks, qp->bus_clks);
>> +       ret = devm_clk_bulk_get(dev, qp->num_bus_clks, qp->bus_clks);
>>         if (ret)
>>                 return ret;
>>
>> --
>> 2.39.0
>>
