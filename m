Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0FC6DE37D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 20:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjDKSIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 14:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjDKSH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 14:07:59 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D27665B8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 11:07:35 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id d7so22600411lfj.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 11:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681236440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tCaVKyIYDr7B6+tV0gmv84EwP6qqzNHVIpXQWRiUw+o=;
        b=kIUjoXd00ilCumUGhKx9HY/79kXl5KZQP8g5mkEoU1/fUtPfHjAtMyFch6oZW9Dcvu
         V4rOHiAFKymSSLWIKeaW5yQPjmkTxJpHGb7E1bVyAmGBmSSL9PL4ufqDUfzP2n6OPAIo
         W9zWx4kVVwTTEZpfL5DQ+x1+i77sUXwrB/1Lv4PODs0VOLH6pHVcQ6Zp0dJ6rR5uD8iR
         OISdyBb9U/n11uCG0DhfqgKBCXijl5MCicK62MJu33QTfxkxfQD0UdyHOSSUm+rMXLRY
         ec0KCNFErsn11OGET/ugdXXcOCPyQ5BhOvbXz63dc4rV84CF0dQeTEQSjwOaSb9gU8rj
         a+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681236440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tCaVKyIYDr7B6+tV0gmv84EwP6qqzNHVIpXQWRiUw+o=;
        b=wUJDI7q0wZRNK+DGa22jX8cQusBylPmgv0JIg4O9z5n82XI51zGtqFQtiZlfXCfHtZ
         tqQfiE9Q4U+K4CCYYotxuYtNJCiFYXg9u+4eOF+mmqpos6ixwZpRmyI6EQjF5g9dvgSw
         Y/gy4P9MOvKd59fgBuCQdBv6gqZdg0tC2/g2HCP6d8wU+NOHVSnOQLesDazQh2P6SNBi
         qHmdggGPjEi7wLBo+7f8+CwrFkY1zmd/m3v5U27K/Pl+zr6Tf/MzP7aC9iDbA0m79vo0
         1prx9wBGV3J4fTwnGySiPv0JZ5E47jKW+xZVrF/SD12Wb88GDStTqNKFbDwW9lX/Lf61
         vUGQ==
X-Gm-Message-State: AAQBX9dRozNkH2MQpnH6e560RrmMmL+lDjyt6rcsudw8ZdgZe4ik0lgQ
        N5wRgqnkkDpjpZ/pQCN7jymdqQ==
X-Google-Smtp-Source: AKy350bHXgGnTpcZC5nbOtZdmB2vuCdADf2jte23B7ssrnMoWnNsq0XSTG/ROB4fWjATEpGxsN9zjw==
X-Received: by 2002:a05:6512:218e:b0:4ec:63e6:526e with SMTP id b14-20020a056512218e00b004ec63e6526emr3551608lft.65.1681236439615;
        Tue, 11 Apr 2023 11:07:19 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id r1-20020a2eb601000000b0029c36ebf89asm2884142ljn.112.2023.04.11.11.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 11:07:19 -0700 (PDT)
Message-ID: <240fe5c1-9df7-80eb-ce99-b0e1d381c57e@linaro.org>
Date:   Tue, 11 Apr 2023 20:07:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: Add base qrb4210-rb2 board dts
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, andersson@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski@linaro.org
References: <20230411072840.2751813-1-bhupesh.sharma@linaro.org>
 <20230411072840.2751813-3-bhupesh.sharma@linaro.org>
 <9130c1cb-4081-b21c-7c1b-2e0c9879e66a@linaro.org>
 <CAH=2NtzuN-0qgm7Hn6aJN+ZSRROFna09SHThVFbfKGVdsLzNWg@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAH=2NtzuN-0qgm7Hn6aJN+ZSRROFna09SHThVFbfKGVdsLzNWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.04.2023 19:38, Bhupesh Sharma wrote:
