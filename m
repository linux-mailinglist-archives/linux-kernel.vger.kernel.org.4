Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9687E63B41D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 22:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbiK1VX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 16:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiK1VXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 16:23:25 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA2910FC8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:23:24 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id f13so19448520lfa.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nNCEcjx8AeJ4otaL+nza4WjfS2/m1uwiSV9Je3FJjNI=;
        b=EkpBZXNE2yjswgyax06Qd3D+o4LmwfSPjxRKYBlJCgkQW5ytvqYi9IgJ6vvuMIu8B/
         WzRtBtMiF4EtTEdrhq5OeZloIt9NHVahY9W2uTxiqWauXlN5TPqAoiUT7Udflcd7u563
         /o30eOmG9AEPaWurs9riR7x0ZlFfvcL6nMBwdQSrlTP6s7v2b1r/FZeSOM3nGuHz/B+5
         xVtPS+Kk2WsQFItFbtv2ngZVCHdKfEZBv44JvSbO8MWUs0CqeHnCNiBnEXFTqbPRr08L
         owtwMJxHStG7EHfmKn4JDhxT+2GNCKDVpTNMDlh6W7K1PYdNM1CoWDwd84+w5qglCSdW
         dFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nNCEcjx8AeJ4otaL+nza4WjfS2/m1uwiSV9Je3FJjNI=;
        b=GBO7l6jP21L1RWYWeisK8hS9byfUzHJIcUoW/4keyHcWxuJjw9CnNCSJ/ntOZ7gmne
         2vAA5blS9qvKQxEhjSxjpJjXKA/3kC2p6+I5Ga0jeMVS3irJ+1lAz1Dy9aBYn7SxHdT7
         bSYdRBZ9y4FSJDSy3zNQhdfGn2BKAIBO2FbIIiEQndXOsu5oayN6QwAKhtKZ6toibdUN
         C8A9guODCTHWJpXClgug8Z18h6+O8pzerjCRQ4uQ+K8D6koRHub/Vff0Jurpz3y7/zkb
         kg0uwYBNLkEnSE+k3vzr5CyUY8hmCKp1vUCEeKf2KwOFChBZKcfmUVOuexDQlINM8Gs1
         mrgA==
X-Gm-Message-State: ANoB5pnTH5yof7Au0PHBB7CgsvRcAXGWj9knDR9dmtZYtNHdMIYhPLT0
        Y2fTF1Ixyq0oYXz7D97uB2neGw==
X-Google-Smtp-Source: AA0mqf5F3dQvpQXGfCWDqrFdkeJpwyWCiQZHm6G74pRKzR08anZxlTesc0H4CqzWPliv1vXMy/sa7g==
X-Received: by 2002:ac2:4ed2:0:b0:4b5:2110:1ac7 with SMTP id p18-20020ac24ed2000000b004b521101ac7mr230394lfr.579.1669670603194;
        Mon, 28 Nov 2022 13:23:23 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a27-20020a056512201b00b004a01105eea2sm1868029lfb.150.2022.11.28.13.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 13:23:22 -0800 (PST)
Message-ID: <a373f1bc-3d7c-0c79-6e20-d459d5608814@linaro.org>
Date:   Mon, 28 Nov 2022 22:23:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] arm64: dts: qcom: msm8916-wingtech-wt88047: Add flash LED
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Travkin <nikita@trvn.ru>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?Q?Andr=c3=a9_Apitzsch?= <git@apitzsch.eu>,
        Pavel Machek <pavel@ucw.cz>
References: <20221128051512.125148-1-linmengbo0689@protonmail.com>
 <43c24e7e-49b6-ff46-2f40-9413af7ac252@linaro.org>
 <Y4T+Mv+uIx7jQwky@gerhold.net>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y4T+Mv+uIx7jQwky@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2022 19:30, Stephan Gerhold wrote:
> Hi Krzysztof,
> 
> On Mon, Nov 28, 2022 at 09:56:47AM +0100, Krzysztof Kozlowski wrote:
>> On 28/11/2022 06:16, Lin, Meng-Bo wrote:
>>> WT88047 uses OCP 8110 Flash LED driver. Add it to the device tree.
>>>
>>> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
>>> ---
>>>  .../dts/qcom/msm8916-wingtech-wt88047.dts     | 22 +++++++++++++++++++
>>>  1 file changed, 22 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
>>> index 166bed05996f..a87be1d95b14 100644
>>> --- a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
>>> +++ b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
>>> @@ -23,6 +23,20 @@ chosen {
>>>  		stdout-path = "serial0";
>>>  	};
>>>  
>>> +	flash-led-controller {
>>> +		compatible = "ocs,ocp8110";
>>
>> The compatible is not documented. Checkpatch warns about it. You need to
>> document devices before using them.
>>
> 
> Unfortunately Pavel never applied the dt-bindings patch for this - only
> the driver patch was applied. André already sent a kind reminder [1] and
> two resends [2, 3] without success. Since it's a documentation-only
> patch, maybe you could take it through the dt-bindings tree?
> 

I'll ping Rob. Other way is to resend. You need to keep resending (maybe
together with DTS in such case) before this can go in.

Best regards,
Krzysztof

