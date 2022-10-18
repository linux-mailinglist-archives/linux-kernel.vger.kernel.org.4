Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA16603154
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 19:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiJRRFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 13:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiJRRFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:05:08 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74802D1CA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 10:04:58 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id g16so5239479qtu.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 10:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DEzQc+Bct6/RN359ieT08SroCePicyjw/ZP5+4KzKko=;
        b=Yv2Yf4MClIPvLvVthW6ibzYYs/8MCcjv7A0cDTf+ru3A3yKWSCT11z1/dmpHREgniS
         CZd8pRhZMM+2t6neOlbn+S9t/NHa3ZGG1QDeEF1tJ5P1eydU7WrOByCOReTDMVU6RSpW
         +qqVuLR71UnsGlES4mbhwEr2E9ViuS9xEAQ5e4hiRiqcoW/DH3vqKiAcaan43qpXSPyO
         gYed5+tLNdW53lishFHaqOzaBduIBigay/B2t3gz835uJF1s7QSI+z76uOn1xsXwwCA9
         GaXKgl79Yx64ZuZyKOFYVJImUWHbwEfvupBj5ejMUARQb1SO9vT6+FJnhkVVI20FEQQ0
         973w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DEzQc+Bct6/RN359ieT08SroCePicyjw/ZP5+4KzKko=;
        b=I64DQd/walsiaMQjr1Go6MlQ+TUhHXoXuaHU7SPj/3m8hYttyOqYUWY9GGe/J4Gm7S
         gj5ckZ4PN/7nsDQyiM0h2Je3Q32PrrEEjbt28DzHF+El9ntuCKIVfi3TUQ1m5geulPet
         atg07oO+/Sqx301gpBWQSjcjiIHPE8u7PX2jtKhrEDNRYJLO6aZ334yfYJeYu9t9LcCx
         Xu5Vtixc+U8hJvRpQ1yiDEDFufdY42POxnP09gq5cCLLwijVUI04/bEIaIlvRWHgdsKQ
         Xw4Fwa5umzgZAf8r90tFlwbOBmnM2coz+S5s/fHnFONrYTXymrcnmfyxKPGXwXvBPohX
         zbvA==
X-Gm-Message-State: ACrzQf3UxMmt3f3QacD4kLvcw9fSu+CSBUKZrXVazIWlHXLN8EFgnvow
        gXnOXpUqqrSrI8arvV8OzkxOsA==
X-Google-Smtp-Source: AMsMyM6O5+hrWJ0mMLBWOJaqqxIhaz6RjAnqBNmY+sO63zvY7Q+NXA1KOLcuPzNWaNyH5Suv784shw==
X-Received: by 2002:a05:622a:1d4:b0:39c:ef9b:e77f with SMTP id t20-20020a05622a01d400b0039cef9be77fmr2864814qtw.529.1666112697242;
        Tue, 18 Oct 2022 10:04:57 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id u24-20020a37ab18000000b006bb83c2be40sm2757555qke.59.2022.10.18.10.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 10:04:56 -0700 (PDT)
Message-ID: <56ce7440-b60b-4688-c7ac-d0435f79eb97@linaro.org>
Date:   Tue, 18 Oct 2022 13:04:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/4 v5] dt-bindings: memory: Factor out common properties
 of LPDDR bindings
Content-Language: en-US
To:     Julius Werner <jwerner@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org, Jian-Jia Su <jjsu@google.com>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <20220930220606.303395-1-jwerner@chromium.org>
 <166610580692.30968.11562735981650899285.b4-ty@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <166610580692.30968.11562735981650899285.b4-ty@linaro.org>
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

On 18/10/2022 11:10, Krzysztof Kozlowski wrote:
> On Fri, 30 Sep 2022 15:06:03 -0700, Julius Werner wrote:
>> The bindings for different LPDDR versions mostly use the same kinds of
>> properties, so in order to reduce duplication when we're adding support
>> for more versions, this patch creates a new lpddr-props subschema that
>> can be referenced by the others to define these common parts. (This will
>> consider a few smaller I/O width and density numbers "legal" for LPDDR3
>> that are usually not used there, but this should be harmless.)
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/4] dt-bindings: memory: Factor out common properties of LPDDR bindings
>       https://git.kernel.org/krzk/linux-mem-ctrl/c/087cf0c5a19c638dd3b26fe7034274b38bc8db6b
> [2/4] dt-bindings: memory: Add numeric LPDDR compatible string variant
>       https://git.kernel.org/krzk/linux-mem-ctrl/c/f4deb90635ec8a7dd5d5e4e931ab539edc9a9c90

Run checkpatch before sending patches to the mailing list... This was a
v5 so I expected it ti be clean.

Best regards,
Krzysztof

