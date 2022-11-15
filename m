Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5BB629CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiKOO5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiKOO5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:57:09 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F222CC81
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:57:02 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id p8so24797414lfu.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DJek8SvY1lKznzyHiHHaCNeGOuDew0+hc/954ZKQZoo=;
        b=XCKQP2v4t1zCGERxBtVGE0MF/1x+qOv4zbnMsLNEb845mJn4wjXgRsw0fV3M+zoFwB
         KHNsVWKGUEkftwb1b5xobkusAs80O6C6jBpsPsR+mdPhxJ8MAzBpYfJUVeHjwJFOSODz
         Yawq7iwkvB+xzXfQvtw9g0w0zMk8IoMLpJ2u3yhBV6T4TfkAcneJ8rto60pT/xPhDr4u
         KrsM0Wi+04es9OgwTr4mAZMbOtrk1q1gqsH95Iiw4bKzQ2im3o/a04kITaySfItQSgES
         vrZA4ktt2Cm9bI2CyZ50mSYB/sMpgK9dAO6GqvNllOtYdXpBNQyqgX7hBv58avv1I7B5
         zoJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJek8SvY1lKznzyHiHHaCNeGOuDew0+hc/954ZKQZoo=;
        b=TZVKpPOcLRjAc7ruJqkjGAd7zWXWgumoaYrXmBhRWb0jPq0R2PJn3xEfv8tR2EKZTH
         Eq4ODEor1F12k7wNIj6SQ513JctXy3XXoE5PDZ8Svn5PeGJQSehHQFZcgXlgOp6tsUNs
         rmhuA/B3JgkabgECYRf26Ig5oqSsKsCgoJWIzRxd7y26wGKA+rG/p1PCcDQVWLNxm4Gp
         IruUyItoDUfSuJaZSf6IqfMs9KSO4TTen1pPYqkHbPVk6HnpQmxxuxhuBuLHVi6parm2
         /Jy5I2rDURJAFcb2pN3LCf7JMf8GuvXEkphmDuT/CZBnGcetjGzXdGytVJdvLZiTd2LH
         Nggw==
X-Gm-Message-State: ANoB5pkzHrBS+IlDL/pASoXJUaEzxOTr18raFVybu7E5lGCIZ4Iygkc3
        nG6D0FSCSdrdcGp01s20jkQJkw==
X-Google-Smtp-Source: AA0mqf7EJdF6Rm3TGtS3IrReZ2gMfHNq0nBv5xhrw57YYWrJhBklbkSG9T4lJmh0N7yrbW9WrlVPIA==
X-Received: by 2002:a05:6512:3134:b0:4a8:3a6a:c2b8 with SMTP id p20-20020a056512313400b004a83a6ac2b8mr5806014lfd.557.1668524220782;
        Tue, 15 Nov 2022 06:57:00 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s7-20020a19ad47000000b004abc977ad7fsm2225842lfd.294.2022.11.15.06.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 06:57:00 -0800 (PST)
Message-ID: <28ddcec9-095f-f2e7-48ab-e05aab04963a@linaro.org>
Date:   Tue, 15 Nov 2022 15:56:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 02/14] dt-bindings: phy: qcom,qmp-usb3-dp: fix sc8280xp
 bindings
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Y3JCVzJ74YsfcDz4@hovoldconsulting.com>
 <de3a426a-03e8-ed15-a9a1-bb300e776e5f@linaro.org>
 <Y3JOO0kNnaNhnW3K@hovoldconsulting.com>
 <02725b78-04ad-8f4a-25c2-9cdaa1e37ab7@linaro.org>
 <Y3JthM1jC2vH1Kn+@hovoldconsulting.com>
 <efd412d0-7411-8b0b-4700-9e183a592048@linaro.org>
 <Y3JxZ+yFMLZkwNBi@hovoldconsulting.com>
 <8420c342-9dce-aea7-8d1e-f141e0c1ebb5@linaro.org>
 <Y3J2AjjjsybI9mKd@hovoldconsulting.com>
 <61df3c4f-f41c-9525-606d-1b8261163080@linaro.org>
 <Y3OgwLlNaqcd5SwW@hovoldconsulting.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y3OgwLlNaqcd5SwW@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2022 15:22, Johan Hovold wrote:
