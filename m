Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9036EB086
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 19:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbjDURZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 13:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjDURZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:25:24 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9EBBBB2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 10:25:23 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-94a34d3812cso323755266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 10:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682097921; x=1684689921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KuR1QTA5de2XpIRxwF6wkpWoxygn8gWhtK3M4m5P0yo=;
        b=Vn1pb6ehuFwl3wRaUgASiDignPRsqNKSAol5FaiF0SheHyxVCprP/+QoCMfMUp+MjU
         ssO0wpHBSlzJMTEvG1JgnRKVkck5isRzEzVXwNIFtYxJr37MNBTzLQtxQy9tbychWwDH
         PKWwZLTyTKb75qUQrVDxBZ5Q9u71P4Kz1+wLi/RqosCl2NyGLrS48BSaIZzz8Sdc/hEW
         +mK/bGu7nqBdyN8J9w6DrfMVl42HLCIYbjjx7Ajhvi1qsqELNASaAaZKoA+Fau+ejKxv
         bO9buZEOgqYPeu9nzaMX7qE4W3RQVyo5NuIahkbzqN7moGAzyEnvoIyyd9VDfBrzp+eO
         Jg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682097921; x=1684689921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KuR1QTA5de2XpIRxwF6wkpWoxygn8gWhtK3M4m5P0yo=;
        b=FcHg/dsxknkQOozm8FbiL+iR2IIScOYlG+AjmG2yEQHGS6cWwzUYUI44X5ROKNNSnN
         zxvz+5YnR0isKNoMncPJc03MjMKmErUoqtQGg4rGFycB3ZHr9V+t1+7PEyS6wkOrq1RJ
         jN2dbPF5Y8+/x9C5Eoe9O9YR0ubYiMumwZk2j/p7qyTffZZ4l/9kCF7R/vKo9ThF6ykR
         VaZz3ZH7ogRMDIbVt3UEJoR4thXf1fNmoZVxvAln5QdIwIGMK9N15b9tksQbo83oWtv9
         KPCMu9NdItZNsIlphqPlRW93tblWNKWBg5FlvAkN8gzYoS2aox+Kvb5RqFGffeL43QXm
         lejA==
X-Gm-Message-State: AAQBX9eJ1k0RZ3YIHq7f+082Lr06/a9CaP27jDw0ZRha4Ru1Yz1HNnre
        p0bPwiLn0Mn2VmrndBm8fAPHTQ==
X-Google-Smtp-Source: AKy350akQcwHtVGFCaVm9vH8T6/N5IsWemFtVpqLTZasE7IGcZlk4RlNsMzNd2z0PCpZeEIJU9aQxQ==
X-Received: by 2002:a17:906:ecb7:b0:8b1:3467:d71b with SMTP id qh23-20020a170906ecb700b008b13467d71bmr3000598ejb.48.1682097921527;
        Fri, 21 Apr 2023 10:25:21 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:687d:8c5:41cb:9883? ([2a02:810d:15c0:828:687d:8c5:41cb:9883])
        by smtp.gmail.com with ESMTPSA id bj1-20020a170906b04100b0094f7acbafe0sm1243769ejb.177.2023.04.21.10.25.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 10:25:20 -0700 (PDT)
Message-ID: <fde5c0af-8691-6066-3238-01b500000e11@linaro.org>
Date:   Fri, 21 Apr 2023 19:25:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: potentiometer: Add the Renesas
 X9250 potentiometers
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230421085245.302169-1-herve.codina@bootlin.com>
 <20230421085245.302169-2-herve.codina@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230421085245.302169-2-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2023 10:52, Herve Codina wrote:
> The Renesas X9250 is a quad digitally controlled potentiometers.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../iio/potentiometer/renesas,x9250.yaml      | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml b/Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml
> new file mode 100644
> index 000000000000..dfa36b23eb0d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/potentiometer/renesas,x9250.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas X9250 quad potentiometers
> +
> +maintainers:
> +  - Herve Codina <herve.codina@bootlin.com>
> +
> +description:
> +  The Renesas X9250 integrates four digitally controlled potentiometers.
> +  On each potentiometer, the X9250T has a 100 kOhms total resistance and the
> +  X9250U has a 50 kOhms total resistance.
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml
> +  - $ref: /schemas/iio/iio.yaml

Apologies, I missed it last time - you do not need iio.yaml. It's coming
from core schema and is always selected. You won't find its usage
anywhere in the kernel (git grep iio.yaml)

With iio.yaml dropped:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

