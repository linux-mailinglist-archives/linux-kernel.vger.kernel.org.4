Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D136FADA4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbjEHLgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbjEHLgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:36:09 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBA52D71
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 04:35:54 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f122ff663eso4929516e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 04:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683545710; x=1686137710;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mfR4LStcd/qNMQinT2M55AhtQze+Ml04+yfWl4Tpc/I=;
        b=BplfKDUCxsZYYk5Ccdyl9eWUyt5lsK7kLwLm4JsehFWGl08LViELoNrCXglZgesmqT
         tn1dvXqxbRRwPWezQKHNRKnRchGSIvW/rlEFeHK3FSK2pVks4hJuRm0XAGohMxtbeRNf
         o98knayb87A7HGboW9ygqrsi07Q9U4M2llvy8xtTi+kzJEv57nBKCkAZdxcubeugGL2c
         S5DuzurFSeJBZar9yH82Z7XVrc8n+S2WSw3E7RCnlwh7zPyL7EXkpxErt3JLW4B1UsdK
         7ddO+HPqeJvX+MxkhiHCYmU8pDhSukiYw3tFz/dyDiqLYUl6SQqRrnDSO1J16QRKMYBj
         rS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683545710; x=1686137710;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mfR4LStcd/qNMQinT2M55AhtQze+Ml04+yfWl4Tpc/I=;
        b=dYj+peh3PiYIA+YIgZygBJmBDlNhw6xPndvqBXBed2Y6WmtA9R2NeqSmOfQoOvrmet
         2dqifVm9kuRPEfJ3aECmZb+ljFggO+BaxmI0jmfHAY76Ka2M6WRlVLLjjbLEpRN/bzPw
         N2LqZ7QfB4qJqyPkUKLI21jDOqSTC2wYEqxDvHu3hrvMsfiY6gsx/5B4k8LSIK7Gj2dy
         te2lihp3DWYsToKiSMuahHNQdR0iy3IvXWFFwWoS+3TfrGaXtUciY74GTxW+HzVuPxzX
         0W/iYH7nLmXMpAJmwOPiAr/OkbVRFMsTwaxo8b3R/QwA4NYL0aJ96bny2bJ0HXwCXl5N
         Gb9Q==
X-Gm-Message-State: AC+VfDyjCx50BL09c3bGn+zlVNsOnHFnWza7SV3rIUiJkx6UlwAhI0Uy
        OLLKGXqrgxm4UuCRrFVIDzL2sQ==
X-Google-Smtp-Source: ACHHUZ5vmwVI/M7Q0gP0oJoyn4KhbcwC+F4+NHKdx1dsAki5ekWv+nOjJPTeXpI1glWaqzahYBAIFg==
X-Received: by 2002:ac2:59ce:0:b0:4e8:4489:6f06 with SMTP id x14-20020ac259ce000000b004e844896f06mr2534062lfn.58.1683545709991;
        Mon, 08 May 2023 04:35:09 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id 2-20020ac24822000000b004f134f7cff3sm1266261lft.167.2023.05.08.04.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 04:35:09 -0700 (PDT)
Message-ID: <69ec1926-760e-c957-82b5-0c3f48f65dcf@linaro.org>
Date:   Mon, 8 May 2023 13:35:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] clk: qcom: mmcc-msm8974: Add OXILICX_GDSC for msm8226
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bartosz Dudziak <bartosz.dudziak@snejp.pl>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230506-msm8226-oxilicx-v1-1-52e34b94ff22@z3ntu.xyz>
 <cef7b823-451f-e98a-65d3-3e396124071a@linaro.org>
 <fdb76743-de20-91c5-2edc-19dd5ead33e3@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <fdb76743-de20-91c5-2edc-19dd5ead33e3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8.05.2023 13:32, Dmitry Baryshkov wrote:
