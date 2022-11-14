Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6AF462797D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbiKNJul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236322AbiKNJuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:50:12 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246FB1E3F0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:50:07 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id k19so12431740lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bb1XdXznzYLeTlfpjaMwLLPlS8dogxRK+xeWlIfRthY=;
        b=Bba7Br3qW4MJ9GT+nWtvv1YOAFcLlyAQxGyr6H6Wx8+l9sdgEpkaxc01+cFXdJaeDm
         PVWICyz4l/EeStCaOzCk5/yPKKlljE6QAcki4QjDFy2ht96P/RsteKIO4tPuJV5F7gNM
         pGqGNKBjAK41ZdEP5eFbdN675TTyjImehn7rIwKojvozCVG38aUyVDO0pdPZIEhxz9/g
         LePNCsWAAw4f+iqp6am/ZANGSWCmz3vIQps6LL/1ZMgqHINvZ2l5akmq9p3v2RKOUtAt
         sDJYrKfmv45zuKinQQFHRlXQlehysdH+lH/lhfIGFs3A32ZsOqodDr60tZizxnK/QCa9
         NyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bb1XdXznzYLeTlfpjaMwLLPlS8dogxRK+xeWlIfRthY=;
        b=oO2fE/p8DHKmLb+oMsA8hz4knPbJdCf/gLRgzm0BTl9PAREMEjjnrP6FbUjLDIQ/5n
         aBgH/scdJnqRwUJ4irB/IytOHcAVoqjvn+s8ypUPBu52vJhqYzajw2OQz3+/GYTsMYZ1
         kD20Sm8jP31ouTPkvYgN8eISduiQoco1WyU30Z3FH1Tn6mcdQ1gvvEAUJh5lHYMdmAI4
         uE9f+dpmGaP6LlfKXPWNXI5Y2LOKaPVLvwGaJIlkiJ+ehhSTwsVw8LrR2J8AmeUBt36u
         Sjzts1W8aaj1Wc48ApCdAKpodcp88rFMkgkzVIoUdKOXaCfYnvYAJBKB8FHjBSVV2Xo2
         LlrA==
X-Gm-Message-State: ANoB5plDoZblHuUfgCRoeodyEozLUyrAMOn1q4jT5JICSqUR8JulCENG
        4dWwlTnpzZ33dORn6yY0+G0ggg==
X-Google-Smtp-Source: AA0mqf6s18w6QWcr71EVCTgdz+uIIb4iJNURL08uyDNDCOMA8RbN/aaZ6bd6Wb3S/bg+o99lX+EhKw==
X-Received: by 2002:a2e:711a:0:b0:26e:3292:12ad with SMTP id m26-20020a2e711a000000b0026e329212admr4189418ljc.271.1668419406135;
        Mon, 14 Nov 2022 01:50:06 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id 14-20020ac25f4e000000b004a03eb21c4fsm1747994lfz.288.2022.11.14.01.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 01:50:05 -0800 (PST)
Message-ID: <9a782abf-378d-08ab-aae2-683178622890@linaro.org>
Date:   Mon, 14 Nov 2022 12:50:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 16/22] phy: qcom-qmp-combo: add DP configuration tables
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221111085643.9478-1-johan+linaro@kernel.org>
 <20221111085643.9478-17-johan+linaro@kernel.org>
 <56752623-d865-2848-3132-4df769a31d39@linaro.org>
 <Y3H+gpKZsOH05RET@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Y3H+gpKZsOH05RET@hovoldconsulting.com>
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

On 14/11/2022 11:38, Johan Hovold wrote:
> On Sat, Nov 12, 2022 at 10:39:12AM +0300, Dmitry Baryshkov wrote:
>> On 11/11/2022 11:56, Johan Hovold wrote:
>>> In preparation for merging the USB and DP configurations, add dedicated
>>> pointers for the DP serdes and tx tables to the configurations.
>>>
>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>> ---
>>>    drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 45 ++++++++++++-----------
>>>    1 file changed, 24 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>>> index 499368e19e00..b27d1821116c 100644
>>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>>> @@ -816,6 +816,11 @@ struct qmp_phy_cfg {
>>>    	const struct qmp_phy_init_tbl *pcs_usb_tbl;
>>>    	int pcs_usb_tbl_num;
>>>    
>>> +	const struct qmp_phy_init_tbl *dp_serdes_tbl;
>>> +	int dp_serdes_tbl_num;
>>> +	const struct qmp_phy_init_tbl *dp_tx_tbl;
>>> +	int dp_tx_tbl_num;
>>> +
>>
>> I'd prefer to have DP-specific instance of struct qmp_phy_cfg_tbls here
>> instead of having separate dp-specific fields. WDYT?
> 
> No, I don't see any good reason for doing so currently.
> 
> You may be able to share a few pointers between some of the SoCs but
> only until it turns out they need to override certain sequences anyway
> (e.g. sc8280xp which mixes v4 and v5 tables currently).
> 
> You'd also need dedicated aggregate table structs for USB and DP and it
> seems all of this would just make things more opaque for little gain.

Forgot:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

