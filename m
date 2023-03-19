Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419EE6C0165
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 13:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjCSMHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 08:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjCSMG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 08:06:57 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F87722A23
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:06:54 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id cy23so36693736edb.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679227612;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3GQ0kuX+CANTyKsciGzMU4Vb8Jeilt6T7QwH/C5HtcI=;
        b=wyyRNf1RVCSmVWy3uIQD6gbqmoxHXa4hhnuxOXFy5DSK6KoJMRW/7snBe+hAcOuLSh
         4Lil0xPsXtCAFbTqAzDdtCyDhPRNI/pweLUmN6KTonFGYaLFKA2c641IjtNvE0333K/0
         iwf8OUVV6CImiDOkzXbLoQxSXxGLT1pNVgzmz8rjCC4TtF0xRkBnaw2J6Q6fsDn6B3vO
         qGuzkd5xHcL84vTvayPMp0BjhvSj1BaD45jc37kce8oQ795+M7hlUkz5iakVRZLdUngL
         KVKgU5E9wG7BR2kQZUT4ObnjiJ9P0zF028UvVcHQPrlM6HIR4Yc/BHO1sVUHHif7PQzP
         va2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679227612;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3GQ0kuX+CANTyKsciGzMU4Vb8Jeilt6T7QwH/C5HtcI=;
        b=4w1vDrjElPAFz9yYs7LXWzeDIJ1BzwSVQBnyXsrw61SHLB5RXb+TJ4RruP68Nhn9ey
         8M2vjgjWKCf1LG9Fka61A9yETtPtP9aR0WtMyx1tpucdifsd78bU08onaotE8nBZ2F5f
         BqTJK04VOHqOiE4tW8Wp3Lsq4LD+9X9MVNDCY7e6a5Y9RwERbrR8v22TErlkDna2pNqV
         Yanzr8IpdsyrzRTCqlA6YZL36FPtV8V8X872HTUB1Kwu+MsXX+PxSdTAwTXLb2PQJhQO
         LJdGZ7P3kslvlo2pTRA0RHfpSrF3DAZ6GfwFJhwbyXwQdzxKUTs3lfsV15JgxOZl79W+
         6c1w==
X-Gm-Message-State: AO0yUKUdg8DiYZZYCdUw05Q8Ct4SlDw/u5YzPR4ih8V6SlgO5SAJd02z
        a3pW1q7wB/mKDMYipEeAm2/SaA==
X-Google-Smtp-Source: AK7set80QOZ+DV1BMmqsy+GIRzW1eJc2fyUakkB2BmV/dLpU+3H5MSHjgo5dvspVJM8r1tWCDkHtFw==
X-Received: by 2002:a05:6402:4d2:b0:501:c120:6e90 with SMTP id n18-20020a05640204d200b00501c1206e90mr1103738edw.3.1679227612697;
        Sun, 19 Mar 2023 05:06:52 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5b5f:f22b:a0b:559d? ([2a02:810d:15c0:828:5b5f:f22b:a0b:559d])
        by smtp.gmail.com with ESMTPSA id qx20-20020a170906fcd400b008eaf99be56esm3244862ejb.170.2023.03.19.05.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 05:06:52 -0700 (PDT)
Message-ID: <a4d6ef37-77a4-bdf7-9281-681864b901d3@linaro.org>
Date:   Sun, 19 Mar 2023 13:06:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: rtc: Drop unneeded quotes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20230317233634.3968656-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230317233634.3968656-1-robh@kernel.org>
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

On 18/03/2023 00:36, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

