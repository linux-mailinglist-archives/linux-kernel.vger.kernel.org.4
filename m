Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240455EDBCB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbiI1Lbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbiI1Lb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:31:27 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AA47FE62
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 04:31:25 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id s6so19879551lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 04:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=DNyd7Dp30Sf0SODKJSMM/lNDwtYbEH3SyllMKtKT77c=;
        b=KpajDYCMGJ8vWnzB3LaNGSoHuAgM+XXgZAmX8AP20Oq7pT3oB2eVSDz2fHceIN8qMR
         MCLtER4Zf/Gh6+SaqCUd5kbu1BVfHf+GCWMqF6zNmdJH1Nq+ENkR6ExMFPyMASuLL4aP
         IZCKjNME4+XpcpNjdDtrPSBKs3k2PaSaz8s/tm3+77Dn3vreQLyyHL8gDpQnb/qqeHTJ
         Eul/sNBm45v3nb79uSfd9mcv92nu1OteVTpOSwjZ6UndCcZL15VByYry+UjrYFm25FaA
         Ib0Z5JH85SFYDf91dIXNBfSJyJnl83OkQSjWTyx6tTlQ4TYKvB5V3j+HWGwY6uEYdc7h
         SVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=DNyd7Dp30Sf0SODKJSMM/lNDwtYbEH3SyllMKtKT77c=;
        b=4mrAfEQLvm3dJs+gYbX3fv1jgTRP+8QEYy7fSuzb+ZH3hsRH2KYGeYg89/7AbsorRw
         v7E7LnUZaIaEQx93yCC9if9mwtLmlOP9mIGF3FUWx/MoM6Un54aIJ89pQV4iWwyz91dp
         wm83DdwooesRbZGwiMT5gQ2NlVutghQz2DUd6RyxQNS+URS1sp4xL8WKIb7T7SPgW1eF
         6ptEZSYZQS81IHZB37eawVgsSyJB/0R03LdaQRf/JOzAknxKNWebKC78dnOua4O6/PLi
         EEtdatmlKhEsn1l/loZtgKVoF2JB2FSENUbZKr6jDFihb8jd2uxP8YupYUZYlW2Kt2WM
         rW1A==
X-Gm-Message-State: ACrzQf14ZswOWfcWKUYkdGZ0Iqrp+XX9PKxYQZGYB2LQxjdG1xgQTiAH
        kx5sNQaYd5jk1HSSp19O8XYvMBN8lZctBw==
X-Google-Smtp-Source: AMsMyM5kCJeiDB/X7LyzOhLlRdLOEAIYdVt+sl12dtCLxDbBitQujSCBF9Cg1v1vNCzCKkEoTUx1zw==
X-Received: by 2002:a05:6512:3da2:b0:499:d70a:e6bc with SMTP id k34-20020a0565123da200b00499d70ae6bcmr13914197lfv.191.1664364684179;
        Wed, 28 Sep 2022 04:31:24 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o22-20020ac25e36000000b004946c99e78asm448119lfg.277.2022.09.28.04.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 04:31:23 -0700 (PDT)
Message-ID: <fca2b97c-9d4f-d372-ef2a-aae8b367bbe5@linaro.org>
Date:   Wed, 28 Sep 2022 13:31:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/3] dt-bindings: gpio: Conver Unisoc GPIO controller
 binding to yaml
Content-Language: en-US
To:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220928092937.27120-1-zhang.lyra@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220928092937.27120-1-zhang.lyra@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 11:29, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> Convert the Unisoc gpio controller binding to DT schema format.
> 


Thank you for your patch. There is something to discuss/improve.

> diff --git a/Documentation/devicetree/bindings/gpio/sprd,gpio.yaml b/Documentation/devicetree/bindings/gpio/sprd,gpio.yaml
> new file mode 100644
> index 000000000000..c0cd1ed9809b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/sprd,gpio.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2022 Unisoc Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/sprd,gpio.yaml#

Use compatible as filename, so sprd,sc9860-gpio.yaml

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Unisoc GPIO controller
> +

Best regards,
Krzysztof

