Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85FE74EBF6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjGKKs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjGKKs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:48:57 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C27CE79
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 03:48:55 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fa16c6a85cso8489763e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 03:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689072534; x=1691664534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0eFHO/YTEUagrBewYQOFY9B3mReoUZ8q6wnsrnHtS7k=;
        b=UTG0UMZx/jrJiH909Qr8nKmS1Il6jQf91rvAHrhgGtpuVGRQs+/jDFSI9pCaonAGWn
         6FPter8spF1/XsPHLQO2LMuK5M4xFo/bnuRhLbHw9SV7RxUT+LRP7CpWHaz/cbtLtKxJ
         FxdcpE3idf/GgCLYKnr5xbM/6N8kRCxDyoz27UVCaEwn7JVmkHS9jHs30/kiLBOoD6q+
         eUfvn/EbRoAZjjZbL/VI75Cj1riEN6dJOmxrXBVudK4XsQUL3dl1orFGAyqW/Vw6Z/r5
         IOmvrH4nZOH/VLGwNMx6rMU6lk53NCKxvURrd2VeTKPmN0hER5TrefSVkJ732khM1IWF
         5obA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689072534; x=1691664534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0eFHO/YTEUagrBewYQOFY9B3mReoUZ8q6wnsrnHtS7k=;
        b=M1X1egA8YSl0oT5VBt3nxVxBa/rzf2BO7rvKaYNpnQyvZ4+4hIiYaZIg4kKWxGHG5j
         3gLFeuIg3nWK1ypoARBw8NAxypl+cwRePs2s9gNnQm6SXv0dycbEjvV8PzZVtBaYcA/h
         ogbggoPkAgOjjRaH1RuFBRuDYijToJJE2GT09CdkOP7X2HSg+5LGsLsTYlmK67N8TLUb
         rC7+59MreIM4tyEwXnkW55GPv0ZO56Nm+OtZC4TXLygl+0N19e7nFc6VoFScmMDkmtmP
         8xv603M+jmtV5bzSZgF+aHE+u1GNJ/wmvZ7EE0n+XGOg6ZGkC/LvoYDFsjKbf8qzcAmQ
         qLrQ==
X-Gm-Message-State: ABy/qLbVNWWCZo8wV82PZvhw85xxmS+wKlVQeY8mmFzFL0+wSyECpjyQ
        TGKFIy5mgyTY2zptIpnG8ALQMQ==
X-Google-Smtp-Source: APBJJlEooQztKTPhQusolwyTxbLEy6kiT0+yLZ0dfXx832LQZQPLMjUHGhI6T1FyCyG34GYWh5/Lcw==
X-Received: by 2002:a05:6512:3bb:b0:4f8:71bf:a259 with SMTP id v27-20020a05651203bb00b004f871bfa259mr11228051lfp.67.1689072533821;
        Tue, 11 Jul 2023 03:48:53 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id ep30-20020a056512485e00b004fbac025223sm271572lfb.22.2023.07.11.03.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 03:48:53 -0700 (PDT)
Message-ID: <43d290c9-fdec-4832-242e-6732d9f0ea6c@linaro.org>
Date:   Tue, 11 Jul 2023 12:48:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] arm64: dts: qcom: qrb2210-rb1: Add regulators
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230711-topic-rb1_regulator-v1-1-bc4398c35800@linaro.org>
 <CAA8EJpoeAeitC=_pbAxFATfxx8UK-4cAQ=Zr3nKc0jhAdoG5fg@mail.gmail.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJpoeAeitC=_pbAxFATfxx8UK-4cAQ=Zr3nKc0jhAdoG5fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.07.2023 12:44, Dmitry Baryshkov wrote:
> On Tue, 11 Jul 2023 at 13:28, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> Add and assign RPM regulators coming from PM2250.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
[...]

