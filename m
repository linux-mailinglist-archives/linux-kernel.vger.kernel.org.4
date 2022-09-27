Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202A05EBEB8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 11:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbiI0Jfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 05:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiI0Jfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 05:35:45 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F6C979FB
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 02:35:43 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t14so14050576wrx.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 02:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=bYDduPOYUHGL+haj1p8TyQkIszmepMQqlkeaZAG58xQ=;
        b=pqxCY9Jcv96qIg0b1ZjiLbxmNwVLM6AKPHt/eLZ4X/++56Du72O4kXt2u4iJ//B8Kw
         rE9ypTLDUKI4bioBu0TYYob4rbd4ztUedOfjpc2CbDQlcGKzIRy+8q45jzxPI5MKiIL9
         /Pw9DBKJhJeEW5W6iPOiSj8+ZzHVbRiRRuYwtOkPFs7pUH7d00/POKAfoW6eyTovU1pM
         JGrxLHCmstOb+yqRFsgSMh0NXDddRqGfZ2iqJ0jYHQLbrYImFfVTxKRYu5QRDzoTKhiA
         uWC/d8tBim6PMeCRRF4WuW4Nu/lmzmRh1r3+bDxQhdGyR1xh2XXMtPrM0al/e232KRfD
         H+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=bYDduPOYUHGL+haj1p8TyQkIszmepMQqlkeaZAG58xQ=;
        b=LrO9bISqmx4n2oRn+ogWs9aPzM4j0J8Ts/luimKRQChb74yPd+S51orihnZufAwFOH
         HLxgEvH2D/rHk2hblxKkdL0PpAQXIze9+P+ZGpZIgB6cwEiNsmfrNoh1Ncxl4ZJxLeqt
         jKBCNdjt3Dt05H05z5id2Lr6Q8r+yn2cZQ2QncxKc6QIOdScwrfjg18I4Z00iom/S6Sm
         PViLYE4+ck+fK2rjtEHCn7iuuWC1TLzhKs3/IkQ/j+gRdny4xe9WqJXoah8pSYuLmpwh
         HR057GjZlDWxbDRw1HUxGUX0SyY1W33KI4Aeh6+zrONHRPsORWtV+6EdZc9WUpdI9q+o
         +SLQ==
X-Gm-Message-State: ACrzQf3Rr6J6ORBi1tzxEavgfhZCtFQ5q4p++IPMygcqvuuf7COjWpsI
        /zQXbmVZFVWMFGFR457HxNz+aQ==
X-Google-Smtp-Source: AMsMyM5hLEsgw/sMl4xl47SSdL796TJP4p8NX1zAeCjjbSox0gvaWDZaX7FcMrbeGpH36FlEmAJwSQ==
X-Received: by 2002:a5d:5887:0:b0:22b:107e:7e39 with SMTP id n7-20020a5d5887000000b0022b107e7e39mr16606742wrf.694.1664271342352;
        Tue, 27 Sep 2022 02:35:42 -0700 (PDT)
Received: from [192.168.0.20] (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.gmail.com with ESMTPSA id m17-20020a05600c461100b003a5fa79007fsm1181762wmo.7.2022.09.27.02.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 02:35:41 -0700 (PDT)
Message-ID: <b37e9ada-79d9-685f-7b74-06f0d32ba271@baylibre.com>
Date:   Tue, 27 Sep 2022 11:35:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] spi: dt-bindings: amlogic, meson-gx-spicc: Add
 pinctrl names for SPI signal states
Content-Language: en-US
To:     neil.armstrong@linaro.org, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        narmstrong@baylibre.com, Da Xue <da@libre.computer>
References: <20220809172017.215412-1-aouledameur@baylibre.com>
 <20220809172017.215412-2-aouledameur@baylibre.com>
 <f9bf3f7e-e949-3e77-a74c-74c0eecd77c0@linaro.org>
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
In-Reply-To: <f9bf3f7e-e949-3e77-a74c-74c0eecd77c0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil

On 9/27/22 10:29, Neil Armstrong wrote:
> Hi,
>
> On 09/08/2022 19:20, Amjad Ouled-Ameur wrote:
>> SPI pins of the SPICC Controller in Meson-GX needs to be controlled by
>> pin biais when idle. Therefore define three pinctrl names:
>> - default: SPI pins are controlled by spi function.
>> - idle-high: SCLK pin is pulled-up, but MOSI/MISO are still controlled
>> by spi function.
>> - idle-low: SCLK pin is pulled-down, but MOSI/MISO are still controlled
>> by spi function.
>>
>> Reported-by: Da Xue <da@libre.computer>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
>
> Don't forget to CC devicetree@vger.kernel.org otherwise it won't be 
> reviewed.

Sure, will do in V2.

Regards,

Amjad

>
>
>> ---
>>   .../bindings/spi/amlogic,meson-gx-spicc.yaml      | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml 
>> b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
>> index 50de0da42c13..10707a8216f5 100644
>> --- a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
>> +++ b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
>> @@ -43,6 +43,14 @@ properties:
>>       minItems: 1
>>       maxItems: 2
>>   +  pinctrl-0:
>> +    minItems: 1
>> +
>> +  pinctrl-1:
>> +    maxItems: 1
>> +
>> +  pinctrl-names: true
>> +
>>   if:
>>     properties:
>>       compatible:
>> @@ -69,6 +77,13 @@ else:
>>         items:
>>           - const: core
>>   +    pinctrl-names:
>> +      minItems: 1
>> +      items:
>> +        - const: default
>> +        - const: idle-high
>> +        - const: idle-low
>> +
>>   required:
>>     - compatible
>>     - reg
