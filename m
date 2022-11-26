Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D702639650
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 15:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiKZOQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 09:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKZOQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 09:16:52 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A45B1D312
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 06:16:51 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id z24so8141793ljn.4
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 06:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OIMZD3XxyhT7mbxN3+O9EeY+atM1x1y6l6xsxzVqKFo=;
        b=EaWjhKBu2mujx7WpVfhmDydUuW6097k7tvxgB0dRAxOdIx9bgLU8TrRCshsOeT+QK1
         XzPvkNlUTDHmw4gVb8cv1ECC8SoDuKnMw1eewAV6BPfcDf75JWjqaPks0JEQvn+HRCzf
         S0WtiSbG7ZUzZ53Nkxx2I8jfouvXyF89NqZQopIXIMNqqAX66cJJ6hA1vQC3zZ5zZMZM
         8Xm8u/OChrurt+aZglid7hOhSQVQiNUC6HFKCCpQX/GXQkFL1jnuCoH/6YWHSFoRvxx/
         MWwE6RnM7oKH7E6gxwqcKb1THTmDmJlApDNJ+BZcM5bTQM4CCrGPafqDQWSoy63K3zpT
         9Irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OIMZD3XxyhT7mbxN3+O9EeY+atM1x1y6l6xsxzVqKFo=;
        b=0Lrhq6WsaYLFelZa7fd7NZhJyr805Tu+wgwWm5ktBecTcHMgs10CkzyxKQmg8N1F7t
         V4oJgqj0qz/i9yRMv/f+XXhT7qaZn29Mxc6gSEUmy0ATtBqy7b9njasycvYcwH2VXmdq
         taKaRrp40VlGdM4tXL0fKEvqKEIrip3XjFwQ/OfEQX1W0PVwUrDOQe5sTyHJ9vQdT9eG
         XDiXAUGUirBo6QFITRInPaUoUgoOWG1Two8HGT8P7MK+D4/U7y2yOwyV2djGzNqKIQUU
         caRttp4S95HuoTRFNGAsa8rxcYDV0oMXRr5xSnkU/OXMlB2CKkqFh5+O8KrfahSzxzz7
         P5gQ==
X-Gm-Message-State: ANoB5pmxF/zGwebNlg1h4fbzU6oW9XEKMeitFrD7a/QylJeim+n9Qqnc
        rudo0qDs0/DwE49x8fCEwUTgBw==
X-Google-Smtp-Source: AA0mqf7U2YqAOIaKV8TxXn235bn6cK6igkK9AUjLBApqru9timelSNmL19AoXsWnLnrcyURNL9pwCg==
X-Received: by 2002:a2e:be28:0:b0:278:f1a5:a361 with SMTP id z40-20020a2ebe28000000b00278f1a5a361mr8073946ljq.124.1669472209423;
        Sat, 26 Nov 2022 06:16:49 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 2-20020ac24822000000b004a22599c4ddsm930015lft.268.2022.11.26.06.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Nov 2022 06:16:48 -0800 (PST)
Message-ID: <a135f93a-235a-27b8-f649-69d62f6ebd30@linaro.org>
Date:   Sat, 26 Nov 2022 15:16:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] arm64: dts: amlogic: align LED node names with dtschema
Content-Language: en-US
To:     neil.armstrong@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221125144141.477253-1-krzysztof.kozlowski@linaro.org>
 <3719828c-0ac5-34c9-a04b-251cbeb5f6ef@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3719828c-0ac5-34c9-a04b-251cbeb5f6ef@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2022 18:16, Neil Armstrong wrote:
> On 25/11/2022 15:41, Krzysztof Kozlowski wrote:
>> The node names should be generic and DT schema expects certain pattern:
>>
>>    amlogic/meson-sm1-bananapi-m5.dtb: leds: 'blue' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
> 
> 
> <snip>
> 
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Aren't you maintainer of the platform? This means I should take care of
this patch?

Best regards,
Krzysztof

