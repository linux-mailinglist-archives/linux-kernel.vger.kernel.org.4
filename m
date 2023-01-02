Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3222865B4E9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbjABQNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbjABQNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:13:30 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66072A0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 08:13:27 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id cf42so42130524lfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 08:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B45ARsjYKeYyUPM468UJSOfYF6QTwYEJnWcRpLeLJ1Q=;
        b=ErWFMZEJC2+Tu/oLqrGuiMBQutHk575btqGsQPR2GlPpgG5kEtPDD9MtizaZ2kH/j+
         pASGkEQhVmnpgmu9w8gnDQ7WMUtGHWbDFAPndFGXbAF1fQLrl+BbMS8c+Jp2ZztUDMba
         zUCkFDUqjxrgi+InhO1F4cmMoPkcCLAPia8Uk18/ELMXbePq13X3x4cCzW8nEzOOSN+K
         o7uGBXNhdNzzsw1nkNoJYbzDamdUT1KPsfBNfAnviYGt/V5DQZhqle6KTABq0C8eOLjT
         R7lESgzGyDnYpEq+DgyA3JyIs06o/eEV36FYiGp/jxhZivPTrhM3qg2dFEGCjFQeTF+P
         t1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B45ARsjYKeYyUPM468UJSOfYF6QTwYEJnWcRpLeLJ1Q=;
        b=HGnqDwVyI2mqhVNTues/7/H7CLnhvK7t49jV0JumlhSC+Uj45vCnKdy2rNjbfYwXiI
         2ntc+/6COj5ri1FzfjLbRGqvmxcFdJYdwGKO4nQ2lo6zdlIpI/KAqu9ALPGtxBt7c8JN
         lDtfM7l27ezekEQYzpgLtPsNtJsXLEcFn8DRkpX4CNSBWKZFkaTPHxs4ZSTvYWSnFeYf
         bgIF5Mb2GG/ScwzJqH49uXMy7gY4Ci1zzoW+q+I4oPamkB6KAIhWyVnwKabPuhiOj4Gv
         ESKDN4MMzT3BAt2nNEcAcEWAAM1oaV/lWduAKzEzBvGQBQEwTATulBRNEr0eo8SgqYnt
         WiFQ==
X-Gm-Message-State: AFqh2kqIdG+AT7plRnk7tUzsoR/tVYN5SuXkkLpQt+JiMOwP2z1XcaiM
        LUVsC9IXbmn9hJ7zEStohOCFLw==
X-Google-Smtp-Source: AMrXdXuaJKeaFsTAvoTZgU3pEnOvANnA53tMa5fQ8Ap7iPi7HD75K0cLRnedWC4bZIr6sqUCw+FuUw==
X-Received: by 2002:a05:6512:20d4:b0:4b6:f08e:1196 with SMTP id u20-20020a05651220d400b004b6f08e1196mr10366637lfr.11.1672676006301;
        Mon, 02 Jan 2023 08:13:26 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id x10-20020a056512078a00b004b587e37265sm4534210lfr.58.2023.01.02.08.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 08:13:25 -0800 (PST)
Message-ID: <70a6fcc9-6922-60e7-b2ce-1de32277483f@linaro.org>
Date:   Mon, 2 Jan 2023 17:13:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/6] arm64: dts: qcom: sc8280xp-x13s: disable soundcard
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230102105038.8074-1-johan+linaro@kernel.org>
 <20230102105038.8074-2-johan+linaro@kernel.org>
 <fc42801a-55d9-90b9-f7f0-48657ec7a373@linaro.org>
 <Y7LzJ+RRzDNRf3jR@hovoldconsulting.com>
 <81e3994e-49d9-ea5b-b055-cbcc737a6e37@linaro.org>
 <Y7L3OTs/u8FsH8o2@hovoldconsulting.com>
 <8bd6487a-3ae7-f7c1-e478-1effd68700d3@linaro.org>
 <Y7L6t3p57uTCECRy@hovoldconsulting.com>
 <5de95075-ca62-3cae-ce07-d263ea3aa264@linaro.org>
 <Y7L/JbUICN0OQhaK@hovoldconsulting.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y7L/JbUICN0OQhaK@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2023 16:58, Johan Hovold wrote:
