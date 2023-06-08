Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696FC727F46
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbjFHLqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbjFHLqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:46:03 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6022121
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 04:45:37 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5151934a4e3so748672a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 04:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686224731; x=1688816731;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AbhAghjawLzBEcXZUXbPe6opYRFvtRyYlpt+uKgziIg=;
        b=TvZwH3IlT2VEyjrc9IouFpTmIIY5a7r2X4e+92fqyZgenAl5p7XwVzkxHF/OR0wDy3
         1F0GXmqcEr/CLJWaNMfCbbh7y8yUnRSpBUQ4KGKvG4++N86bFyNxcq0GfCcK2iBk4Z45
         cMkEDfnGtCfDtvS39y5T9u47ixRq2cq3YI+x5jNxwLHuPHRjHDVq/doOs6VI2UntzJZ/
         CpzrA+2wlyDPPu3xGg6GtOqYhPqzYfjG+yk5b0UnoQUFzExos/zTiJDhMj6ugJ2/UZY+
         ZbOHdM6XRoXMJ4xs3r3iKCtFy8wGge58Cuu2ARJ+8oQN5SgEomnCSW0F3K+NtyxAb9CE
         5m6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686224731; x=1688816731;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AbhAghjawLzBEcXZUXbPe6opYRFvtRyYlpt+uKgziIg=;
        b=IisjjROQjJ+LRqPKyzKcERyHLddx1z6Inm9bEyEojQ4UfDSQtFEnB1O4wiHBaHefAx
         cNrh7GNiptfZ7M2tfK3uNOkTi0OdAKetzD14bPOTRNe1mdeeAVQ3z0J88j4dxv5KwS91
         XsXZakgZsW9oObAnTfBAPsH5naj9LQqfdTkKsoQimMbbz7qw4llOvGZcahfxwJGltBKI
         pSBnnIxtThrqeKr5XdnXx4AL0mvGJ06CWIdTkFnUY2qheykRwA/E5wKbMyBZ+P9hvtMh
         nrbhBqGHV3CnMWhfgbOLiDaoxgDHfIuwv5JfvJokdfxhNnmuxK1lY8H9FkrbHw6zAdne
         Kb4Q==
X-Gm-Message-State: AC+VfDxLOjqqqemPb8SoPCyFwp7CyUpq8z6KuT80aqcqFgb+CGZWvzja
        1kW8YgFHK9NJYiaqV2cb46BJRg==
X-Google-Smtp-Source: ACHHUZ5HmtzT2HmzwjEKYaHiDYcKIMmjjNdcI7Au+tLjgnldEAp2UvNxsmqjrhD4TDXuZihM4yzoNQ==
X-Received: by 2002:aa7:c9d0:0:b0:50d:9e7c:264d with SMTP id i16-20020aa7c9d0000000b0050d9e7c264dmr7855652edt.8.1686224731465;
        Thu, 08 Jun 2023 04:45:31 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id m8-20020a056402050800b005149cb5ee2dsm449662edv.82.2023.06.08.04.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 04:45:30 -0700 (PDT)
Message-ID: <a9952e76-1204-5bc7-7856-0c7f8a411d76@linaro.org>
Date:   Thu, 8 Jun 2023 13:45:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v12 1/2] spi: add loongson spi bindings
Content-Language: en-US
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f6d4ecb5-e9df-346e-4aab-772fd01689c8@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2023 13:42, zhuyinbo wrote:
>>
>>> It can work was for ls2k1000 and ls2k0500 and it specifically refers to
>>> spi driver. but 2k0500 doesn't implementing a clock driver and doesn't
>>
>> We do not discuss here drivers, but bindings. Whatever your drivers are
>> not supporting, matters less.
>>
>>> use CCF to gain clock but can use "clock-frequency".  Is it necessary to
>>> obtain a clock based on CCF? If it's necessary, then it seems that it
>>> can only added 2k1000 spi first.
>>
>> Not related to bindings...
> 
> 
> I may understand that what you said, and the dt-bindings only cover 
> hardware and not involve the drivers. if so, I will add following:
> 
> 
> --- a/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
> @@ -16,6 +16,7 @@ properties:
>     compatible:
>       enum:
>         - loongson,ls2k1000-spi
> +      - loongson,ls2k0500-spi

Aren't they compatible?

Best regards,
Krzysztof

