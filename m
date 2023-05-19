Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDD6709567
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjESKvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjESKvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:51:44 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A854E66
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:51:43 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2ab3e8f4efeso8407441fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684493501; x=1687085501;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ScXDhSxUJlLB8bM84R+68wogc+rqJq5r2RRK+MTJ+NU=;
        b=Z8ePaJEEAJ1d44ZWVMtQaPnFFAAFJjtgE1a4DYu9XXZwR/vsW6KMijy2rX9+CINVC/
         ceIA7VXMB/WVy6vD884addB3TzMt4cxituZuJCkc/KqE5fiOnDs0FM4IGC+K+Nu2q6FR
         u65no+7ysyDVzWxMUy+Jf3ldBI5UpD7AbzgtfKb6aqJGLwr228gaV7fqymN9Dyze6Vmt
         8FXQnnTfiAdQrM+RHzqdJiSImgqgy8pTTwBHmQxwrVkggZy7DDMtPuw9aHpOKpX/Vgtj
         XdTbfPPt4rM23XoQmPVT4m50LDhcEBJ0ekUL7KhZorE6qDxtIzm7nzME6gg14mqpR4hx
         FNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684493501; x=1687085501;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ScXDhSxUJlLB8bM84R+68wogc+rqJq5r2RRK+MTJ+NU=;
        b=NpTeOd6/rGrvyhfL4yrPS6+eNFSNHoLmM72XbPEZKj8/nZEyHpcAsPGOM5yVqribmY
         FZZLvpEHQbABCg2frx+UkWGUbFodtrb7dy88/z0K9NvKQnvPZmjPebvuZg4RCg7N20XW
         NDyZ+8BrtcJNzsSM1UKSrOLvwef3HkaLApDsjAWoOK/e3mEFVa6ppBFT+OG/FppCeJRl
         7kCsGPwKl+puVlYVFApFPAcWfvfzI9rMJmbu5ebrAMBdBq5C2JaHNF+oUIat5yRnhysK
         9fIdmC04FTTWdMS1WJxDSaos6NJqoiic9PE8nKLPhRlgUIsPtuO+2Jh49esUADWN1Lrb
         neRw==
X-Gm-Message-State: AC+VfDyFOu/LKYsIY3SPBg1EusjFPOOqK7EFT/OblqlL2tnUQJSbFdQm
        WcR4rdtI9f5+wuc2LUxIBamjCQ==
X-Google-Smtp-Source: ACHHUZ7fNE8pZaCdlzbVuTf+/ffBSjRXKTAUPOZ+CEDWu2vtGLTvWrFE8NaZsL+Pk6K2CYcvA2il9g==
X-Received: by 2002:a05:6512:68f:b0:4eb:4157:5704 with SMTP id t15-20020a056512068f00b004eb41575704mr884889lfe.29.1684493501227;
        Fri, 19 May 2023 03:51:41 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id e5-20020a056512090500b004f38411f148sm560865lft.84.2023.05.19.03.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 03:51:40 -0700 (PDT)
Message-ID: <875dec34-35da-e427-ae32-598958762dd2@linaro.org>
Date:   Fri, 19 May 2023 12:51:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 07/11] arm64: dts: qcom: sm6115: Add Crypto Engine
 support
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org, djakov@kernel.org
References: <20230405072836.1690248-1-bhupesh.sharma@linaro.org>
 <20230405072836.1690248-8-bhupesh.sharma@linaro.org>
 <ZGdLCdSof027mk5u@gerhold.net>
 <CAH=2Ntx4H+hOzYLWqiogdBGE+rQ2XayrweE_P8T8gVE0zbwzeg@mail.gmail.com>
 <8c754bc2-abb3-faaa-0ab5-2c1991dfc2a6@linaro.org>
 <CAH=2NtyUNJFMbrhvP9BjmzdsLj9kvSYUH_ueAPUan9GRKaq2Xw@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAH=2NtyUNJFMbrhvP9BjmzdsLj9kvSYUH_ueAPUan9GRKaq2Xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.05.2023 12:49, Bhupesh Sharma wrote:
