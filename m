Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC8161EE95
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbiKGJQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbiKGJQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:16:35 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD1D15827
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 01:16:34 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id r12so15898413lfp.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 01:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ee9rRE2EZYR3AFslDfAa5vqk35kYdBztnuAgp9P1svM=;
        b=rLgN8Ab0FHYbqyHfhx61S13OglQV0IxcL7oh3Q2DBIZpIffz/Sd22ckP2kXKhUWdoD
         XvrViZQmsTqi88VTF76St/XTn4YOdfkVFy5KKxKwnLTMQOjcTmoq8VR0FA+Xs2zANdP3
         uLffjmEj/GWzqAs9SLlrGU/opeVKi69yxnPhm545g7nJbioLzKGdmfMC0bdtU3cNLSCk
         a4T+Bk+uJUJKNk037idWb8jzsGZRaIlvfDF09tEqF/KG7mUN3b7m0jw4jEI6SaghYjBb
         ZvmvKp53XDqFo6SK4VuyIQsHh3B0qvWgJvurbkZ5lrnMxKVpRrLvHPb6hY/Vn7F1SBVe
         kbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ee9rRE2EZYR3AFslDfAa5vqk35kYdBztnuAgp9P1svM=;
        b=pOOycO9p4pSi/Xk+vB9V8Xq7IHLOAr1+rtHvm6rtWjVmNBhdD+VcZQLhE5Rf9U6rTJ
         xy5Q+5gPcNQZHJE70HTI1hvBYPY1J1Yna6RJy7Xq0/hh1mwzdib8pcUc/IlPzKyWI4WJ
         /KX87wIeW/EjQil41OsI1t0KlNbLElhdh3NHvl4q0l9F41EtioN5dgDKuy1EuzYvMnM7
         0+kAfP7NmJE8e7L5dcD1rA8TRBn9qxKu9zCYQl16T6UjsIqaJPXWgypDK+dq4gx90gHc
         OSxJau8kJ3DIN4kKPOmAzbSR4U8AmunBy3vBsqhvoPyUypBWZC8ou4RSl0vigHGL9Y06
         7T3g==
X-Gm-Message-State: ACrzQf27PXf8+0H1LmPVDxjGZmrX+sCyMdBedttjnu6uyZyfFa7yjZBq
        +c1F57EQEQBzOpdqv9i6I114Ww==
X-Google-Smtp-Source: AMsMyM640xZfzovEVbRzAzA3JwN3fsqXmGXCqtuz5rmj/QtkLofAuR/i6wzcJkcTdHZb+Jm513To6A==
X-Received: by 2002:a05:6512:b21:b0:4ae:391c:e655 with SMTP id w33-20020a0565120b2100b004ae391ce655mr16423127lfu.45.1667812592555;
        Mon, 07 Nov 2022 01:16:32 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id t20-20020a2e8e74000000b0027755f52a94sm1129600ljk.80.2022.11.07.01.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 01:16:32 -0800 (PST)
Message-ID: <9ddc0bc9-c5cf-6c94-d15e-77a7a7e2b7f1@linaro.org>
Date:   Mon, 7 Nov 2022 10:16:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [v2 2/2] dt-bindings: iio: adc: Remove the property
 "aspeed,trim-data-valid"
Content-Language: en-US
To:     Billy Tsai <billy_tsai@aspeedtech.com>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        linmq006@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20221107091506.28630-1-billy_tsai@aspeedtech.com>
 <20221107091506.28630-2-billy_tsai@aspeedtech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221107091506.28630-2-billy_tsai@aspeedtech.com>
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

On 07/11/2022 10:15, Billy Tsai wrote:
> The valid of the trimming data will use the otp default value as a
> criterion.
> 
> Fixes: 2bdb2f00a895 ("dt-bindings: iio: adc: Add ast2600-adc bindings")

If this is a fix, you need to describe the bug.

> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However, there's no need to repost patches *only* to add the
tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.


Best regards,
Krzysztof

