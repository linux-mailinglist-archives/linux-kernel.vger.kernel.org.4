Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B657122AB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 10:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242804AbjEZIvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 04:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242614AbjEZIu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 04:50:59 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490B5119
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 01:50:56 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f3ba703b67so451460e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 01:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685091054; x=1687683054;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFgq2+VVrviL7UALj9pqiFm5m6vdqKFWr7xuBpXEGgk=;
        b=ME1+1zcdcnrW6W4YFgkJY1I+UtG6/knxC7rNTHRZcgSM65ZRaaM3RkNSBBfDbBa6FU
         jw/VX2m07hj8QVYd2l74yQUINdMLICa9Oh4jqTlcVTA03+F9s3TdNzDcQIzxUdo40B9d
         p/O8jNChmQHvRz4y2q7Oe8OzM2C2vfiNu0I+OUyqFXtkKwCX9c1yH8ViS4T6P3FC6SyT
         NXF5XEPuQ3qeUM4dfs/pS88L7OJOsZE5uOeI7h6OsFYioA53ZA0vO9VC4NYpDB11xS9/
         MzgWJuFbwum+WYKpWuVHsfpXi7+TAlqfG4Fr9XeObmZCsNWvF/W1mrLQnon99FphY4ix
         raHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685091054; x=1687683054;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vFgq2+VVrviL7UALj9pqiFm5m6vdqKFWr7xuBpXEGgk=;
        b=TYUYZzv+fnfW9kpToaP2IkPj0n40fPj5GqPbftXm7dZYsFVn/9EjIRyEKzWPnEdDZe
         hrCNFbWTIaBRcwokMYFUsRaY9mmwpAT/B3U2d4mtJFUF9BDiXQKkN1cnmvEN0t/xVb7p
         suHSenlPIRCgFQOxjjxe8ZuKz7dLC36f07ZUhvHLgeokTJria/2Ne5zErnVglqHtissw
         lUz1QT/j4MN4Bv1zfD82d4z8YO1iWaE+VXeSdLwIIJvc1mnuUXr64Tv+s4TZE074ojs4
         5i3EXgFCZsDRT67P/d7Utyi5JBnplrT5nfJMl396zDC239qGeWNqToSMvLaW+EkK314L
         wTpw==
X-Gm-Message-State: AC+VfDynIgEvmHgqO/p4bhwn4EZE20YJDVgleU5BTyqi4LI/xPv5xJd9
        ZAbjvZ3QOxYQzZz6Exj7D7VBOPtEAP9oTZ5LoFE=
X-Google-Smtp-Source: ACHHUZ6SBk/LbQLpRdgponALylw72ijErfTNlvdTRC9EnogFDghqyrnhNRt206k+lEMedSeVjT/SeQ==
X-Received: by 2002:ac2:4571:0:b0:4f3:f98c:77fc with SMTP id k17-20020ac24571000000b004f3f98c77fcmr307628lfm.8.1685091054513;
        Fri, 26 May 2023 01:50:54 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id d16-20020ac25450000000b004f3b2d3fc25sm542344lfn.10.2023.05.26.01.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 01:50:54 -0700 (PDT)
Message-ID: <41f5b7a9-d927-e468-d1ea-291ad35ba943@linaro.org>
Date:   Fri, 26 May 2023 10:50:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230510-msm8916-regulators-v1-0-54d4960a05fc@gerhold.net>
 <20230510-msm8916-regulators-v1-8-54d4960a05fc@gerhold.net>
 <ea53525b-749b-25e2-6dde-662a8e273597@linaro.org>
 <ef7b7335-d20c-3ddc-52df-b2801fa40283@linaro.org>
 <ZHBTi-j657tW3jIu@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 8/8] arm64: dts: qcom: msm8916-pm8916: Mark always-on
 regulators
In-Reply-To: <ZHBTi-j657tW3jIu@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.05.2023 08:36, Stephan Gerhold wrote:
> On Fri, May 26, 2023 at 02:28:52AM +0200, Konrad Dybcio wrote:
>> On 26.05.2023 01:39, Konrad Dybcio wrote:
>>> On 17.05.2023 20:48, Stephan Gerhold wrote:
>>>> Some of the regulators must be always-on to ensure correct operation of
>>>> the system, e.g. PM8916 L2 for the LPDDR RAM, L5 for most digital I/O
>>>> and L7 for the CPU PLL (strictly speaking the CPU PLL might only need
>>>> an active-only vote but this is not supported for regulators in
>>>> mainline currently).
>>> Would you be interested in implementing this?
> 
> At least on MSM8916 there is currently no advantage implementing this.
> The "active-only" votes only have the CPU as limited use case. S1 (aka
> MSM8916_VDDCX) and L3 (MSM8916_VDDMX) are both used via rpmpd/power
> domains which already provides separate active-only variants. L7 (for
> the CPU PLL) is the only other regulator used in "active-only" mode.
> However, at least on MSM8916 L7 seems to stay always-on no matter what I
> do, so having an active-only vote on L7 doesn't provide any advantage.
In this case it may be more important that we tell RPM that we want it
to be active-only, even if it ultimately makes a different decision.
You probably played with this more, but my guess would be that not letting
off of an a-s vote could confuse the algos

> 
>> Actually, I think currently all votes are active-only votes and what
>> we're missing is sleep-only (and active-sleep if we vote on both)
> 
> If you only send the "active" votes but no "sleep" votes for a resource
> then the RPM firmware treats it as active+sleep, see [1].
> The active/sleep separation only starts once a separate sleep vote has
> been sent for a resource for the first time.
> 
> Therefore, all requests from the SMD regulator driver apply for both
> active+sleep at the moment.
> 
> [1]: https://git.codelinaro.org/clo/la/kernel/msm-3.10/-/blob/LA.BR.1.2.9.1-02310-8x16.0/drivers/regulator/rpm-smd-regulator.c#L202-204
/me *dies*

that's a design decision if i've ever seen one..

> 
>>>
>>> Ancient downstream defines a second device (vregname_ao) and basically
>>> seems to select QCOM_SMD_(ACTIVE/SLEEP)_STATE based on that..
>>>
>>> Looks like `struct regulator` stores voltage in an array that wouldn't
>>> you know it, depends on the PM state. Perhaps that could be something
>>> to explore!
>>>
> 
> Don't get confused by the similar naming here. RPM sleep votes are
> unrelated to the "system suspend" voltages the regulator framework
> supports. :)
> 
> RPM sleep votes become active if the cpuidle reaches the deepest state
> for the (cpu/)cluster(/CCI). This can happen anytime at runtime when the
> system is idle long enough. On the other hand, the regulator suspend
> voltages are meant to become active during system suspend (where all the
> devices get suspended as well).
Yes and pm_genpd tracks that very meticulously, at least in the case of PSCI.

> 
> Since we do have "active-only" support in rpmpd I think the question is
> if it is worth bringing the feature also to regulators. Perhaps one
> could simply treat all regulators that are needed by the CPU as power
> domain.
That would make sense..

> 
> For example, L7 on MSM8916 is fixed at 1.8V so while it doesn't have
> corners the simple enable/disable votes could also be sent via rpmpd.
> In some places in downstream L7 is also called VDDPX, similar to
> VDDCX and VDDMX which are already in rpmpd.
Yeah, anything available from RPM is only vaguely categorized as being
a clock/regulator/bus, sometimes wrongly (see: bus clocks in rpmcc) so
there's some flexibility here.

Konrad
> 
> Thanks,
> Stephan
