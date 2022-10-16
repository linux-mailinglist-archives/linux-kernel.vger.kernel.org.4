Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B7A600137
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 18:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiJPQXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 12:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiJPQXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 12:23:34 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDB1399FE
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 09:23:31 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a18so5435920qko.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 09:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MX65gOaIT08XY4M5cn1g7cbmh/RnvIq8wli6SwXMtBg=;
        b=p66SBm+jxcoSdZGKJv7ohAq+81+Wn8YhnMz8iueTmtobse4/DkXueovkEUAUaCkUu6
         WVm/9HPU515u6TG0YAJiCNF1ofIRPqDK8Q9CyDVKliN69cgHRFabsOCxYaeuk4+rLYMz
         Uh6IwFRMQQakirGwlhoxDQ8k5+w4YxLuaaHMs+zwPgBjDY5+lUr7nUiNuGJIgAyK7KSO
         k9XhPBuImxFy62joLKYvUVC8icWt2L6w4AK/jqbKNg8a0V52eod7KTVCgYXp5rYKKWQ3
         z/+kWcCPQg/y2JNutjffp7bFIhMhUNHM0GhPHh4vsLeRMaMCaF3eyGrcM+Qh0rztXVP2
         q0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MX65gOaIT08XY4M5cn1g7cbmh/RnvIq8wli6SwXMtBg=;
        b=0c0ocKUc7bLdzA7UP0p4kchtIkT4lPtG+RkVc2n2raUgQ7l5bq+wgv2NDRnYGHc23b
         fHbIBF57TfqGid01wDZQFPDlpcYyaJmYfn4B/3TyIPeeJzBURajNfLlEdCFjh9nTL2h7
         RJHVVmv43tMQdZjqvGhGdb5rRiMaajehQ79H7KYY4YWva9GUaU6wPhzN6QGdFIggJSpH
         kQ58r1JBt4SLcHqO7g8JdmK27xQZOGVW2vQoZtPN1KQJHcojvEvH6F/b1dGjGN2G/c1Y
         dUye7ktMTOBD4Qz3nzps867xWfGBknlHZ+pvy7Bj+YbvsODHq79LAG4YRaFj1Z0QXHGo
         Yavg==
X-Gm-Message-State: ACrzQf0nrUguqSmdZNSRaAvsvkJ3JS6lEHOZfUk82IrDTTNNWsrdTlJd
        QoFLx+W8uIcclDcp5FOjglogTQ==
X-Google-Smtp-Source: AMsMyM7Fe2XdLHMwVi3SxpUC+8uRYLyaZr1loOQzqOHB/PYzX8BlQ7wQ8d2rt0Y1ba72gdby5qnCjw==
X-Received: by 2002:a37:2d04:0:b0:6e7:4f3f:140e with SMTP id t4-20020a372d04000000b006e74f3f140emr4930915qkh.187.1665937410874;
        Sun, 16 Oct 2022 09:23:30 -0700 (PDT)
Received: from ?IPV6:2601:42:0:3450:9b13:d679:7b5b:6921? ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id bb33-20020a05622a1b2100b00399fe4aac3esm6042064qtb.50.2022.10.16.09.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 09:23:29 -0700 (PDT)
Message-ID: <fe7a6720-1bf6-bc66-22d2-225cb6e575ff@linaro.org>
Date:   Sun, 16 Oct 2022 12:23:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sc7180: align TLMM pin
 configuration with DT schema
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221013184700.87260-1-krzysztof.kozlowski@linaro.org>
 <20221013184700.87260-2-krzysztof.kozlowski@linaro.org>
 <CAD=FV=VyrCA4jNkfVGwRw2Zf-sCwJe21dRHidtZnJyb73i_UrQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=VyrCA4jNkfVGwRw2Zf-sCwJe21dRHidtZnJyb73i_UrQ@mail.gmail.com>
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

On 14/10/2022 13:50, Doug Anderson wrote:
> Hi,
> 
> On Thu, Oct 13, 2022 at 11:49 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
>> index eae22e6e97c1..37abe131951c 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> 
> [ ... cut ... ]
> 
>>  &spi0 {
>> -       pinctrl-0 = <&qup_spi0_cs_gpio_init_high>, <&qup_spi0_cs_gpio>;
>> +       pinctrl-0 = <&qup_spi0_cs_gpio_init_high>, <&qup_spi0_spi>;
>>         cs-gpios = <&tlmm 37 GPIO_ACTIVE_LOW>;
>>  };
> 
> Something still looks wrong with the above. I would have expected:
> 
>   <&qup_spi0_cs_gpio_init_high>, <&qup_spi0_spi>, <&qup_spi0_cs_gpio>;

