Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2EF72CD6D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbjFLSD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbjFLSDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:03:54 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FC3E69
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:03:51 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-977e7d6945aso822903866b.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686593030; x=1689185030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+gBq/t0JN3IzKswRA94RxVh/S2cDbwUrf8NJSpnNdH8=;
        b=Pw8r5MbGovGypHmtBmz6yfhQEnE+zUeLQ2WrirrWlxDjY+Aa/GR882ginIgV7EVeZR
         br86bMhYeKThvzp+ijHJIOzfkudyrCQgNEeI1xZPfJpUWA9zHTYufZK1o4L34Y3+wauY
         +LRr3vGFamsvz3GrEHI5t0TjS/UnwvcdkK7Ttg9Xwe7VA6LI6Iy97c8UEXAYEGgMCwpC
         TDC3sSa8xRknm9JvynmXNuOFlWIoV+x11A/BihgqxvM5YSBCWoIr2PjcfQiAfbIiW/rM
         +ouAZt1X1wqeE8eJhWRkvj7xu2jlCvbs8/vpRLwlxcS0ntoqAXDW5kQoVvl5B3S0mP7Q
         k0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686593030; x=1689185030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+gBq/t0JN3IzKswRA94RxVh/S2cDbwUrf8NJSpnNdH8=;
        b=bFdzqzTl4bKvGYfF0k1usMu0lb5cbJjtjh+xd99idakzT/BHTw45xM+Ls4IO/IluNh
         LJ4D0qKhOCCHcCisW1ItlePH1amzb5q9oE3QsHgZPTDMXAIZGsVr0FRSulVbdA9UJ3Lw
         0xBlHjaFtDAyLC/HVMTHoZhJsTl5gvsGA4THE/gSy6GWTkAov14I482bFJMGVF6XMN8A
         +2fa1sLw8ZJfZS94j4RbQNgIq99I+HtZ16b+5X7y9vCOgeI3vDskNQ+tbddzqzFl4R0g
         mdR9/D3DS+2tr1qJ9UN7csBWI6OaDhjPw2+0+PMLKIbKFdvpsAXv1s1xT4gvkeUB+nFb
         wqVA==
X-Gm-Message-State: AC+VfDz/sNj42Y4FM1sXYcOPAVE2yRsX3sOk1fI+80MBJF6KI+KDV+sS
        SxAnDRrWV7cDz2QWA5j6yoXE5A==
X-Google-Smtp-Source: ACHHUZ6r1a+S4U278JHtoJCXri2PKwOvWFUCGuQzut1SdnewBrBtda3IbFuJC7OwiaB1N2wI/WMZYw==
X-Received: by 2002:a17:907:6d23:b0:96f:b8a0:6cfe with SMTP id sa35-20020a1709076d2300b0096fb8a06cfemr10181499ejc.54.1686593030299;
        Mon, 12 Jun 2023 11:03:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id e26-20020a1709062c1a00b00974556e50a6sm5524182ejh.114.2023.06.12.11.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 11:03:49 -0700 (PDT)
Message-ID: <28e776f8-1e37-79f4-5c10-a57c5cd7d4e4@linaro.org>
Date:   Mon, 12 Jun 2023 20:03:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v12 1/2] spi: add loongson spi bindings
To:     zhuyinbo <zhuyinbo@loongson.cn>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
References: <20230608072819.25930-1-zhuyinbo@loongson.cn>
 <20230608072819.25930-2-zhuyinbo@loongson.cn>
 <6ebed84c-2b42-c981-7b3f-e71cc88e4c2c@linaro.org>
 <4bf747c4-b767-b20c-e00f-724b50f44edb@loongson.cn>
 <6bfc2a22-6901-0858-7b90-bc4c52c66810@linaro.org>
 <bd2d7830-3ab6-0906-b06a-83d3e0a96749@loongson.cn>
 <11ca2b90-544d-18c2-fb15-7909ca60507f@linaro.org>
 <f6d4ecb5-e9df-346e-4aab-772fd01689c8@loongson.cn>
 <a9952e76-1204-5bc7-7856-0c7f8a411d76@linaro.org>
 <9c94397d-1e31-02fa-bdbe-af888c72eac4@loongson.cn>
 <657f8d19-de83-8be6-4a9d-5f13b1df7383@linaro.org>
 <b0e5e13e-6746-bd90-2a49-31ee6dd3e8a2@loongson.cn>
 <84ccf4cc-072d-adbf-0361-95ceae13f333@linaro.org>
 <5d060cac-ff28-60e9-98a8-f2bd4d378455@loongson.cn>
 <4e30870d-86e2-8536-8e0d-aab4ce5027d2@linaro.org>
 <0c532e09-4821-5e07-92e6-7bc3cd79869e@loongson.cn>
 <d24f1e60-0ef3-2cb9-9675-846d861ef0c8@linaro.org>
 <9fec9cfa-0686-91d8-cba4-91ea67243b47@loongson.cn>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9fec9cfa-0686-91d8-cba4-91ea67243b47@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2023 13:29, zhuyinbo wrote:
> 
> 
> 在 2023/6/12 下午4:16, Krzysztof Kozlowski 写道:
>>>>>>>>> 在 2023/6/8 下午7:45, Krzysztof Kozlowski 写道:
>>>>>>>>>> On 08/06/2023 13:42, zhuyinbo wrote:
>>>>>>>>>>> --- a/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
>>>>>>>>>>> +++ b/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
>>>>>>>>>>> @@ -16,6 +16,7 @@ properties:
>>>>>>>>>>>          compatible:
>>>>>>>>>>>            enum:
>>>>>>>>>>>              - loongson,ls2k1000-spi
>>>>>>>>>>> +      - loongson,ls2k0500-spi
>>>>>>>>>>
>>>>>>>>>> Aren't they compatible?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Are you saying that the spi driver is compatible with 2k0500 ?
>>>>>>>>
>>>>>>>> Didn't you say this through 11 previous revisions?
>>>>>>>
>>>>>>>
>>>>>>> Yes, did I understand your meaning incorrectly ?
>>>>>>
>>>>>> If they are compatible, then they are not part of one enum. They could
>>>>>> not be as this would easily fail in testing of your DTS.
>>>>>>
>>>>>
>>>>>
>>>>> The "loongson,ls2k0500-spi" wasn't a compatible in previous version and
>>>>> I will add "loongson,ls2k0500-spi" as a compatible in spi driver and
>>>>> added it as a part of the one enum in dt-binding.
>>>>
>>>> No, because you claimed - if I understood correctly - that they are
>>>> compatible. Don't add fake entries to the driver.
>>>>
>>>
>>>
>>> I'm a bit confused, and I just need to add 'loongson,ls2k0500-spi' as
>>> one enum in dt-bindings, but driver don't add this entry ?
>>
>> Compatibility is expressed with a list:
>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#compatible
>> so it cannot be just one enum, but "items". There are hundreds of
>> examples including example-schema.
> 
> 
> Is it a description like the following?
> 
>   properties:
>     compatible:
> -    enum:
> -      - loongson,ls2k1000-spi
> +    oneOf:
> +      - enum:
> +          - loongson,ls2k1000-spi
> +      - items:
> +          - enum:
> +              - loongson,ls2k1000-spi
> +          - const: loongson,ls2k1000-spi

Remove this items part - it does not make sense. Device is not
compatible with itself. Rest looks ok.



Best regards,
Krzysztof

