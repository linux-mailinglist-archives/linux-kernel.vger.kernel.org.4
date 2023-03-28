Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582D26CB9A3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjC1InA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjC1Im6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:42:58 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABCB3C34
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 01:42:54 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id c9so4370413lfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 01:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679992972;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eXAO2QVztc0wIt4GbZ6rGEc3cgJK8TnMWwwoFL/En1o=;
        b=K2+jVIubCiT4gJ6wBkkGdON9SRmp178AuQrKMbBcaGesnpoyocjauSMco50YGFHn2c
         2EOImgAs7VV8pUkg+INg4bNkk8flMPrrVlQTk6BLrK2q5nguJBS4TlHkdaU/Ii9FOSh6
         NbflJpGC1ApBm8IqpuF1srmnpk2qkYzFj+WA5qLPZ0LBBJUTKXScxUZH+INH8R+UO+xb
         ++Ux58FkUXhhNBPP83PgMT+jERsB/hj7Ns7rD1rKQfdRM6Sc60AxG17n2IpL+UBfwLhj
         RzvPzna8mz4Qoxpdqw5Z4CME8zPwawPE3jQ68vALwVzHRRBkhvuJRe6T0XctEwTSUCu3
         WE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679992972;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eXAO2QVztc0wIt4GbZ6rGEc3cgJK8TnMWwwoFL/En1o=;
        b=GXeFJZS5/uDNId7HR6sVIRUVYubp4fs6c0oDtTZlGG5qn0eMdjwzh5z/9r9TUWsMH/
         EI/DHr0TqJNck3ST/Nzaiv5lrT70rPSTX2Cj+WoVDfQ9MHj9fEBc5tG6MVOiTGz2oPnU
         bRItGP0qNBcg5xJgFf6ucX7FOhpiySUfvKbv3IZpfAe551w7Sj1U3DufFLZ6y9Gc46v+
         9aYLiIzWJNMOLaN7gdLU5x1qSihAMNpfBDwabphgohEnU6Y0NzMvnqRq3Auu5Tmp6QuR
         48/193xjhXUUVP3AtQaQgT6dx0F2U6aR7/s/pwQnB6sfOjl2vHe2KtxcxI1tDcbeNBvQ
         NDsQ==
X-Gm-Message-State: AAQBX9fzzIEJT70MYNuAoNg5vCy4ntS+pMYvlEy9UqmIpfDBf062adOC
        a2T2WhyjXjc1w0Ny3nG13HeVag==
X-Google-Smtp-Source: AKy350ZSAWagGBNHA5PmKfaemuAQKtAXuaYDZnKQL0TPA7YYUOdEM3bAwyuwhOZQCrm4lGjdbmFE6A==
X-Received: by 2002:ac2:59d9:0:b0:4dd:cbf3:e981 with SMTP id x25-20020ac259d9000000b004ddcbf3e981mr4338231lfn.28.1679992972560;
        Tue, 28 Mar 2023 01:42:52 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9c52000000b002934b5d6a61sm4939271ljj.121.2023.03.28.01.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 01:42:52 -0700 (PDT)
Message-ID: <cf530ceb-ca4c-5f5e-db61-60f856dafecb@linaro.org>
Date:   Tue, 28 Mar 2023 10:42:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V10 3/4] arm64: dts: qcom: Add support for ipq9574 SoC and
 RDP433 variant
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        nfraprado@collabora.com, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
References: <20230327132718.573-1-quic_devipriy@quicinc.com>
 <20230327132718.573-4-quic_devipriy@quicinc.com>
 <CAA8EJprTm1sZ8fnfNee+NJTiaFq17QwWaEnSoJWVYs_GY65xFg@mail.gmail.com>
 <a6225636-7abb-3c5c-c78f-8d40c25167b9@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <a6225636-7abb-3c5c-c78f-8d40c25167b9@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.03.2023 09:31, Devi Priya wrote:
