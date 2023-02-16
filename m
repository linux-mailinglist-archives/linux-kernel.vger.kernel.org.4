Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1EB699209
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjBPKpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBPKp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:45:28 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0458112F17
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:45:04 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id f34so2207421lfv.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dCZ/9iiMJgWMxLk83BvjMM6b0ZsfcU5mDoisIH9FJuA=;
        b=i2dyU6M6NR6Sz5XWONXph/oCKcJUfJtkwWvAAc6AoYo4tU3uosNpJKzdIdUGnJiRy7
         kz4xkplcZ29Nr8pPhdLsoC1kIBlfngbf7qpiB4bYCBCNMc7aD3iZkxnLQv9s2wesVCl1
         g4hsZm6SXOnsL3rsBvTcMK0gtwQgUNjmusaZiw1iAcJ21iLz48sD3eY5eO5HlC1+MDBP
         C7ncPzd+XyXRuGihjXYvTo0sasYL55QI+7OZBMOXM+cLgDrsmFuGfMjwqTQsyGpx0z8E
         VvE6Y9MHQamlDaOsJ9EH+kWfwqO4FeCJnMOUgffyvyd40Gq1eEv2GLkT7MsyljYVUOw7
         sbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dCZ/9iiMJgWMxLk83BvjMM6b0ZsfcU5mDoisIH9FJuA=;
        b=KADX6ukMzpbm4wMB9AI3EU31gYAB8m7sJkWXaP3OE5fa1RbwqsnpFEq04/biqJ4cK4
         RuKR88TFCSTsKwVvR2n/vDR9TUfUYTqpscyyqVm06bU8HgblGBtUFZ2rkLlDcNX+Ih4o
         p6x+m3jydF3msVpWBMhG4QIaxA+3tM+jGFXhxtS2ESPsuJI1nUYldPV/7soQ1oTEQ4A1
         WJVAG4zTdnsdYgN96QySozHH2Xis6vXQkhy/hfsJ1jgwkZyk11kyppbt7x4Fxj1PLRZM
         vWMz5z69ct+wS7PNXpOpMeBnQg58jgPo+m29GKBkIziGEs+hH2xw/f42Lmcu3KgcewT8
         tmoA==
X-Gm-Message-State: AO0yUKVv2aimUVI06Bq7BwNiljTePWX9Mal+ptYp6pjxgcng6YDDPt4k
        E76EjtJNDnxKMo/TaCDMMRL+kw==
X-Google-Smtp-Source: AK7set+Fyt70izS+UadNf/0BX09qj3GdpdGt3WgT59NR/O+QR2/i4FHJ3XDofU/12DxzvXNyNvHfZQ==
X-Received: by 2002:ac2:5d46:0:b0:4b6:ed8b:4f16 with SMTP id w6-20020ac25d46000000b004b6ed8b4f16mr1327178lfd.52.1676544299741;
        Thu, 16 Feb 2023 02:44:59 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id c13-20020a05651221ad00b004b53eb60e3csm250545lft.256.2023.02.16.02.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:44:59 -0800 (PST)
Message-ID: <719d3a5d-4bba-e7ef-c000-2df29295f9e0@linaro.org>
Date:   Thu, 16 Feb 2023 11:44:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: sa8775p: add the GNSS high-speed
 UART for sa8775p-ride
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230215154002.446808-1-brgl@bgdev.pl>
 <20230215154002.446808-4-brgl@bgdev.pl>
 <CAMRc=MdH7yxof63V2icesypGTFSssziaA5sCOZP_Gby-3ciLKA@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAMRc=MdH7yxof63V2icesypGTFSssziaA5sCOZP_Gby-3ciLKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.02.2023 10:43, Bartosz Golaszewski wrote:
> On Wed, Feb 15, 2023 at 4:40 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>
>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
>> Add the serial port connected to the GNSS on sa8775p-ride.
>>
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 34 +++++++++++++++++++++++
>>  arch/arm64/boot/dts/qcom/sa8775p.dtsi     | 15 ++++++++++
>>  2 files changed, 49 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
>> index d01ca3a9ee37..47cf26ea49e8 100644
>> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
>> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
>> @@ -13,6 +13,7 @@ / {
>>
>>         aliases {
>>                 serial0 = &uart10;
>> +               serial1 = &uart12;
>>                 i2c18 = &i2c18;
>>                 spi16 = &spi16;
>>         };
>> @@ -66,6 +67,30 @@ qup_i2c18_default: qup-i2c18-state {
>>                 drive-strength = <2>;
>>                 bias-pull-up;
>>         };
>> +
>> +       qup_uart12_cts: qup-uart12-cts-state {
>> +               pins = "gpio52";
>> +               function = "qup1_se5";
>> +               bias-disable;
>> +       };
>> +
>> +       qup_uart12_rts: qup_uart12_rts-state {
>> +               pins = "gpio53";
>> +               function = "qup1_se5";
>> +               bias-pull-down;
>> +       };
>> +
>> +       qup_uart12_tx: qup_uart12_tx-state {
>> +               pins = "gpio54";
>> +               function = "qup1_se5";
>> +               bias-pull-up;
>> +       };
>> +
>> +       qup_uart12_rx: qup_uart12_rx-state {
>> +               pins = "gpio55";
>> +               function = "qup1_se5";
>> +               bias-pull-down;
>> +       };
>>  };
>>
>>  &uart10 {
>> @@ -75,6 +100,15 @@ &uart10 {
>>         status = "okay";
>>  };
>>
>> +&uart12 {
>> +       pinctrl-0 = <&qup_uart12_cts>,
>> +                   <&qup_uart12_rts>,
>> +                   <&qup_uart12_tx>,
>> +                   <&qup_uart12_rx>;
>> +       pinctrl-names = "default";
>> +       status = "okay";
>> +};
>> +
>>  &xo_board_clk {
>>         clock-frequency = <38400000>;
>>  };
>> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> index 1abb545ff4f4..8b8931ea739d 100644
>> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> @@ -489,6 +489,21 @@ &clk_virt SLAVE_QUP_CORE_1 0>,
>>                                 operating-points-v2 = <&qup_opp_table_100mhz>;
>>                                 status = "disabled";
>>                         };
>> +
>> +                       uart12: serial@a94000 {
>> +                               compatible = "qcom,geni-uart";
>> +                               reg = <0x0 0xa94000 0x0 0x4000>;
>> +                               interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>;
> 
> Please disregard this series, I've just noticed I didn't stage the
> change to the interrupt number here which is wrong. And I need to fix
> the underscores in node names too.
Generally it would be "nicer" if you split adding the nodes
in the SoC and device DTs as well, since you're already resending..

Konrad
> 
> Bart
> 
>> +                               clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
>> +                               clock-names = "se";
>> +                               interconnects = <&clk_virt MASTER_QUP_CORE_1 0
>> +                                                &clk_virt SLAVE_QUP_CORE_1 0>,
>> +                                               <&gem_noc MASTER_APPSS_PROC 0
>> +                                                &config_noc SLAVE_QUP_1 0>;
>> +                               interconnect-names = "qup-core", "qup-config";
>> +                               power-domains = <&rpmhpd SA8775P_CX>;
>> +                               status = "disabled";
>> +                       };
>>                 };
>>
>>                 qupv3_id_2: geniqup@8c0000 {
>> --
>> 2.37.2
>>
