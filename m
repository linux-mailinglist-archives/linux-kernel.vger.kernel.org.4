Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BBF62EEFC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241100AbiKRIMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240934AbiKRIMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:12:41 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F0F8C081
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:12:36 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id x21so5817747ljg.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1G+LgXVLTwAD0bsABjVNnklaty4nAZBWRi8DQ0slbOE=;
        b=NNAC/uuKgylej5tykC35MHAC0nNZTTDCJqHHoytAlCAfjmKoE0NYYDPBfiGYedF7OH
         DNSrS5UZGBbDCT5YHEXrsDNer66nxxfsd5YlVnFWNICjTAY6LcUeNh2W6pUnlIBou3ok
         +VggMm8ngkmdObxRVeK9sFV1QmwEChkNnqi7NM4PpXrUwTBqo8NLZI86PmNs3RV7Lj5e
         NSlWWeqLB/QWH2hACEfAxbV2zbg/CLpk1bIw23p0VJXT/141ETsvl1LFE8zXWCg0E5Wh
         7YZ+GVB7Nv6UAbN6D3IhbGj869F1QYTaVKTAwacv4pDz2cmM9vHEumWANiJuKo4CW8Lu
         G1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1G+LgXVLTwAD0bsABjVNnklaty4nAZBWRi8DQ0slbOE=;
        b=LCutCEGeOk8J2BDQNRRGxew137J/RuTobT4iSkbtaGfmIm5SdwcnCOyB25YaGxY6DH
         lHXpYvkrqVcK5YXMnGp6vIZiLtqsZO/LtYc80bda5CF91Agxey0eqiR1us8DBE4yH/MQ
         oASEYIlrz6vSfIf2A1hTCBaUL2s0moLygAmvgfDa1JK/KIWXL4gBQsZwwHUTD/5+Y2wD
         ByXzY/iI13b9eZTie1OekL0lfdppiW0pZsXNx4Wc6X4033khvg2+yb044GvngNUoi7b0
         tDGKXHuqDPjKDwhWKjrPu3F2BMSOW86aiqRDb+5V5SG/qGMqck+9A0nVgUI2GW9nkwUc
         dOCQ==
X-Gm-Message-State: ANoB5ple8IUK4lfvyFUKSrgFHgSBGZv4/2NRXC/CgJQoe1Qcukg9pGdZ
        +xCHU3Zh6LM7VxfYbH8n21wySg==
X-Google-Smtp-Source: AA0mqf7Hx6EsBYu1SX3qFIK4j7Nt84bw7BfCDum1i5gA+lyJoiJLwfo90iHXgMyfWlGsMEkMGzBSzw==
X-Received: by 2002:a05:651c:2de:b0:277:276a:a5d2 with SMTP id f30-20020a05651c02de00b00277276aa5d2mr2325194ljo.160.1668759154399;
        Fri, 18 Nov 2022 00:12:34 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id n16-20020a05651203f000b004b1b0f12cb4sm560672lfq.201.2022.11.18.00.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 00:12:33 -0800 (PST)
Message-ID: <198b0e2c-a566-3922-d454-6c3210bb432c@linaro.org>
Date:   Fri, 18 Nov 2022 09:12:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 2/5] dt-bindings: arm: rockchip: Add more RK3326
 devices
Content-Language: en-US
To:     Maya Matuszczyk <maccraft123mc@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     =?UTF-8?B?Sm/Do28gSCAuIFNwaWVz?= <jhlspies@gmail.com>,
        Chris Morgan <macroalpha82@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221117215954.4114202-1-maccraft123mc@gmail.com>
 <20221117215954.4114202-3-maccraft123mc@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221117215954.4114202-3-maccraft123mc@gmail.com>
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

On 17/11/2022 22:59, Maya Matuszczyk wrote:
> This patch adds Anbernic RG351M, Odroid Go Advance Black Edition and
> Odroid Go Super into dt bindings.
> 
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

