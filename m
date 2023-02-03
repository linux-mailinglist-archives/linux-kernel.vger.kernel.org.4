Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF1C68A382
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 21:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjBCUVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 15:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjBCUVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 15:21:38 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12237A7EC9
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 12:21:34 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so6798941wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 12:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m5sLjr7aYK315tj89Xz8yTzw8nhiBSznb+bT5o725x0=;
        b=HLoFOX9M38kF2qyUXFQwXqSnMduKtNxMFBrU5CvSYknJxcduZ84ZUxf/VVFfkk+dwR
         /WLjnjiBsb1y6V6GqLtfXH8j5KJDNyoWTaR76slT+yDk3LZqAJB1XDDj/ITC4vfTaEDc
         qFfA1b2qa/H9ba7GlMKHQAetHgjPTM8d4A5x2BWt0AEtogp1MPI5kISnP7fI+Rk6HQNR
         h71USPCrKliJYX5PoXeGf3p8mOTdD+tGnDRL5uvNeBQpeuYIDUzK7vnKZM0nDi3JChGc
         rML/UuG3wp30vrDrWJF1gFFn9XzjnHdc5MkgTBcQ5cZL/ZP8JUtO3UVYFG8JILgMYRMf
         2gQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m5sLjr7aYK315tj89Xz8yTzw8nhiBSznb+bT5o725x0=;
        b=schY4YoPSgxuQxPMkxzt3pfUfv6ay8P1rIP4YxWtcvTsRPSdN5ih7Q9l1sKloJYFb9
         iBXASUrGIigzmOj4rYY1i6gBaJmES3a4dh0ELoTaBmDLG54mgipQNh2yGdXZEQiqW+mH
         fPELmdvIabhWpXkJtgOIiiUL23ynzw2eTWaZQaXrSw4QclJxrEzvLjr338IPZJklLGtg
         yBLTYSBT17wq3xEecZYJno29mWyTlMrUKf0LBkLhxQ+WwQa4J0UvlMzgYZXItkpC72c1
         TgL5HJNaE3+p/b3ohZqmml/GA6VzdmkT+ZJ6gsFyir+hMqQ0wwPVWDduAyBC7TWw0yci
         /jVw==
X-Gm-Message-State: AO0yUKVsJLEXmTRYQ6lv4iEx2Ke3gY8YXviIgsrXtPRbQyGnQjdB6X6Y
        snpYSQhTlOz2/ZHZPnNz4/l2DQ==
X-Google-Smtp-Source: AK7set8Gpfp/Oz+hFP5DrhCusCPg/cotAzMpidE7HBO1Avb+cX25jy40Vo3VZeQupr3Q20OM5Hxk4g==
X-Received: by 2002:a05:600c:444f:b0:3da:c07:c5fe with SMTP id v15-20020a05600c444f00b003da0c07c5femr10596494wmn.5.1675455692569;
        Fri, 03 Feb 2023 12:21:32 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm3803784wmo.21.2023.02.03.12.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 12:21:32 -0800 (PST)
Message-ID: <f9d9bbfc-507d-2092-6ae8-f80ab3d23bd1@linaro.org>
Date:   Fri, 3 Feb 2023 21:21:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 9/9] ASoC: dt-bindings: meson: convert axg sound card
 control to schema
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230202183653.486216-1-jbrunet@baylibre.com>
 <20230202183653.486216-10-jbrunet@baylibre.com>
 <f229e181-c56d-6ec7-2a1c-754690f70438@linaro.org>
 <1jfsbmn7ql.fsf@starbuckisacylon.baylibre.com>
 <fede7119-4a9b-76a1-ae1a-7af5dd8d1032@linaro.org>
 <1jbkmamtfg.fsf@starbuckisacylon.baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1jbkmamtfg.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2023 20:34, Jerome Brunet wrote:
> 
> On Fri 03 Feb 2023 at 18:59, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 03/02/2023 15:13, Jerome Brunet wrote:
>>>>> +          Multiplication factor between the frame rate and master clock
>>>>> +          rate
>>>>> +
>>>>> +      sound-dai:
>>>>> +        $ref: /schemas/types.yaml#/definitions/phandle-array
>>>>
>>>> Old binding was saying it is just phandle
>>>
>>> It is just a phandle but the bindings used to have problem with phandle
>>> that had cells.
>>>
>>> See:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml?h=v6.2-rc6&id=d031d99b02eaf7363c33f5b27b38086cc8104082
>>>
>>> Was it wrong or did the situation change since then ?
>>
>> Then define it as having cells:
>>
>> https://elixir.bootlin.com/linux/v5.18-rc1/source/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml#L42
>>
> 
> The card is provided with the phandle.
> Whether or not the phandle has cells or not has nothing do with card
> driver. The card just consums sound-dai. I don't understand this comment.

You said this is only a phandle. Then you have just two options - either
this is one phandle without arguments (then change it as I asked
originally) or this is one phandle with arguments (then change it to
define the arguments like in example I gave you).

Best regards,
Krzysztof

