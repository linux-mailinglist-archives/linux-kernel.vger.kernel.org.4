Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E736E7081DF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 14:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjERMyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 08:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjERMyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 08:54:23 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696991710
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 05:54:20 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4eed764a10cso2413823e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 05:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684414458; x=1687006458;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGL7tJe2R/pndMei8Z26s8Ep8SxlOSmhM3gTp42yw60=;
        b=AVhW7b0P29X0NK1I9toFEUORHktkndMoSvpgXM6F4WHuaFgyC9TdMps3/28rbuM252
         6ZPNq8jMaFksN3eaE2ePEj9wuRDZ4MtCsSoqR3n0oEzlvwxFJ/eTsIvnyTK74K9m0N8j
         305Xl/YjvEhqpdfBGo3Kox7u/N6UZURx9aww2sBQQdMEFCg1g+JmYE1f6zXANdgLVarf
         7w5uxf11vaKSxYjtk34AtHhdjkDZAtxtTuUzQToAQlbid9pc+RCEzm0a3EMPRKZA9/P4
         kEb+fveOAbSuTt+DWUXfpy5bWvznc0Be3SA1Ia97MymX1j7my8ujxOjGQY1Qi+PtTdjs
         isoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684414458; x=1687006458;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kGL7tJe2R/pndMei8Z26s8Ep8SxlOSmhM3gTp42yw60=;
        b=MoMoi+fVzpd3JUL/dugyzCV+SzBaqRUpky1tDuvydr6YusX8hGdC/oiBWsLgr9u/1b
         ng+b1FaS4UAt8oDph0E/MneNVeZ4270leSewQtGhRsheMWuiTLrzdLiaJQs3f+nvV3rT
         mu2Tc1erK/JEi19qExKyWMwdHhc2+ksEi/xLOo3J+1x35EMHgbaoQDORGlZEn/FkN10y
         izfe2xnBaJkmeTYxzBWCbS9cgrEeUzcxxwLZfCasDUnoffaZQt+OecRtEAidPGgMhvkO
         oA7c4IIZXf/3nDpdAVUWnmCjH90FzNRanwSP+mn9OvO592tR2FZA9CRZEBKPb7+Lj+bx
         FVqQ==
X-Gm-Message-State: AC+VfDxXzm5oKk/c11/UQ6IlalpCOeJkOn6cxSyaS8E6PsL84m7Xihzw
        A2TlJRLf20PVqnIsiDGAXYdpFg==
X-Google-Smtp-Source: ACHHUZ4I+0QfRj0+aaSKBVXQKrDgPq5R6zxH1tPybkLd+nFZs3mFrEE18x3NAEF9VgihacTcGL8pTg==
X-Received: by 2002:ac2:47e7:0:b0:4e6:9b01:b92b with SMTP id b7-20020ac247e7000000b004e69b01b92bmr1148731lfp.67.1684414458618;
        Thu, 18 May 2023 05:54:18 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id x7-20020ac24887000000b004f13c00dd9bsm239318lfc.135.2023.05.18.05.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 05:54:18 -0700 (PDT)
Message-ID: <fb58c20e-ad2c-5398-ad69-8e01de58fc02@linaro.org>
Date:   Thu, 18 May 2023 14:54:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Cc:     Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230328-topic-msgram_mpm-v2-0-e24a48e57f0d@linaro.org>
 <20230328-topic-msgram_mpm-v2-1-e24a48e57f0d@linaro.org>
 <168069726278.2356075.14351594478003012447.robh@kernel.org>
 <20230405134727.GA2461305-robh@kernel.org>
 <1e6e2590-ac78-400b-35ce-321d5e52f385@linaro.org>
 <9df12111-ec84-c4f7-fbcb-bccaef91b048@linaro.org>
 <3ce9b5ec-8b02-537a-c663-c849e80cab66@linaro.org>
 <ZDAAToSzNLVo6le8@gerhold.net>
 <198523f5-d06f-15cd-af6c-f391c02bcaa9@linaro.org>
 <1f8fc036-380b-0a42-bb29-a3e275ed6a33@linaro.org>
 <2e648a97-083e-8ee2-1695-4af299bb222a@linaro.org>
 <15f48b06-a6be-1295-5deb-d3594bce6699@linaro.org>
 <ec32fc8e-56e0-51a5-dd96-c7cc8b9cf71f@linaro.org>
 <6a9b1c25-2e17-a657-3a58-b2ff8d1c86d7@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: interrupt-controller: mpm: Pass MSG
 RAM slice through phandle
