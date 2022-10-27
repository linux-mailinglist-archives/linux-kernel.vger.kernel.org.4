Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27A160F994
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbiJ0NrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbiJ0NrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:47:04 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC9414C50B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:47:01 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id z30so875361qkz.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1G4uza6OunYBQ//lixENKM+uBhXjuS/v82cPTgaP3Fw=;
        b=O3vgzsRfBu6EpgVs5hN61Zsk5tTlBSEf1LZZL/C9gCKXnmYF1gfjQp6ZPm6phX88qx
         Q62Pf3Jwyz/V5S84k6DJLkGczFEVg8SuFw69SCSjL64ILASDXySnAKFPKIhh5eWVk2sc
         +YrSpw7DPRyFz52RujOT40FIrD/TmJlB3XLBZBSgrQrlu4IFAhCGAloExlO1VOJ3fMbN
         U9+QGp1mkf3LerDazIZ2cL0zuGatBV9mNy4pxkehxNpZu6cnpSQBbTZSLhWN7BS/z21D
         fENoCJ7tWTrvZXEhxbqy4UtQExM+e6UGnvX4uu+9K9hYoRSpBOeX/c90Aa9/q2FrGlGf
         Rgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1G4uza6OunYBQ//lixENKM+uBhXjuS/v82cPTgaP3Fw=;
        b=JaosRTqotprApJccC4fVeMDwocXcosPR4OQ2hKQZF2pBwJ3ksXDTalWyAEApMgioW/
         jiyHZN+0LSf8lpeMh6TlHiBwP38XWu/eBfkLzENNGhvCoa5gABDOPEsqkA17JJ4DQT/H
         geyOivFyzBXfmAGlUUPevDrnUCSfyNIsLptksfRLP3d2mAEUN5SBl9MVJi+Ame054HRt
         mYI7720a1N/jhvjnCaeKgb+sa21CVo8GgKWsQnaOYvDCSpoJwZOKT97RiGcdIHhMusLk
         zP/NkyYKYpEmNs6XrLI59L1Ndwx9MyweCl19jJ9HKS6SSC8eWY/mITpuouPLV43nQfXn
         sq0g==
X-Gm-Message-State: ACrzQf1QwpyMS0cs4IiF8+BTinncaft1qmq/T0I+sjHaweM5SFvOsXKs
        km5JcAPmsfzjDtSTGqUk/kIzIw==
X-Google-Smtp-Source: AMsMyM6u4j3Fw0nLx0Bg1S0gIFL0V0Jou31arkL1Q03nKtCYQDxobMqN3uwUJ0IKtCWeNrlbTax+zQ==
X-Received: by 2002:a37:9306:0:b0:6f9:b745:68b5 with SMTP id v6-20020a379306000000b006f9b74568b5mr4525771qkd.582.1666878420178;
        Thu, 27 Oct 2022 06:47:00 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id f11-20020a05620a280b00b006eee3a09ff3sm993432qkp.69.2022.10.27.06.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 06:46:59 -0700 (PDT)
Message-ID: <f023f273-e4d2-fd92-a3d4-2c17af7e4314@linaro.org>
Date:   Thu, 27 Oct 2022 09:46:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 01/11] dt-bindings: iio: qcom: adc7-pm8350: Allow
 specifying SID for channels
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221027063006.9056-1-manivannan.sadhasivam@linaro.org>
 <20221027063006.9056-2-manivannan.sadhasivam@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221027063006.9056-2-manivannan.sadhasivam@linaro.org>
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

On 27/10/2022 02:29, Manivannan Sadhasivam wrote:
> As per the new ADC7 architecture used by the Qualcomm PMICs, each PMIC
> has the static Slave ID (SID) assigned by default. The primary PMIC
> PMK8350 is responsible for collecting the temperature/voltage data from
> the slave PMICs and exposing them via it's registers.
> 
> For getting the measurements from the slave PMICs, PMK8350 uses the
> channel ID encoded with the SID of the relevant PMIC. So far, the
> dt-binding for the slave PMIC PM8350 assumed that there will be only
> one PM8350 in a system. So it harcoded SID 1 with channel IDs.
> 
> But this got changed in platforms such as Lenovo X13s where there are a
> couple of PM8350 PMICs available. So to address multiple PM8350s, change
> the binding to accept the SID specified by the user and use it for
> encoding the channel ID.
> 
> It should be noted that, even though the SID is static it is not
> globally unique. Only the primary PMIC has the unique SID id 0.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../bindings/thermal/qcom-spmi-adc-tm5.yaml   |  6 +-
>  .../dt-bindings/iio/qcom,spmi-adc7-pm8350.h   | 90 +++++++++----------
>  2 files changed, 46 insertions(+), 50 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> index feb390d50696..d20569b9b763 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> @@ -222,8 +222,8 @@ examples:
>                  qcom,hw-settle-time = <200>;
>              };
>  
> -            conn-therm@47 {
> -                reg = <PM8350_ADC7_AMUX_THM4_100K_PU>;
> +            conn-therm@147 {
> +                reg = <PM8350_ADC7_AMUX_THM4_100K_PU(1)>;
>                  qcom,ratiometric;
>                  qcom,hw-settle-time = <200>;
>              };
> @@ -247,7 +247,7 @@ examples:
>  
>              conn-therm@1 {
>                  reg = <1>;
> -                io-channels = <&pmk8350_vadc PM8350_ADC7_AMUX_THM4_100K_PU>;
> +                io-channels = <&pmk8350_vadc PM8350_ADC7_AMUX_THM4_100K_PU(1)>;
>                  qcom,avg-samples = <2>;
>                  qcom,ratiometric;
>                  qcom,hw-settle-time-us = <200>;
> diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h b/include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h
> index 9426f27a1946..50de5adfe6ac 100644
> --- a/include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h
> +++ b/include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h
> @@ -6,62 +6,58 @@
>  #ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8350_H
>  #define _DT_BINDINGS_QCOM_SPMI_VADC_PM8350_H
>  
> -#ifndef PM8350_SID
> -#define PM8350_SID					1
> -#endif
> -
>  /* ADC channels for PM8350_ADC for PMIC7 */
> -#define PM8350_ADC7_REF_GND			(PM8350_SID << 8 | 0x0)
> -#define PM8350_ADC7_1P25VREF			(PM8350_SID << 8 | 0x01)
> -#define PM8350_ADC7_VREF_VADC			(PM8350_SID << 8 | 0x02)
> -#define PM8350_ADC7_DIE_TEMP			(PM8350_SID << 8 | 0x03)
> -
> -#define PM8350_ADC7_AMUX_THM1			(PM8350_SID << 8 | 0x04)
> -#define PM8350_ADC7_AMUX_THM2			(PM8350_SID << 8 | 0x05)
> -#define PM8350_ADC7_AMUX_THM3			(PM8350_SID << 8 | 0x06)
> -#define PM8350_ADC7_AMUX_THM4			(PM8350_SID << 8 | 0x07)
> -#define PM8350_ADC7_AMUX_THM5			(PM8350_SID << 8 | 0x08)
> -#define PM8350_ADC7_GPIO1			(PM8350_SID << 8 | 0x0a)
> -#define PM8350_ADC7_GPIO2			(PM8350_SID << 8 | 0x0b)
> -#define PM8350_ADC7_GPIO3			(PM8350_SID << 8 | 0x0c)
> -#define PM8350_ADC7_GPIO4			(PM8350_SID << 8 | 0x0d)
> +#define PM8350_ADC7_REF_GND(sid)			(sid << 8 | 0x0)

As it is macro, I think it argument should be in parens: (sid)


Best regards,
Krzysztof

