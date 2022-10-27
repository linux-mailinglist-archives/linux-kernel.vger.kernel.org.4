Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A687A60F7F1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbiJ0MtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbiJ0MtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:49:17 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C2416F414
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:49:15 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n14so913072wmq.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q36OlMnP3Ys/6ybhANV3Apdof3npa1Vh+Mgsx1pBVWU=;
        b=OQyezL4cGU1S6Th8YVxCSmmKg8MDodYMD5HBV7ElzJz4DtRh+iegPU5J4dVfdCItuH
         dH97BHd68JdE3Jo/G/zHfYvNNSReIHiHCRWAFXj8kofujxZxdQnVrTmj28ukfotkS3MN
         HCvGo5DIIw9WZcsyGtfu66qsxa1g6nBLzRhprzhByHv8I7+eMkYkxlU1B5D3xq3I4KOf
         /28vnmmORF0AvfXt4fvhe9ftj7JGy12h86+fvleBteEpTJrSSCwPNZW1SuahFhQyjGJu
         Cv4MvPWxyx1NHB3qoqVJeBCgSm0DwTbCnQCRHfUpV2PaPjloUpfwAxtiC3iz5FqnGXB7
         6YrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q36OlMnP3Ys/6ybhANV3Apdof3npa1Vh+Mgsx1pBVWU=;
        b=W0NmwS8YlvRC7CRLw8fMhAlggkhunQVyZ1NE6OeMEYD0eQ5RFXXt5j0oyd6iLFUHUy
         cJyc168DRlRRenKpL0yuHNlMsPGu/eAyUmPASEToJm06TH2NwG6bkbGVE9CV5LOjkG6P
         D4R7ZGLzLDpMK/XZIgv7d1y9YAm7VaoMR48S14UDYsWr76n2iPlPQkggeY3mcPXDQDNN
         koV+osQyZzfe8z9+sVeTxGUrfr9vSxGr/HKj+1B1zP3BmBYTY5wphH8KDTdWAIopCaBY
         POFb76BdCvbHtYFDpfvs6tzazu7MEG54mHBi6MC/EiFQ2BuPqpq0/DqPjxPBaODhL0Yx
         mAWw==
X-Gm-Message-State: ACrzQf0/r8N8/WOvAz8vzR7bGYqJyEXlWyWbOCHI/gX2adQMTU2P7Hc2
        qz1xAfawN+NGuvUArfCItWydhQ==
X-Google-Smtp-Source: AMsMyM7H83+TH22aHNQ6HRVyJaoDi39AW5Sf28cYzigPPM7qK21FcZrwDuemt/vdFqzRpl+/R7UhNg==
X-Received: by 2002:a05:600c:4f45:b0:3c7:176b:2505 with SMTP id m5-20020a05600c4f4500b003c7176b2505mr5771448wmq.185.1666874954196;
        Thu, 27 Oct 2022 05:49:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:898:f380:1cb7:f7ba:a36e:de10? ([2a01:e0a:898:f380:1cb7:f7ba:a36e:de10])
        by smtp.gmail.com with ESMTPSA id bg33-20020a05600c3ca100b003b49bd61b19sm4977299wmb.15.2022.10.27.05.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 05:49:13 -0700 (PDT)
Message-ID: <18ae0876-2d37-cde9-183f-894dfcdf4be9@linaro.org>
Date:   Thu, 27 Oct 2022 14:49:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCHv3] arm64: dts: meson: Enable active coling using gpio-fan
 on Odroid N2/N2+
Content-Language: en-US
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Dan Johansen <strit@manjaro.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221022084737.1028-1-linux.amoon@gmail.com>
 <CAFBinCBu_-0m9JeAr5kd-v7Z5LTi7w0WmmUYybW_kL4KJXXpOQ@mail.gmail.com>
 <CANAwSgRzdD0FWg+z6hTFs7KvpsD64bChX-k0dPXJfACXZH2zbQ@mail.gmail.com>
 <CAFBinCCNJiL-ZKRYesQAwys6bBMpYHJbUDK-Zi_VhGDVSvF7uQ@mail.gmail.com>
 <CANAwSgTLTCA9=WvWXcR-40baauN3kAk2qx9k4FQOPCa1+_O0Yw@mail.gmail.com>
 <5d2ffeca-b41c-20b4-454b-703c39bbb29e@linaro.org>
 <CANAwSgR1CN=Gho6NGMoM1bH92KyeGqoAphmT6NqtnL=+3Zg_jQ@mail.gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <CANAwSgR1CN=Gho6NGMoM1bH92KyeGqoAphmT6NqtnL=+3Zg_jQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/10/2022 18:02, Anand Moon wrote:
> Hi Neil,

<snip>

> 
> When I try to use pwm_AO_cd,,
> Either one of the PWM binds will fail to get the following error.
> 
>   &pwm_AO_cd {
> -       pinctrl-0 = <&pwm_ao_d_e_pins>;
> +       pinctrl-0 = <&pwm_ao_d_e_pins>, <&pwm_ao_d_10_pins>;
>          pinctrl-names = "default";
>          clocks = <&xtal>;
>          clock-names = "clkin1";
> 
> [    3.941700] pwm-regulator regulator-vddcpu-b: error -EBUSY: Failed to get PWM
> [    3.943198] pwm-regulator: probe of regulator-vddcpu-b failed with error -16
> 
> [    3.956356] pwm-fan pwm-fan: error -EBUSY: Could not get PWM
> [    3.956396] pwm-fan: probe of pwm-fan failed with error -16

Yeah because PWM "D" is already used by the "pwm_AO_ab" controller, so you can't use it for the FAN.

> 
> Below are my changes with  pwm_AO_ab
> ---------------------------------------------------------------------------------------------
> alarm@odroid-n2:~/linux-amlogic-5.y-devel$ git diff
> arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
> b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
> index fd3fa82e4c33..d038ba1e2453 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
> @@ -39,6 +39,14 @@ emmc_pwrseq: emmc-pwrseq {
>                  reset-gpios = <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
>          };
> 
> +       fan: pwm-fan {
> +               compatible = "pwm-fan";
> +               pwms = <&pwm_AO_ab 1 1250 0>;

Here you use the "B" PWM signal, not the D.

> +               fan-supply = <&vcc_5v>;
> +               #cooling-cells = <2>;
> +               cooling-levels = <0 100 170 230>;
> +       };
> +
>          leds {

<snip>

> 
> +&pwm_AO_ab {
> +       pinctrl-0 = <&pwm_ao_d_10_pins>;

The "pwm_AO_ab" controller only controls the PWM "A" & "B signals, not the "D" !

This basically enables the PWM "D" pin function to GPIOAO_10, it doesn't assign it to the "pwm_AO_ab" controller.

So by enabling this pinctrl, it will duplicate the pwm_ao_d_e_pins signal to pwm_ao_d_10_pins, this is why the FAN spins non-stop.

> +       pinctrl-names = "default";
> +       clocks = <&xtal>;
> +       clock-names = "clkin1";
> +       status = "okay";
> +};
> +
>   &pwm_AO_cd {
>          pinctrl-0 = <&pwm_ao_d_e_pins>;
>          pinctrl-names = "default";
> -------------------------------------------------------------------------------------------
>>>
>>> Thanks
>>>
>>> -Anand
>>
>> Neil

Neil
