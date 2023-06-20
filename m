Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BED7374D6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjFTTC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 15:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjFTTCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:02:25 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2003B170D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:02:24 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f955850e30so902347e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687287742; x=1689879742;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7LIPQ7TmOkpbIvBCWabiui+NKsz8UsHfmjlDRffHBUk=;
        b=Xs4PfMspW7xDc/O1aa4rE+DQ9pkOJ4ZTsInVa0vytaaeZpQBMkh49mIONsbq23o/v8
         REPjMxfyTaLoWX60QsuvW1A9JV1EXfEhLCL5TMFC9z2Q+WkdOS7RX7rLA23TjLs4jMuu
         X0gtnRQAQKRe+cYWOdZEprxDRUlgFZasijjJA4vO27jBYxmgtw6ZyGzRz1962r5KIpKo
         dAe6rHRhKDMAhuztkwRGPcLcUHx1NmRw4zDqtnm+IjE4buY51pSJnMg9AMc6CSDN0+5D
         ODfgm5AIJ5CemHo7VjK+qoC7xx+hSL5fp67SGAKor5YJHHoYA0/dryF07AbL5AMkaFD9
         qUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687287742; x=1689879742;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7LIPQ7TmOkpbIvBCWabiui+NKsz8UsHfmjlDRffHBUk=;
        b=K0bEHAONKp6TF5mFGK15Z1zYjm8RHK+DF7/ZJfNPuUiyR93r/Y8h8IJVopDGCYbJyd
         kUJAYulJFH2wUALxXtuDakVBzTuA64uzHnfUi55Y/Q6rLZ4ufdgNNdNAyEPvFgnJp6eb
         nQ5brPuvug3Fzlw/EsZ6KfMwRdkG9KmPymvEGXySWB+e0YsD0RvXHGPvN2CmEVMjWEji
         7UisTWE94LR3Ih1zU5D72BIk0vSPLvHdIiKomqU+0sNZ402ESn3onvANcx2ZpTL/6xra
         yEYCyPv4kgHXnuKny9cZ0GasjOOnccQuyQYgvnHUx0jhPm1vvmFawnzTsgDB9lRQrLkC
         pZZw==
X-Gm-Message-State: AC+VfDxyafx8Rogdj9mP6PTTqyt4trKpqukpMjYFBPGrQfYYRiOc4VSE
        m4l3EasNXAvx7rag/evMpDzwPA==
X-Google-Smtp-Source: ACHHUZ4t8Pq5QEb7VId6ZVll1Oua+R9L/mIP9UOkzwJC8+552a1mk2SXWhsTfB/x2sy3Dvs003n/3A==
X-Received: by 2002:a05:6512:454:b0:4f8:565f:8ec7 with SMTP id y20-20020a056512045400b004f8565f8ec7mr4350043lfk.27.1687287742337;
        Tue, 20 Jun 2023 12:02:22 -0700 (PDT)
Received: from [192.168.1.101] (abxj193.neoplus.adsl.tpnet.pl. [83.9.3.193])
        by smtp.gmail.com with ESMTPSA id o3-20020a056512050300b004f8751285a5sm460669lfb.80.2023.06.20.12.02.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 12:02:21 -0700 (PDT)
Message-ID: <02ee3320-4ff6-f713-3020-c2c82deb674a@linaro.org>
Date:   Tue, 20 Jun 2023 21:02:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sm6115p-j606f: Hook up display
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230620-topic-gpu_tablet_disp-v1-0-7bb02bec8dc0@linaro.org>
 <20230620-topic-gpu_tablet_disp-v1-2-7bb02bec8dc0@linaro.org>
 <c9ed9e06-3a94-e8ee-7fb6-8ff66c41a32e@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <c9ed9e06-3a94-e8ee-7fb6-8ff66c41a32e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.06.2023 17:52, Dmitry Baryshkov wrote:
> On 20/06/2023 16:17, Konrad Dybcio wrote:
>> Enable the required nodes, add the required pins and tweak a
>> regulator to enable non-simplefb display on the Tab P11.
>>
>> Do note that there exists a second SKU with a different panel+touch
>> combo, but due to insufficient information, that will need to be
>> handled separately.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts | 57 +++++++++++++++++++++--
>>   1 file changed, 52 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
>> index 81fdcaf48926..a10ce676bd44 100644
>> --- a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
>> @@ -65,9 +65,41 @@ ramoops@ffc00000 {
>>       };
>>   };
>>   -&dispcc {
>> -    /* HACK: disable until a panel driver is ready to retain simplefb */
>> -    status = "disabled";
>> +&mdss {
>> +    status = "okay";
>> +};
>> +
>> +&mdss_dsi0 {
>> +    vdda-supply = <&pm6125_l18>;
>> +    status = "okay";
>> +
>> +    panel: panel@0 {
>> +        compatible = "lenovo,j606f-boe-nt36523w", "novatek,nt36523w";
>> +        reg = <0>;
>> +
>> +        reset-gpios = <&tlmm 82 GPIO_ACTIVE_LOW>;
>> +        vddio-supply = <&pm6125_l9>;
>> +
>> +        pinctrl-names = "default";
>> +        pinctrl-0 = <&te_active &sde_dsi_active>;
>> +
>> +        rotation = <180>; /* Yep, it's mounted upside down! */
>> +
>> +        port {
>> +            panel_in: endpoint {
>> +                remote-endpoint = <&mdss_dsi0_out>;
>> +            };
>> +        };
>> +    };
>> +};
>> +
>> +&mdss_dsi0_out {
>> +    data-lanes = <0 1 2 3>;
>> +    remote-endpoint = <&panel_in>;
>> +};
>> +
>> +&mdss_dsi0_phy {
>> +    status = "okay";
>>   };
>>     &pm6125_gpios {
>> @@ -212,8 +244,9 @@ pm6125_l17: l17 {
>>           };
>>             pm6125_l18: l18 {
>> -            regulator-min-microvolt = <1104000>;
>> -            regulator-max-microvolt = <1312000>;
>> +            /* 1.104V-1.312V fixed @ 1.232V for DSIPHY */
>> +            regulator-min-microvolt = <1232000>;
>> +            regulator-max-microvolt = <1232000>;
>>           };
>>             pm6125_l19: l19 {
>> @@ -282,6 +315,20 @@ sdc2_gate_pin: sdc2-gate-state {
>>           bias-pull-up;
>>           output-high;
>>       };
>> +
>> +    te_active: te-active-state {
>> +        pins = "gpio81";
>> +        function = "mdp_vsync";
>> +        drive-strength = <2>;
>> +        bias-pull-down;
>> +    };
>> +
>> +    sde_dsi_active: te-active-state {
> 
> mdss_dsi_active? Or just dsi_active?
mdss is ok

Also Marijn pointed out in private that this node overwrites
the previous one.. Thankfully video mode panels don't care about
TE! :D

Konrad
> 
>> +        pins = "gpio82";
>> +        function = "gpio";
>> +        drive-strength = <8>;
>> +        bias-disable;
>> +    };
>>   };
>>     &ufs_mem_hc {
>>
> 