> 
> 
> On 3/27/2023 8:15 PM, Dmitry Baryshkov wrote:
>> On Mon, 27 Mar 2023 at 16:28, Devi Priya <quic_devipriy@quicinc.com> wrote:
>>>
>>> Add initial device tree support for Qualcomm IPQ9574 SoC and
>>> Reference Design Platform(RDP) 433 which is based on IPQ9574
>>> family of SoCs
>>>
>>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>>> Co-developed-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
>>> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
>>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>>> ---
>>>   Changes in V10:
>>>          - Renamed the Board Device Tree Source to use the RDP numbers
>>>          - Updated the Makefile, subject and commit message accordingly
>>>
>>>   arch/arm64/boot/dts/qcom/Makefile           |   1 +
>>>   arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts |  84 ++++++
>>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi       | 270 ++++++++++++++++++++
>>>   3 files changed, 355 insertions(+)
>>>   create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>>>   create mode 100644 arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>>> index 1a29403400b7..52f1f92c5195 100644
>>> --- a/arch/arm64/boot/dts/qcom/Makefile
>>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>>> @@ -8,6 +8,7 @@ dtb-$(CONFIG_ARCH_QCOM) += ipq6018-cp01-c1.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)        += ipq8074-hk01.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)        += ipq8074-hk10-c1.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)        += ipq8074-hk10-c2.dtb
>>> +dtb-$(CONFIG_ARCH_QCOM)        += ipq9574-rdp433.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)        += msm8916-acer-a1-724.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)        += msm8916-alcatel-idol347.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)        += msm8916-asus-z00l.dtb
>>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>>> new file mode 100644
>>> index 000000000000..2ce8e09e7565
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>>> @@ -0,0 +1,84 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
>>> +/*
>>> + * IPQ9574 RDP433 board device tree source
>>> + *
>>> + * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
>>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "ipq9574.dtsi"
>>> +
>>> +/ {
>>> +       model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C7";
>>> +       compatible = "qcom,ipq9574-ap-al02-c7", "qcom,ipq9574";
>>> +
>>> +       aliases {
>>> +               serial0 = &blsp1_uart2;
>>> +       };
>>> +
>>> +       chosen {
>>> +               stdout-path = "serial0:115200n8";
>>> +       };
>>> +};
>>> +
>>> +&blsp1_uart2 {
>>> +       pinctrl-0 = <&uart2_pins>;
>>> +       pinctrl-names = "default";
>>> +       status = "okay";
>>> +};
>>> +
>>> +&sdhc_1 {
>>> +       pinctrl-0 = <&sdc_default_state>;
>>> +       pinctrl-names = "default";
>>> +       mmc-ddr-1_8v;
>>> +       mmc-hs200-1_8v;
>>> +       mmc-hs400-1_8v;
>>> +       mmc-hs400-enhanced-strobe;
>>> +       max-frequency = <384000000>;
>>> +       bus-width = <8>;
>>> +       status = "okay";
>>> +};
>>> +
>>> +&sleep_clk {
>>> +       clock-frequency = <32000>;
>>> +};
>>> +
>>> +&tlmm {
>>> +       sdc_default_state: sdc-default-state {
>>> +               clk-pins {
>>> +                       pins = "gpio5";
>>> +                       function = "sdc_clk";
>>> +                       drive-strength = <8>;
>>> +                       bias-disable;
>>> +               };
>>> +
>>> +               cmd-pins {
>>> +                       pins = "gpio4";
>>> +                       function = "sdc_cmd";
>>> +                       drive-strength = <8>;
>>> +                       bias-pull-up;
>>> +               };
>>> +
>>> +               data-pins {
>>> +                       pins = "gpio0", "gpio1", "gpio2",
>>> +                              "gpio3", "gpio6", "gpio7",
>>> +                              "gpio8", "gpio9";
>>> +                       function = "sdc_data";
>>> +                       drive-strength = <8>;
>>> +                       bias-pull-up;
>>> +               };
>>> +
>>> +               rclk-pins {
>>> +                       pins = "gpio10";
>>> +                       function = "sdc_rclk";
>>> +                       drive-strength = <8>;
>>> +                       bias-pull-down;
>>> +               };
>>> +       };
>>> +};
>>> +
>>> +&xo_board_clk {
>>> +       clock-frequency = <24000000>;
>>> +};
>>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>> new file mode 100644
>>> index 000000000000..3bb7435f5e7f
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>> @@ -0,0 +1,270 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
>>> +/*
>>> + * IPQ9574 SoC device tree source
>>> + *
>>> + * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
>>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>>> + */
>>> +
>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +#include <dt-bindings/clock/qcom,ipq9574-gcc.h>
>>> +#include <dt-bindings/reset/qcom,ipq9574-gcc.h>
>>> +
>>> +/ {
>>> +       interrupt-parent = <&intc>;
>>> +       #address-cells = <2>;
>>> +       #size-cells = <2>;
>>> +
>>> +       clocks {
>>> +               bias_pll_ubi_nc_clk: bias-pll-ubi-nc-clk {
>>> +                       compatible = "fixed-clock";
>>> +                       clock-frequency = <353000000>;
>>> +                       #clock-cells = <0>;
>>> +               };
>>
>> What is the source for this clock? With it clocking at 353 MHz, I
>> doubt that it is an external clock.
> bias_pll_ubi_nc_clk (353MHz)is a backup source
> for Q6_AXIM2_CLK
Is this not handled internally by MPSS firmware or RPM
then?

Konrad
/PCIE2_AXIM_CLK/PCIE3_AXIM_CLK/SNOC-CLK
> It is from the CMN_PLL, and is the same as that of PPE core clock.
> Do you suggest to move its clock-frequency to Board DT similar to xo/sleep clock?
>>
>>> +
>>> +               sleep_clk: sleep-clk {
>>> +                       compatible = "fixed-clock";
>>> +                       #clock-cells = <0>;
>>> +               };
>>> +
>>> +               xo_board_clk: xo-board-clk {
>>> +                       compatible = "fixed-clock";
>>> +                       #clock-cells = <0>;
>>> +               };
>>> +       };
>>
>> [skipped the rest]
>>
> Regards,
> Devi Priya
