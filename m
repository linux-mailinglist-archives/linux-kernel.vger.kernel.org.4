Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930D3693161
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 14:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjBKNtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 08:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBKNtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 08:49:19 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA1B28237
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 05:49:18 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso5953305wms.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 05:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MnfzBiktksQsGYvw/qPfvChM1tKpn2xHHEtb2ZxpH3A=;
        b=x1gnL8NKsVz5ZGzWVr/mJF13Vjl3h7Rwmz5oYj5ywVWD4HAFKr2BzYSEfIWbMG4vYz
         CDYQMgrEGV9FIr4E1OuD6rk7BNROlyjz3Yc16SY6quecz1i5BjrXGplAjrsbFHtjb/8q
         Wq+sQ249kCvAB0xQM8YfCLwhBA1ipOlztN+gTAsfijIi8AAi29NAWuicCvd8JiM3sIpf
         D+eGJWOqYtkD0kRRUrgJJgJwFBfv4kM7rcRsZZQm1thFBThFmLxogORlpI21uVq5+bfa
         Flm6UQ5HaUFTKVkC6HMljqP+javiJ+chQWbdOJ2nG/qpkYEPW3WpwJWak1fcSlIGW0DA
         iJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MnfzBiktksQsGYvw/qPfvChM1tKpn2xHHEtb2ZxpH3A=;
        b=i9Hao1C3YJ6L50ga1iHhv6sQr+5t9srB5yQhC9egvRzdieljTPUz8CjoU+baPaOK8E
         wIERCWsTORTCApobwVBgvtC5ZC6lZI+2zmi6t5eJJxZ6eOYANVb+W1F5cEMKSwx0+plA
         5/eBRTDWCQg5GqhnhBjeV1icuOuCj3/SJLPoruBiVxH4T5D5GhNAFS24MI8aYwtbg3bF
         ZxjgQdNFm4dL5IOhcw9DSH/7Yt+Kr+IIO7mh5BA5g0RCY3GKVPAxG6JS7CGSQNmF+24Y
         CfR1Tsu3D5Hr8SVSdMXppgb3hLqYoGV2Y+zkn4zxjzju/h9+XuN8CUihzUoWsnlPHoVQ
         MipA==
X-Gm-Message-State: AO0yUKWwUryKlx9FrSdBniK4WjJ2iFcEyctGDM1F3N6OfphCWz1UsnS5
        33ArhJsytnlfnFVG+ie5Vt/U7A==
X-Google-Smtp-Source: AK7set/LsuYodEEOcidXf0D4o0B3LrUM3jAixoxUL02Fyge8P3l4XD+91MwFH+ek7E8+PWPC0x1n3g==
X-Received: by 2002:a05:600c:4d97:b0:3e0:c75:7071 with SMTP id v23-20020a05600c4d9700b003e00c757071mr15266644wmp.5.1676123357077;
        Sat, 11 Feb 2023 05:49:17 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:e13f:18ce:8394:3c66? ([2a01:e0a:982:cbb0:e13f:18ce:8394:3c66])
        by smtp.gmail.com with ESMTPSA id t15-20020a5d534f000000b002c55306f6edsm135154wrv.54.2023.02.11.05.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 05:49:16 -0800 (PST)
Message-ID: <f727dd7d-08a8-acdf-316c-d571e36a4b1e@linaro.org>
Date:   Sat, 11 Feb 2023 14:49:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] dt-bindings: phy: amlogic,g12a-usb3-pcie-phy: add missing
 optional phy-supply property
Content-Language: fr, en-GB
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230207-b4-amlogic-amlogic-g12a-usb3-pcie-phy-fix-v1-1-3e437b759549@linaro.org>
 <Y+Z5xOlAeqO6JyIj@matsya>
From:   Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <Y+Z5xOlAeqO6JyIj@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 10/02/2023 à 18:07, Vinod Koul a écrit :
> On 07-02-23, 16:03, Neil Armstrong wrote:
>> Add missing optional phy-supply property used to power up PHY regulators.
>>
>> Fixes: 87a55485f2fc ("dt-bindings: phy: meson-g12a-usb3-pcie-phy: convert to yaml")
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   .../devicetree/bindings/phy/amlogic,g12a-usb3-pcie-phy.yaml          | 5 +++++
> 
> I dont have this file in my tree, what was this based on?

It has been renamed in a previous patch by Heiner: https://lore.kernel.org/all/8d960029-e94d-224b-911f-03e5deb47ebc@gmail.com/

Neil

> 
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/amlogic,g12a-usb3-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/amlogic,g12a-usb3-pcie-phy.yaml
>> index 129d26e99776..3314711292d6 100644
>> --- a/Documentation/devicetree/bindings/phy/amlogic,g12a-usb3-pcie-phy.yaml
>> +++ b/Documentation/devicetree/bindings/phy/amlogic,g12a-usb3-pcie-phy.yaml
>> @@ -35,6 +35,11 @@ properties:
>>     "#phy-cells":
>>       const: 1
>>   
>> +  phy-supply:
>> +    description:
>> +      Phandle to a regulator that provides power to the PHY. This
>> +      regulator will be managed during the PHY power on/off sequence.
>> +
>>   required:
>>     - compatible
>>     - reg
>>
>> ---
>> base-commit: 49a8133221c71b935f36a7c340c0271c2a9ee2db
>> change-id: 20230207-b4-amlogic-amlogic-g12a-usb3-pcie-phy-fix-b5daf54fb7d6
>>
>> Best regards,
>> -- 
>> Neil Armstrong <neil.armstrong@linaro.org>
> 

