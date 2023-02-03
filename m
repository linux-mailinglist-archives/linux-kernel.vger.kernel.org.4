Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB7768910E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 08:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjBCHkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 02:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjBCHkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 02:40:02 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154E193AF5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 23:40:00 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso3161305wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 23:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eDG+Tq9iDGbHsf5EgNu0sPH0oktHNFK56axN09nipps=;
        b=yptLRVcqgMEv8JFQdUEfePL7JJZ5m6e8TTX6WXgdibOU5Xgo43x2mz1dEM1ustKfPV
         TojcrLeEU06LWS9QaEqyVsJF9DvFP/uM5FBnYICrJmklLai385IRWMYCye7Q8e00aqko
         5cNF/XAhVJ44XEB0TIFQm0lLj0SxLQyVPuCQRyMu/oEwnY34X+gboWZOJV0hb/Xg+tV0
         Ozv3lTqxqQHZcGKMU/7E/dA8YKdioh1tx23nD6Ndr+nbIwXcq30e1/RxsWZ3KZXh0f/1
         7rxeAf/947EThE7vujkmhADU7gxp3YmZDFASuX6fP54AQWqdq7oYBCIu9TWzd+GjBTDc
         9mBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eDG+Tq9iDGbHsf5EgNu0sPH0oktHNFK56axN09nipps=;
        b=sLWPYcDFTpFvS2xDQr6aKayYdsd1R4G4Xjod1GDPppKyYc+NDF451DMuiLjmDGXs1O
         uRb1zkaE1tvCUPo7dF89deWi7jWLXxYqBk+wFaLOM8hSidIu5x+gpoGkX861zAz9kzkT
         CwqBvoXGp6THtH5Vqlac7Fd1KUcu8azaPHhdY9RGOuzNx1rLz9UHi4JJpBCj7CS/TyZS
         xPZkshD4zpS68gQ8oLdj2EY26VHcyUSc/82E8mzqJvbXvDndLMFVlGj+Xsu/RV/24f5n
         hi5PnfFvqfPpWN7YnWaNG6CTrrIFemDJyqZ/15CWkwZNYWeqAHAragSx4oAdUjumQ4ia
         INoA==
X-Gm-Message-State: AO0yUKXQRc341aCpOqd/Ikea+26yYQSKwYVS4+q2IPAa92NnvPF5f3Qk
        z7b+keYVnw6Q2uIPI5YuF3p7Tw==
X-Google-Smtp-Source: AK7set+WVSL5lEE03IKAtRDn0G9GQ2gh7h7Cg2Buma4kwR1Id2znaqCke5/4PO5RGEDw3TtaU0/xNw==
X-Received: by 2002:a05:600c:5389:b0:3dc:557f:6126 with SMTP id hg9-20020a05600c538900b003dc557f6126mr10773527wmb.4.1675409998149;
        Thu, 02 Feb 2023 23:39:58 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q14-20020a7bce8e000000b003dc49e0132asm6747405wmj.1.2023.02.02.23.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 23:39:57 -0800 (PST)
Message-ID: <0012a2d8-ef4c-400d-7236-a2afbcdddf47@linaro.org>
Date:   Fri, 3 Feb 2023 08:39:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/9] ASoC: dt-bindings: meson: fix gx-card codec node
 regex
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
 <20230202183653.486216-3-jbrunet@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202183653.486216-3-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2023 19:36, Jerome Brunet wrote:
> 'codec' is a valid node name when there is a single codec
> in the link. Fix the node regular expression to apply this.
> 
> Fixes: fd00366b8e41 ("ASoC: meson: gx: add sound card dt-binding documentation")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

