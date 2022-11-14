Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E27628459
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbiKNPto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236055AbiKNPtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:49:42 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1787FD103
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:49:41 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id u2so13739982ljl.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6wSuGB76l81gaOZPm77HZM6lioiS7r+dfc+W7xsVPIc=;
        b=HskIouhVyi2ue7+LEhRN1RNzMQvR2PC9gCYjtggrfbJLkrjQSaDW8HSkDC2ngq/GGY
         T7CvhwkLZcQEP7RHrGRISmnitfx1GOUeqhMkImP7385hiYtqtnfPuY/NtKgTeaQqK3Xe
         pgnx9nvuaNp7VJQmCWdEWilqgSbOoYiQaafmZWrfPz3T5RNkTyrhRLcqj8zrIUN70ITz
         +sC3HeCliR8IXBCJsa3SMVIofiy0Tji4L7fXbJSgzNGYnkKuJ7GwIYGgnCvLzdst8IxB
         U3bTqm76MPVBtBftuH8k2gpUyo6abWhlTUVle9NCp/FMZf2QYl7CRVCjNFI1i/z+XNXn
         GgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wSuGB76l81gaOZPm77HZM6lioiS7r+dfc+W7xsVPIc=;
        b=rNsPo+fJ9xZp6IszzrVdgJWYgp6EPRYekfgNztESKIdG99g1Ry/FLWCBDkHauSGFvy
         Fvk6NERXlCJBcKBYJ7lc02l80HxrAoyD9KFqdZGhhyzM1feOSh2zahl5PX94yZs7fsOv
         fPp7Ad3rUNxdYPAcMnHZt+SHD7TlQSSHwRyp8DEQSmZXKtDwIoskcgaP1Gslee2yUJ3W
         ch8m73mMt3Z/uOLZkTKaQtUVIIo8cQRyCr2AVJwZLrnWVL9LFZ/HNX48KLVqBDD6kdVV
         6nT3HrQAagB8lDpzJkD5sQvwIyPIydAq5WIuRFipP8GSC68IKFs5EODi5fYI0jhf4zdc
         HlMA==
X-Gm-Message-State: ANoB5pm5fXueleOxE551NEXoEtwAywG9yJDNO5IdIQWHcf2Ajn59thTd
        17JkbJQA4myLiTOeaASGrXzGWxX7ONwXixmi
X-Google-Smtp-Source: AA0mqf6z1dI9nYxuRJzt3DSAk7mzSPHDwCDS+Nlxum6G3BtXxkcMr8KPa73iixm4aEeEjQ4yKM8BNQ==
X-Received: by 2002:a2e:460a:0:b0:26f:ab25:8a77 with SMTP id t10-20020a2e460a000000b0026fab258a77mr4098788lja.93.1668440979411;
        Mon, 14 Nov 2022 07:49:39 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e10-20020a19674a000000b0049311968ca4sm1855621lfj.261.2022.11.14.07.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 07:49:38 -0800 (PST)
Message-ID: <02725b78-04ad-8f4a-25c2-9cdaa1e37ab7@linaro.org>
Date:   Mon, 14 Nov 2022 16:49:37 +0100
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
References: <20221111092457.10546-1-johan+linaro@kernel.org>
 <20221111092457.10546-3-johan+linaro@kernel.org>
 <a22888cd-34cb-3453-0dc2-096da208564c@linaro.org>
 <Y3JCVzJ74YsfcDz4@hovoldconsulting.com>
 <de3a426a-03e8-ed15-a9a1-bb300e776e5f@linaro.org>
 <Y3JOO0kNnaNhnW3K@hovoldconsulting.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y3JOO0kNnaNhnW3K@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2022 15:18, Johan Hovold wrote:
> On Mon, Nov 14, 2022 at 03:07:41PM +0100, Krzysztof Kozlowski wrote:
>> On 14/11/2022 14:27, Johan Hovold wrote:
>>> On Fri, Nov 11, 2022 at 04:17:29PM +0100, Krzysztof Kozlowski wrote:
>>>> On 11/11/2022 10:24, Johan Hovold wrote:
>>>>> The current QMP USB3-DP PHY bindings are based on the original MSM8996
>>>>> binding which provided multiple PHYs per IP block and these in turn were
>>>>> described by child nodes.
> 
>>>>> +  "#clock-cells":
>>>>> +    const: 1
>>>>> +
>>>>> +  clock-output-names:
>>>>> +    items:
>>>>> +      - const: usb3_pipe
>>>>> +      - const: dp_link
>>>>> +      - const: dp_vco_div
>>>>
>>>> Why defining here fixed names? The purpose of this field is to actually
>>>> allow customizing these - at least in most cases. If these have to be
>>>> fixed, then driver should just instantiate these clocks with such names,
>>>> right?
>>>
>>> I'm only using these names as documentation of the indexes. The driver
>>
>> What do you mean by documentation of indexes? You require these specific
>> entries and do not allow anything else.
> 
> I'm using this property as documentation of the valid indexes that can
> be used when referring to clocks provided by this device.
> 
> There are currently three and the mapping is described by the
> 'clock-output-names' property.

That's not the purpose of this property. Drop it then. The names do not
define the ABI and do not document it, actually. You require now that
every DTB, if providing clock-output-names, will have exactly such names
instead of having fixed IDs. DTBs are not for defining the ABI.

>  
>>> doesn't use these names, but that's a Linux-specific implementation
>>> detail.
>>>
>>> I noticed that several bindings leave the clock indexes unspecified, or
>>> have header files defining some or all of them. I first added a QMP
>>> header but that seemed like overkill, especially if we'd end up with
>>> one header per SoC (cf. the GCC headers) due to (known and potential)
>>> platform differences.
>>
>> Headers for the names? I do not recall such but that does not seem right.
> 
> Headers for the indexes.
> 
>>>
>>> On the other hand reproducing this list in each node is admittedly a bit
>>> redundant.
>>>
>>> Shall I add back a shared header for all PHYs handled by this driver
>>> (another implementation detail) even if this could eventually lead to
>>> describing clocks not supported by a particular SoC (so such constraints
>>> would still need to be described by the binding somehow):
>>>
>>> 	/* QMP clocks */
>>> 	#define QMP_USB3_PIPE_CLK	0
>>> 	#define QMP_DP_LINK_CLK		1
>>> 	#define QMP_DP_VCO_DIV_CLK	2
>>
>> What are these about? To remind - we talk about names of clocks this
>> device creates. The output names. Whatever IDs you have are not related
>> to the names.
> 
> As I mentioned above, this is not about the names that Linux gives to
> its representation of these clocks. Its just about defining the valid
> indexes in the binding.

With or without the header, the IDs are part of ABI and are fixed. The
headers are I think always encouraged because it makes above sentence
explicit. Without the headers developers might want to change the IDs.

> 
> If you think that that using 'clock-output-names' for this is a bit too
> unconventional, I can add back the header with defines like the above
> instead.
> 
> Note that the clock schema has:
> 
>   clock-output-names:
>     description: |
>       Recommended to be a list of strings of clock output signal
>       names indexed by the first cell in the clock specifier.

Exactly. Not to describe the ABI behind the ID.

>       However, the meaning of clock-output-names is domain
>       specific to the clock provider, ...

... because you might have more cells. Just because clock-output-names
do not fit some drivers it does not mean you can use it any way you
wish. It is still for names of provided clocks.

Best regards,
Krzysztof

