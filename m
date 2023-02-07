Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFF368D976
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 14:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjBGNfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 08:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbjBGNfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:35:44 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B812387C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 05:35:42 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso11466448wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 05:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k1ykxnCSPogB0kbxJnMoBL8O048yCl07opBue4WpgaQ=;
        b=tTuj0/XbFSyS4dn6D7rW1NOCwMHRyzAh+O6FP2x0BBLP/2F0FxstsfvHct8fILSH/K
         0GllB2iScPYt8V7iN34H0RSFKCruoUivMiSVGCtxTkSnKMZpYaIpKftzuLJyH0leBR0+
         qSJCq3ldl5dw6okdCiYezdtVaU1jvRex6x4G6R0UYxPklWw1Pn6TtaMyVhomxJuPkWMC
         FpOPOnGAt3n96q4B+oUkaXxF7ct2JK8etPczii+PuYqtxUsmT2vaQP62U8p/PFz4SLTg
         W11hImxwMZc1PGSjZR6AGekxCjzEeZzJJIP+OHLZ6Sb10ADbKfHuPKUElUaTxONnUgjE
         sEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k1ykxnCSPogB0kbxJnMoBL8O048yCl07opBue4WpgaQ=;
        b=5Edj/Fp7tPNth8VbnuXF7BZ8YHlsXGbssc66eKs12ekE5qVji88PPPHHBvjJqwGmzm
         5BKy5vGHWhtN2QWuyLpGZ4AkZdL0uF/U+lRE1Uo6Ef3xfIKQou+J4FtfJ2/SUGZjUpcU
         FJ9TichJEOEquTaU/a7udORxXQDHKwz5+Y3ic23oogh+BzauaaK+XiFHp5HOtTxKHe+5
         SBTBsFNyf0NRjk/P/aO+Vh8xnq5ClH4S+E7cGBKxjAjd505CTznro+Wy+w0LW65+gOu+
         f/hW7DZxaEw6JtYPyl3VRQ5OtiwXGzZaOliUglSKmZkDj7ZPINQf16LUgEm5y1VMpFZ0
         c6sw==
X-Gm-Message-State: AO0yUKVeULIxoAXrrfdMuDTT2P22bz3dHkbtFp9YlN0dF8Qg2RGrWecR
        4giPwNK1SywdHcBa5eGKj09WWA==
X-Google-Smtp-Source: AK7set9N2kRdkmfxK++BVbR4XXH+Yw/7DgZyRt1NfDA/eM1SF/QMNr1FLrcIAOqKD1ls1/bhgKNttg==
X-Received: by 2002:a05:600c:3596:b0:3df:d431:cf64 with SMTP id p22-20020a05600c359600b003dfd431cf64mr3061555wmq.39.1675776941479;
        Tue, 07 Feb 2023 05:35:41 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f1-20020a1cc901000000b003df14531724sm18521999wmb.21.2023.02.07.05.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 05:35:41 -0800 (PST)
Message-ID: <046b3b31-cbf7-674d-f05c-b825d6b46bf6@linaro.org>
Date:   Tue, 7 Feb 2023 14:35:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v13 2/6] dt-bindings: thermal: mediatek: Add LVTS thermal
 controllers
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
References: <20230207130958.608305-1-bchihi@baylibre.com>
 <20230207130958.608305-3-bchihi@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230207130958.608305-3-bchihi@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2023 14:09, bchihi@baylibre.com wrote:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Add LVTS thermal controllers dt-binding definition for mt8192 and mt8195.
> 


> +allOf:
> +  - $ref: thermal-sensor.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt8192-lvts-ap
> +              - mediatek,mt8192-lvts-mcu
> +    then:
> +      properties:
> +        nvmem-cells:
> +          maxItems: 1
> +
> +        nvmem-cell-names:
> +          maxItems: 1
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt8195-lvts-ap
> +              - mediatek,mt8195-lvts-mcu
> +    then:
> +      properties:
> +        nvmem-cells:

minItems: 2

> +          maxItems: 2
> +
> +        nvmem-cell-names:

minItems: 2

> +          maxItems: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts

(...)

> diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
> new file mode 100644
> index 000000000000..4f2082065a31
> --- /dev/null
> +++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + * Author: Balsam CHIHI <bchihi@baylibre.com>
> + */
> +
> +#ifndef __MEDIATEK_LVTS_DT_H
> +#define __MEDIATEK_LVTS_DT_H
> +
> +#define MT8195_MCU_BIG_CPU0		0
> +#define MT8195_MCU_BIG_CPU1		1
> +#define MT8195_MCU_BIG_CPU2		2
> +#define MT8195_MCU_BIG_CPU3		3
> +#define MT8195_MCU_LITTLE_CPU0	4

These changed for some reason. Why? The indentation is now broken
(although not visible above quote, but visible in diff and code).

Best regards,
Krzysztof

