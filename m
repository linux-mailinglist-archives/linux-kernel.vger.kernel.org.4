Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE41D67F75A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 11:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjA1KtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 05:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbjA1Ks5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 05:48:57 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC549023
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 02:48:56 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m15so5070072wms.4
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 02:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BDMyuNY9y2+mLIY91GGCJaf3jR2VGlODgfIJsSjay2k=;
        b=hmFG1UC0xZDkKe8YXYtTsoSlN+mukQIUz+DjLBJydedkPIcvK8+eReW4WbgNupYvZt
         otEbRmzGeNzYEdhfu5WWDr4pMIvYjLYxP6InEc0nUuCcaRf0SB/Y4aSWVyesWuExKx/z
         U2lItJlcCAexXE1oyUeaEu2jwUYHH2FB54OL0XBD7MkMe2sqyALHhf+IVDik6zoqEA/O
         9QIUe5775lSgBt5BwcqaOcoxUykdawfEypSNY1Ri7B8E7cuh9Dixjig1gfWl9m5hph33
         pWybVYBJaz1U5+OhpUxD3/m7lbmdS9SiXu3hYg4/J1pIDsyAsE7t+v4Xk9Y9A5nM2yRE
         bgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BDMyuNY9y2+mLIY91GGCJaf3jR2VGlODgfIJsSjay2k=;
        b=qxQjwIiVqNhv3vgCjmYXegHQ+y+jM13hMgCRy6HYVB61SDklzDZiPJFBe4zBHB5Jop
         2DMdjj0bqNQUS/2RqzhHhubMK7Q23UtoL4kai0bWFHdXpvYlpHRf55tfxX8AGe9aSJnp
         iekfaTESL4EeCaVPzBnA5vUOY0Psco2DV8rHo/wmy2zY5H7UlwfWDfPI1sYeRCfxHrnY
         iM7qSUSKV5fN24C5TRrAI7yRYGXJfa6aFOey+h/BrGK64RY+MaFdiL6ZhX6j6iwgl8Oh
         zisX5tORLxpCH19r9cWiq/zA9eDiQQG/5FGgcIE8Bv6cuPwVYb/ktUUojaV9NmvmUXrk
         HLWg==
X-Gm-Message-State: AFqh2kp1t8oMnHC5FG6ih9tD/YbruwoKvMknIlFg569gzudenW6ZV+my
        7zPEnFVsggDxCgUTA6yxuaWEVg==
X-Google-Smtp-Source: AMrXdXvzLKnPJzKgzaJo+Fihga+fGeShpAelemc3eeNsipvcvTqGS01hVJ+Ze/uvvnAp2CCmGSCNMQ==
X-Received: by 2002:a05:600c:3b18:b0:3db:eab:3c5c with SMTP id m24-20020a05600c3b1800b003db0eab3c5cmr40476863wms.32.1674902934819;
        Sat, 28 Jan 2023 02:48:54 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c42c600b003daf89e01d3sm6781867wme.11.2023.01.28.02.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jan 2023 02:48:54 -0800 (PST)
Message-ID: <5ec49108-6ad8-daf7-54ec-104f0923a31d@linaro.org>
Date:   Sat, 28 Jan 2023 11:48:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v12 2/6] dt-bindings: thermal: mediatek: Add LVTS thermal
 controllers dt-binding definition
Content-Language: en-US
To:     bchihi@baylibre.com, daniel.lezcano@linaro.org,
        angelogioacchino.delregno@collabora.com, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230124131717.128660-3-bchihi@baylibre.com>
 <20230126161048.94089-1-bchihi@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230126161048.94089-1-bchihi@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2023 17:10, bchihi@baylibre.com wrote:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Add LVTS thermal controllers dt-binding definition for mt8195.

Subject: drop second/last, redundant "dt-binding definition". The
"dt-bindings" prefix is already stating that these are bindings.

Plus two comments at the end.

> 
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> ---
> Changelog:
>   v12:
>      - Fixed subject prefix
>      - Fixed licences GPL-2.0+ to GPL-2.0
>      - Added dual licenses


> +    };
> diff --git a/include/dt-bindings/thermal/mediatek-lvts.h b/include/dt-bindings/thermal/mediatek-lvts.h
> new file mode 100644
> index 000000000000..902d5b1e4f43
> --- /dev/null
> +++ b/include/dt-bindings/thermal/mediatek-lvts.h

Same filename as bindings.

> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: (GPL-2.0 or MIT) */

Although this is correct, any reason why not using exactly the same
license as bindings?

> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + * Author: Balsam CHIHI <bchihi@baylibre.com>
> + */

Best regards,
Krzysztof