In-Reply-To: <6a9b1c25-2e17-a657-3a58-b2ff8d1c86d7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.04.2023 10:50, Krzysztof Kozlowski wrote:
> On 12/04/2023 19:06, Konrad Dybcio wrote:
>>
>>
>> On 12.04.2023 18:53, Krzysztof Kozlowski wrote:
>>> On 12/04/2023 14:09, Konrad Dybcio wrote:
>>>>
>>>>
>>>> On 12.04.2023 13:55, Krzysztof Kozlowski wrote:
>>>>> On 12/04/2023 13:47, Konrad Dybcio wrote:
>>>>>>> For unrelated reasons I actually have some patches for this, that switch
>>>>>>> the /smd top-level node to a "remoteproc-like" node dedicated to the
>>>>>>> RPM, similar to how WCNSS/ADSP/Modem/etc are represented. I need this to
>>>>>>> add additional (optional) properties like "resets" and "iommus" for the
>>>>>>> RPM, but it would allow adding arbitrary subnodes as well:
>>>>>>>
>>>>>>> https://github.com/msm8916-mainline/linux/commit/35231ac28703805daa8220f1233847c7df34589e
>>>>>>>
>>>>>>> I could finish those up and post them if that would help...
>>>>>> Krzysztof, what do you think?
>>>>>
>>>>> I don't know what is there in MSM8916 and how it should be represented.
>>>> Similarly to other Qualcomm SoCs, MSM8916 has a RPM (Cortex-M3) core,
>>>> which communicates over the SMD protocol (or G-LINK on >=8996).
>>>>
>>>> The Qualcomm firmware loads the RPM fw blob and sets it up early in
>>>> the boot process, but msm8916-mainline folks managed to get TF-A
>>>> going and due to it being less.. invasive.. than the Qualcomm TZ,
>>>> RPM needs a bit more handling to be accessible.
>>>>
>>>> The M3 core is wired up through the CNoC bus and we communicate
>>>> with it through the MSG RAM and the "APCS mailbox".
>>>
>>> Thanks, that's actually good description. Yet I still do not know what
>>> is exactly the problem and the question. Linking some out of tree
>>> commits does not give me the answer, at least I cannot get that answer
>>> form the link.
>>>
>>> For example what I don't understand is: why additional resources (like
>>> resets) can be provided only in new binding, but not in the old.
>> The old binding dictates that the rpm node (which in turn
>> holds all "devices" that only interface with RPM, like RPMCC) is
>> a child of smd{}, which does not make sense logically, as SMD is
>> a protocol (e.g. we don't place devices connected over i2c under
>> /i2c{}).
> 
> We do. All devices connected over I2C are under i2c node which is the
> controller. The example is different than what you have here...
> 
>>  The rpm node lacks a compatible, as it's representing
>> an "smd channel", so there's no driver so there's no way to assert
>> resets etc.
> 
> You have rpm-requests which has compatible. These are not its resources?
I believe we misrepresented this 10y ago and now we're stuck with that
legacy..

Currently we have:

[1]
smd {
	rpm {
		rpm-requests {
			compatible = "qcom,rpm-msm8916"

or

[2]
rpm-glink {
	rpm-requests {
		compatible = "qcom,rpm-sm6375"


In the case of [1], 'smd' is a communication protocol and the 'rpm'
node describes the RPM's "smd edge" (think a communication channel
assigned to the RPM processor)


In the case of [2], rpm-glink is also just a description of the G-LINK
communication protocol/"bus" (putting bus in quotes, as GLINK is really a
very very fancy set of mailboxes)

So we've really been describing the protocols and not the hardware buses..

What Stephan and I were trying to say, is that there's no great node that
actually represents the Cortex-M3 RPM core itself.

The rpm-requests node is the closest, but it won't fit his purpose, as it 
depends on the communication with the CM3 already being active - it will
only get registered through qcom_glink_rx_open / qcom_channel_state_worker
for GLINK/SMD respectively. These channels will only be open if the core
is up, but for that to happen its reset line must be deasserted.

Stephen proposed restructuring that to be centered around the CM3 core and
not the communication protocol.

I know you're not very fond of downstream tree commits, but looking at his
branch, I think that's it:

https://github.com/msm8916-mainline/linux/commit/e4e90fd3f711295461ee17891567e75e2342e5c8

I'd be in favour of such restructurization - makes things much more clear
and sane.

Stephen, if you're willing to do it, I can test your patches on both GLINK
and SMD platforms.

> 
>>
>> On newer SoCs that still implement SMD RPM (like 8996), we do
>> actually have a driver and a parent node which it binds to
>> (rpm-glink).
> 
> You want to add RPM resets to rpm-glink node? This also does not look right.
No, I was just pointing out that rpm-requests' direct parent node has a
driver bound to it in case of GLINK but not in the case of SMD


> 
>>
>> AFAIU:
>> In both cases, the "final" drivers (rpmcc, rpmpd..) are bound
>> after hitting a SMD/GLINK callback that tells Linux we're ready
>> to rock. That's an issue for Stephan, as these callbacks won't
>> ever happen if the RPM core is not initialized (and TF-A doesn't
>> do that).
> 
> To me half or almost all of Qualcomm remote-proc-related bindings, like
> SMD, GLINK and associated processors, are difficult to read, half-baked
> and developed to match the current Linux/SW need.
Agreed :/

When the Linux drivers
> changed, new bindings were added... If you want to fix it, sure go
> ahead, but design everything to match something rational, not again to
> match one specific SW/FW implementation.
I don't think it's worth the hassle.. we may add it to the "we'll fix it
when we eventually find some gamebreaking issue that requires us to break
the 10yo backwards compatibility for some deep core driver, if that happens"
list..

Konrad
> 
> Best regards,
> Krzysztof
> 
