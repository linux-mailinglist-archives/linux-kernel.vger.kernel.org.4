Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A4E73B5BE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjFWKwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjFWKwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:52:30 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86AF172C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:52:28 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-311394406d0so483144f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687517547; x=1690109547;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eWEOidUJqp0aLghw7rI6ZPiFar30CL1k7BWpWzIKSaQ=;
        b=fEPfYpNpM+kOWFETP5HHPhwsrhU96CN7hlkvNOZApJD0sTbef+VnuLpfGgpatZzsTf
         ZtxzyO9aFCzREXLWdLBdqQuanuSe1p27au1LN9G9cGvQ0Y+dMFPZZdeRbB1+iKVVHul3
         1fm4Exe6wgpVgPUHPK3P0TTRmVqs5wgtgilmk38LxwUsoGmb9DO/ju3cWLIZiXriTu/b
         YxP0Nu/SIcfqJQpptgkW4u9fQaMbaE/VxH7QXGmTk0KzNxfAUh5AZopwReyIFL7qtgZ4
         UbOgmove+bah38iGaNDz/ffdIjg9enWzqvhp06Yqts//HtHFf/CjtG4PYGgLfJsdnGLm
         UECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687517547; x=1690109547;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eWEOidUJqp0aLghw7rI6ZPiFar30CL1k7BWpWzIKSaQ=;
        b=VhBk1RCLoliw/HG+e1jPg3VauquYUW95TgzJpqgpj6MA2vkQqYOWii3LX9w+eajjHi
         dzbkxjxOLsosQWzRor6AGl74P/mZVl33GNdaADsOGPWVyZqtMiASTbsD4xA4CsJ3dUwG
         qH//QCEFj9F1FwmMNZXjbshd8xAgWxkJigVKqVJtQpch/ajKQ/9QvENSelnbEEZET+HP
         YiSiAOBBZsH2zb3wvh/hxXIrW4nCV7l3q/x8Ee6bovz4lL2D9gJHTlu/yoO/qFkcnZrs
         70sklLqKHY5Z+h4WLgGu/iXAliBV4WJJkxxqQ+GD4d6fcKglyS75XVD+FgPxp9j6QzrJ
         TZEA==
X-Gm-Message-State: AC+VfDwsDm7/njXbVnkhMClRWm5Y76w5g+KxEUcT+HZtTLmtC6s538iV
        mtsQPIQeaNsdwLQVYHjp3Jdf2w==
X-Google-Smtp-Source: ACHHUZ5NzN+KrJhCPGgb27SRp4H+bicuOgMOfPu6WiCpbEXbCfrOYSaqJFBUF7vf7wxFZQPT+lx+Tw==
X-Received: by 2002:adf:f203:0:b0:311:19df:dac7 with SMTP id p3-20020adff203000000b0031119dfdac7mr15248678wro.28.1687517546863;
        Fri, 23 Jun 2023 03:52:26 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id e14-20020adfef0e000000b0030c2e3c7fb3sm9223908wro.101.2023.06.23.03.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 03:52:26 -0700 (PDT)
Message-ID: <71ae3799-4668-891c-c32d-d36da655d56d@linaro.org>
Date:   Fri, 23 Jun 2023 11:52:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: msm8939-samsung-a7: Add initial
 dts
Content-Language: en-US
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     agross@kernel.org, andersson@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, nikita@trvn.ru, robh+dt@kernel.org,
        stephan@gerhold.net, ~postmarketos/upstreaming@lists.sr.ht
References: <20230623100135.5269-1-linmengbo0689@protonmail.com>
 <20230623100237.5299-1-linmengbo0689@protonmail.com>
 <5fbba4e8-a8d9-0e99-e112-31b5781c1648@linaro.org>
 <20230623104647.5501-1-linmengbo0689@protonmail.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230623104647.5501-1-linmengbo0689@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 23/06/2023 11:47, Lin, Meng-Bo wrote:
> Hi Bryan,
> 
> On Friday, June 23rd, 2023 at 10:27 AM, Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:
> 
>>> +++ b/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
>>> @@ -0,0 +1,495 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "msm8939-pm8916.dtsi"
>>> +
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +#include <dt-bindings/input/input.h>
>>> +#include <dt-bindings/interrupt-controller/irq.h>
>>> +
>>> +/ {
>>> + model = "Samsung Galaxy A7 (2015)";
>>> + compatible = "samsung,a7", "qcom,msm8939";
>>> + chassis-type = "handset";
>>
>>
>> Will the downstream bootloader accept this dts without
>>
>> // This is used by the bootloader to find the correct DTB
>> qcom,msm-id = <239 0>;
>>
>> qcom,board-id = <0xEF08FF1 1>;
>>
>>
>> ?
>>
>> https://github.com/msm8916-mainline/lk2nd/blob/master/dts/msm8916/msm8939-samsung-r01.dts#L10
>>
> 
> Similar to A3 and A5, and the other msm8916 devices, with lk2nd,
> "qcom,msm-id" or "qcom,board-id" are not required in mainline to boot
> this dts.
> If I understand correctly, lk2nd will attempt to boot an image with any
> qcdt appended.
> 
> https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
> https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts

I understand.

IMO the upstream DTS should work without depending on lk2nd.

I'd add the board and msm id to the DTS for that reason.

If not then I'd put a comment into the DTS explaining the dependency.

For preference the upstream dts should *just work* as much as possible 
without requiring churning of bootloader.

---
bod

