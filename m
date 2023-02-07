Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1B968D6BF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 13:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjBGMab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 07:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjBGMaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 07:30:30 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF5E305CC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 04:30:28 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id y1so13403266wru.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 04:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uo8Ualo99d53mmVi49FY+l820ilSRXIZGdKs4k2O74k=;
        b=lD9EZ7RPG6IizC5UEkDoAl2VLeg5YjRQJ9YuKzsS3PDhjFqSwmEkcfqb42JvX1M6PO
         jPwtqoYOWqmM8JxVJeAoMdRkwyLbWEWCf8iYoetSVVUw016uSm8r2XFY05mJ72meJu4b
         KLAaRI0zu3/9Slfx96CHzXB5AYW4gdj64B1X21R3beCnHSIQUsQfLV7RJB0IDWNv6wDz
         gJe+jj4fgugWXWjR5iOZMGNBsM2KDOLHH6cvvJuNQMmfcNmw1RFam2SYz8uCgWjP84Bk
         vsXdFu4q9yz6zrJ0t0507194GRN7eVBQr09dQLvVkrO0gaI53cfYu8ltm+OkSQMFA3Wc
         4PdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uo8Ualo99d53mmVi49FY+l820ilSRXIZGdKs4k2O74k=;
        b=8NS7nPV656rvoxZCB23g28Od7kGXlyxCmz3w1iHBjD086IzzKsI0QQ4LNYdX28RaXw
         zFRzepWbIG17m9cUX2TFKRBB0cknFpz+jqYdxejwQrgvZJWu6eZggNaBITHuqP8INZg1
         6X6hMkDXBANBkD7PJqhMphlOKjpeRDp2lKufO1fLHy6gort02cn7MMpE64PUIicoMFNI
         8ogMeq7CcTXZpVlT/lUSWnzQofLtcqtg9OP4HPwrzqZUEhtMYRPllOhzFsHKqjLb9dAc
         WMmq6YtGIkO+8JQNSKYTxDz5NSl/qXShkMRNfNeBvRzesPa/ECe3SRtp8KrwZ274AAWR
         uXUg==
X-Gm-Message-State: AO0yUKWNanAac7duXKVjAwcanMPUvm6nX+m8EXIB/Zff1v5psD1HKBuM
        sP2Jy0wXsIaIace8a1vzYg6duQ==
X-Google-Smtp-Source: AK7set/FHB9i8kE1subd+a6lk2/Py5IpC82cHNa3nwC0OUd/lRxJYlOvxC7g0sC/El2fSuhrlQBR6A==
X-Received: by 2002:adf:f6c6:0:b0:2bf:b571:1f18 with SMTP id y6-20020adff6c6000000b002bfb5711f18mr3028904wrp.61.1675773027151;
        Tue, 07 Feb 2023 04:30:27 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k10-20020a5d6e8a000000b002bdda9856b5sm11214256wrz.50.2023.02.07.04.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 04:30:26 -0800 (PST)
Message-ID: <6804adf4-2fba-e4f9-36ef-a6b8bacae76d@linaro.org>
Date:   Tue, 7 Feb 2023 13:30:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 7/7] ASoC: dt-bindings: meson: convert axg sound card
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
References: <20230206153449.596326-1-jbrunet@baylibre.com>
 <20230206153449.596326-8-jbrunet@baylibre.com>
 <a711905e-dbfb-4258-62be-250a9549a9c4@linaro.org>
 <1jbkm53jvg.fsf@starbuckisacylon.baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1jbkm53jvg.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2023 10:25, Jerome Brunet wrote:
> 
> On Mon 06 Feb 2023 at 20:21, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>>> +
>>> +  audio-routing:
>>> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
>>> +    description: |
>>
>> You still have everywhere | which should be removed. Here and in almost
>> every other description when no special formatting is needed.
> 
> I'm sorry if I misunderstood your comment. I thought the problem was
> with the '-' of '|-', which I removed here.
> 
> Should I use '>' for the YAML multiline format instead ?

I asked to remove "|-". Don't add any other character - why do you need
it? Multiline descriptions don't need block scalar headers unless you
want to preserve some format.

Best regards,
Krzysztof

