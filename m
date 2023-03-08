Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E496B05A3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjCHLQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjCHLPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:15:55 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB276A17FC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 03:15:43 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id s20so20835906lfb.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 03:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678274142;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cz0PeM+B0eQ33qul29Nk8o+XDr5rI2u92dlLH1wyCRw=;
        b=u9L/BW52fkJTFMv0G1nHSj0BToTicCSmoGAOHPCnd6BostvT19Pwy/uA5oLeJwlRdk
         4xyL8cU1W3QBgrMLyQBCagcRs4vvBpvq9NsYhpYTgXgENQMTQ3jnE222EP+JT+RW+2mQ
         X5xZFi9U0qExg3OwtiHkaipyb6gareDdrm23NpN4R93ni+Z5dDd+zlcdn10i2qEBbLfd
         siJudg5dLv0h5htnrAZ5Zzuc2iJTAvv34Cokrycbeq498yfjK2XCRymfJM9BpkR8wkXX
         0QFCgDvWq3zVAaPllpqpeahC/0e7LIEbqTuq2q/wHCaQmf0PXrT0xttnsD/K/fK4i9O4
         8n9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678274142;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cz0PeM+B0eQ33qul29Nk8o+XDr5rI2u92dlLH1wyCRw=;
        b=DWNzeXrdYTAdBAdP2xMCW3d/WC+TTvJ2ftOfZbPozv1lsMaZQnDTmkW8tEcFfZAhTC
         RuLkF1HC9EgIq7mwRKsS/nmhlUTLPnoyUGgAjZ7jM4J7S1iK53wcdcflAb3xnD/3GJox
         oyIIIOIMh7iei7IDSIpmULS6UFvwczq5U8+GO04MhWA1g5/QRGzYJ6GUCwGr/TizZc/Z
         0XPgDu6V0s/ifNrAYYDPLOTS/MD25AUoPWcKmDmSoWzSNKTYWf4AzH1DJnrirrB2Nh/Q
         7b01tQEXl4gETEnXZtDlVVEg5EH1zVjf2TQT4TlGDsUY5GUZ3nfoVr2GUC1FdtvYOW+G
         Hy3Q==
X-Gm-Message-State: AO0yUKUw40qpHRgvpAto4OpvAY1pVfzXwN2Pmyw7IG/iI3IPEBSUYYmK
        sMpi3EpeusEHWOhmGX3hfMzH6w==
X-Google-Smtp-Source: AK7set/dgjPcQT+ZnAEcKKpqEFtOfwkM51MutRzzCDQ8hJL5c1DYwiTXltCOcjox7fFpSfEqVYY1CA==
X-Received: by 2002:ac2:4432:0:b0:4cb:41ca:1841 with SMTP id w18-20020ac24432000000b004cb41ca1841mr4599858lfl.48.1678274142049;
        Wed, 08 Mar 2023 03:15:42 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id 9-20020ac25689000000b004dc4d984911sm2298796lfr.271.2023.03.08.03.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 03:15:41 -0800 (PST)
Message-ID: <64ab4061-6a8b-662e-1c7a-99b0da26751c@linaro.org>
Date:   Wed, 8 Mar 2023 12:15:39 +0100
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
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZAhrT1ICTQjfdeGq@hovoldconsulting.com>
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



On 8.03.2023 12:02, Johan Hovold wrote:
> On Wed, Mar 08, 2023 at 11:09:48AM +0100, Konrad Dybcio wrote:
>>
>>
>> On 6.03.2023 18:08, Lux Aliaga wrote:
>>> The SM6125 UFS PHY is compatible with the one from SM6115. Add a
>>> compatible for it and modify the config from SM6115 to make them
>>> compatible with the SC8280XP binding
>>>
>>> Signed-off-by: Lux Aliaga <they@mint.lgbt>
>>> Reviewed-by: Martin Botka <martin.botka@somainline.org>
>>> ---
>>>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>>> index 318eea35b972..44c29fdfc551 100644
>>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>>> @@ -620,6 +620,13 @@ static const char * const qmp_phy_vreg_l[] = {
>>>  	"vdda-phy", "vdda-pll",
>>>  };
>>>  
>>> +static const struct qmp_ufs_offsets qmp_ufs_offsets_v3_660 = {
>>> +	.serdes		= 0,
>>> +	.pcs		= 0xc00,
>>> +	.tx		= 0x400,
>>> +	.rx		= 0x600,
>>> +};
>>> +
>>>  static const struct qmp_ufs_offsets qmp_ufs_offsets_v5 = {
>>>  	.serdes		= 0,
>>>  	.pcs		= 0xc00,
>>> @@ -693,6 +700,8 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
>>>  static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
>>>  	.lanes			= 1,
>>>  
>>> +	.offsets		= &qmp_ufs_offsets_v3_660,
>> Will this not trigger OOB r/w for the users of qcom,sm6115-smp-ufs-phy
>> which specify the regions separately (old binding style)?
> 
> No, that should work fine.
So do you think the SM6115 binding could be updated too? Or should
we keep it as-is for ABI purposes?..

> 
> But looks like this series needs to be rebased on 6.3-rc1 as these
> offsets are now already set in mainline.
..Or did you do that already and I can't find it?

Konrad
> 
> Johan
