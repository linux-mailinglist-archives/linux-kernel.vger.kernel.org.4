Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941C363A74C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 12:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiK1LnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 06:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiK1Lmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:42:52 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1840DE62
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:42:49 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id g12so16913931lfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JW3L3Bp1tixWEJFW9KkuTzunuGdrxdHxaArzuZlqgwg=;
        b=uZMNnGTqFeYPmqTg00CGhxLquKegPgAX2zJBqPZfiUeepL3qhbOEodUwGiZVN23jld
         BjB7flA9VQd7+kCSugUnXRnssi4xtrAw54Jk4llVaMtT5H9XGV2veC4QKcLSQ3YFFiiS
         pjsakE+P/0dePdn7joy1xZpRIRu5EgbWf3Cj0SH/IFbB7RAF00IYpbL5pxXyHugPdMlS
         g0eEcl6LiLSC1vTIeBdYkweH8ipDmUofCJUUq4Pdl8DPb03UruvsAi8IVqkstGIWdeXz
         jUTvAfkLkt3wFor5QlpuDU106doC4kLAYg5utiVFc+x+iGfWefgGQHOFprW+s1Xqx//6
         PMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JW3L3Bp1tixWEJFW9KkuTzunuGdrxdHxaArzuZlqgwg=;
        b=EW8pSSsTDRGPrtmYsMoGLt+ULqViEO7ekIU6KCe/eKx5ifF36amGonZjGZifFh9YT+
         KAlqYAyD7e1yVdhGwUFPjhtPxGdMxsoPIbpsaaD3wo/zmtrv5Q+KyLxuzEvEz8Vy37+9
         e/Xbxe9NPkuY6aNgdJpqBnsT9J2z+zFcIUK7zGq5uz9wUKQkZR1MUYFcTlam2nqODjVP
         91/7rjvPZ8LViuy5bCBLfc97KASmI1x+Wo+sIEBBrtSJ22ep3o2AOOcuyQtPyUmfqrX+
         cZ1lJig2ZPARQTtCIFA/3jEU/QTx11DYLdxwldgyrkekkbouiJwLHzlCwt9LffHu/3nx
         VVbA==
X-Gm-Message-State: ANoB5pm/CIjP/9+AUV7A0ORk/8A/ZG5+XK99Ap2tidtrk2p3Z9X51GxM
        CijIArWAjk5mdHO/FER60Sjxow==
X-Google-Smtp-Source: AA0mqf7olWvb5Zj1dxpRFdUBBN8BxguAWCuanq9QQAYqwve+t01cFZUYcM98HAzPlkT7uQSr6rkzxA==
X-Received: by 2002:a05:6512:3603:b0:4b4:b5d8:880d with SMTP id f3-20020a056512360300b004b4b5d8880dmr15662151lfs.121.1669635767332;
        Mon, 28 Nov 2022 03:42:47 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f24-20020ac25cd8000000b004a44ffb1050sm1684825lfq.171.2022.11.28.03.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 03:42:46 -0800 (PST)
Message-ID: <8f26bc40-10eb-fb0a-8a69-a303b42c9e60@linaro.org>
Date:   Mon, 28 Nov 2022 12:42:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/5] dt-bindings: reset: meson-g12a: Add missing NNA
 reset
Content-Language: en-US
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     italonicola@collabora.com,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Amlogic Meson SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221128111740.39003-1-tomeu.vizoso@collabora.com>
 <20221128111740.39003-2-tomeu.vizoso@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221128111740.39003-2-tomeu.vizoso@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2022 12:17, Tomeu Vizoso wrote:
> Doesn't appear in the TRM I have, but it is used by the downstream
> galcore driver.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

This is a v2, what are the changes? Please include a changelog either in
cover letter or in every patch.

Best regards,
Krzysztof