> On Tue, Nov 15, 2022 at 09:12:54AM +0100, Krzysztof Kozlowski wrote:
>> On 14/11/2022 18:08, Johan Hovold wrote:
>>>>
>>>> Which is also fine. I don't understand still why it is a problem - even
>>>> if you have multiple files, one for each SoC/phy. If USB4 brings here 10
>>>> more clocks and other SoCs/phys might bring many more options, then what
>>>> else can you do? Grow the binding file with big text-based mapping of
>>>> IDs? It's not a viable solution. Header or headers is the only
>>>> maintainable way for such cases.
>>>
>>> So then we must add per-SoC (and PHY type) headers even if we can
>>> possibly reuse defines from one platform for another as long as they
>>> appear to be similar enough?
>>
>> No, you don't have to. I just got impression that future devices will
>> bring so many changes that anyway you will end up with per-SoC defines.
>>
>>> For example, using a "SC7180_USB3_DP" infix
>>> for the current platforms and add a new series of indexes for SC8280XP:
>>>
>>> 	QMP_SC7180_USB3_DP_USB3_PIPE			0
>>> 	QMP_SC7180_USB3_DP_DP_LINK			1
>>> 	QMP_SC7180_USB3_DP_DP_VCO_DIV			2
>>>
>>> 	QMP_SC8280XP_USB4_USB3_DP_USB3_PIPE		0
>>> 	QMP_SC8280XP_USB4_USB3_DP_DP_LINK		1
>>> 	QMP_SC8280XP_USB4_USB3_DP_DP_VCO_DIV		2
>>> 	QMP_SC8280XP_USB4_USB3_DP_USB4_PCIE_PIPE	3
>>> 	...
>>> 	QMP_SC8280XP_USB4_USB3_DP_USB4_RX1		9
>>
>> The names are just a names, you can even use QMP_SC7180_* on SC8280XP.
>> You can skip the SoC part and have something shared. We already have
>> such patterns - although maybe more often for outside components (like
>> PMICs). The differences are:
>> 1. For per-SoC name it's quite obvious which clock is supported on fiven
>> SoC,
>> 2. With shared names, you should document somewhere mapping between
>> supported clocks and SoCs. Also what to do if new device comes with 10
>> new clocks entirely different - re-use/map existing defines or add
>> completely new set of 10 of them?
> 
> Ok, thanks. I'll go with a common prefix per PHY type for now, and we
> can worry about hypothetical hardware revisions later.
> 
> I'll use a "QMP_USB43DP_" prefix for the new SC8280XP binding, which can
> be reused also for the older SoCs with USB3-DP PHYs if/when we convert
> them as their indexes will be a subset of the SC8280XP ones:
> 
> 	/* QMP USB4-USB3-DP clocks */
> 	#define QMP_USB43DP_USB3_PIPE_CLK	0
> 	#define QMP_USB43DP_DP_LINK_CLK		1
> 	#define QMP_USB43DP_DP_VCO_DIV_CLK	2
> 
> Since I'm adding a new header anyway, I decided to go with dedicated
> indexes also for the PHY selection (instead of using the PHY_TYPE
> defines):
> 
> 	/* QMP USB4-USB3-DP PHYs */
> 	#define QMP_USB43DP_USB3_PHY		0
> 	#define QMP_USB43DP_DP_PHY		1
> 
> I'll add these to a common dt-bindings/phy/phy-qcom-qmp.h header so that
> it can be used also for the UFS clocks (with a "QMP_UFS_" prefix).

Sounds good, thanks.

Best regards,
Krzysztof