Yes, you're right.

> 
> Specifically the old commit e440e30e26dd ("arm64: dts: qcom: sc7180:
> Avoid glitching SPI CS at bootup on trogdor") only worked correctly
> because "qup_spi0_cs_gpio_init_high" didn't specify a "function".
> That meant it was guaranteed to _just_ set the GPIO output to be
> high without changing the mux. Then later we'd change the mux and
> the output would already be high and we'd have no glitch.
> 
> As I mentioned earlier, I didn't love that solution but I didn't
> see a better way. Specifically, I don't think that the properties
> within a device tree node are ordered. Thus with your new definition:
> 
>   qup_spi0_cs_gpio_init_high: qup-spi0-cs-gpio-init-high-state {
>     pins = "gpio37";
>     function = "gpio";
>     output-high;
>   };
> 
> Nothing tells the pinctrl subsystem whether it should apply the
> 'output-high' before the 'function = "gpio"' or vice versa. From
> my previous investigation it seemed to set the function first
> and then the output to be high. Maybe that's because I happened
> to list the function first, but I wouldn't have thought it was
> legal to rely on the ordering of properties.
> 
> On the other hand, values within a property _are_ ordered. That
> means that when we specify:
> 
>  <&qup_spi0_cs_gpio_init_high>, <&qup_spi0_spi>, <&qup_spi0_cs_gpio>;
> 
> The pinctrl subsystem can see that we want "init_high" done first,
> then the SPI pins setup, and then the GPIO setup.
> 
> I confirmed that with your patches applied that the EC was reporting
> a glitch, though I haven't (yet) managed to reproduce the cros-ec
> probe failure that we were seeing in the past.
> 
> Unfortunately, I then reverted your patches and the EC was _still_
> glitching. :( It looks like things broke in commit b991f8c3622c ("pinctrl:
> core: Handling pinmux and pinconf separately"). :( Sure enough,
> reverting that patch fixes the glitching.

Regardless of this issue, binding requiring a function does not allow to
keep the pin in previous state. Your glitch-workaround was actually an
use-case for such keep-old-function feature.

Yet, I am not sure if we should keep such ability. The firmware could
configure the pin to whatever. Firmware behavior could also change it
making the OS behavior non-predictable.

> 
> OK, several hours later and I've come up with a proposed solution [1].
> Assuming that solution lands, then I think the answer is:
> 
> a) Totally get rid of the '_init_high' entries.
> b) trogdor should just specify:
>    <&qup_spi0_spi>, <&qup_spi0_cs_gpio>;

Yes.

> 
> [ ... cut ... ]
> 
>> +&qup_spi0_spi {
>> +       drive-strength = <2>;
>> +       bias-disable;
>>  };
>>
>>  &qup_spi0_cs_gpio {
>> -       pinconf {
>> -               pins = "gpio34", "gpio35", "gpio36", "gpio37";
>> -               drive-strength = <2>;
>> -               bias-disable;
>> -       };
>> +       drive-strength = <2>;
>> +       bias-disable;
>> +};
>> +
>> +&qup_spi6_spi {
>> +       drive-strength = <2>;
>> +       bias-disable;
>>  };
>>
>>  &qup_spi6_cs_gpio {
>> -       pinconf {
>> -               pins = "gpio59", "gpio60", "gpio61", "gpio62";
>> -               drive-strength = <2>;
>> -               bias-disable;
>> -       };
>> +       drive-strength = <2>;
>> +       bias-disable;
>> +};
>> +
>> +&qup_spi10_spi {
>> +       drive-strength = <2>;
>> +       bias-disable;
>>  };
>>
>>  &qup_spi10_cs_gpio {
>> -       pinconf {
>> -               pins = "gpio86", "gpio87", "gpio88", "gpio89";
>> -               drive-strength = <2>;
>> -               bias-disable;
>> -       };
>> +       drive-strength = <2>;
>> +       bias-disable;
>>  };
> 
> Mostly addressed by the above, but it should be noted that in your
> patch you were specifying settings in the trogdor.dtsi file for
> "qup_spi#_cs_gpio" but then never using it (it used the _init_high
> versions).
> 
> [1] https://lore.kernel.org/r/20221014103217.1.I656bb2c976ed626e5d37294eb252c1cf3be769dc@changeid

Best regards,
Krzysztof

