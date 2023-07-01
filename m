Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE27674489B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 13:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjGALBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 07:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjGALB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 07:01:27 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B403C00
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 04:01:24 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-992b2249d82so297635266b.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 04:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688209283; x=1690801283;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dZ1or/MdMx0omH5bKg4Oj18nw/lksLHMXCAGiNzJOQ4=;
        b=l5ATTLEkTO6e3mMV4Zd/lzxiZOKjq9mQSPrWhK2DFNU1A1eHH4GcFlE4AI1mwkBhN1
         0e3OO/PYcI/uXGYv0iBLZahCX5H4/N+CPOyQN/HD2RZVL5jVeF2xVRZ4xMRnSTQ5bAHU
         HaBMFgPTvEQbduVWcooM13IMk7rSph8N0J1UwfkdwmHsLPZglXgeMMx3BJuqAlyj3P+o
         LDEk8b6oVyBYRjCsT2D0wBBLK7Sxs2ZRDkhbAnhxef1475ZhyEWdu6bOgnp0UxsBHUBJ
         LigN6sghjD2mXQKLfLpUTGhm0RAiouU+42/DfhvkaIR3j39nNWKB92zGcTecaADMKroS
         gVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688209283; x=1690801283;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dZ1or/MdMx0omH5bKg4Oj18nw/lksLHMXCAGiNzJOQ4=;
        b=J4V10mT0c+0BgRjj2osRn7mE7zTg/tWVfYk0a3FhdX5ILrrhdIErAMtY09W3fO6rja
         dhQfb4Kn9ab/JEJcgJPgjCZqYB68E6Oor9dx6HY/mdQ8tB3WqC1KtCWgdH2FHQh+4YhH
         T11pFhgoW/ri2OgFj1nixAlPN73cDaBvKiq5PJhNnXTIFE1cWDkb14lurW81BnR6GDK5
         szoYP+9QpNnkv/9NepgxxD2W1JANdD3Ebq4qnaaIQ0VzCk/ChrKKep+fdljllC5TsDIr
         e9KMPPJuROPL89XHGkf71kHUFW00GkFChbNVch6O1nfwo2Dw/7gJqyLdoKyPr8r9ZqSf
         RflA==
X-Gm-Message-State: ABy/qLZ7zP9bQTRk7NltF71FExPz6ItzQWSVF7AsRCXQGhup5OmbQx6L
        W1K0TrgZ3PKr7ODXhblAkCJb0A==
X-Google-Smtp-Source: APBJJlElNbbZdOdk19QhJCE35zZn5Te95ct9xR7hyv0ISeTz7uMTomfWvFBRbgRu/jsnLzZJIKe2tA==
X-Received: by 2002:a17:906:c3a4:b0:98d:f062:8503 with SMTP id t36-20020a170906c3a400b0098df0628503mr3168554ejz.77.1688209282661;
        Sat, 01 Jul 2023 04:01:22 -0700 (PDT)
Received: from [192.168.10.214] ([217.169.179.6])
        by smtp.gmail.com with ESMTPSA id sb22-20020a170906edd600b00982a92a849asm9195404ejb.91.2023.07.01.04.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jul 2023 04:01:22 -0700 (PDT)
Message-ID: <caaf6ada-61a4-df67-0a55-06ab3c19fd3c@linaro.org>
Date:   Sat, 1 Jul 2023 13:01:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/7] dt-bindings: leds: leds-qcom-lpg: Add support for LUT
 through NVMEM devices
Content-Language: en-US
To:     Anjelique Melendez <quic_amelende@quicinc.com>, pavel@ucw.cz,
        lee@kernel.org, thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org
Cc:     konrad.dybcio@linaro.org, u.kleine-koenig@pengutronix.de,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org
References: <20230621185949.2068-1-quic_amelende@quicinc.com>
 <20230621185949.2068-3-quic_amelende@quicinc.com>
 <4ee5f3fc-3376-7421-23cd-8fc905704493@linaro.org>
 <cb7630b4-4953-31df-faeb-a54f7757c1af@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <cb7630b4-4953-31df-faeb-a54f7757c1af@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/2023 02:12, Anjelique Melendez wrote:
