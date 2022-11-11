Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E772F625D6C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 15:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbiKKOqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 09:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbiKKOph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 09:45:37 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30666DF1B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 06:45:35 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id g12so8656438lfh.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 06:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nKIh7Rn2uY03gvMDxLSAjGI/gyfIpOz2PNRYMB/8BVY=;
        b=zMLqECAHr+5NcQNla/y7bj36+Jihm72LxNXySqm8xh+3R51WS6kmb8BtZlvnSPqDe/
         igKUE/GAiR9gOUGc4qHV9tkJW/7sbMSEYiWS0UIQYo1Z7/kmm6k5wASAJOJKomoVAY47
         Kb2GD5r0gu5itoPz6sZK49pbQhiySjQsFbvaEAnLSVpbI0fwR2LDfRE//v5AjgFf+DD+
         waGekmsiQWHluWL22/FWNtkd/9TBklGK4p1GLIPqkb8dKq8tCscS52QU5WvSegdzfiVX
         aYhHp1GTJg5XGXC58x1ppi9ZDqYtjsD7f3qL4rLaZ5BbJqNFlsPuI6//YxkETH8shZdL
         P8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nKIh7Rn2uY03gvMDxLSAjGI/gyfIpOz2PNRYMB/8BVY=;
        b=rl1JZVcSegLpCAu+wyK2GxDN8WA34FYtbVdaWL5FF27ErXWTuC6e+ujJGjh19N1NVY
         vtaRorCBN2mh1FxNSSPoHS04d6WmZr050fRs749XV3HCIfPuFPX1t9OlkecuoXlTD1E8
         T47sV1CqmrsFiD1N5VsrBEykI768e/fQk2wNJukzbE870NMnyB+SEW+EXqOFrYEpWrs5
         ev6AmuwXr6pdp7gDTnVqOnc718caPyEmA0QDzdyO+zsLwcH54k1r8CihtSJx7xXmEuMd
         YBdJzLQe/QfpxksnHIRuYVY+RJk1PFsc1GM5KygxQAOHeRI/VZFs7gI1WXQUt4BQYuxu
         UFUg==
X-Gm-Message-State: ANoB5pm34k2o8J3H44jonrI1Msr9TeWbEyUKtox0hW+zkTVyuaAU4NZI
        thUafqnQr3RHT3TmWqZkayy2Zw==
X-Google-Smtp-Source: AA0mqf4sgLsj52HWaY59vMgHa4fGiq4HixM8ZVYXfqlh1s69CeMqoQVflfov72D5yRE0mhynje0tUA==
X-Received: by 2002:a19:6d0f:0:b0:4a2:23b0:b850 with SMTP id i15-20020a196d0f000000b004a223b0b850mr780143lfc.60.1668177933536;
        Fri, 11 Nov 2022 06:45:33 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id n26-20020ac2491a000000b00494a603953dsm361574lfi.89.2022.11.11.06.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 06:45:32 -0800 (PST)
Message-ID: <72093230-9da4-665d-c177-055c0a5e33cc@linaro.org>
Date:   Fri, 11 Nov 2022 15:45:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 3/9] dt-bindings: regulator: Add binding schema for
 mt6357 regulators
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-rtc@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
References: <20221005-mt6357-support-v4-0-5d2bb58e6087@baylibre.com>
 <20221005-mt6357-support-v4-3-5d2bb58e6087@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221005-mt6357-support-v4-3-5d2bb58e6087@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2022 19:43, Alexandre Mergnat wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add YAML schema for the MediaTek MT6357 regulators.

Use subject prefixes matching the subsystem (git log --oneline -- ...).
regulator: dt-bindings:

> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  .../regulator/mediatek,mt6357-regulator.yaml       | 292 +++++++++++++++++++++
>  1 file changed, 292 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6357-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6357-regulator.yaml
> new file mode 100644
> index 000000000000..3997a70a8b6c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6357-regulator.yaml
> @@ -0,0 +1,292 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/mediatek,mt6357-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

