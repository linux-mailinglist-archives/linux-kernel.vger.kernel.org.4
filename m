Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD756E5ED7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjDRKeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDRKd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:33:59 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76C7DA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:33:57 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id y24so1956579ljm.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681814036; x=1684406036;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q5/bfT+RXd6RtVeOwPRrzIiafIg3lFmOa6O9Z8BiwAE=;
        b=kZmeDGSdMwfgVWKsFDqktR9W3cUkkDYFckVBi0lAMmZEJ5RyWsBLc3MsRcKVeo1L3A
         vNX4zLHHNA1UKtlg3oMjYLD5VfL6glEnfgtTaRF16L0K0UU+rjmA75fsgS3u7fIg3zAz
         HiuvGOeQiAanGEEPIfarIwhONrTqKWXTfDBoH4jDIqewCGExGcf6im6v5cvGIlDDi+If
         5SFlhzGwEER236gbjOhXWgC/I7SBs5jSACeppKy0puJW2J/oETd3DB6B6sC75hsr+6th
         owmI+E4YhUens4vvBxgDYabue4KqGxiQNFkKVn4BmpvVkH7o3r/Z6c/K/YpBudAPX6FO
         Dd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681814036; x=1684406036;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5/bfT+RXd6RtVeOwPRrzIiafIg3lFmOa6O9Z8BiwAE=;
        b=XBSpt9MNZleexkzjw25Jo7+UA/eEvzrpo8JJrhD8m1pk0cp+JdVcEFxqtFpKK4+7si
         XdfxsoVNYc4rbZv84ctmSM2y4g36vBAUY/uknZIJkrQzCkzUX5SR+iM1d6L5HzeP64O0
         ek+iD8oayH124mIYKWBx4bblG39z6idfrKmTn1xw8rHU+zUaprvMYT5YG6nT8p8OjURr
         TPrp9IniJN3rEdzSqchBpYBmcVI6CS58wXwOrdQr8LcgPJakaBhza/b5S3fidDq2VvSC
         QgG9S2KFiGrmmz/SlYf5PyMTNTEE20KxOHb6B6ed8FAMk0oid/ZJM2L3sF3Cs4YZGIne
         pthA==
X-Gm-Message-State: AAQBX9cmjySzQHDPtye4/WUQKi0kOFv5Z9G5PicrTPjhVHuWd3FRy2RR
        3+taqBFAh3T6fsQzHpMoylZKtQ==
X-Google-Smtp-Source: AKy350ZbCcfL3I9jAM9i+Z+zM7VRlJEaAWOsr0O4MjW6or/G+gRTHtsmX4gjbR5Ap03BW7pNhjWi4g==
X-Received: by 2002:a2e:9810:0:b0:2a8:b188:139a with SMTP id a16-20020a2e9810000000b002a8b188139amr533757ljj.45.1681814036167;
        Tue, 18 Apr 2023 03:33:56 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id e15-20020a2e984f000000b002a8afccf545sm1885029ljj.127.2023.04.18.03.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 03:33:55 -0700 (PDT)
Message-ID: <3873483f-7f7d-a146-cca9-b50f054289d4@linaro.org>
Date:   Tue, 18 Apr 2023 12:33:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH RFT v2 01/14] dt-bindings: clock: qcom,rpmcc: Add a way to
 enable unused clock cleanup
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org
References: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org>
 <20230303-topic-rpmcc_sleep-v2-1-ae80a325fe94@linaro.org>
 <ZD2YYrOdQMD3pi7u@gerhold.net>
 <d63d4896afe8a1a901470f88862ce608.sboyd@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <d63d4896afe8a1a901470f88862ce608.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.04.2023 02:19, Stephen Boyd wrote:
> Quoting Stephan Gerhold (2023-04-17 12:05:06)
>> On Wed, Mar 08, 2023 at 10:35:17PM +0100, Konrad Dybcio wrote:
>>> Disabling RPMCC clocks can be a bit touchy. If we can't guarantee all
>>> (or at least most) of the oneline peripherals ask the interconnect
>>> framework to keep their buses online and guarantee enough bandwidth,
>>> we're relying on bootloader defaults to keep the said buses alive through
>>> RPM requests and rate setting on RPM clocks.
>>>
>>> Without that in place, the RPM clocks are never enabled in the CCF, which
>>> qualifies them to be cleaned up, since - as far as Linux is concerned -
>>> nobody's using them and they're just wasting power. Doing so will end
>>> tragically, as within miliseconds we'll get *some* access attempt on an
>>> unlocked bus which will cause a platform crash.
>>>
>>> On the other hand, if we want to save power and put well-supported
>>> platforms to sleep, we should be shutting off at least some of these
>>> clocks (this time with a clear distinction of which ones are *actually*
>>> not in use, coming from the interconnect driver).
>>>
>>> To differentiate between these two cases while not breaking older DTs,
>>> introduce an opt-in property to correctly mark RPM clocks as enabled
>>> after handoff (the initial max freq vote) and hence qualify them for the
>>> common unused clock cleanup.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>  Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
>>> index 2a95bf8664f9..386153f61971 100644
>>> --- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
>>> +++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
>>> @@ -58,6 +58,12 @@ properties:
>>>      minItems: 1
>>>      maxItems: 2
>>>  
>>> +  qcom,clk-disable-unused:
>>> +    type: boolean
>>> +    description:
>>> +      Indicates whether unused RPM clocks can be shut down with the common
>>> +      unused clock cleanup. Requires a functional interconnect driver.
>>> +
>>
>> I'm surprised that Stephen Boyd did not bring up his usual "rant" here
>> of moving the interconnect clock voting out of rpmcc into the
>> interconnect drivers (see [1], [2]). :-)
> 
> :) I was hoping to get a fix for disabling unused clks during late init
> at the same time. Shucks!
> 
>>
>> I was a bit "cautious" about it back then but at this point I think it
>> kind of makes sense. Make sure to read Stephen's detailed explanation in
>> https://lore.kernel.org/linux-arm-msm/159796605593.334488.8355244657387381953@swboyd.mtv.corp.google.com/
>>
>> We keep looking for workarounds to prevent the CCF from "messing" with
>> interconnect-related clocks. But the CCF cannot mess with "clocks" it
>> does not manage. The RPM interconnect drivers already talk directly to
>> the RPM in drivers/interconnect/qcom/smd-rpm.c. I think it should be
>> quite easy to move the QCOM_SMD_RPM_BUS_CLK relates defines over there
>> and just bypass the CCF entirely.
> 
> Please do it!
Okay, that's a plan..

> 
>>
>> For backwards compatibility (for platforms without interconnect drivers)
>> one could either assume that the bootloader bandwidth votes will be
>> sufficient and just leave those clocks completely alone. Or the
>> "icc_smd_rpm" platform device could initially make max votes similar to
>> the rpmcc device. By coincidence the "icc_smd_rpm" platform device is
>> always created, no matter how the device tree looks or if the platform
>> actually has an interconnect driver.
>>
> 
> Yeah that's a good plan. Suspend will be broken or burn a lot of power,
(that's what happens as of today, so sgtm!)

> but presumably the new DTB will be used fairly quickly. Or you can
> implement something like clkdev for interconnects that lets you hack up
> an association between interconnects and consumers for existing DTs and
> then drop those lookups months later.
Uh.. let's not.. Let's just contain it in the interconnect driver.

The buses will be at bearable frequencies coming from the bootloader
(as RPM, storage etc. are enabled) and boosting them at icc_rpm_smd
probe sounds sane.

Konrad