> On Tue, 11 Apr 2023 at 18:26, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>> On 11.04.2023 09:28, Bhupesh Sharma wrote:
>>> Add DTS for Qualcomm qrb4210-rb2 board which uses SM4250 SoC.
>>>
>>> This adds debug uart, emmc, uSD and tlmm support along with
>>> regulators found on this board.
>>>
>>> Also defines the 'xo_board' and 'sleep_clk' frequencies for
>>> this board.
>>>
>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>>> ---
>>>  arch/arm64/boot/dts/qcom/Makefile        |   1 +
>>>  arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 223 +++++++++++++++++++++++
>>>  2 files changed, 224 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>>> index e0e2def48470..d42c59572ace 100644
>>> --- a/arch/arm64/boot/dts/qcom/Makefile
>>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>>> @@ -74,6 +74,7 @@ dtb-$(CONFIG_ARCH_QCOM)     += qcs404-evb-1000.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)      += qcs404-evb-4000.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)      += qdu1000-idp.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)      += qrb2210-rb1.dtb
>>> +dtb-$(CONFIG_ARCH_QCOM)      += qrb4210-rb2.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)      += qrb5165-rb5.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)      += qrb5165-rb5-vision-mezzanine.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)      += qru1000-idp.dtb
>>> diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
>>> new file mode 100644
>>> index 000000000000..c9c6e3787462
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
>>> @@ -0,0 +1,223 @@
>>> +// SPDX-License-Identifier: BSD-3-Clause
>>> +/*
>>> + * Copyright (c) 2023, Linaro Limited
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "sm4250.dtsi"
>>> +
>>> +/ {
>>> +     model = "Qualcomm Technologies, Inc. QRB4210 RB2";
>>> +     compatible = "qcom,qrb4210-rb2", "qcom,qrb4210", "qcom,sm4250";
>>> +
>>> +     aliases {
>>> +             serial0 = &uart4;
>>> +     };
>>> +
>>> +     chosen {
>>> +             stdout-path = "serial0:115200n8";
>>> +     };
>>> +
>>> +     vph_pwr: vph-pwr-regulator {
>>> +             compatible = "regulator-fixed";
>>> +             regulator-name = "vph_pwr";
>>> +             regulator-min-microvolt = <3700000>;
>>> +             regulator-max-microvolt = <3700000>;
>>> +
>>> +             regulator-always-on;
>>> +             regulator-boot-on;
>>> +     };
>>> +};
>>> +
>>> +&qupv3_id_0 {
>>> +     status = "okay";
>>> +};
>>> +
>>> +&rpm_requests {
>>> +     regulators {
>>> +             compatible = "qcom,rpm-pm6125-regulators";
>>> +
>>> +             vdd-s1-supply = <&vph_pwr>;
>>> +             vdd-s2-supply = <&vph_pwr>;
>>> +             vdd-s3-supply = <&vph_pwr>;
>>> +             vdd-s4-supply = <&vph_pwr>;
>>> +             vdd-s5-supply = <&vph_pwr>;
>>> +             vdd-s6-supply = <&vph_pwr>;
>>> +             vdd-s7-supply = <&vph_pwr>;
>>> +             vdd-s8-supply = <&vph_pwr>;
>>> +             vdd-s9-supply = <&vph_pwr>;
>>> +             vdd-s10-supply = <&vph_pwr>;
>>> +
>>> +             vdd-l1-l7-l17-l18-supply = <&vreg_s6a_1p352>;
>>> +             vdd-l2-l3-l4-supply = <&vreg_s6a_1p352>;
>>> +             vdd-l5-l15-l19-l20-l21-l22-supply = <&vph_pwr>;
>>> +             vdd-l6-l8-supply = <&vreg_s5a_0p848>;
>>> +             vdd-l9-l11-supply = <&vreg_s7a_2p04>;
>>> +             vdd-l10-l13-l14-supply = <&vreg_s7a_2p04>;
>>> +             vdd-l12-l16-supply = <&vreg_s7a_2p04>;
>>> +             vdd-l23-l24-supply = <&vph_pwr>;
>>> +
>>> +             vreg_s5a_0p848: s5 {
>> I think going with pmicname_regulatorname (e.g. pm6125_s5) here
>> and adding:
>>
>> regulator-name = "vreg_s5a_0p848"
>>
>> would make this more maintainable.
> 
> Ok.
> 
>>> +&sdhc_1 {
>>> +     vmmc-supply = <&vreg_l24a_2p96>;
>>> +     vqmmc-supply = <&vreg_l11a_1p8>;
>>> +     no-sdio;
>>> +     non-removable;
>>> +
>>> +     status = "okay";
>>> +};
>>> +
>>> +&sdhc_2 {
>>> +     cd-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>; /* card detect gpio */
>> This comment is still pretty much spam.
> 
> Ok.
> 
>>> +     vmmc-supply = <&vreg_l22a_2p96>;
>>> +     vqmmc-supply = <&vreg_l5a_2p96>;
>>> +     no-sdio;
>>> +
>>> +     status = "okay";
>>> +};
>>> +
>>> +&sleep_clk {
>>> +     clock-frequency = <32000>;
>>> +};
>>> +
>>> +&tlmm {
>>> +     gpio-reserved-ranges = <37 5>, <43 2>, <47 1>,
>>> +                            <49 1>, <52 1>, <54 1>,
>>> +                            <56 3>, <61 2>, <64 1>,
>>> +                            <68 1>, <72 8>, <96 1>;
>>> +};
>>> +
>>> +&uart4 {
>>> +     status = "okay";
>>> +};
>> This is not the correct SE for the production board. People
>> booting this will get a tz bite.
> 
> Hmm.. I can swap it, but the problem is that it's as the SE for my RB2
> board, so I would rather provide instructions in the cover letter as to how
> to swap it (say for a production board) and recompile the dts.
That's what I did for RB1 and what I believe is the correct approach.

> 
> Otherwise, it might break the debug uart console for even the test
> folks @ Qualcomm.
Perhaps that'll teach them a lesson about making major design
changes and sharing the details on release day..

We can take care of preproduction boards after we set up U-Boot
with hw rev recognition, but that's a story for another day.


> I will send a v4 accordinglyBjorn sent a "thank you" email already but I don't see the patches
on his branch, not sure how he wants to proceed here.

Konrad
> 
> Thanks,
> Bhupesh
