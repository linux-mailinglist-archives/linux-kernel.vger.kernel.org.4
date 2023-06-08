Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B3E727794
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 08:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbjFHGqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 02:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbjFHGqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 02:46:38 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBA12129
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 23:46:36 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9788554a8c9so51623966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 23:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686206795; x=1688798795;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IZgN/pq4zJXDMGVU52SbNy/IfFWaN7LSvJZjeMzXd3A=;
        b=iGdtH8Yqn6jyihGPQrVSC70sM4ACObapuBk2v11OGmQBItBAukIcUpZpLTmfOoBuMH
         MHMA687Xp4MEV2oWdJP/Wn/K3E5glM6aPgQL+wxe5WGRKiOHlCEefmESBl0dNa7Y1BSI
         J3bKeUuKfB2HIqfxCO/S/dQUt2PdVGLQmRA+DX2hVHY43g0SQfyYlk26IAh8GMiPJAAK
         k8oZ27dbhxkySftlDFX9G7fu82nMV96SdFjcG1j/pvBA6anzLU9pO1YuQUUebDzPcmol
         +y4mxiKfkVli1IYAh7BCSbrk1hcSw5wlO0WwSjUWivy5UYahTuamqSnpcWSrg+dTFkQ5
         eG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686206795; x=1688798795;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IZgN/pq4zJXDMGVU52SbNy/IfFWaN7LSvJZjeMzXd3A=;
        b=dBvR9kdxhwSpCUsmy620iTLqjbfEIJc3+7Uxwq5yz/UPeuxUdj+nKq8GPQb+/ckMbX
         OGiPVJU6GErzxGud22YPybHoF/VJUchmdLIpuyO0t+Ihz0GOeW4CQ4nw5FgcaS+RV+5v
         RhcTdX9jug6R2za/dIT+TnmzWXU6kzwidCpoWat8J89DfH4wTevLNLhvFhSVldmPkw8L
         MGmeUtgcOTKfl8t2E8zffV1aMNQ8PUT2nVfbCJxikyBgkj+WJ9/mIHRajyubHd54YcAb
         jMzrpTDQyzoJOxeez6IX+Vglylp9UjQvhBJCPBq0aZXSrcoxXXHqZE/qkXWGItOQM4Dd
         FSfw==
X-Gm-Message-State: AC+VfDx9qL+6kTe3NJnpSYHgLvQFYx9rlO3yoA3KVrF9ZADWvlZsp0k2
        YBHBDoLaSyPHPca/in1RNcwe/ExhvXLd46BU6OU=
X-Google-Smtp-Source: ACHHUZ5p6fnCJHV5uldMrLu0wmGEQEGXksmv6Ojnv/qWf/9hyk16AeQy+XeNgmX+HuGIJCAn8kxjXg==
X-Received: by 2002:a17:907:72d0:b0:974:5ece:19a6 with SMTP id du16-20020a17090772d000b009745ece19a6mr9808402ejc.54.1686206794751;
        Wed, 07 Jun 2023 23:46:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id z18-20020a170906945200b00978874d1083sm273646ejx.135.2023.06.07.23.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 23:46:34 -0700 (PDT)
Message-ID: <4dffd320-8e30-fb30-6ded-79519afddc21@linaro.org>
Date:   Thu, 8 Jun 2023 08:46:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [v6 1/4] dt-bindings: pwm: Add ASPEED PWM Control documentation
Content-Language: en-US
To:     Billy Tsai <billy_tsai@aspeedtech.com>, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        corbet@lwn.net, p.zabel@pengutronix.de,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org,
        patrick@stwcx.xyz
References: <20230608021839.12769-1-billy_tsai@aspeedtech.com>
 <20230608021839.12769-2-billy_tsai@aspeedtech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230608021839.12769-2-billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2023 04:18, Billy Tsai wrote:
> Document the compatible for aspeed,ast2600-pwm device.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/pwm/aspeed,ast2600-pwm.yaml      | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml b/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
> new file mode 100644
> index 000000000000..a9e040263578
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2021 Aspeed, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/aspeed,ast2600-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed Ast2600 PWM controller
> +
> +maintainers:
> +  - Billy Tsai <billy_tsai@aspeedtech.com>
> +
> +description: |
> +  The Aspeed PWM controller supports up to 1 PWM outputs.

This does not look right.

> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-pwm
> +
> +  "#pwm-cells":
> +    const: 3

3 cells? For one PWM? What are they?

> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - clocks
> +  - resets
> +
> +additionalProperties: false

Missing examples. All bindings need examples.

Best regards,
Krzysztof