> On Fri, 19 May 2023 at 16:12, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> On 19.05.2023 12:22, Bhupesh Sharma wrote:
>>> Hi Stephan,
>>>
>>> On Fri, 19 May 2023 at 15:40, Stephan Gerhold <stephan@gerhold.net> wrote:
>>>>
>>>> Hi Bhupesh,
>>>>
>>>> Not sure if this is the latest version of this series since it's pretty
>>>> old but I didn't find a new one. Just came here because you mentioned
>>>> RB1/RB2 [1] in my bam_dma patch and they don't have any BAM defined
>>>> upstream yet.
>>>>
>>>> [1]: https://lore.kernel.org/linux-arm-msm/CAH=2Ntw0BZH=RGp14mYLhX7D6jV5O5eDKRQbby=uCy85xMDU_g@mail.gmail.com/
>>>>
>>>> On Wed, Apr 05, 2023 at 12:58:32PM +0530, Bhupesh Sharma wrote:
>>>>> Add crypto engine (CE) and CE BAM related nodes and definitions to
>>>>> 'sm6115.dtsi'.
>>>>>
>>>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>>>>> ---
>>>>>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 22 ++++++++++++++++++++++
>>>>>  1 file changed, 22 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>>> index 2a51c938bbcb..ebac026b4cc7 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>>> @@ -650,6 +650,28 @@ usb_hsphy: phy@1613000 {
>>>>>                       status = "disabled";
>>>>>               };
>>>>>
>>>>> +             cryptobam: dma-controller@1b04000 {
>>>>> +                     compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
>>>>> +                     reg = <0x0 0x01b04000 0x0 0x24000>;
>>>>> +                     interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
>>>>> +                     #dma-cells = <1>;
>>>>> +                     qcom,ee = <0>;
>>>>> +                     qcom,controlled-remotely;
>>>>> +                     num-channels = <8>;
>>>>> +                     qcom,num-ees = <2>;
>>>>> +                     iommus = <&apps_smmu 0x94 0x11>,
>>>>> +                              <&apps_smmu 0x96 0x11>;
>>>>> +             };
>>>>> +
>>>>> +             crypto: crypto@1b3a000 {
>>>>> +                     compatible = "qcom,sm6115-qce", "qcom,sm8150-qce", "qcom,qce";
>>>>> +                     reg = <0x0 0x01b3a000 0x0 0x6000>;
>>>>> +                     dmas = <&cryptobam 6>, <&cryptobam 7>;
>>>>> +                     dma-names = "rx", "tx";
>>>>> +                     iommus = <&apps_smmu 0x94 0x11>,
>>>>> +                              <&apps_smmu 0x96 0x11>;
>>>>
>>>> Shouldn't you have clocks = <&rpmcc RPM_SMD_CE1_CLK> here to make sure
>>>> the clock for the crypto engine is on? Your binding patch (PATCH 06/11)
>>>> says "Crypto Engine block on Qualcomm SoCs SM6115 and QCM2290 do not
>>>> require clocks strictly" but doesn't say why.
>>>>
>>>> Make sure you don't rely on having rpmcc keep unused clocks on
>>>> permanently. This is the case at the moment, but we would like to change
>>>> this [2]. Adding new users that rely on this broken behavior would just
>>>> make this effort even more complicated.
>>>>
>>>> If you also add the clock to the cryptobam then you should be able to
>>>> see the advantage of my bam_dma patch [3]. It allows you to drop
>>>> "num-channels" and "qcom,num-ees" from the cryptobam in your changes
>>>> above because it can then be read directly from the BAM registers.
>>>
>>> Thanks for pointing this out. Actually that's why I was using your
>>> patch while testing with RB1/RB2 :)
>>>
>>> Yes, so the background is that I am preparing a new version of this
>>> crypto enablement patchset.
>>> Also your assumption about the clocks being turned on by the firmware
>>> is true for RB1/RB2 devices, so enabling them via Linux is optional as
>>> per Qualcomm enggs.
>> This is not necessarily true. Currently it's kept always-on on
>> by clk_smd_rpm_handoff, but that's a hack from 10 years ago when smd
>> was still new.
>>
>>>
>>> So, I am testing the new patchset right now with 'clock' entries
>>> provided in the .dtsi and see if that causes any issue / improvement
>>> (etc.)
>> It won't change since it's on anyway, but that won't be a given for long.
> 
> Right, so that's what I observe: RPM_SMD_CE1_CLK is always on by the
> time crypto _probe gets called.
> So, IMO let's not mix this patchset with the other fix which probably
> will fix the 10-year old clk_smd_rpm handoff keeping
> these clocks on.
> 
> Probably that should be a separate changeset - requiring very thorough
> checks to make sure that we don't break
> working platforms.
It's not about mixing patchsets, the nodes should reflect all the clock/
power-domain/regulator/pinctrl/etc. dependencies from their introduction.
Remember, dt describes the hardware, not the software or firmware.

That - among other things - ensures backwards compatibility can be
preserved.
> 
> Thanks.
