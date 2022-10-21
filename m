Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8682060776E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiJUM75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 08:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiJUM7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 08:59:54 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509E136DDB
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 05:59:49 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id p11so1713977qvr.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 05:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xs86T8FYH3cxwsGgQStZ75SdWF5yjS9RigXMT2iDTuI=;
        b=raelHNIqjAfNIduVyyhSmxlkeTmBDWI5M6eoHxEOrDyKvgNyTbqt/BRWMPAC4nyTU/
         +RIcoIbxCOd1bCVzg0ez40BfCEH8TH5rbH/1bKbuWoMDp9xT+/XTptK0PvMHZJMCBOFo
         tdhKqlH3KQJEvM5sQlNYiMBPzVTM4IIBtCbGm7COkFrpRtKe2PJ0lybfPAALCxS3bMia
         DNJoHxnwgLylRFQfjoTP96dCa7nKWqblDqBC6IG/Fofgnzwn+v1y0EgrqueYHx+2FQX6
         W45YOl3lHnGDZ3YWK12yIQL7vxtLoElGLygLUlaxImLD83SnzCSpERJZLHW0JoEs9BEl
         JuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xs86T8FYH3cxwsGgQStZ75SdWF5yjS9RigXMT2iDTuI=;
        b=SD8dHgQpx+Tj6aapevRHJGNhqyr8nfiYLtOlz2JoIkCzc8sGcAlFYEMni8C0rjczns
         fJA8Mbjt3k6mMdcSwjnmWTZMfcPwf/E97F29KavDuOgug/A4yuhnlmuDY9ERHAbBsVos
         3fQZOEEBF1iR8JUpeUn+yZpl+Xva9Vf4b/Rv2wT1uDGf648Yx1Ii29HETCFp7MdCJNfi
         caj104Kbni+rMhUefuhpdn8zK9gN6xzPULQVvvqQKspYgMD/kbwEDRBMGJvxkWYHMbsE
         mrD9EoQJyTlZXfkpFD09EwsP5Fyv3vt/9dOV5Ad/egcAxr1CXe/EGbMJafHd4b1tLBbW
         vH8Q==
X-Gm-Message-State: ACrzQf2oZEnOgI9vgp6B5K6s6ikEVuxPrR7VG07VGgVvbV7jfp0E+l0V
        wrB5zZG6LGVU34O8xIGFN+jYWA==
X-Google-Smtp-Source: AMsMyM4j88gzow5EGAxNNk2ntX3Dfj86V9wgcexSHaNsAvEEmqSEG+IUzLHqUnaYykHbSpgJR0l5pw==
X-Received: by 2002:a05:6214:1c89:b0:4af:664e:553b with SMTP id ib9-20020a0562141c8900b004af664e553bmr16626198qvb.18.1666357188296;
        Fri, 21 Oct 2022 05:59:48 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id bn4-20020a05622a1dc400b0039ccbf75f92sm7884973qtb.11.2022.10.21.05.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 05:59:47 -0700 (PDT)
Message-ID: <4a0b2e54-e13c-d6e8-261a-a282f35c1a30@linaro.org>
Date:   Fri, 21 Oct 2022 08:59:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 1/2] spi: dt-bindings: amlogic, meson-gx-spicc: Add
 pinctrl names for SPI signal states
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        neil.armstrong@linaro.org, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Da Xue <da@libre.computer>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221004-up-aml-fix-spi-v3-0-89de126fd163@baylibre.com>
 <20221004-up-aml-fix-spi-v3-1-89de126fd163@baylibre.com>
 <d355ee40-5905-4d10-8300-81e9a63117ee@linaro.org>
 <dc918114-8b89-441b-5ba1-aaf3ae084860@linaro.org>
 <20c115e0-0acf-dac2-2a30-0f394fa513ab@linaro.org>
 <df1895c8-aec6-cada-e208-ccda8042860d@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <df1895c8-aec6-cada-e208-ccda8042860d@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 08:54, Amjad Ouled-Ameur wrote:
> Hi
> 
> On 10/20/22 14:49, Krzysztof Kozlowski wrote:
>>>>> +      properties:
>>>>> +        pinctrl-names:
>>>>> +          minItems: 1
>>>>> +          items:
>>>>> +            - const: default
>>>>> +            - const: idle-high
>>>>> +            - const: idle-low
>>>> You should also define in such case pinctrl-0 and others.
>>> Ok I thought it would be covered by the pinctrl-consumer.yaml
>>> but yeah we should allow pinctrl-1 and pinctrl-2 here aswell by adding:
>>>
>>>               pinctrl-1: true
>>>               pinctrl-2: true
>>>
>>>
> In such case, should I define pinctrl- as part of the if statement, as shown below,
> 
> or before allOf ?

The same as pinctrl-names, so part of allOf.

> 
> [...]
> 
>    - if:
>        properties:
>          compatible:
>            contains:
>              enum:
>                - amlogic,meson-gx-spicc
> 
>      then:
>        properties:
>          pinctrl-0: true
>          pinctrl-1: true
>          pinctrl-2: true
> 
>          pinctrl-names:
>            minItems: 1
>            items:
>              - const: default
>              - const: idle-high
>              - const: idle-low

Best regards,
Krzysztof

