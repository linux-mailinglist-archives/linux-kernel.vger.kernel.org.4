Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5A264BC91
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 20:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236680AbiLMTAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 14:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236674AbiLMS75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 13:59:57 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A91922B11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 10:59:56 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id g7so6508071lfv.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 10:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=niE9Gl1g7coSiv+o7hzU6IeDDQuCZTc7hB6J3K6GqeQ=;
        b=MuUJRLtq2dNP5ghSyqTKd3xlOhgSYwZpXmg/dZdZpmiErBcTPtVOUuELUDjICWmRVv
         fGpiuxW89ADVyBEQNoyMnhWCScFklpxbShDEjZKe/vgRocXT5SapjGL+7YMCrHyUuGE2
         CvGV4lATVQ5N2LzDWCZW1FqjKu8Q8edkxFsZOunWpxC4CRA2AA1LdRR8GAKlkP5saeVv
         KOmYesDEbwHDprWMj2k0gOoz3ZltgpvlVbRG9zjEXG4QDmHMY2+5yJFOWs/NasYhoItU
         6Zhc4/13o2bp9fRsouPv0B/7JKhj+5zxwMx3xnzlmNDxnt81GACVNy1WnQXlC9Hqb667
         XJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=niE9Gl1g7coSiv+o7hzU6IeDDQuCZTc7hB6J3K6GqeQ=;
        b=Bgxmp5swjNJjgqYOL7UNHH+mQTT0jLULDnfP2mTb2fl+4DTHVPH40ul6/iMDy7Hu11
         +h8jEM7/XPdD1FLVsIgUpVABjWReNLEgfldL4NveY08HrnflMKJ90/m9g9GA6iKVAyWE
         QvuYb3QRBYR0mFUnbYNoeFwanbHXXbwTSxGy7coIdVI9eqoKCDahMFr5kixkL1QTDso+
         WozWA4uPRMffNI0Y4/RyWYJgaYALKiv3wFjAerdKabna4o/4nc1cnHBxy8HfWasL+vMP
         AbmYFhDd/XfdQ61z6E1NWPRV9yNbYDp6XUbh6mJF4HKoux/MRfrAPJD6Ryu64aNI8Jp8
         Z6vw==
X-Gm-Message-State: ANoB5pnTtMMlFveeMQg2gk/G9Vlp9zP0b1qtKhQ6oRsGsXLkF+ERxEHF
        AcKIPELni1wmLXpTS0CyFuKPtw==
X-Google-Smtp-Source: AA0mqf6Rs/MAH5dsj8hMiWJjVJ9jvgmpiwkqL6TjlYQFmFIkqvk04wbEUP/YiOytSkc0q6UwRoX8pg==
X-Received: by 2002:a19:550a:0:b0:4aa:114d:1fd7 with SMTP id n10-20020a19550a000000b004aa114d1fd7mr5151357lfe.19.1670957994647;
        Tue, 13 Dec 2022 10:59:54 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v11-20020ac258eb000000b004b5831b69dcsm467299lfo.140.2022.12.13.10.59.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 10:59:54 -0800 (PST)
Message-ID: <ecb2c9ff-b092-22fa-c91e-01ead6266457@linaro.org>
Date:   Tue, 13 Dec 2022 19:59:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm6115: Add USB SS qmp phy node
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, andersson@kernel.org
References: <20221213123823.455731-1-bhupesh.sharma@linaro.org>
 <20221213123823.455731-4-bhupesh.sharma@linaro.org>
 <39ff2174-6d04-ec21-b762-377ed28088cb@linaro.org>
 <CAH=2NtwUODvzLx=JThuZpADv+x+NtLx688Ox-95b_T9PtRf4_w@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAH=2NtwUODvzLx=JThuZpADv+x+NtLx688Ox-95b_T9PtRf4_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 13/12/2022 19:52, Bhupesh Sharma wrote:
> Hi Krzysztof,
> 
> On Tue, 13 Dec 2022 at 18:26, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 13/12/2022 13:38, Bhupesh Sharma wrote:
>>> Add USB superspeed qmp phy node to dtsi.
>>>
>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 38 ++++++++++++++++++++++++++--
>>>  1 file changed, 36 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>> index e4ce135264f3d..9c5c024919f92 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>> @@ -579,6 +579,40 @@ usb_hsphy: phy@1613000 {
>>>                       status = "disabled";
>>>               };
>>>
>>> +             usb_qmpphy: phy@1615000 {
>>> +                     compatible = "qcom,sm6115-qmp-usb3-phy";
>>> +                     reg = <0x01615000 0x200>;
>>> +                     #clock-cells = <1>;
>>> +                     #address-cells = <1>;
>>> +                     #size-cells = <1>;
>>> +                     ranges;
>>> +                     clocks = <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
>>> +                              <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
>>> +                              <&gcc GCC_AHB2PHY_USB_CLK>;
>>> +                     clock-names = "com_aux",
>>> +                                   "ref",
>>> +                                   "cfg_ahb";
>>> +                     resets = <&gcc GCC_USB3_PHY_PRIM_SP0_BCR>,
>>> +                              <&gcc GCC_USB3PHY_PHY_PRIM_SP0_BCR>;
>>> +                     reset-names = "phy", "phy_phy";
>>> +                     status = "disabled";
>>
>> Hm, you add a disabled PHY which is used by existing controller. The
>> controller is enabled in board DTS, but new PHY node isn't. Aren't you
>> now breaking it?
> 
> The USB controller is connected to two PHYs - one is HS PHY and the other is SS
> QMP Phy. So while the exiting board dts describes and uses only the HS
> PHY, newer
> board dts files (which will soon be sent out as a separate patch),

Then I miss how do you narrow the existing DTS to use only one PHY. I
don't see anything in this patchset.

> will use both the HS and SS
> USB PHYs.
> 
> So, this will not break the existing board dts files.

I still think it will be. The board boots with USB with one phy enabled
and one disabled. The driver gets phys unconditionally and one of them
is disabled.

Even if Linux implementation will work (devm_usb_get_phy_by_phandle will
return -ENXIO or -ENODEV for disabled node), it is still a bit confusing
and I wonder how other users of such DTS should behave. Although it will
affect only one board, so maybe there are no other users?

Best regards,
Krzysztof

