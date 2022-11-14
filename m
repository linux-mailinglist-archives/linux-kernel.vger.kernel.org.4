Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E577628429
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbiKNPiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236986AbiKNPil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:38:41 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECB9630B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:38:38 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id s8so2770649lfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mOEG1//p1argvxLaN4lEBl+c5SYhnpTC5Y7qXDI3ncw=;
        b=qTlwph1jEH3KELFPFwz1JXAbic1+PYa+nVKg7gi0wwHS8yEv8VHdj0TKmytCtvVxEy
         yBBJxvXe01l6hFpQ00zZLU/XWyiV01dmUXXLu7lCnoSbjZyb2HeB9adFfUvaRNE/G4S2
         v6w97ze9QKb+QHuRSmMt53gvwN39T3latGxLYfHl8O2a1E7DpRzi+Wp1CAOyhYpkhJ7S
         0Sf17VlXIxT0pXYPGVkm6MoqVcoAeFTmFXbc7dbZG/JcnbukDG0UdoWMXApPnnOGpDeZ
         zOkQhlzBGZQ7NSm8brURS78jfPDZzlWj23bDsWaJvlKUBN4LKdsVn7TuqrMQj6XjZbZl
         XiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mOEG1//p1argvxLaN4lEBl+c5SYhnpTC5Y7qXDI3ncw=;
        b=nExzJ7ZFFIL+pvOzi/Dizry9jabV82XMqCDOr6g5d87iawQQfqay/i8oEmuPpIWpmO
         udr4YsiLBV0/ZSz/K0JwHLDAsUTYXOt1TmaVSxFBXpyUk7ExDDRZJHj5/zMXQoDJvmTC
         PS1rf6mEelcBNio/cj3dTuIx6NgVaSGf1xjxUZ0hTo+aq5cmd6gJSiwxZNh2FqpZIV0L
         ccxa2x5xvFcGwIx6yw3ceTYEDNG84m/8RWCZsfeQGqiBz7oD7b3Coejbb/pq8sr/7w+G
         KuKX7GZLM/eUlq2DAItyRhFnpae8wzQ0wmscOOf7ucSNlLxFewMZ4Omi5KRqec1/FlnJ
         dBvQ==
X-Gm-Message-State: ANoB5plnFKPrfmK4YgrjsfB7dqVt2TDr4aWRrrDx3oG+9CmBdJWxcg7t
        zCyKPpoZQn2SBvNCx5T+3b9mHw==
X-Google-Smtp-Source: AA0mqf7+3xN1f8t+uzuu1OEu7CQSB8unLeS83Qd0QmP57uok3EDsdUSFFPnirNUlE1gFGiJMveKDxg==
X-Received: by 2002:a05:6512:2097:b0:4a9:39f4:5790 with SMTP id t23-20020a056512209700b004a939f45790mr4584562lfr.192.1668440316948;
        Mon, 14 Nov 2022 07:38:36 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s8-20020a056512202800b00498f32ae907sm1872273lfs.95.2022.11.14.07.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 07:38:36 -0800 (PST)
Message-ID: <e1140358-b693-c23e-68dc-787bf6aa2422@linaro.org>
Date:   Mon, 14 Nov 2022 18:38:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 12/14] phy: qcom-qmp-combo: rename common-register
 pointers
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221111092457.10546-1-johan+linaro@kernel.org>
 <20221111092457.10546-13-johan+linaro@kernel.org>
 <f3ae781b-2046-e1be-564f-9de74107f000@linaro.org>
 <Y3I6lN6UTHg2ozNP@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Y3I6lN6UTHg2ozNP@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 14/11/2022 15:54, Johan Hovold wrote:
> On Sat, Nov 12, 2022 at 02:31:27PM +0300, Dmitry Baryshkov wrote:
>> On 11/11/2022 12:24, Johan Hovold wrote:
>>> The common registers are shared by the USB and DP parts of the PHY so
>>> drop the misleading "dp" prefix from the corresponding pointers.
>>>
>>> Note that the "DP" prefix could also be dropped from the corresponding
>>> defines, but leave that in place for now.
>>>
>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>> ---
>>>    drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 24 +++++++++++------------
>>>    1 file changed, 12 insertions(+), 12 deletions(-)
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>
>> Note regarding the last phrase: I'd suggest leaving the DP prefix in
>> register names, it makes it easier to visually note & verify the
>> register block.
> 
> My point is that "DP" was never part of the COM register block name. The
> confusion likely comes from the vendor driver naming these defines along
> the lines of
> 
> 	USB3_DP_COM_POWER_DOWN_CTRL
> 
> Here "USB3_DP" is the common prefix for all defines that apply to both
> "parts" of the PHY so the corresponding Linux define
> 
> 	QPHY_V3_DP_COM_POWER_DOWN_CTRL
> 
> should either include "USB3" or drop "DP".

My thought was that we already have too many _COM_ defines in the qmp 
headers. Having QPHY_Vn_COM_something would make it too easy to mix it 
with QSERDES_Vn_COM_foo. Thus I'd vote to leave DP_COM prefix in place. 
While it might be not fully accurate, it serves the point of identifying 
the register block.

> 
> This becomes more apparent on SC8280XP where the corresponding define
> is:
> 
> 	USB43DP_COM_POWER_DOWN_CTRL

I'd still use something like QPHY_V10_DP_COM_POWER_DOWN_CTRL here.

> 
> Johan

-- 
With best wishes
Dmitry

