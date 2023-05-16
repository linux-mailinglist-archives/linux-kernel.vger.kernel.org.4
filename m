Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA9F704227
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 02:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245314AbjEPAPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 20:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244409AbjEPAPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 20:15:13 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D366A59
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 17:15:10 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f2510b2b98so11394226e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 17:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684196109; x=1686788109;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dNuW8WbbkbN1EuTD/B8YFcxXcOfRKZw0Lk+3iDbVrZI=;
        b=L03suy7XmWzBF3s6J/OR6Oktx2OLrjD4IXvKJIu2AOnC2iAYF6hhCBwOXorYM4foaM
         y3VntA+TeXj4q2jrbJm4SqZ3U33y8c3qmYHlcZ6SPa2RyTR0xn19XjBzVJMkW5UyolzB
         k2ZWCuUP256WbXo/JyT/j41ZcWxQ20bl9L0VqBf3p4AOLeMW1VtSq0BbGf4padcdkwms
         BJ35+Yy6A5O9uUka7TpWaLsW2mi84l4uN01chVAauMATqeTPd/NiriJgqvr1ZYYL8mNJ
         BSUZTxkdlemnSLHgfBRP5drlMEhx+bvCyGeBKF/BbvzA3Imr8racnT4K2i49OrUzAgTj
         nmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684196109; x=1686788109;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dNuW8WbbkbN1EuTD/B8YFcxXcOfRKZw0Lk+3iDbVrZI=;
        b=GONTlYobR391w0Pzd6YiGoIsocz4E5pAzykS+e/zmLdD6H9tepvtdPHcp6zQQPzOlO
         BPzt1SkA5X536iuSaU+19Z2yc/icXPKm9rSoWBdkiEvy+fUhj9eZtYmqEXxaFzjzbJs+
         FKUOk37TGn6g5GjJVqJ37GZxjhdJvgNCn5+9YlI3p8PQyr7by4Sa0fx1GUxM+TaODxNM
         bsNFzhUhLEXc7jejCRxzRPRKHKdAAiaeNsJ3u0KvMXGp5igWELSAwb19XTIfF2WZQBBG
         5acnRlXfW5Ef5YSz3NqJfre10bLPo/cjCnSNGYrHOxOl1Co1+WZ0fZN4VbM6+UUPgCuM
         vxpA==
X-Gm-Message-State: AC+VfDyiHqIZmpUjic/g0iaPT8MkX+TcygZGHqsPcdbA21Qb6wrgWDzb
        W3NlZsn13l3K6MiBt2Rt0cfw+Q==
X-Google-Smtp-Source: ACHHUZ7FXPxFHEWbCvpBR3Li5SzobFga6iS/1Ud+rF+AJwu26ihzFXIAuXbvfKglcvGnMqBRU+MfpA==
X-Received: by 2002:ac2:44b8:0:b0:4dd:9fd8:3a36 with SMTP id c24-20020ac244b8000000b004dd9fd83a36mr6090397lfm.1.1684196108710;
        Mon, 15 May 2023 17:15:08 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id g24-20020ac25398000000b004efee46249fsm2760538lfh.243.2023.05.15.17.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 17:15:08 -0700 (PDT)
Message-ID: <275c997a-a09d-113f-631d-bb677a05ac5f@linaro.org>
Date:   Tue, 16 May 2023 02:15:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] clk: qcom: mmcc-msm8974: Add OXILICX_GDSC for msm8226
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bartosz Dudziak <bartosz.dudziak@snejp.pl>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230506-msm8226-oxilicx-v1-1-52e34b94ff22@z3ntu.xyz>
 <fdb76743-de20-91c5-2edc-19dd5ead33e3@linaro.org>
 <69ec1926-760e-c957-82b5-0c3f48f65dcf@linaro.org>
 <2528191.PYKUYFuaPT@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <2528191.PYKUYFuaPT@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9.05.2023 18:57, Luca Weiss wrote:
