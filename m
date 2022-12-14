Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E85F64C674
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 10:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238047AbiLNJ43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 04:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238055AbiLNJ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 04:56:22 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3ED2DEB4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 01:56:20 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id q6so9500669lfm.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 01:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aNJNTOII/kcONJd8CaNcXxHzCuywHLZopRKDpGjPQGY=;
        b=I2ZYbEUz/VnpqOOO9tLIGFPE++82w7iP+LU8JFd5EAl5dEsxMlntD+vTpOtmeINzKk
         xLJ7Kt7W2MyRT+ZwBwDGJLY0UbNNBnQx2sqJ2KxsVtlVRrOcSWklj4JbYfZ+IwqjAfl4
         jzTXG+olvbujK5q4FfGwLItl3Qpi1qJtMNZMVb0kphfCXUENQ16qLzoXuouKTrGfTJNe
         m9Dhy5D59N1UJSZTdaJggEEAowq3H/3mbcZJzuTbapyCkt1d8+HNArH0zNwx5g7aMuPc
         T7e9PDffMRHodpazN/LoMIcHZJQazT46dRaFzmAh3w+pk2KVBmlkK9mOzbK1ty7Ql6lT
         r5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aNJNTOII/kcONJd8CaNcXxHzCuywHLZopRKDpGjPQGY=;
        b=Ql0+zvpytBICi6u+bB25N7EzCVg2X2xx8pZcvXtLYhc/X64p19AypNqYq6jxrJgf38
         Sb/o4D6qVa6cEe7/pIwF7kPRgPHAhuYGqd12Cpzgf5pxLiDwPwDD28WSy3+YGbVoSfyr
         gSj5xkQ8b0nDjex1qFMBM8KlgoQMIqoioyr8wqDWgPdlRZ7AIHXXV5lefguWZGfe09rF
         8GGEy/wB7WajPIjyviPHB3aiWeFzMLHbnptOWedQRh2wrAdRqHlBOtFR7jP2mI+USoAm
         I5wIP5vIYKdL4QKCw5RnjmELMn9mspqiEdSMJC01Ks0kZ8/PGhzIp40fV6NQ03UfknLo
         6Sng==
X-Gm-Message-State: ANoB5plTA7Uv04uRbed0jnA9yPxA6cFvOeMX7BjoMEND/a8g3JSuc6Q+
        g8yJEW/3utuNJ3/oT374/2kwXw==
X-Google-Smtp-Source: AA0mqf4xW64tVM5DPefPl+m+tqJT3zPBAIQOsntrDEuumQIYumNk5ua9B4HLuOQeoT7ewEkVS0u9RQ==
X-Received: by 2002:a05:6512:39d2:b0:4b6:fdc3:a65f with SMTP id k18-20020a05651239d200b004b6fdc3a65fmr1987539lfu.11.1671011779131;
        Wed, 14 Dec 2022 01:56:19 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id w3-20020a05651234c300b004a9b9ccfbe6sm746744lfr.51.2022.12.14.01.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 01:56:18 -0800 (PST)
Message-ID: <c428b894-6c6c-bd26-6815-ca8c091c6ac5@linaro.org>
Date:   Wed, 14 Dec 2022 10:56:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm6115: Add USB SS qmp phy node
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        andersson@kernel.org
References: <20221213123823.455731-1-bhupesh.sharma@linaro.org>
 <20221213123823.455731-4-bhupesh.sharma@linaro.org>
 <39ff2174-6d04-ec21-b762-377ed28088cb@linaro.org>
 <CAH=2NtwUODvzLx=JThuZpADv+x+NtLx688Ox-95b_T9PtRf4_w@mail.gmail.com>
 <ecb2c9ff-b092-22fa-c91e-01ead6266457@linaro.org>
 <CAH=2NtynGaNH+wm-wavj=NsGFQrWVHqjYmivN2nuq-YSXFs0tw@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAH=2NtynGaNH+wm-wavj=NsGFQrWVHqjYmivN2nuq-YSXFs0tw@mail.gmail.com>
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



On 14.12.2022 06:20, Bhupesh Sharma wrote:
> On Wed, 14 Dec 2022 at 00:29, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 13/12/2022 19:52, Bhupesh Sharma wrote:
>>> Hi Krzysztof,
>>>
>>> On Tue, 13 Dec 2022 at 18:26, Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 13/12/2022 13:38, Bhupesh Sharma wrote:
>>>>> Add USB superspeed qmp phy node to dtsi.
>>>>>
>>>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>>>>> ---
>>>>>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 38 ++++++++++++++++++++++++++--
>>>>>  1 file changed, 36 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>>> index e4ce135264f3d..9c5c024919f92 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>>> @@ -579,6 +579,40 @@ usb_hsphy: phy@1613000 {
>>>>>                       status = "disabled";
>>>>>               };
>>>>>
>>>>> +             usb_qmpphy: phy@1615000 {
>>>>> +                     compatible = "qcom,sm6115-qmp-usb3-phy";
>>>>> +                     reg = <0x01615000 0x200>;
>>>>> +                     #clock-cells = <1>;
>>>>> +                     #address-cells = <1>;
>>>>> +                     #size-cells = <1>;
>>>>> +                     ranges;
>>>>> +                     clocks = <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
>>>>> +                              <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
>>>>> +                              <&gcc GCC_AHB2PHY_USB_CLK>;
>>>>> +                     clock-names = "com_aux",
>>>>> +                                   "ref",
>>>>> +                                   "cfg_ahb";
>>>>> +                     resets = <&gcc GCC_USB3_PHY_PRIM_SP0_BCR>,
>>>>> +                              <&gcc GCC_USB3PHY_PHY_PRIM_SP0_BCR>;
>>>>> +                     reset-names = "phy", "phy_phy";
>>>>> +                     status = "disabled";
>>>>
>>>> Hm, you add a disabled PHY which is used by existing controller. The
>>>> controller is enabled in board DTS, but new PHY node isn't. Aren't you
>>>> now breaking it?
>>>
>>> The USB controller is connected to two PHYs - one is HS PHY and the other is SS
>>> QMP Phy. So while the exiting board dts describes and uses only the HS
>>> PHY, newer
>>> board dts files (which will soon be sent out as a separate patch),
>>
>> Then I miss how do you narrow the existing DTS to use only one PHY. I
>> don't see anything in this patchset.
>>
>>> will use both the HS and SS
>>> USB PHYs.
>>>
>>> So, this will not break the existing board dts files.
>>
>> I still think it will be. The board boots with USB with one phy enabled
>> and one disabled. The driver gets phys unconditionally and one of them
>> is disabled.
>>
>> Even if Linux implementation will work (devm_usb_get_phy_by_phandle will
>> return -ENXIO or -ENODEV for disabled node), it is still a bit confusing
>> and I wonder how other users of such DTS should behave. Although it will
>> affect only one board, so maybe there are no other users?
> 
> Ah, now I get your point. So how does the following fix in
> sm4250-oneplus-billie2.dts look like. It allows the base dtsi to carry
> the usb nodes as exposed by the SoC and allows other board dts files
> to use both the USB2 and UBS3 PHYs.
> 
> Please let me know.
> 
> --- a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> +++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> @@ -232,6 +232,9 @@ &usb {
>  &usb_dwc3 {
>         maximum-speed = "high-speed";
>         dr_mode = "peripheral";
> +
> +       phys = <&usb_hsphy>;
> +       phy-names = "usb2-phy";
>  };
Looks good now!

Konrad
> 
> Thanks.
