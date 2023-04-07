Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51056DAD6D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240784AbjDGN1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240519AbjDGN1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 09:27:17 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05D8A27B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 06:27:13 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id g29so4627318lfj.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 06:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680874032;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CMS58S0zRr0RBsuH0FUy+WC/JEamPVFrvmqlnUgullw=;
        b=q+Hn6eEk4bLUPus4fBt4715Hy9Fj6bzImQBHQqMlmBvO6lKWrYb5LPyPwz64ylZay6
         sNVvjPeeuk53/ZLj93ZsQs4F+Gcmr9T9GG7IDYn9IdGIYaxeZ1R6g/RK53eCmh4eRonO
         5vswpBfaJeo3ejh7EGnjkZwE7Xud3Y4GFLTHRE6P0hRJxM72Xcb13hmg/BCBMKxTJH1h
         IBUmybj5YMpw8fF0VtAbwPgOuDpfvcd3C4wvKcrHWlXzZ0g4NvF4OfXFx5eqWFV9wQxJ
         DfnXswpvw5UHFBzMgBfse+lqEmbXfIxJohQCG5b+jQK+etanZOrNHFTAvo43ZFPV19Pv
         sZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680874032;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CMS58S0zRr0RBsuH0FUy+WC/JEamPVFrvmqlnUgullw=;
        b=UgFLs3bWvAFxJnfgbOBvTbvBnOMHHB/mdfJbcCAHdk6dLTyDRMKySgcJ8YORWSHEpz
         h8tB1W+o535cKdsgSL1FfAVaJpZIDu87zbTLXqxhbPSW5LCCCeT71e8ZPOKhGlruRjEP
         u85h+hzcH1z94XWhv8eWRiQdPiRkXA8BnMCvP0ld8em5h2As1a9BOVqTQ7QyQUAgewgT
         KJpLVnpzqLQh5WmwT2ZSgp4bNH9ZqH+Jjgqxdbqn9j4myq2eH87RfZtjG25EREf+drFj
         yifCyIIfPznpRV8K/B6zAyZwuWKQjz6OR5wT3GMVgebqAN2pbPsThEjvBAF1cpys50XB
         anbw==
X-Gm-Message-State: AAQBX9frpVXkcJckRnpzIuiYwKt9kBxqX1Du6RaTKztB/3whON3sBSa7
        vsx0F2UXnA3zYe+YhJA+XXtZWQ==
X-Google-Smtp-Source: AKy350Y/3/7phel9U34KHUDJ11+cY5mHaThhqp/iCmNPO4bPF2mSDqrx4zMDcFz5+tOtCJb7zd6e7w==
X-Received: by 2002:ac2:44ae:0:b0:4eb:982:ad3 with SMTP id c14-20020ac244ae000000b004eb09820ad3mr818826lfm.24.1680874031966;
        Fri, 07 Apr 2023 06:27:11 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id i13-20020a056512006d00b004e83edd8ce8sm709658lfo.196.2023.04.07.06.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 06:27:11 -0700 (PDT)
Message-ID: <32274c8e-43e5-f58d-3d4f-80425d55f5b3@linaro.org>
Date:   Fri, 7 Apr 2023 16:27:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm6115p-j606f: Enable ATH10K WiFi
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230406-topic-lenovo_features-v1-0-c73a5180e48e@linaro.org>
 <20230406-topic-lenovo_features-v1-4-c73a5180e48e@linaro.org>
 <7476b5ba-426c-3701-c4aa-d3e2db3de112@linaro.org>
 <bceb91fa-c94b-a0bf-a612-19fc5778810e@linaro.org>
 <CAA8EJprmzibdarZCKDtAa14HTShxTwQ6FQfi665hbVR_=5MLaQ@mail.gmail.com>
In-Reply-To: <CAA8EJprmzibdarZCKDtAa14HTShxTwQ6FQfi665hbVR_=5MLaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 21:56, Dmitry Baryshkov wrote:
> On Thu, 6 Apr 2023 at 21:32, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>>
>> On 6.04.2023 19:51, Dmitry Baryshkov wrote:
>>> On 06/04/2023 18:25, Konrad Dybcio wrote:
>>>> Enable the onboard QCA Wi-Fi. HW identifiers for reference:
>>>> qmi chip_id 0x320 chip_family 0x4001 board_id 0xff soc_id 0x400e0000
>>>>
>>>> Firmware sources:
>>>> /vendor/firmware_mnt/image/wlanmdsp.bin -> qcom/.../wlanmdsp.mbn
>>>> /vendor/firmware_mnt/image/bdwlan.bXX [1] -> [2] -> ath10k/.../board-2.bin
>>>> [3] -> ath10k/.../firmware-5.bin
>>>>
>>>> Not sure where 3 comes from on the device itself, gotta investigate that..
>>>>
>>>> According to [4], it's called WCN3990_STRAIT.
>>>>
>>>> [1] XX = board_id printed when the file is missing or by your downstream
>>>> kernel firmware loader in the dmesg; if XX=ff, use bdwlan.bin
>>>
>>> Since the board_id is 0xff, please add qcom,ath10k-calibration-variant
>> Do I make up a name, or is there some convention?
>>
>> I see Johan used "LE_X13S" in commit 2702f54f400ad3979632cdb76553772414f4c5e3.
>> Should I go with "LE_P11"?
> 
> I think Lenovo_P11 or LENOVO_P11 might be better.


An update here:

Kalle added a board file for Yoga C630 using the id 
'bus=snoc,qmi-board-id=ff,qmi-chip-id=30214,variant=Lenovo_C630'. So, I 
think, we should use 'Lenovo_P11' here.

> 
>>
>>>
>>> Ideally, could you please send the bdwlan to ath10k for inclusion, see https://wireless.wiki.kernel.org/en/users/drivers/ath10k/boardfiles .
>> The legal situation is ambiguous at best :/
> 
> As usual :-(
> 
>>
>> Konrad
>>>
>>>>
>>>> [2] https://github.com/jhugo/linux/blob/5.5rc2_wifi/README
>>>> [3] https://github.com/kvalo/ath10k-firmware/blob/master/WCN3990/hw1.0/HL3.1/WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1/firmware-5.bin
>>>> [4] https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/wlan/qca-wifi-host-cmn/-/blob/LA.VENDOR.1.0.r1-20700-WAIPIO.QSSI13.0/hif/src/hif_hw_version.h#L55
>>>>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts | 8 ++++++++
>>>>    1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
>>>> index 2aac25171dec..4ba8e59a27d8 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
>>>> +++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
>>>> @@ -315,6 +315,14 @@ &usb_hsphy {
>>>>        status = "okay";
>>>>    };
>>>>    +&wifi {
>>>> +    vdd-0.8-cx-mx-supply = <&pm6125_l8>;
>>>> +    vdd-1.8-xo-supply = <&pm6125_l16>;
>>>> +    vdd-1.3-rfa-supply = <&pm6125_l17>;
>>>> +    vdd-3.3-ch0-supply = <&pm6125_l23>;
>>>> +    status = "okay";
>>>> +};
>>>> +
>>>>    &xo_board {
>>>>        clock-frequency = <19200000>;
>>>>    };
>>>>
>>>
> 
> 
> 

-- 
With best wishes
Dmitry