> On Montag, 8. Mai 2023 13:35:07 CEST Konrad Dybcio wrote:
>> On 8.05.2023 13:32, Dmitry Baryshkov wrote:
>>> On 08/05/2023 10:23, Konrad Dybcio wrote:
>>>> On 6.05.2023 23:20, Luca Weiss wrote:
>>>>> On msm8226 we also have OXILICX_GDSC but we need a slighly different
>>>>> config, with a .cxcs defined for clock but with no parent.
>>>>
>>>> Hm, on newer (a5xx+) GPUs, CX needs to be turned on first and
>>>> to achieve that, we sometimes define it to be the GX's (also
>>>> implicitly known as "oxili-non-CX" in before-a6xx-times) parent..
>>>>
>>>> Roughly speaking CX powers the "GPU hardware owned by the broader
>>>> SoC that may not need the GPU core clock to be up" and GX powers
>>>> the "GPU hardware owned strictly by the GPU that needs at least some
>>>> GPU clocks to be enabled"
>>>>
>>>> Maybe 8974 simply has a bug in the driver that would do the reverse?
>>>> Could you (and perhaps Dmitry on his shiny new 13yo board) test that
>>>> theory, preferably on both SoCs?
>>>>
>>>> --- a/drivers/clk/qcom/mmcc-msm8974.c
>>>> +++ b/drivers/clk/qcom/mmcc-msm8974.c
>>>> @@ -2431,6 +2431,7 @@ static struct gdsc oxili_gdsc = {
>>>>          .pd = {
>>>>                  .name = "oxili",
>>>>          },
>>>> +       .parent = &oxili_gdsc.pd,
>>>>          .pwrsts = PWRSTS_OFF_ON,
>>>>   };
>>>
>>> Are you declaring oxili_gdsc to be a parent of itself?
>>
>> lol.. nice catch of course this line should have been
>>
>> +       .parent = &oxilicx_gdsc.pd,
>>
>> and the definitions would need to be swapped
> 
> The 0x4024 oxili_gdsc (downstream name gdsc_oxili_gx) is disabled in 8226 dts.
> 
> Only in downstream msm8974.dtsi this gdsc gets "parent-supply = 
> <&pm8841_s4_corner>;", on 8226 there's no parent-supply. And the gdsc parent 
> doesn't even seem to be described there.
> 
> Should I still try?
No, nevermind, this SoC is cut down more than I had initially thought.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

with a minor nit: oxilicx -> oxili_cx

Konrad
> 
>>
>> Konrad
>>
>>>>   @@ -2439,7 +2440,6 @@ static struct gdsc oxilicx_gdsc = {
>>>>          .pd = {
>>>>                  .name = "oxilicx",
>>>>          },
>>>> -       .parent = &oxili_gdsc.pd,
>>>>          .pwrsts = PWRSTS_OFF_ON,
>>>>   };
>>>>
>>>> Konrad
>>>>
>>>>> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
>>>>> ---
>>>>>   drivers/clk/qcom/mmcc-msm8974.c | 11 +++++++++++
>>>>>   1 file changed, 11 insertions(+)
>>>>>
>>>>> diff --git a/drivers/clk/qcom/mmcc-msm8974.c
>>>>> b/drivers/clk/qcom/mmcc-msm8974.c index 4273fce9a4a4..39ee3953567c
>>>>> 100644
>>>>> --- a/drivers/clk/qcom/mmcc-msm8974.c
>>>>> +++ b/drivers/clk/qcom/mmcc-msm8974.c
>>>>> @@ -2443,6 +2443,16 @@ static struct gdsc oxilicx_gdsc = {
>>>>>       .pwrsts = PWRSTS_OFF_ON,
>>>>>   };
>>>>>   +static struct gdsc oxilicx_gdsc_msm8226 = {
>>>>> +    .gdscr = 0x4034,
>>>>> +    .cxcs = (unsigned int []){ 0x4028 },
>>>>> +    .cxc_count = 1,
>>>>> +    .pd = {
>>>>> +        .name = "oxilicx",
>>>>> +    },
>>>>> +    .pwrsts = PWRSTS_OFF_ON,
>>>>> +};
>>>>> +
>>>>>   static struct clk_regmap *mmcc_msm8226_clocks[] = {
>>>>>       [MMSS_AHB_CLK_SRC] = &mmss_ahb_clk_src.clkr,
>>>>>       [MMSS_AXI_CLK_SRC] = &mmss_axi_clk_src.clkr,
>>>>> @@ -2533,6 +2543,7 @@ static struct gdsc *mmcc_msm8226_gdscs[] = {
>>>>>       [MDSS_GDSC] = &mdss_gdsc,
>>>>>       [CAMSS_JPEG_GDSC] = &camss_jpeg_gdsc,
>>>>>       [CAMSS_VFE_GDSC] = &camss_vfe_gdsc,
>>>>> +    [OXILICX_GDSC] = &oxilicx_gdsc_msm8226,
>>>>>   };
>>>>>     static const struct regmap_config mmcc_msm8226_regmap_config = {
>>>>>
>>>>> ---
>>>>> base-commit: dd9e11d6477a52ede9ebe575c83285e79e823889
>>>>> change-id: 20230506-msm8226-oxilicx-7f3f0f8e491d
>>>>>
>>>>> Best regards,
> 
> 
> 
> 
