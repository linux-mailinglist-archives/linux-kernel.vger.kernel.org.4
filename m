Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297AC6CD896
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjC2Lhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjC2Lhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:37:43 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104194233
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:37:41 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id h9so15738351ljq.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680089859;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/mPqUZsIheYp4PXF7QUo518QtsktPDNZj6+NdEGhwtc=;
        b=NpB3I/3t6Lr2Ro2+EJkY6MoU+efyaKtpbJK9meLzt/PnkQ9vfc9GKCjdALUV2XM7tv
         tBuhn04cg21GiS2DFH5U8oHTeO8uOGuXWiuqRf3OzFUrQoSUeZ06DcuQ+QlL2y4U+gl3
         uOkXiLElUVfUv+FaFVKv7u/HJDLd7NlNz9PXqLSxs5cQq+Kzel/ytYNTzzDGfXD7+C1i
         0s5vXwB8fS8D9pp80biD7hzYYp9Jx/CcXaIkTHu2k8l824Laa1blGq2f/Dw7X2jRgwA7
         NwUfxVEEdJGnFvzA+Ho0dj78IjBb8xQQ3fYA8PHTsbd86od6K8oJtZkk0jlMzQJcVcHa
         GXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680089859;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/mPqUZsIheYp4PXF7QUo518QtsktPDNZj6+NdEGhwtc=;
        b=oyVkaFZAzBHP6fX/f2QB7CS50cxD9QaG6a8S4La/DNnKbqz2ZssFf1PgbuXUa2gmhR
         4eEwTJHBRaBEAJmOImz0U011osS/iROma0ID05lwPREOsEGQ7Gp+/F3QR+8jV4aAsGcV
         b9n9R9/kWaLEAKYJFHcx63WpqUxGXo05KYDIF2HHHPTijl372cSFq3513QYUct5uR8ZA
         /XQ/+dyuRn6sWmFtUpeB8Fc0FMRgZFGJcAUIxR8i/+JSqUC0PxTC/86dAMZ3Qv0t9f3O
         VEqqVhWB63Fk/qOi3iJdYV1NzYpiwMUO4NiJgw/d18J9yAEQzX3VA+ZDmjoxxJSLGQn3
         4W3A==
X-Gm-Message-State: AAQBX9cpWX0oyZqywt+Iz/g7IjNKfnHTZGgFPHfmTAkMf683kDLB7K8W
        o8Z4oITTQWveZ8iZqw6aipMY/A==
X-Google-Smtp-Source: AKy350Y9MsLYN1pnTgHTW80ELhfO9f2kj3EVc9bx5pgZ5cHDPeoOaEuf4c+eqX8TZxSTOejxy/xHDw==
X-Received: by 2002:a2e:a174:0:b0:299:aa88:8dd8 with SMTP id u20-20020a2ea174000000b00299aa888dd8mr6285200ljl.50.1680089859145;
        Wed, 29 Mar 2023 04:37:39 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a18-20020a05651c011200b002a483f01d9csm1902273ljb.85.2023.03.29.04.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 04:37:38 -0700 (PDT)
Message-ID: <f62c07d4-cda8-9873-8890-3411cd2f3b03@linaro.org>
Date:   Wed, 29 Mar 2023 13:37:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 1/2] dt-bindings: spi: add loongson spi
Content-Language: en-US
To:     zhuyinbo <zhuyinbo@loongson.cn>, Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        Mark Brown <broonie@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
References: <20230328112210.23089-1-zhuyinbo@loongson.cn>
 <20230328112210.23089-2-zhuyinbo@loongson.cn>
 <168000761529.3001360.2224316097077012976.robh@kernel.org>
 <8336d5ba-1150-81ca-bd5a-7862bd10ef58@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8336d5ba-1150-81ca-bd5a-7862bd10ef58@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2023 12:39, zhuyinbo wrote:
> 
> 
> 在 2023/3/28 下午8:57, Rob Herring 写道:
>>
>> On Tue, 28 Mar 2023 19:22:09 +0800, Yinbo Zhu wrote:
>>> Add the Loongson platform spi binding with DT schema format using
>>> json-schema.
>>>
>>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>>> ---
>>>   .../bindings/spi/loongson,ls-spi.yaml         | 43 +++++++++++++++++++
>>>   MAINTAINERS                                   |  6 +++
>>>   2 files changed, 49 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
>>>
>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> Error: Documentation/devicetree/bindings/spi/loongson,ls-spi.example.dts:22.28-29 syntax error
>> FATAL ERROR: Unable to parse input tree
>> make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/spi/loongson,ls-spi.example.dtb] Error 1
>> make[1]: *** Waiting for unfinished jobs....
>> make: *** [Makefile:1512: dt_binding_check] Error 2
>>
>> doc reference errors (make refcheckdocs):
>>
>> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230328112210.23089-2-zhuyinbo@loongson.cn
>>
>> The base for the series is generally the latest rc1. A different dependency
>> should be noted in *this* patch.
> Hi Rob,
> 
> I'm sorry, actually, I don't know what the specific operation I should 
> do when I received the check warning
> from your bot. Does it means that I should add dependency note into this 
> patch's changelog ? 

Yes, this is explicitly mentioned in the sentence you quoted.

> or something else, I really
> don't know. Actually, I'm always bothered by these things that how to 
> resolve the dependency issue for two
> dependent patches that do not belong to the same series.

Another approach, as Rob suggested last time, would be to just get rid
of the dependency and open-code the clock IDs...

Best regards,
Krzysztof

