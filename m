Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1700063BB01
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 08:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiK2Hwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 02:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiK2HwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 02:52:25 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2348E5216D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 23:52:24 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id a19so126340ljk.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 23:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mUR4w/hPvYNcbwexPR4YZOdhkXAreGxeMf455Zyzvio=;
        b=hMgkztx20JO5yNjN3lhFueTKmLFoogPofa4si09Yb/A8uKliAj4T9xh7YsHLnQYR1M
         wsFnO89Ybtg5sF1vMk90tS3PNL8efwtlC7VjAUtg/sArxh7WW5roa46sccu64XOo1PgI
         auG3ulRrjtWlwDzc8Dy9ao2SrcRFoGHcLFbIJRffBvSmFjVgfUinwifXbib93DZmn6Gy
         e9xRmYLBFlQpfrZ5yH18SXdMIbiUCOYYhO891xR41EX5Y3XpBHt7+bhCg41oaGpEVjSO
         7YTL45XgFUax5MzwNM5gM6kzatas3LXfjgBrOlBjs1Qo09Vl8+NQt3Rx9lND2jn8K5Dk
         sMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mUR4w/hPvYNcbwexPR4YZOdhkXAreGxeMf455Zyzvio=;
        b=7Z2h4DWlSyvqWmAqGNben0LvUdlVAXMB4+8iotvhuIDyuiwJz+WMZ1dqYNzdvYytfT
         pNT8eM4wXfdDoTtJNJcnbOcZ2gTcYvVM9jwu6xeQgzCm+nqzvBkF4iw3UaSu/cFZ+y8c
         aUJbxhdL3S06NHGsJPub+00ka+A9QmdCgt6hhqJ2YPO3fx9cqJhvH3Y6Hz1InAjHmw17
         EU47lfKnHWGrBQx7kTsJIlDwfGMQfXpF0MfPhQh8SnCC/SsVTgpzcopJlB/9BGZdDXm+
         NmJygd0yOmfFWVg6BzDCSQTDCmhC+ea3SSB3L9jcibzvIBtVA0rsD7aXOkqzoVsQ1acX
         1kUA==
X-Gm-Message-State: ANoB5pm9usBaS1EPVC+Om1m3saoBL9/oj9ti0OAJq5+lUh3quJ6GjyH/
        Qw3oHFIwr4smJOZwQzzaSSKUIw==
X-Google-Smtp-Source: AA0mqf44EPkmgyclmfgC6DvDtKph+jnY1iudJFDajVwWs+PscSMAo2T9iuG95Usi1JxjKg7XBcNI0A==
X-Received: by 2002:a2e:8e6a:0:b0:279:a6c7:50d9 with SMTP id t10-20020a2e8e6a000000b00279a6c750d9mr2445443ljk.460.1669708342523;
        Mon, 28 Nov 2022 23:52:22 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 9-20020a2eb949000000b002797e41e1bdsm1455392ljs.86.2022.11.28.23.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 23:52:22 -0800 (PST)
Message-ID: <4e3a22d3-cde1-8d31-ad71-933011519296@linaro.org>
Date:   Tue, 29 Nov 2022 08:52:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/2] dt-bindings: Add doc for Orange Pi R1 Plus
Content-Language: en-US
To:     Chukun Pan <amadeus@jmu.edu.cn>, Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20221129064042.17806-1-amadeus@jmu.edu.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221129064042.17806-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2022 07:40, Chukun Pan wrote:
> Add devicetree binding documentation for the Orange Pi R1 Plus.

Use subject prefixes matching the subsystem (git log --oneline -- ...).
dt-bindings: arm: rockchip: Add Orange Pi R1 Plus


> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

