Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C12639AEE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 14:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiK0NNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 08:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiK0NNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 08:13:17 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D89B50
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 05:13:16 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id c1so13551800lfi.7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 05:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ymMQqhpUEMJO+b52K8VIsBNlBPxjfHjs+nxko8CCAkA=;
        b=JSJGXxblDGy1qS3qoTAjnackIDa+wZQBCsH0kr+qVnprwKK4TvbG4yjfrTjRMcLql1
         1/e+fiJF3Z/UVAeIUWKRj6FaNjBu9wi9TrKIRBtQxz/IZqBeGexTtdjndE7H5zu6iqO9
         7lXjgqaJXGArz2D0S4kx3cW8vYTaGZ0lDqJv7aNL9FkECn4XUPIicchnBYJX4sM0vE15
         ATZw2hWO7+IGJTSvZaatmyjY/pFguaRyguEdPBt/uSX106j6vbVhNh6EE12222/w6SBM
         24tGqUVwQIkAJDrip3cPHR6Y5HcWJxtWyj4tRTOnxuY9YpevZ2nvnY8vuljqbbwEH9Di
         Z7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ymMQqhpUEMJO+b52K8VIsBNlBPxjfHjs+nxko8CCAkA=;
        b=McUu6524S91Laz3/4KA1naeITW3UM4Avubtox+eO5Z+rfIqwPdRW34C2Tc+hi/i7Ym
         ZEIeAaRq+7RoDkuelvfKhjes8lWl9ZalEizPV5h24e8DIUW1TrjGVlH7FRjUNYD0Nm/W
         ZMqLCjUzbqTluTrt5kcBjCIK28uUrSKfHgSbhfOeGWgMCsP8HySQJF3aFbNWTZy1qjhu
         Q61i3SjG7kbmasnXXoMeJHZ5LoSxNqbFwc+fnFeEfZCCqt3N/rFW1WgLJNWmPLD9FySf
         bFl41Lxwr/wAx7tY9gaJ95uM7IJZHpVHAv1zZPEJC0X6N/brR/aVMlQAO7r0CxDpKOD9
         Ze9w==
X-Gm-Message-State: ANoB5pl6pW70vRmEka1BD6gAI28LsAirgkE5lMMIukf7hw6nnW0IseZM
        eo2FsVEDi9eNNVKKGpGZcQjZvg==
X-Google-Smtp-Source: AA0mqf7qTvx4Q0DD8LmdqDNmzQypbQWAj1Cy/SzOTvxmHHY8KN/okl4/hczpu04jclcNSh1fjuMl9g==
X-Received: by 2002:ac2:58d7:0:b0:4b4:fbce:606b with SMTP id u23-20020ac258d7000000b004b4fbce606bmr4336087lfo.27.1669554794552;
        Sun, 27 Nov 2022 05:13:14 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 6-20020ac25f46000000b004ac393ecc32sm1297941lfz.304.2022.11.27.05.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 05:13:13 -0800 (PST)
Message-ID: <f893330f-8fcd-044b-5bc9-f2c80813bb40@linaro.org>
Date:   Sun, 27 Nov 2022 14:13:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v6 06/10] dt-bindings: mfd: mediatek: Add bindings for
 MT6357 PMIC
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Flora Fu <flora.fu@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20221005-mt6357-support-v6-0-4f589756befa@baylibre.com>
 <20221005-mt6357-support-v6-6-4f589756befa@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221005-mt6357-support-v6-6-4f589756befa@baylibre.com>
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

On 25/11/2022 16:10, Alexandre Mergnat wrote:
> Currently, almost all MT63XX PMIC are documented mfd/mt6397.txt.
> Unfortunately, the PMICs haven't always similar HW sub-features.
> To have a better human readable schema, I chose to make one PMIC schema
> to match the exact HW capabilities instead of convert mt6397.txt to
> mediatek,mt63xx.yaml and put a bunch of properties behind
> "if contain ... then ..."
> 
> - add interrupt property
> - change property refs to match with new yaml documentation
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

