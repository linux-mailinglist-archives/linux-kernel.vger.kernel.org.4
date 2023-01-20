Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABB66761C8
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 00:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjATXzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 18:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjATXzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 18:55:39 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B64589B8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 15:55:37 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id l8so5212358wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 15:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ff0A3kv/bgct8rqbXfX4KXy2H1Te2l8OeqZhx13j8HI=;
        b=rXJEYKqxZSNOEEj7Bp746mpBz+AjotzURkZk2iiq5Jlmd2JFT99TtAJ+OUqiCPvQMO
         Tf/StJrJTS8Hmwxp4mrVS/XyEDtf5vDvQnk/pD7irkMrflPHgJCOoXaFqPMtATDT1bJg
         IZNpbuqPib7LpTYWSbCZbEYIR4um2oewtayqw44k4kK1ghUdvuT0lNz+MJjVdyM7R8/h
         bFvhpyo6SfMg65FL8kVPcfxEu7AauldoTtMTKVtMurh/woqqWEpqRpKLHQ7fhsSQsy+u
         lD1lyFd4fxkYNRpmNc0K2Ut22lmAtOEa86EQf447h64lV+LhXDITcv2AVuG8tiUGC3U5
         aoow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ff0A3kv/bgct8rqbXfX4KXy2H1Te2l8OeqZhx13j8HI=;
        b=mp2ni/13LITFTMzNOCB8OedPaz68mrlAD9uKm/40xWEof6Lpq/vUHldBScp3jHit/X
         USk5d83RW9eVJsQw0K8QP7dSxd0qA0SGWCit1fB79PZtPtK+6i774VNkrq83FVdHzvY5
         WgecgwvsRZJnjOhELxhtwO6IpRifkbzn3NKPayloKJ4FZikO521JWXC+s0EFWTNLORrx
         nRtu78iYJlhhB0+xWsHmJ3xl4VJlaFf132flelmCxAxIywsFi/Stg1sPGOcnhy+rHBKF
         p8VfOEMPq9amTnB4WdNozg5za4rFM0MHF1R7nHb+/0KHzmMMKrhOCNHKIygiz4lG4EZb
         /XRQ==
X-Gm-Message-State: AFqh2kr7HDXYsq5j152DjsPKjLBPw0iMJ1V6OmubeF1tBfx8cBXBCd4t
        3ZRhqKt3DHBHA1Pn9VANsKrgTA==
X-Google-Smtp-Source: AMrXdXuW1MKzdMucZFZGu2HrYDLuLfT/y0K+3EqW9j/yN3rMlnlz21zrNlxDaFBUImqHxB2zW9FuYg==
X-Received: by 2002:a05:600c:cc8:b0:3cf:497c:c59e with SMTP id fk8-20020a05600c0cc800b003cf497cc59emr12474479wmb.6.1674258936218;
        Fri, 20 Jan 2023 15:55:36 -0800 (PST)
Received: from [192.168.0.15] (cpc76484-cwma10-2-0-cust274.7-3.cable.virginm.net. [82.31.201.19])
        by smtp.gmail.com with ESMTPSA id q23-20020adfb197000000b002be5bdbe40csm2731007wra.27.2023.01.20.15.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 15:55:35 -0800 (PST)
Message-ID: <46929065-0f8d-9487-d44c-406503fe7a0c@linaro.org>
Date:   Fri, 20 Jan 2023 23:55:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFT PATCH v2 4/6] arm64: dts: qcom: sdm845: move audio to
 separate file
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20230118103458.107434-1-krzysztof.kozlowski@linaro.org>
 <20230118103458.107434-4-krzysztof.kozlowski@linaro.org>
 <46acf2f4-3272-c33d-887f-05d4f4aad4d7@linaro.org>
 <1711636c-8aa1-eccc-eded-14a64baf7bec@linaro.org>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <1711636c-8aa1-eccc-eded-14a64baf7bec@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/01/2023 07:42, Krzysztof Kozlowski wrote:
> On 20/01/2023 00:24, Caleb Connolly wrote:
>>
>>
>> On 18/01/2023 10:34, Krzysztof Kozlowski wrote:
>>> Re-organize SDM845 sound components into separate, audio DTSI which
>>> should be included and customized by the SDM845 boards wanting audio.
>>> The DTSI includes:
>>> 1. WCD9340 codec node because it is not a property of the SoC, but board.
>>> 2. Common sound DAI links, shared with all sound cards.
>>
>> Hi Krzysztof,
>>
>> I know I already reported this on IRC, I thought I'd duplicate the info
>> here for completeness sake.
>>
>> Due to how the sound node is parsed the device numbers in alsa are
>> derived from the index of the sound/mmX-dai-link child nodes.
>>
>> For boards which use more than 3 FE's this causes breaking changes in
>> userspace, as the slim-dai-link and slimcap-dai-link nodes now come
>> before the other mmX-dai-link nodes, for example with my OnePlus 6
>> patches "aplay -l" shows:
>>
>> card 0: O6 [OnePlus 6], device 0: MultiMedia1 (*) []
>>   Subdevices: 1/1
>>   Subdevice #0: subdevice #0
>> card 0: O6 [OnePlus 6], device 1: MultiMedia2 (*) []
>>   Subdevices: 1/1
>>   Subdevice #0: subdevice #0
>> card 0: O6 [OnePlus 6], device 2: MultiMedia3 (*) []
>>   Subdevices: 1/1
>>   Subdevice #0: subdevice #0
>> card 0: O6 [OnePlus 6], device 5: MultiMedia4 (*) [] <-- 5 instead of 3
>>   Subdevices: 1/1
>>   Subdevice #0: subdevice #0
>> card 0: O6 [OnePlus 6], device 6: MultiMedia5 (*) []
>>   Subdevices: 1/1
>>   Subdevice #0: subdevice #0
>> card 0: O6 [OnePlus 6], device 7: MultiMedia6 (*) []
>>   Subdevices: 1/1
>>   Subdevice #0: subdevice #0
>>
>> This breaks the UCM configs shipped by postmarketOS and Mobian - though
>> none of it is "upstream".
> 
> Thanks for the report.
> 
> 
>>
>> Would it be reasonable to add all 6 FE DAI's and then disable the unused
>> ones on a per-board basis?
> 
> 
> Or just drop the sound node from the audio DTSI, not sure if there are
> benefits in such case...

That sounds reasonable to me. I'd be happy to rebase my OnePlus 6 patch
on this.
> 
>>
>>>
>>> The Xiaomi Polaris, although includes WCD9340 codec, it lacks sound
>>> node, so it stays disabled.
>>>
>>> On all others boards not using audio, keep the Slimbus node disabled as
>>> it is empty.
> 
> Please trim your replies - there is a lot of unrelated content here and
> I don't know if I should keep scrolling to look for something or not.

Will do, thanks for pointing that out.
> 
> Best regards,
> Krzysztof
> 

-- 
Kind Regards,
Caleb (they/them)
