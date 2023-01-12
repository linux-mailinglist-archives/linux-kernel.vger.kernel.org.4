Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C931667F76
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbjALToL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjALTnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:43:51 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027696422
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 11:33:54 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id e13so20475813ljn.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 11:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1JIYsMoXBydeWSn636wmG/Lb0+3KtaflCFgpsVqKASE=;
        b=qbrF/2QjIGACx037/GJu0XQQcZ1Y3hPaMwOzChvkOLdToaTqaiN4h2QOJc9QgTq2i/
         WDSgTjY9P/FNpiuJoM5wPVLAz9GT0a945L5MAGu42sDfYya0i7UbcDgXwt4flH7UPLfh
         8xIk7FFcJLUy5HS1asOTzx6v1zrirnNfs8IJAZ9Sk65shK24W+/ucRe0EbRKntUhWULc
         v2P+3CoYAuOVzE+CI+Zks73+sD6up7ltZtXiAM+73xNuLMFlfBSfnNxW3MK2EIQO5vG7
         c71f8rgNmCGMhusBMu6InU+O3AFVX7t+S8NzsIKAlgOBKKf5HDHzainln9Y0vcsEmU1q
         FCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1JIYsMoXBydeWSn636wmG/Lb0+3KtaflCFgpsVqKASE=;
        b=4ZCzibJYb/bU0wcZWUf5GsZi6cY647BjB5r6hDn19IrvomnSF5NHNs/fJK0v0c1KWB
         Tex+Cw/pW0iuzUDVbQqxlLT8RINsEhzpTTI+d7ZXGUJdW+YKyrkNtAWPO++70drK51b2
         ypjYw2HRnTIRDaI05Yd/ErVbUHSjxxsNpp+gMlaXo7ipnhCPboYaZbGo+QeVdTxbg4bC
         4BZahsvXrS3zbak/cCXZxpknSnM+NAn6civZqkkpQCyNTJ1shOzPGBwcXrdO2aiNdN1h
         DR3oJg4gm/akbCyUgrsoz9bNbTxQfe1CY1FVRHnGeQrrIpT6i/KecUqySRRaZs6g+h1p
         W/8A==
X-Gm-Message-State: AFqh2koUueclCc0sHvRHeiintdofN4JblVgAkB79eduPZaSD1cY4uB33
        fvIvT86F0AoPug0Y0Im6WUXm8g==
X-Google-Smtp-Source: AMrXdXv3+ZSf9y1ilQIM6yrNYmOcMkr/mWVjVGi348euRwBv5qEqZ0+ZJ0/epNcIXFHgpqqxpAod+g==
X-Received: by 2002:a2e:80c9:0:b0:287:d8ce:6c9d with SMTP id r9-20020a2e80c9000000b00287d8ce6c9dmr2860076ljg.4.1673552032393;
        Thu, 12 Jan 2023 11:33:52 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id v25-20020a2e87d9000000b00288470f3145sm906564ljj.36.2023.01.12.11.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 11:33:52 -0800 (PST)
Message-ID: <cf968a25-02f7-d402-530b-eb379b707e54@linaro.org>
Date:   Thu, 12 Jan 2023 21:33:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 2/3] phy: qcom-qmp-combo: Add config for SM6350
Content-Language: en-GB
To:     Vinod Koul <vkoul@kernel.org>, Johan Hovold <johan@kernel.org>
Cc:     Luca Weiss <luca.weiss@fairphone.com>,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221130081430.67831-1-luca.weiss@fairphone.com>
 <20221130081430.67831-2-luca.weiss@fairphone.com>
 <Y6xP4YRAp68TfxFi@hovoldconsulting.com> <Y8BIX+js1ircJyb9@matsya>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Y8BIX+js1ircJyb9@matsya>
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

On 12/01/2023 19:50, Vinod Koul wrote:
> On 28-12-22, 15:17, Johan Hovold wrote:
>> Luca, Vinod,
>>
>> On Wed, Nov 30, 2022 at 09:14:28AM +0100, Luca Weiss wrote:
>>> Add the tables and config for the combo phy found on SM6350.
>>>
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>> ---
>>> Changes since v2:
>>> * Drop dp_txa/dp_txb changes, not required
>>> * Fix dp_dp_phy offset
>>>
>>>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 126 ++++++++++++++++++++++
>>>   1 file changed, 126 insertions(+)
>>>
>>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>>> index 77052c66cf70..6ac0c68269dc 100644
>>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>>
>>> @@ -975,6 +1039,19 @@ static const char * const sc7180_usb3phy_reset_l[] = {
>>>   	"phy",
>>>   };
>>>   
>>> +static const struct qmp_combo_offsets qmp_combo_offsets_v3 = {
>>> +	.com		= 0x0000,
>>> +	.txa		= 0x1200,
>>> +	.rxa		= 0x1400,
>>> +	.txb		= 0x1600,
>>> +	.rxb		= 0x1800,
>>> +	.usb3_serdes	= 0x1000,
>>> +	.usb3_pcs_misc	= 0x1a00,
>>> +	.usb3_pcs	= 0x1c00,
>>> +	.dp_serdes	= 0x1000,
>>
>> I would have expected this to be 0x2000 as that's what the older
>> platforms have been using for the dp serdes table so far. Without access
>> to any documentation it's hard to tell whether everyone's just been
>> cargo-culting all along or if there's actually something there at offset
>> 0x2000.

usb3_serdes is 0x1000, so dp_serdes equal to 0x1000 is definitely an typo.

Judging from the downstream dtsi, the DP PHY starts at offset 0x2000. So 
dp_serdes is equal to 0x2000, dp_phy = 0x2a00, ln_tx1 = 0x2200, ln_tx2 = 
0x2600.

>>
>> Vinod, could you shed some light on this as presumably you have access
>> to some documentation?
>>
>>> +	.dp_dp_phy	= 0x2a00,
> 
> No sorry, I dont have access to this version...
> 

-- 
With best wishes
Dmitry