> On 08/05/2023 10:23, Konrad Dybcio wrote:
>>
>>
>> On 6.05.2023 23:20, Luca Weiss wrote:
>>> On msm8226 we also have OXILICX_GDSC but we need a slighly different
>>> config, with a .cxcs defined for clock but with no parent.
>> Hm, on newer (a5xx+) GPUs, CX needs to be turned on first and
>> to achieve that, we sometimes define it to be the GX's (also
>> implicitly known as "oxili-non-CX" in before-a6xx-times) parent..
>>
>> Roughly speaking CX powers the "GPU hardware owned by the broader
>> SoC that may not need the GPU core clock to be up" and GX powers
>> the "GPU hardware owned strictly by the GPU that needs at least some
>> GPU clocks to be enabled"
>>
>> Maybe 8974 simply has a bug in the driver that would do the reverse?
>> Could you (and perhaps Dmitry on his shiny new 13yo board) test that
>> theory, preferably on both SoCs?
>>
>> --- a/drivers/clk/qcom/mmcc-msm8974.c
>> +++ b/drivers/clk/qcom/mmcc-msm8974.c
>> @@ -2431,6 +2431,7 @@ static struct gdsc oxili_gdsc = {
>>          .pd = {
>>                  .name = "oxili",
>>          },
>> +       .parent = &oxili_gdsc.pd,
>>          .pwrsts = PWRSTS_OFF_ON,
>>   };
> 
> Are you declaring oxili_gdsc to be a parent of itself?
lol.. nice catch of course this line should have been 

+       .parent = &oxilicx_gdsc.pd,

and the definitions would need to be swapped

Konrad
> 
>>   @@ -2439,7 +2440,6 @@ static struct gdsc oxilicx_gdsc = {
>>          .pd = {
>>                  .name = "oxilicx",
>>          },
>> -       .parent = &oxili_gdsc.pd,
>>          .pwrsts = PWRSTS_OFF_ON,
>>   };
>>
>> Konrad
>>>
>>> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
>>> ---
>>>   drivers/clk/qcom/mmcc-msm8974.c | 11 +++++++++++
>>>   1 file changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/clk/qcom/mmcc-msm8974.c b/drivers/clk/qcom/mmcc-msm8974.c
>>> index 4273fce9a4a4..39ee3953567c 100644
>>> --- a/drivers/clk/qcom/mmcc-msm8974.c
>>> +++ b/drivers/clk/qcom/mmcc-msm8974.c
>>> @@ -2443,6 +2443,16 @@ static struct gdsc oxilicx_gdsc = {
>>>       .pwrsts = PWRSTS_OFF_ON,
>>>   };
>>>   +static struct gdsc oxilicx_gdsc_msm8226 = {
>>> +    .gdscr = 0x4034,
>>> +    .cxcs = (unsigned int []){ 0x4028 },
>>> +    .cxc_count = 1,
>>> +    .pd = {
>>> +        .name = "oxilicx",
>>> +    },
>>> +    .pwrsts = PWRSTS_OFF_ON,
>>> +};
>>> +
>>>   static struct clk_regmap *mmcc_msm8226_clocks[] = {
>>>       [MMSS_AHB_CLK_SRC] = &mmss_ahb_clk_src.clkr,
>>>       [MMSS_AXI_CLK_SRC] = &mmss_axi_clk_src.clkr,
>>> @@ -2533,6 +2543,7 @@ static struct gdsc *mmcc_msm8226_gdscs[] = {
>>>       [MDSS_GDSC] = &mdss_gdsc,
>>>       [CAMSS_JPEG_GDSC] = &camss_jpeg_gdsc,
>>>       [CAMSS_VFE_GDSC] = &camss_vfe_gdsc,
>>> +    [OXILICX_GDSC] = &oxilicx_gdsc_msm8226,
>>>   };
>>>     static const struct regmap_config mmcc_msm8226_regmap_config = {
>>>
>>> ---
>>> base-commit: dd9e11d6477a52ede9ebe575c83285e79e823889
>>> change-id: 20230506-msm8226-oxilicx-7f3f0f8e491d
>>>
>>> Best regards,
> 
