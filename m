Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11E86283B1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbiKNPTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237171AbiKNPT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:19:29 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96345B7ED
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:19:28 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id r12so19823168lfp.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s4qZK+7Yu5In+UGyLhgCuDgQLMaWOt08UJeOqh2oGhw=;
        b=emhOMbjzzww1AVtCE0BIcdbg90+NXwBG+sDpW2IiOedAX1gNoTeO/3Gkg+NP3Ipc65
         AZOPsqLXQOvmn1vF6ZmBVwiFG00UXe5sc1RyAYEe+s2odFUJ2+9l5DxYPx7nL7u+XE9e
         5KZlqWQC07nothoXFiTKx/c7IyUt1fcBCE09xJ6hzPw4/F7dVrExcOVJCk+CkqnsMMZv
         HXuHjOiA6cst3u0dz/tFnhJ2e5O1Oei0tmVrxeZVimU0M0hwwd0Q1Il2/+xuCBX5OlPo
         qIe1wtMjAOYcLMq+XtcuZNAVWnZGJw5ZQF47P3lxUG1yG73TQ61ZNUk8Zj6bXSOldsXr
         0v6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s4qZK+7Yu5In+UGyLhgCuDgQLMaWOt08UJeOqh2oGhw=;
        b=Z80BvNbhm/VpJrghIaSSmexHqzp5pnu1ONUug1NIY/PbSJgd2feQ+OJcydvpDk0Gh9
         OYp0DBXgbg67Gk3s3IicTb3eM2fcJllff2oVPA4xsoZUqssiGXM204MwIGJVnCwY0Io+
         rXbeI7MeS4jDfBhswuRlzwuBBwKp77rRCErPe3qnSuSvQdEHpQCM9dyu6eSRVnDXKxqU
         CKrotouBFoLldo8IM/+rhqix55rjiwXLqmUdJwzmwNH1UmbeEfAuIAGsEKuT8T/TnM4u
         MKhV7ecpN3pGX394mk4bVwBNILoEIu5xBchyE4hP9g5fuIMvlzmVNXL9lehG6+4HBxbP
         YUeg==
X-Gm-Message-State: ANoB5plMbxNZMplavCWSu8F8i7IZQl11KoUu0SEtHxe82KpzUzhYxEP3
        vL6IPG7gIFPMCWJwCOGbdiAYcg==
X-Google-Smtp-Source: AA0mqf7veRF5xNa75Gb2ttLpByTFoLlWD7Us1WXZrNtszCy+XYC07Ejh2ODD7bykiw3P1st5l3kUjg==
X-Received: by 2002:a05:6512:2345:b0:4ae:d4db:9f89 with SMTP id p5-20020a056512234500b004aed4db9f89mr4098057lfu.174.1668439166935;
        Mon, 14 Nov 2022 07:19:26 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id p4-20020ac24ec4000000b00498f570aef2sm1854905lfr.209.2022.11.14.07.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 07:19:26 -0800 (PST)
Message-ID: <78cda6f8-849c-219a-8dbb-966c283c1a92@linaro.org>
Date:   Mon, 14 Nov 2022 18:19:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 02/14] dt-bindings: phy: qcom,qmp-usb3-dp: fix sc8280xp
 bindings
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
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
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Y3JOO0kNnaNhnW3K@hovoldconsulting.com>
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

On 14/11/2022 17:18, Johan Hovold wrote:
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

Maybe QMP_COMBO_USB3_PIPE_CLK, QMP_COMBO_DP_LINK_CLK, 
QMP_COMBO_DP_VCO_DIV_CLK?

I'll then extend this header with QMP_UFS_RX_SYMBOL_0_CLK 
QMP_UFS_RX_SYMBOL_1_CLK and QMP_UFS_TX_SYMBOL_0_CLK.

>>
>> What are these about? To remind - we talk about names of clocks this
>> device creates. The output names. Whatever IDs you have are not related
>> to the names.
> 
> As I mentioned above, this is not about the names that Linux gives to
> its representation of these clocks. Its just about defining the valid
> indexes in the binding.
> 
> If you think that that using 'clock-output-names' for this is a bit too
> unconventional, I can add back the header with defines like the above
> instead.
> 
> Note that the clock schema has:
> 
>    clock-output-names:
>      description: |
>        Recommended to be a list of strings of clock output signal
>        names indexed by the first cell in the clock specifier.
>        However, the meaning of clock-output-names is domain
>        specific to the clock provider, ...
> 
> Johan

-- 
With best wishes
Dmitry

