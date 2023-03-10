Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E94E6B3849
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjCJIOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 03:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjCJINf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:13:35 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E354B81E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:13:32 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id g3so17236832eda.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678436011;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CEPOx6Kwho4WulB2OeUMcq60ngC+gDTko4FaO6LvQts=;
        b=fZO54m22EllMgQT3ljYOGeNEoUes1cH0hDHzecRdbywedL6XngZKkw1h0xFv5H2mXA
         0DmmTjVjV1k2ehBU0S7hULfTJSgfWiC+Qp04O5rGgtLWrVRypNIQLaHsSDSzhpJsy+6i
         eguZ/PtTKqp5Fu+Q6JCmNdU89nnvScLgXI3PX4QC5mysGM4nNQYX5f2oosbNNgwT9K+E
         b4x6HJqkIrRjTBnnQd2OBSwOGeehXml3thjck3Ty6gVMcOoVfFw0lKSJf/Dx6AjWRKfH
         Pvi146UrueYcO2IlPyuaTpspwHX4zKV256ZNAyoyKe+7xi4UEeTUsENpz0WkT6U6l6NV
         fjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678436011;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CEPOx6Kwho4WulB2OeUMcq60ngC+gDTko4FaO6LvQts=;
        b=UYSFkWx1eQ+GZzmu5HpIJQeibiksi/VnFqlqmKUg/35auwtxOrHfY2lyh1odLXZkjW
         9f1mSNnUkq/WqYvCzfYE4GceWNziWWziQazcNCnsQcsh01AEFn0qQLdBOmluY2XedKkY
         k/H0x5orcVnpw36qXMpwhjdCvZxoK8RLP9TpLqD80w2moUS3q+kGzOFsviEcxYIgch/D
         oDAesjQGDlxhWfAtC8JaUYi/KRZco/Hrg6kFkU5y/jqgN/UHMpakeKLVhB/Mt0hhkveS
         7VoAtwlP9oMGSRKcA7YnTcbMMw0zNYBJ3B8iegfVD3ql7QpMi8OafQxd0/Zq/eg13/m/
         +0iA==
X-Gm-Message-State: AO0yUKUxUCVLERi9b39em8BTIRtRqUKWvO7mqHtQBGlRDBMmprYRRKiu
        orLmrIpcqkItEGRgQzP33PEVGg==
X-Google-Smtp-Source: AK7set8hHmBQYQjiev7icT060MuM2aDe1d5sXieWR847rpHIWIaqa2m9i4Cs+I/TgT7t42q1surT2g==
X-Received: by 2002:a05:6402:7ce:b0:4c0:57b:47a9 with SMTP id u14-20020a05640207ce00b004c0057b47a9mr21919985edy.35.1678436010973;
        Fri, 10 Mar 2023 00:13:30 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:2a59:841a:ebc:7974? ([2a02:810d:15c0:828:2a59:841a:ebc:7974])
        by smtp.gmail.com with ESMTPSA id c22-20020a50d656000000b004c09527d62dsm525188edj.30.2023.03.10.00.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 00:13:30 -0800 (PST)
Message-ID: <b5c9aa6e-69d1-165a-4ff9-b5a9f33688e6@linaro.org>
Date:   Fri, 10 Mar 2023 09:13:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH v2 7/7] arm64: dts: qcom: Add the Inline Crypto Engine
 nodes
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20230308155838.1094920-1-abel.vesa@linaro.org>
 <20230308155838.1094920-8-abel.vesa@linaro.org>
 <4eab53fc-2d26-dc93-3ae6-c0b2546ad3e0@linaro.org>
 <ZAol5o5a6HZYgRaG@sol.localdomain>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZAol5o5a6HZYgRaG@sol.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2023 19:31, Eric Biggers wrote:
> On Thu, Mar 09, 2023 at 11:31:46AM +0100, Krzysztof Kozlowski wrote:
>> On 08/03/2023 16:58, Abel Vesa wrote:
>>> Drop all properties related to ICE from every UFS and SDCC node,
>>> for all platforms, and add dedicated ICE nodes for each platform.
>>> On most platforms, there is only one ICE instance, used by either
>>> UFS or SDCC, but there are some platforms that have two separate
>>> instances and, therefore, two separate nodes are added.
>>>
>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>> ---
>>>
>>> Changes since v1:
>>>  * Made changes for all platforms that use ICE, as a single patch since
>>>    most changes look really similar.
>>>
>>>  arch/arm64/boot/dts/qcom/sdm630.dtsi | 18 +++++++++-----
>>>  arch/arm64/boot/dts/qcom/sdm670.dtsi | 15 +++++++----
>>>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 21 +++++++++-------
>>>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 37 +++++++++++++++++-----------
>>>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 31 ++++++++++++++---------
>>>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 21 +++++++++-------
>>>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 22 ++++++++++-------
>>>  7 files changed, 102 insertions(+), 63 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
>>> index 5827cda270a0..2aed49104d9d 100644
>>> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
>>> @@ -1330,9 +1330,8 @@ opp-200000000 {
>>>  		sdhc_1: mmc@c0c4000 {
>>>  			compatible = "qcom,sdm630-sdhci", "qcom,sdhci-msm-v5";
>>>  			reg = <0x0c0c4000 0x1000>,
>>> -			      <0x0c0c5000 0x1000>,
>>> -			      <0x0c0c8000 0x8000>;
>>> -			reg-names = "hc", "cqhci", "ice";
>>> +			      <0x0c0c5000 0x1000>;
>>> +			reg-names = "hc", "cqhci";
>>
>> I believe this will break the ICE on these platforms without valid
>> reason. The commit msg does not explain why you do it or why this is
>> necessary.
>>
>> We already we received comment that we keep breaking Qualcomm platforms
>> all the time and need to keep them in some shape.
>>
>> Also, patchset is non-applicable in current set (breaks users) and
>> neither commit nor cover letter mentions it.
>>
> 
> FWIW, I tested this patchset on SDA845, and ICE continues to work fine.

Really? I clearly see of_find_device_by_node -> "return NULL" and all
old code gone, so ABI is broken. Are you sure you applied patch 1-6 and
ICE was working?

> 
> (Though if I understand the patchset correctly, the ICE clock is no longer
> turned off when the UFS host controller is suspended.  That isn't ideal as it
> wastes power.  I would like that to be fixed.)
> 
> Anyway, when you say "break the ICE", do you really mean "make an incompatible
> change to the device-tree bindings"?

It breaks existing users of DTS and kernel.

> 
> I'd think there would be no problem with that as long as everything is updated
> at once, which this patchset does.

Which is obviously not possible. DTS always goes separate branch,
always. It cannot be combined with code into the same branch! So how do
you even imagine this?

> 
> I've heard before that some people consider the device-tree bindings to be a
> stable UAPI.  That doesn't make sense to me. 

It is stable ABI. Bindings and DTS are used by other firmwares,
bootloaders and systems. The kernel *must* work with old and out of tree
DTS.

Even if this does not make sense to you, these are the realities,
practice and current rules.


> Actually, my original ICE patches
> ran into this issue too, and the resolution was simply that the Qualcomm
> platforms maintainer (Bjorn) decided to take the patches anyway.  I never heard
> any complaints afterwards.  Maybe the same is fine here too?


No, it is not fine. The patchset breaks ABI, breaks existing kernel with
old DTS and breaks other projects using DTS and bindings.

Best regards,
Krzysztof