>>
>>
>>
>>> +      required when LUT mode is supported and the LUT pattern is stored in a single
>>> +      SDAM module instead of a LUT module.
>>
>> Which devices support LUT? Why this is not constrained per variant?
> When you say constrained per variant, are you looking for something more like this?
> i.e. 
> allOf:
>   - if: 
>       properties:
>         compatible:
>           contains:
>             const: qcom,pmi632-lpg
>     then:
>       properties:
>         nvmem:
>           maxItems: 1
>         nvmem-names:
>           items:
>             - const: lpg_chan_sdam
>       required:
>         - nvmem
>         - qcom,pbs-client
>   - if: 
>       properties:
>         compatible:
>           contains:
>             const: qcom,pm8350c-pwm
>     then:
>       properties:
>         nvmem:
>           maxItems: 2
>         nvmem-names:
>           items:
>             - const: lpg_chan_sdam
>             - const: lut_sdam
>       required:
>        - nvmem

Yes.

> 
>>
>>> +
>>>    multi-led:
>>>      type: object
>>>      $ref: leds-class-multicolor.yaml#
>>> @@ -191,4 +216,64 @@ examples:
>>>        compatible = "qcom,pm8916-pwm";
>>>        #pwm-cells = <2>;
>>>      };
>>> +  - |
>>> +    #include <dt-bindings/leds/common.h>
>>> +
>>> +    led-controller {
>>> +      compatible = "qcom,pm8350c-pwm";
>>> +      #address-cells = <1>;
>>> +      #size-cells = <0>;
>>> +      #pwm-cells = <2>;
>>> +      nvmem-names = "lpg_chan_sdam" , "lut_sdam";
>>
>> Fix your whitespaces.
> Ack
>>
>>> +      nvmem = <&pmk8550_sdam_21 &pmk8550_sdam_22>;
>>
>> Two entries, not one> 
>> Anyway, adding one property does not justify new example. Integrate it
>> into existing one.
> 
> So we actually cannot integrate these properties into existing examples.
> The current examples are for PMICs that use LUT peripherals (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/leds/rgb/leds-qcom-lpg.c?h=v6.4#n1417).
> This patch series is adding support for PMICs that do not have a LUT peripheral
> and instead store LUT patterns and LPG configurations in either 1 or 2 NVMEM(s). 
>>
>>> +
>>> +      led@1 {
>>> +        reg = <1>;
>>> +        color = <LED_COLOR_ID_RED>;
>>> +        label = "red";
>>> +      };
>>> +
>>> +      led@2 {
>>> +        reg = <2>;
>>> +        color = <LED_COLOR_ID_GREEN>;
>>> +        label = "green";
>>> +      };
>>> +
>>> +      led@3 {
>>> +        reg = <3>;
>>> +        color = <LED_COLOR_ID_BLUE>;
>>> +        label = "blue";
>>> +      };
>>> +    };
>>> +  - |
>>> +    #include <dt-bindings/leds/common.h>
>>> +
>>> +    led-controller {
>>> +      compatible = "qcom,pmi632-lpg";
>>> +      #address-cells = <1>;
>>> +      #size-cells = <0>;
>>> +      #pwm-cells = <2>;
>>> +      nvmem-names = "lpg_chan_sdam";
>>> +      nvmem = <&pmi632_sdam7>;
>>> +      qcom,pbs-client = <&pmi632_pbs_client3>;
>>
>> One more example? Why?
>>
>> Why do you have here only one NVMEM cell? Aren't you missing constraints
>> in the binding?The use of the qcom,pbs-client is only used when we have a PMIC device that has a single PPG NVMEM, 
> which is why this was not included in the above 2 nvmem PPG example. I see how these two PPG examples
> are repetitive so I am ok with getting rid of one of them but I do think we should have at least one PPG example.


This example probably should replace one of the previous ones, because
it is bigger / more complete.

Best regards,
Krzysztof

