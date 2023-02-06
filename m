Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59BE68C698
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjBFTQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjBFTQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:16:55 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FEC2E811
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 11:16:34 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id n28-20020a05600c3b9c00b003ddca7a2bcbso9669732wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 11:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gJRDeiWMU5LminQ5X0rSwq5LRRKb8iCPzPGu9WgeBvk=;
        b=VPj2N3jHazrLOiA7IMwXdxCeFN/lEBhO1oe783NaPoPoRMAJ6L05bPfNIY1WSBVPvg
         YgR8ZcE1UpgfiKiMwyZjQz3KKkOHc/09+dTTizVt8UI471hYotXy+eaPYtI0LjD2B9X8
         TM+OupEI9O4EaWaz9EAcCuhBecxbDP0XRUE9zBxqMorKfh8kc7fSlqb8WEfyD4Fzvnb/
         oqdWiVzVZiER7qK/GwKoHDG+LSwok8oGcu7mxMwe1vb+7QABcdb2nTyS6R3QhsQ+ZRXT
         Qbw+HQvs0Uij5IaDi5jCdEmXQqTq5Lgy6J67JTREXAUoj/bQYMr60UqRZkPohBhoMUwV
         cvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gJRDeiWMU5LminQ5X0rSwq5LRRKb8iCPzPGu9WgeBvk=;
        b=yawnk6saVjnI7Q+cu8HNxzdXBiVqpWFQaRiX5dO7nvyszoNqcZVELLdG79jJO4cWIH
         W5XoqEVUjXah467a2ugGdSt71yFUqJyXz7MiUxE4tdewOJW1vCCRYMI4N4FCJz9RE/gM
         vkjO22VbWfdMleQ44uDR5/AUUiJGlpVipfFM2Zx9jDasHhVZs2Lt23tXnu1/RHwtwG8w
         EIRu8l9+MpXaaAusy4fatImGMBKZa+8d5gmt/CVpKXRECwAgsIDlqqkQwIqst6LF5zUz
         9AekE4MTTpz+RtQwRAeKAur/7CO4/wApRAiESrYMqagFAsp+KXtPcd5HpWGh/hDvi8LV
         HqpQ==
X-Gm-Message-State: AO0yUKXZELDheQvR+tnAzxo45XNTAsrqMvafDFaLmtcLhf320Tr8py1R
        Lr8p7N1NPLlak6W88UjPskSvUg==
X-Google-Smtp-Source: AK7set9kdM2QNJOY0kxx1JjhOxRMvHbF5AvX3IsjMUfODox45NsBWNLdRL4wGOc0gLaOFODk/k+JVA==
X-Received: by 2002:a05:600c:331b:b0:3df:ead3:c6fc with SMTP id q27-20020a05600c331b00b003dfead3c6fcmr746809wmp.17.1675710988803;
        Mon, 06 Feb 2023 11:16:28 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c3b8900b003d9aa76dc6asm18047337wms.0.2023.02.06.11.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 11:16:28 -0800 (PST)
Message-ID: <ab80be6e-0dfe-a696-6d81-0969e5a21ddb@linaro.org>
Date:   Mon, 6 Feb 2023 20:16:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 6/7] ASoC: dt-bindings: meson: convert axg spdif output
 to schema
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
 <20230206153449.596326-7-jbrunet@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230206153449.596326-7-jbrunet@baylibre.com>
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

On 06/02/2023 16:34, Jerome Brunet wrote:
> Convert the DT binding documentation for the Amlogic axg spdif output to
> schema.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../bindings/sound/amlogic,axg-spdifout.txt   | 25 ------
>  .../bindings/sound/amlogic,axg-spdifout.yaml  | 79 +++++++++++++++++++
>  2 files changed, 79 insertions(+), 25 deletions(-)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

