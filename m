Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2296B0608
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjCHLe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCHLeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:34:23 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59ACD9887B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 03:34:20 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id i9so20918728lfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 03:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678275258;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qEIlAOLqJOUEga8jWhhCTfIkDeYpmS53nHyd5ftpdw4=;
        b=gzNuAFeHu67qA3jHUwFjwfCv3mmKuwAbDAkUqtUl4onK2bQyZOy0/x0IMyaY3yYxnF
         EvYOnuWXh7TSXJeIYsvxPHwIbgOCKNZQm/v5FCu5L+lRo3kAav4sZAPMSfgxF4uId3KD
         XhA1D4oE4okvpInh6KtwraZSdPynW5O898MwOuVmhGItAbwarj1ql4Xkp/GTklxP4SsN
         VsrST1Stm2lNllEIxgdXq2S9RVSyT0Gyyk/fv5fhX3OwFRTDdPXibLSLzeHgP1xEBtG0
         NQAEZCz3bTULePFpQLly8Nu3tbjFRsIgfX0l6TE82wMIQc0V8+KnfnrpArVoY4S0c5BT
         SrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678275258;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qEIlAOLqJOUEga8jWhhCTfIkDeYpmS53nHyd5ftpdw4=;
        b=m/PcXuK58Vsxi+0YFceZD6w2VtmiR6dDMERgTaOdxdy6YWxyssc733UWt62bg6ALwo
         2x1KAEjlnFndkp3qFI3crSE1Ig4gmynVfyu1tkFru/Ch/2wZCDnpZwGSmvBwqGAF2COy
         nibUk2VaBRgWtYn43RtZes2qloL7hD3gW6cLBlZ5xm5fqPG0mq/zb090xecBnqPeHX15
         5RBgkOA2+09CzH5t1yKaeshSk4A5SMsu5ee6w1IHJWFX8+xUza8BSr/3iE41Y5uZl7MZ
         CisX7H9gc79a5Cjxinb7LKBVyGYR4LMw2vTxa1VAuIYTumHfpPwOC5A3CuuoMVue/6Tc
         1g2w==
X-Gm-Message-State: AO0yUKWz25n72kvbFFkcGpNEDssrkkuHkB4YJ9PjEkHxzr09X1zqHogF
        4vkC+7jLLx20lLaEKvmzrH6oRg==
X-Google-Smtp-Source: AK7set+jHlT9ogIKu5mT4G8gT8OABan5198fY6k3RPqdGCoJd95XO36AFMf8+59KJJKUt4o8QUirvw==
X-Received: by 2002:a19:f508:0:b0:4dc:4bda:c26f with SMTP id j8-20020a19f508000000b004dc4bdac26fmr4630854lfb.23.1678275258643;
        Wed, 08 Mar 2023 03:34:18 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id t15-20020ac24c0f000000b004cb35b31b96sm2311175lfq.257.2023.03.08.03.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 03:34:18 -0800 (PST)
Message-ID: <cf6af928-78a9-7990-71d4-9f17daf718d8@linaro.org>
Date:   Wed, 8 Mar 2023 12:34:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 3/6] phy: qcom-qmp: Add SM6125 UFS PHY support
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Lux Aliaga <they@mint.lgbt>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, martin.botka@somainline.org,
        marijn.suijten@somainline.org
References: <20230306170817.3806-1-they@mint.lgbt>
 <20230306170817.3806-4-they@mint.lgbt>
 <25c17af5-8f6b-a2c3-dab3-f9bc69711db7@linaro.org>
 <ZAhrT1ICTQjfdeGq@hovoldconsulting.com>
 <64ab4061-6a8b-662e-1c7a-99b0da26751c@linaro.org>
 <ZAhwTcMZoCQVULQe@hovoldconsulting.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZAhwTcMZoCQVULQe@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8.03.2023 12:23, Johan Hovold wrote:
> On Wed, Mar 08, 2023 at 12:15:39PM +0100, Konrad Dybcio wrote:
>>
>>
>> On 8.03.2023 12:02, Johan Hovold wrote:
>>> On Wed, Mar 08, 2023 at 11:09:48AM +0100, Konrad Dybcio wrote:
>>>>
>>>>
>>>> On 6.03.2023 18:08, Lux Aliaga wrote:
>>>>> The SM6125 UFS PHY is compatible with the one from SM6115. Add a
>>>>> compatible for it and modify the config from SM6115 to make them
>>>>> compatible with the SC8280XP binding
>>>>>
>>>>> Signed-off-by: Lux Aliaga <they@mint.lgbt>
>>>>> Reviewed-by: Martin Botka <martin.botka@somainline.org>
>>>>> ---
>>>>>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 12 ++++++++++++
>>>>>  1 file changed, 12 insertions(+)
>>>>>
>>>>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>>>>> index 318eea35b972..44c29fdfc551 100644
>>>>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>>>>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>>>>> @@ -620,6 +620,13 @@ static const char * const qmp_phy_vreg_l[] = {
>>>>>  	"vdda-phy", "vdda-pll",
>>>>>  };
>>>>>  
>>>>> +static const struct qmp_ufs_offsets qmp_ufs_offsets_v3_660 = {
>>>>> +	.serdes		= 0,
>>>>> +	.pcs		= 0xc00,
>>>>> +	.tx		= 0x400,
>>>>> +	.rx		= 0x600,
>>>>> +};
>>>>> +
>>>>>  static const struct qmp_ufs_offsets qmp_ufs_offsets_v5 = {
>>>>>  	.serdes		= 0,
>>>>>  	.pcs		= 0xc00,
>>>>> @@ -693,6 +700,8 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
>>>>>  static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
>>>>>  	.lanes			= 1,
>>>>>  
>>>>> +	.offsets		= &qmp_ufs_offsets_v3_660,
>>>> Will this not trigger OOB r/w for the users of qcom,sm6115-smp-ufs-phy
>>>> which specify the regions separately (old binding style)?
>>>
>>> No, that should work fine.
>> So do you think the SM6115 binding could be updated too? Or should
>> we keep it as-is for ABI purposes?..
> 
> They could be and the possibility has been raised. I think it may be
> more important to convert the old combo-phy binding (it's on my list,
> but I keep getting preempted), but at some point we can get rid of the
> legacy UFS binding as well.
Okay sounds good!

> 
>>> But looks like this series needs to be rebased on 6.3-rc1 as these
>>> offsets are now already set in mainline.
>> ..Or did you do that already and I can't find it?
> 
> It seems a previous version of this patch was merged almost two months
> ago.
> 
> 	9b9e29af984c ("phy: qcom-qmp: Add SM6125 UFS PHY support")
> 
> Not sure what failed here.
My eyes :)

Konrad
> 
> Johan
