Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0837080CF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 14:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjERML1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 08:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjERMLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 08:11:22 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9A6194
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 05:11:20 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-510d8b0169fso2302422a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 05:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684411879; x=1687003879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eH9Ti4nAq2PZgm6qot+MzQ9siimF1sxRnPpGSpCfOHw=;
        b=RIBUXrHljuk/rLgpBNTWH/Wt8Vy6eMUK63vu12NMpC4cJ4FN3M5zi2onk/Iw4KYhTm
         rP6J/j+yirrlO7lqfR9kv8QcE6GGAl+awJPjixU/XDrx15/r2MwInelsa9xHk4rmNgdm
         FkEzMSUQ1ThUjutqAJMyHrka/ytAY3JXhVk154ofb26rEF6/U7+vVyEKUcDnGTYI8K1J
         ojFx4daCGQQ0jcEKzcZ6chAV0qZgdIEzptZFV6Lx8YGo3mOF6k5AgQwOyxoXRmDUhjU5
         EELFbj+tOxCM0gMyJP42SzyfUSUTaVu1OE8Y2Ol4jr2DKBoti/8WHo0oi95I0BihnWwS
         HnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684411879; x=1687003879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eH9Ti4nAq2PZgm6qot+MzQ9siimF1sxRnPpGSpCfOHw=;
        b=I3OvMKyV4w0fBEbkAc6pwl8ZSOfTAQR0HAqkjuMzC+bOENACIUBmOaDEjY+YpID6L7
         /bRymXey8GI9TcS0VJ4f6YLPo9LH5i11aWu25m6qwG2jiqEYp6W5yZU+bNvdgAdVlwcD
         4o1i+NfnSlQCMoWlPCuTFkJu/H/wi4axo8z4PkUDBusDG9FuQZSne+e1kIyeHiCS7jT0
         2lYAck4sh8xK2hynl781GNd9iwj7evVJ4xpUZmM93XBIQL9x/YwaktPsc0KHM7Z5XvfE
         HOmen+86AJvNIR1LGFEaU9GeMeVKuMJ+adwwa9cjiBMyurLL2H7JojnVuDSyU3YAeFaM
         +rWA==
X-Gm-Message-State: AC+VfDwsZB8x51nZBIoLC61pyUpR4U1IR97FMlOfbdiN+tPIt7AsowvS
        ppSj/Hb4P8lSdMi1LIDL6aBvWQ==
X-Google-Smtp-Source: ACHHUZ4c7pZWy3fky9l24pA71DBgsX/CNygp+rtQGgH6TvGPQbJhspz40DPl1raunNLanz3NzAeP1w==
X-Received: by 2002:a05:6402:b21:b0:510:d9c8:f180 with SMTP id bo1-20020a0564020b2100b00510d9c8f180mr3745398edb.21.1684411879096;
        Thu, 18 May 2023 05:11:19 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a2b:c408:5834:f48e? ([2a02:810d:15c0:828:a2b:c408:5834:f48e])
        by smtp.gmail.com with ESMTPSA id j14-20020aa7ca4e000000b00510b5051f95sm508499edt.90.2023.05.18.05.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 05:11:18 -0700 (PDT)
Message-ID: <53288f73-8271-9572-14b9-27fa34e2c9fc@linaro.org>
Date:   Thu, 18 May 2023 14:11:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 5/5] dt-bindings: clocks: at91sam9x5-sckc: convert to
 yaml
Content-Language: en-US
To:     Claudiu.Beznea@microchip.com
Cc:     robh+dt@kernel.org, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas.Ferre@microchip.com, krzysztof.kozlowski+dt@linaro.org,
        Conor.Dooley@microchip.com, mturquette@baylibre.com,
        devicetree@vger.kernel.org
References: <20230517094119.2894220-1-claudiu.beznea@microchip.com>
 <20230517094119.2894220-6-claudiu.beznea@microchip.com>
 <20230517141508.evb6jg5bcpjzhqve@krzk-bin>
 <79b77cb4-1e18-3c19-15dd-66951541abdf@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <79b77cb4-1e18-3c19-15dd-66951541abdf@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2023 10:31, Claudiu.Beznea@microchip.com wrote:
> On 17.05.2023 17:15, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On Wed, 17 May 2023 12:41:19 +0300, Claudiu Beznea wrote:
>>> Convert Atmel slow clock controller documentation to yaml.
>>>
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>  .../devicetree/bindings/clock/at91-clock.txt  | 30 --------
>>>  .../bindings/clock/atmel,at91sam9x5-sckc.yaml | 70 +++++++++++++++++++
>>>  2 files changed, 70 insertions(+), 30 deletions(-)
>>>  delete mode 100644 Documentation/devicetree/bindings/clock/at91-clock.txt
>>>  create mode 100644 Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml
>>>
>>
>> Running 'make dtbs_check' with the schema in this patch gives the
>> following warnings. Consider if they are expected or the schema is
>> incorrect. These may not be new warnings.
>>
>> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
>> This will change in the future.
>>
>> Full log is available here: https://patchwork.ozlabs.org/patch/1782586
>>
>>
>> sckc@fffffe50: '#clock-cells' is a required property
>>         arch/arm/boot/dts/at91sam9n12ek.dtb
>>
>> sckc@fffffe50: 'clocks' is a required property
>>         arch/arm/boot/dts/at91sam9n12ek.dtb
>>
>> sckc@fffffe50: 'slck', 'slow_osc', 'slow_rc_osc' do not match any of the regexes: 'pinctrl-[0-9]+'
>>         arch/arm/boot/dts/at91sam9n12ek.dtb
> 
> Is it possible that this has been checked on a wrong base? I'm asking this
> because:
> - patch 3/5 in this series uses proper bindings for slow clock controller
>   on at91sam9n12.dtsi (which includes #clock-cells and clocks bindings and
>   removes slck, slow_osc, slow_rc_osc)
> - patch 4/5 in this series does s/sckc@/clock-controller@/ in all AT91
>   device trees.

Yes, it is quite likely. It's up to you to investigate it or ignore if
you are sure report is a false positive.

> 
> Moreover, I've re-checked all the individual dtsi files that describes a
> slow clock controller and all descriptions has the "#clock-cells", "clocks"
> property available and no slck, slow_osc, slow_rc_osc as childs of
> sckc@fffffe50.
> 
> If not, could you please let me know your checker command?


make dbts_check

Best regards,
Krzysztof

