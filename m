Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECF56284C6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbiKNQOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237367AbiKNQOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:14:52 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8CEC7B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:14:50 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id h12so13835844ljg.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b6wTsoEqnWNCo+xLotcVL4lHOc4APMKma952G03jZA0=;
        b=xbKjKIjyIM+dukGJQt2smut7cqu9mbiXPsmLQizdri/lnUIqTbDIrFLV7iFsNHqy3D
         01pctG0PwRPw+sAIHWGIcJlTATI9mmhkfvUECE7k9yn550PtmqartHzQOaw+sk2vgV5B
         cGZfINyThuePrkhwwX8UnxGvKcRP5WXhc6fLgs/ZuG8K/gQNVEu97s6zMXInDV9cKUus
         pkALnXz1zPTE6EXbZk4DBX09AVjU8cIKbUYU/s7ijeHmS3+kuM8Gr6Ozj4qwdX9oiT22
         9dmqv5n+zPP3+Oa6dRakTjtfFfPEtzcbHyx35VGUUCHpi69SVAHu77M21HdO+m4LS4JL
         3UIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b6wTsoEqnWNCo+xLotcVL4lHOc4APMKma952G03jZA0=;
        b=8EF8Cg+yyi08LkBLhv7rMxBDZPRfKaBvBkFnSpi2GTYF/7jlwAMj2EOs7cT9j3QN7P
         QSzwH8HIaqmgdEaCiEdm0QcIuJp947rugaBCD1MNiJhwC3hn3iQiFb6SpMYGi5uztTP6
         OCfprm4ps+aYsjKXJok1TIOnqbcxBqpqNux0SQLJLVRousGXV8xjbQQZfdRqWlRRZJ1o
         DmUrVX3Tx3N+MqsZvT2+fv7lEFF3moSi0UCc1nluzPHv/HSspN+QxfG+YSLxnFBvyyRf
         cR7KadPCPo6mkg7+VdKiQONSTYEU8/iYlJcCHgNWfrfjUMQr2nBGS/uYxCR0F8qGJlBS
         SW+g==
X-Gm-Message-State: ANoB5pmm6GWgF8+Vw9oIcGb3T9rcbrhcfM2z25xdJAulgdtxsp1Ld4Mg
        +8//vNtkH+POqz8apq06oPh87g==
X-Google-Smtp-Source: AA0mqf4RlZ5Ep2WoSFwSpBUgtUqa42n8p2HqsbNIqQqAWZpJtUoN6gfm3iQnIWeex21qOCaZ7GKQTA==
X-Received: by 2002:a2e:99d5:0:b0:277:7714:3fca with SMTP id l21-20020a2e99d5000000b0027777143fcamr4306897ljj.529.1668442489070;
        Mon, 14 Nov 2022 08:14:49 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id a1-20020a19ca01000000b004a03d5c2140sm1867981lfg.136.2022.11.14.08.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 08:14:48 -0800 (PST)
Message-ID: <bcc327b6-c38b-86a9-34cb-440ad33df210@linaro.org>
Date:   Mon, 14 Nov 2022 19:14:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 02/14] dt-bindings: phy: qcom,qmp-usb3-dp: fix sc8280xp
 bindings
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221111092457.10546-1-johan+linaro@kernel.org>
 <20221111092457.10546-3-johan+linaro@kernel.org>
 <a22888cd-34cb-3453-0dc2-096da208564c@linaro.org>
 <Y3JCVzJ74YsfcDz4@hovoldconsulting.com>
 <de3a426a-03e8-ed15-a9a1-bb300e776e5f@linaro.org>
 <Y3JOO0kNnaNhnW3K@hovoldconsulting.com>
 <78cda6f8-849c-219a-8dbb-966c283c1a92@linaro.org>
 <Y3Jg/qmMW3rC5Okc@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Y3Jg/qmMW3rC5Okc@hovoldconsulting.com>
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

On 14/11/2022 18:38, Johan Hovold wrote:
> On Mon, Nov 14, 2022 at 06:19:25PM +0300, Dmitry Baryshkov wrote:
>> On 14/11/2022 17:18, Johan Hovold wrote:
>>> On Mon, Nov 14, 2022 at 03:07:41PM +0100, Krzysztof Kozlowski wrote:
>>>> On 14/11/2022 14:27, Johan Hovold wrote:
>>>>> On Fri, Nov 11, 2022 at 04:17:29PM +0100, Krzysztof Kozlowski wrote:
>>>>>> On 11/11/2022 10:24, Johan Hovold wrote:
> 
>>>>> I noticed that several bindings leave the clock indexes unspecified, or
>>>>> have header files defining some or all of them. I first added a QMP
>>>>> header but that seemed like overkill, especially if we'd end up with
>>>>> one header per SoC (cf. the GCC headers) due to (known and potential)
>>>>> platform differences.
> 
>>>>> Shall I add back a shared header for all PHYs handled by this driver
>>>>> (another implementation detail) even if this could eventually lead to
>>>>> describing clocks not supported by a particular SoC (so such constraints
>>>>> would still need to be described by the binding somehow):
>>>>>
>>>>> 	/* QMP clocks */
>>>>> 	#define QMP_USB3_PIPE_CLK	0
>>>>> 	#define QMP_DP_LINK_CLK		1
>>>>> 	#define QMP_DP_VCO_DIV_CLK	2
>>
>> Maybe QMP_COMBO_USB3_PIPE_CLK, QMP_COMBO_DP_LINK_CLK,
>> QMP_COMBO_DP_VCO_DIV_CLK?
> 
> "COMBO" is just the name of the Linux driver and does not belong in the
> binding.

We do not have any standard (iow, coming from the docs) name, so we can 
invent it on our own.

>   
>> I'll then extend this header with QMP_UFS_RX_SYMBOL_0_CLK
>> QMP_UFS_RX_SYMBOL_1_CLK and QMP_UFS_TX_SYMBOL_0_CLK.
> 
> Yeah, I had those in mind when creating the header and using a generic
> QMP prefix (even if I didn't end up using the header in v1).
> 
> This could just be mapping of (arbitrary) QMP indexes to clocks and we
> use it for USB3, DP, UFS and later also USB4.
> 
> This will however mean that the indexes are not necessarily zero-based
> and consecutive for a specific SoC and PHY. But that's perhaps a
> non-issue (cf. the PHY_TYPE defines).

Ugh. Please, no. We have symbol clocks for UFS PHY, USB+DP clocks for 
USB+DP PHY, but let's not go for the unified clocks index definition.

> 
> We'd still need to describe which clocks are available on a particular
> SoC and PHY, and that's partly why I used 'clock-output-names' to fix
> the mapping in the binding. Guess we can just list the valid defines in
> the property description as I did for #phy-cells.
> 
> Johan

-- 
With best wishes
Dmitry