> On Mon, Jan 02, 2023 at 04:46:40PM +0100, Krzysztof Kozlowski wrote:
>> On 02/01/2023 16:39, Johan Hovold wrote:
>>>>>>>>>  	wcd_tx: wcd9380-tx@0,3 {
>>>>>>>>>  		compatible = "sdw20217010d00";
>>>>>>>>> @@ -781,6 +787,8 @@ &vamacro {
>>>>>>>>>  	pinctrl-names = "default";
>>>>>>>>>  	vdd-micb-supply = <&vreg_s10b>;
>>>>>>>>>  	qcom,dmic-sample-rate = <600000>;
>>>>>>>>> +
>>>>>>>>> +	status = "disabled";
>>>>>>>>
>>>>>>>> That's a double disable.
>>>>>>>
>>>>>>> Yes, that's on purpose. We're temporarily disabling these nodes instead
>>>>>>> of reverting the series which should not have been merged.
>>>>>>
>>>>>> I don't get why disabling something twice is anyhow related to
>>>>>> "temporarily disable". One disable is enough for temporary or permanent
>>>>>> disables.
>>>>>
>>>>> It clearly shows that this was done on purpose and indicates which
>>>>> properties need to be changed to "okay" once we have actual support.
>>>>
>>>> No, it shows nothing clearly as from time to time we got duplicated
>>>> properties and it's a simply mistake. The double disable without any
>>>> comment looks like mistake, not intentional code.
>>>
>>> It's not a mistake. It's intentional. And I don't want to spend hours on
>>> this because of someone else's cock-up.
>>
>> To you it looks intentional, but for the reader of DTS which has
>> disabled node in DTSI and in DTS - so in two places - it looks like a
>> pure bug. Just because you know the reason behind the change does not
>> make the code readable.
> 
> Calling a (temporary) redundant property a 'pure bug' seems like a bit
> of stretch, and it has nothing to do with readability.

Redundant properties is not a code which we want to have anywhere. Why
you are so opposed to documenting this oddity?

> 
>>>>>>>
>>>>>>> Once we have driver support, these properties will be updated again.
>>>>>>
>>>>>> Linux kernel is not the only consumer of DTS, thus having or not having
>>>>>> the support in the kernel is not reason to disable pieces of it.
>>>>>> Assuming the DTS is correct, of course, because maybe that's the problem?
>>>>>
>>>>> Okay, let's revert these sound dts changes then until we have support.
>>>>> We have no idea if the dts changes are correct as sound still depends
>>>>> on out-of-tree hacks.
>>>>>
>>>>> People are using -next for development and I don't want to see them
>>>>> toast their speakers because we failed get the dependencies merged
>>>>> before merging the dts changes which is how we normally do this.
>>>>
>>>> If the error is in DTS, yeah, revert or disable is a way. But if the
>>>> issue is in the incomplete or broken Linux drivers, then these should be
>>>> changed, e.g. intentionally fail probing, skip new devices, drop new
>>>> compatible etc.
>>>
>>> And how long does it take for that to propagate and isn't the response
>>> just going go to be "well then fix the driver".
>>>
>>> I think you're just being unreasonable here.
>>
>> I did not propose to fix the driver. I proposed to fail the driver's
>> probe or remove the compatible from it.
>>
>> Such change propagate the same speed as DTS change.
> 
> But the DTS changes are in Bjorn branch and Bjorn and I discussed it and
> decided to disable them temporarily instead of reverting.
> 
> Now you're asking me to figure out all the dependent driver and patch
> them individually. And this may not reach next before the DTS changes
> do.

Users do not work on linux-next. linux-next is integration tree for
developers. Pretty often broken and not stable, so anyone using it
accepts the risks. Using now linux-next argument for a change is not
appropriate. The change should be reasonable regardless of users of
linux-next.

> 
>>> If Bjorn could rebase his tree, he could simply drop these for now as
>>> sound support was clearly not ready. Since that isn't the case we need
>>> to at least try to be constructive and figure out a reasonable
>>> alternative. While "Linux isn't the only consumer" is a true statement,
>>> it really is not relevant just because there are some dts changes in
>>> Bjorn's tree which should not be there.
>>
>> The SC8280XP audio DTS looks in general correct, except some style
>> issues, redundant properties and never tested against DT bindings.
>> Therefore it looks as accurate and more-or-less correct representation
>> of the hardware, unless you have some more details on this.
> 
> Only that the drivers fail to probe in multiple ways, some which may
> require updating the bindings to address. 

I don't think there is anything needed to fix in bindings in
incompatible way. I was working on them as well (for HDK8450) and I
don't recall any issues.

If you see anything specific, use specific arguments, because otherwise
it is just FUD.

> There's also an indication
> that some further driver support is needed for proper speaker
> protection. That really should be in place before we enable this.

There is easy solution for this - drop the compatible from drivers. Or
if driver is SC8280xp specific, mark it as BROKEN in Kconfig. Or fail
the probe so it won't bother your system.
Best regards,
Krzysztof

