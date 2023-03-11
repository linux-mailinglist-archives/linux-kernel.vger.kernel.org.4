Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03466B5F72
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 18:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjCKR5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 12:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjCKR5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 12:57:23 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D697B8568B
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:57:20 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id cn21so2972553edb.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678557439;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ZzQFADWQjYXc6+XH0LPEMabA+seTwz6QtTtf51Ujcc=;
        b=VIcpHFImgRhlLPDoAAMSYk1JItJrJb2/5qlI512iy4Ll+JGtg0KN3SokgrHV+HHxH1
         cIgv29IiPHvP1U8Lya7ABerW7uoYjqoqWKU8ddgDPt4KFcOH9+xmnPn97Uq+IjHt5OqD
         r5X8FEvzzXmS2QOwIJ4i84D+kftk75y+C7w5F/MxD2qoV3sTLXS+TsulF6mBgM8IbTFk
         78zgOBEuoFmrPrmwZa3cF47If6Kl4NBC3Zoy7O8W/fYf2G5a6LIKEzQJHz46l5HJb/1M
         x0xl9O6R6qiYTDQpycOY08QrL11HgQBM6Qe8qoT4mkSKNIO4mS4Qg7UiJs+jaElbBj2s
         c0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678557439;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZzQFADWQjYXc6+XH0LPEMabA+seTwz6QtTtf51Ujcc=;
        b=QeSIkSyh5HIczddY6BFofC8JxEK1vqEchP8MDz38B0C1xDgwbJdpvQ6ztC4gooH4/C
         b7TXZ/fP2oTIdSmDJoYzNoYv20KI68Z0h74YRlQ2E1IqWW4M7uQyK2Z/GWbi6Id6KLRE
         pUSXrheoGjay4Xi87T5KWbjfvHpLmpirnpLQ1FlHyplTFp3DvJbR+0fnDQdzevw6Fz8J
         I6d7Oko3nFek1a+YmZnRNeNnpgcidDokapYsOEVQag82kxO9PZPbgsjshPv/br9KdNlW
         x1FbIBiuLNocqxg/GunwVVabcAFlx0CkWkol2RaMQtRT24i55RMNrUduYIT9D9OVCBA9
         728w==
X-Gm-Message-State: AO0yUKVyoNmsKjnxww/o7sseoh1nuo6Fa6jLYND/+vOiz4+K8m3lgKUz
        6rWJKjHXc+4X2eQEt/PMMiHeDKvfWOfcOSF2jIg=
X-Google-Smtp-Source: AK7set+aVOQ4IW3YvNK0hGqeruski1GhpuLa88OUPQx0N+Cxu+PYrmbclVVWvTknUtwz4HOeXe+RIg==
X-Received: by 2002:a17:906:66cd:b0:8e8:602f:847a with SMTP id k13-20020a17090666cd00b008e8602f847amr27819882ejp.24.1678557439406;
        Sat, 11 Mar 2023 09:57:19 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:6927:e94d:fc63:9d6e? ([2a02:810d:15c0:828:6927:e94d:fc63:9d6e])
        by smtp.gmail.com with ESMTPSA id ji16-20020a170907981000b008dea022f5e6sm1317076ejc.24.2023.03.11.09.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 09:57:19 -0800 (PST)
Message-ID: <4de11c0b-8e09-c3ef-4180-585662386859@linaro.org>
Date:   Sat, 11 Mar 2023 18:57:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: broken subject?
Content-Language: en-US
To:     Sergey Lisov <sleirsgoevy@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <c13993bc-9d12-f20e-de27-fa0b8a58ed33-1-sleirsgoevy@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c13993bc-9d12-f20e-de27-fa0b8a58ed33-1-sleirsgoevy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2023 18:40, Sergey Lisov wrote:
>>> ---
>>>  .../devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml    | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>

Why did you remove the subject? Please keep the mailing process matching
mailing lists. It messes with mailboxes, filters and reading process.

>>> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
>>> index 8dfad89c7..2bc5ac528 100644
>>> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
>>> @@ -57,6 +57,12 @@ properties:
>>>        force fifo watermark setting accordingly.
>>>      $ref: /schemas/types.yaml#/definitions/flag
>>>  
>>> +  fifo-access-32bit:
>>
>> Missing type boolean.
> 
> Thanks, will add the same $ref as for the entry above.
> 
>>> +    description:
>>> +      Specifies that this device requires accesses to its 64-bit registers
>>> +      to be done as pairs of 32-bit accesses, even on architectures where
>>> +      readq is available.
>>
>> And why the device would require this? If it has 64-bit registers in the
>> first place, they can be accessed in 64-bit. Otherwise these are not
>> 64-bit registers, but just lower/upper 32-bit, right?
>>
>> Also, why this cannot be implied from compatible? Why different boards
>> with same SoC should have different FIFO access?
> 
> It probably can be implied, but I am not exactly sure on which boards it
> affects, so I decided to go for a new devicetree option. Anyway, the same
> argument applies to the "data-addr" property, which is already in the
> spec, so I supposed that adding such knobs is fine.

Yeah, Rob acked it so I will let him to judge this. To me it looks like
unnecessary fragmentation - this looks like compatible specific, not
board. Anyway you need to resend to fix all the mailing mess.

Best regards,
Krzysztof