>> +               pm2250_l5: l5 {
>> +                       /* CSI/DSI */
>> +                       regulator-min-microvolts = <1232000>;
>> +                       regulator-max-microvolts = <1232000>;
>> +                       regulator-allow-set-load;
>> +                       regulator-boot-on;
> 
> why?
> 
To answer all of the questions in one go:

"it's because the regulator is enabled at boot"

Konrad
>> +               };
>> +
>> +               pm2250_l6: l6 {
>> +                       /* DRAM PLL */
>> +                       regulator-min-microvolts = <928000>;
>> +                       regulator-max-microvolts = <928000>;
>> +                       regulator-always-on;
>> +                       regulator-boot-on;
>> +               };
>> +
>> +               pm2250_l7: l7 {
>> +                       /* Wi-Fi CX/MX */
>> +                       regulator-min-microvolts = <664000>;
>> +                       regulator-max-microvolts = <664000>;
>> +               };
>> +
>> +               /*
>> +                * L8 - VDD_LPI_CX
>> +                * L9 - VDD_LPI_MX
>> +                */
>> +
>> +               pm2250_l10: l10 {
>> +                       /* Wi-Fi RFA */
>> +                       regulator-min-microvolts = <1300000>;
>> +                       regulator-max-microvolts = <1300000>;
>> +               };
>> +
>> +               pm2250_l11: l11 {
>> +                       /* GPS RF1 */
>> +                       regulator-min-microvolts = <1000000>;
>> +                       regulator-max-microvolts = <1000000>;
>> +                       regulator-boot-on;
> 
> Shouldn't it be handled by the modem on its own?
> 
>> +               };
>> +
>> +               pm2250_l12: l12 {
>> +                       /* USB PHYs */
>> +                       regulator-min-microvolts = <928000>;
>> +                       regulator-max-microvolts = <928000>;
>> +                       regulator-allow-set-load;
>> +                       regulator-boot-on;
> 
> You guess the question (and further on)
> 
>> +               };
>> +
>> +               pm2250_l13: l13 {
>> +                       /* USB/QFPROM/PLLs */
>> +                       regulator-min-microvolts = <1800000>;
>> +                       regulator-max-microvolts = <1800000>;
>> +                       regulator-allow-set-load;
>> +                       regulator-boot-on;
>> +               };
>> +
>> +               pm2250_l14: l14 {
>> +                       /* SDHCI1 VQMMC */
>> +                       regulator-min-microvolts = <1800000>;
>> +                       regulator-max-microvolts = <1800000>;
>> +                       regulator-allow-set-load;
>> +                       /* Broken hardware, never turn it off! */
>> +                       regulator-always-on;
>> +               };
>> +
>> +               pm2250_l15: l15 {
>> +                       /* WCD/DSI/BT VDDIO */
>> +                       regulator-min-microvolts = <1800000>;
>> +                       regulator-max-microvolts = <1800000>;
>> +                       regulator-allow-set-load;
>> +                       regulator-always-on;
>> +                       regulator-boot-on;
>> +               };
>> +
>> +               pm2250_l16: l16 {
>> +                       /* GPS RF2 */
>> +                       regulator-min-microvolts = <1800000>;
>> +                       regulator-max-microvolts = <1800000>;
>> +                       regulator-boot-on;
>> +               };
>> +
>> +               pm2250_l17: l17 {
>> +                       regulator-min-microvolts = <3000000>;
>> +                       regulator-max-microvolts = <3000000>;
>> +               };
>> +
>> +               pm2250_l18: l18 {
>> +                       /* VDD_PXn */
>> +                       regulator-min-microvolts = <1800000>;
>> +                       regulator-max-microvolts = <1800000>;
>> +               };
>> +
>> +               pm2250_l19: l19 {
>> +                       /* VDD_PXn */
>> +                       regulator-min-microvolts = <1800000>;
>> +                       regulator-max-microvolts = <1800000>;
>> +               };
>> +
>> +               pm2250_l20: l20 {
>> +                       /* SDHCI1 VMMC */
>> +                       regulator-min-microvolts = <2856000>;
>> +                       regulator-max-microvolts = <2856000>;
>> +                       regulator-allow-set-load;
>> +               };
>> +
>> +               pm2250_l21: l21 {
>> +                       /* SDHCI2 VMMC */
>> +                       regulator-min-microvolts = <2960000>;
>> +                       regulator-max-microvolts = <3300000>;
>> +                       regulator-allow-set-load;
>> +                       regulator-boot-on;
>> +               };
>> +
>> +               pm2250_l22: l22 {
>> +                       /* Wi-Fi */
>> +                       regulator-min-microvolts = <3312000>;
>> +                       regulator-max-microvolts = <3312000>;
>> +               };
>> +       };
>> +};
>> +
>>  &sdhc_1 {
>> +       vmmc-supply = <&pm2250_l20>;
>> +       vqmmc-supply = <&pm2250_l14>;
>>         pinctrl-0 = <&sdc1_state_on>;
>>         pinctrl-1 = <&sdc1_state_off>;
>>         pinctrl-names = "default", "sleep";
>> @@ -61,6 +322,8 @@ &sdhc_1 {
>>  };
>>
>>  &sdhc_2 {
>> +       vmmc-supply = <&pm2250_l21>;
>> +       vqmmc-supply = <&pm2250_l4>;
>>         cd-gpios = <&tlmm 88 GPIO_ACTIVE_LOW>;
>>         pinctrl-0 = <&sdc2_state_on &sd_det_in_on>;
>>         pinctrl-1 = <&sdc2_state_off &sd_det_in_off>;
>> @@ -104,6 +367,9 @@ &usb {
>>  };
>>
>>  &usb_hsphy {
>> +       vdd-supply = <&pm2250_l12>;
>> +       vdda-pll-supply = <&pm2250_l13>;
>> +       vdda-phy-dpdm-supply = <&pm2250_l21>;
>>         status = "okay";
>>  };
>>
>>
>> ---
>> base-commit: 8e4b7f2f3d6071665b1dfd70786229c8a5d6c256
>> change-id: 20230711-topic-rb1_regulator-44c4ade93246
>>
>> Best regards,
>> --
>> Konrad Dybcio <konrad.dybcio@linaro.org>
>>
> 
> 
