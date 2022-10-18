Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0056B6035F9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 00:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiJRWfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 18:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiJRWe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 18:34:59 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D486598
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 15:34:41 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id f8so9657953qkg.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 15:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d8l26VqjYWMF70YANmL81xtMBvMhRbV8z9l+EzsfRds=;
        b=YQU3BqgIHmAt0qLxWsgB/A/68Rg1+5YSjPjDYmW4ZrL3BcBgrBwppHonhNCu251mQ3
         efCkml5cPx8PmPF0jeawXTMouir0+ENDrVxBMuzqw5um/jvUpSBgufubtRGRIApUbeao
         rTvKRvpy84yhLlu0FNeOkuSNWFO2sS7cLR+GcWGE26fijILt/TDJWlkNxGcRREGinTsH
         o9N6jhZu4nfgWI0XidVVGyWNwvLWZOPb+sWGAppNExQaBX3OhaOrqPS1HVbp1VVi/Wrg
         qGuQdG2iT8S+jivnBEQJx+sA2JrJpxoTbew7QRxyh2whO2vhCd12sQgBhMLSVMgAyBEA
         au1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d8l26VqjYWMF70YANmL81xtMBvMhRbV8z9l+EzsfRds=;
        b=bhWtTbrFQwhvs8WcJTN4xBWL0/Jnuvcmzew/evfiut4gWkQGzUkAJe4yuhwQtvK/ue
         EPTUpteJMrQKWgagk9CmxuoJT6H5m7TLrK5SY+zJ6nRLVxUODpiIj98degdwl/PeDWKH
         RFWArzIz2Dh0awrHwvqM1ajFLOg12unq3uGT7piviAJfu8fanoDdwC/VRlXNVxy/NZIi
         p9yaKhOyQ41qU5I6qtfyPFDPzX9aE7anpPUBoPKZMd0UJWKX+n7DEVC6DykZfJNkrjeD
         b/e4LMMp27CsOssTtJGuwH3Y1WhuPOAaO5e71Uhyit2eQxWH96S2gwlVtb9MIzT4D+Hx
         l53Q==
X-Gm-Message-State: ACrzQf1XG9HtCeV5G3Oi8Z9FKiXfjnWH9UurBRKAkQPm7xCIIXHuSJe8
        0vyHx9wxDEbBtVGwyIv7Wu7Jqw==
X-Google-Smtp-Source: AMsMyM6gR/rEAC/F7rWYiVhzX0uXvT39XzWAY16QONciExLnxAPhkuGkhDZgxZo29aVddigxcRgU/Q==
X-Received: by 2002:a05:620a:8010:b0:6ee:cf03:38a6 with SMTP id ee16-20020a05620a801000b006eecf0338a6mr3568874qkb.264.1666132476151;
        Tue, 18 Oct 2022 15:34:36 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id n14-20020ac85a0e000000b0039ad65104fasm2987271qta.12.2022.10.18.15.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 15:34:35 -0700 (PDT)
Message-ID: <3b446b01-cf9c-a185-bbad-a77b7d73c5d2@linaro.org>
Date:   Tue, 18 Oct 2022 18:34:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [net-next][PATCH v4] dt-bindings: dsa: Add lan9303 yaml
Content-Language: en-US
To:     Jerry.Ray@microchip.com, andrew@lunn.ch, vivien.didelot@gmail.com,
        f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221003164624.4823-1-jerry.ray@microchip.com>
 <c1b64758-219b-9251-cea8-d5301f01ee7f@linaro.org>
 <MWHPR11MB1693223A91222AEAAA3FC69FEF299@MWHPR11MB1693.namprd11.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <MWHPR11MB1693223A91222AEAAA3FC69FEF299@MWHPR11MB1693.namprd11.prod.outlook.com>
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

On 17/10/2022 14:33, Jerry.Ray@microchip.com wrote:
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  reset-gpios:
>>> +    description: Optional reset line
>>> +    maxItems: 1
>>> +
>>> +  reset-duration:
>>> +    description: Reset duration in milliseconds
>>> +    default: 200
>>
>> This is a friendly reminder during the review process.
>>
>> It seems my previous comments were not fully addressed. Maybe my
>> feedback got lost between the quotes, maybe you just forgot to apply it.
>> Please go back to the previous discussion and either implement all
>> requested changes or keep discussing them.
>>
>> Thank you.
>>
> 
> I am documenting "what is" rather than what I think it should be. I
> would prefer there be a "-ms" suffix on the name, but that was not
> what was in the pre-existing code.
> 
> I added the "default: 200" line and can add a "maxItems: 1", but begin
> getting errors when I attempt to further define this field as a
> uint32 type or anything like that.

There are no errors after adding proper type. However I cannot help you
for some unspecified code with unspecified warnings.

> 
> And no, I'm not getting any warnings or errors from the dt_bindings_check.

Best regards,
Krzysztof

