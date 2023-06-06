Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BD9724023
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236535AbjFFKwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236436AbjFFKvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:51:18 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEFB1FCF
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 03:49:09 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-977e7d6945aso280835266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 03:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686048548; x=1688640548;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6OxQ/WVFYZmGc+9CMM9rjpLj4RMdDlgV2nWVue5FuEM=;
        b=m1tCThnr2QA5UotLP+/T+Gj9clGL6ioYl8gxstTn5hyE9T+4I10NPOzZrUr0uKT1uE
         QqVGSaFIguYSwKeTXKJiBo5ZaAWMY9gwTmYyj0Iw55khskv/NeSnSyivRpfC4yxEIx4f
         ayUb1xXsmfkWZyDgd2/YGfgUhee5AzNyLX5mSltAC+FpH6vS9bZglrI7UtwdKH26BqYa
         /F9UFAjS++gJ7IaslVqnZ2sYMz3TzCcHFjViLp1IpPS1FqhngLl+RJDwB7TCBajo1uCK
         dp1L4E8n7M1MuKXGCFuSMLeRm1d07aWg8NzCY272rEyC5un7/OXo57JShej+xQjwXlLv
         UN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686048548; x=1688640548;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6OxQ/WVFYZmGc+9CMM9rjpLj4RMdDlgV2nWVue5FuEM=;
        b=fbXFF6z4KEXaK8pSRT7fKzKoAhMNQuJsd7H/dLPKVGAc25PqUMOMr2ZxCkCdlTwEHS
         dtrydbq6ZfhdkUjMeGbLnNifoYhsjALp4TDMKGuDmlLDMic+n9QcuCVCBvO/PMwa5Fdl
         QD6fWFprRrfbcqXMEBoWxw/YvzD3jsHy+cvoi1FC4Lh4MaK0J4sdUjgL45KUWJOHbZBe
         DkUBYleEoUXwyOVojApmvmtv/6SiWHFWZLlJma+yK0iu5swt6atvYzItiv2Kia4Y9Zta
         70J0rDp/JhNbmkowaAJDvSklazUWUmdB2ll/1OSICsYX+QnTP7WP6TQJPNlkxVVdp4UP
         AmgA==
X-Gm-Message-State: AC+VfDwAy8jk7EP+c9F138Xnd1/x4Se2rlURfMulVzHMwtWjsUT4sRpr
        rhSY2IHr+4mdxeINmJsSdWypSA==
X-Google-Smtp-Source: ACHHUZ62p9CREiTDBs8+NQvQxZi8jYGLp28YpDUxsKHxFW/5WSepttSvAu2okKmihhBbk0Igv/r/PA==
X-Received: by 2002:a17:906:9b8d:b0:965:7fba:6bcf with SMTP id dd13-20020a1709069b8d00b009657fba6bcfmr2266323ejc.67.1686048547910;
        Tue, 06 Jun 2023 03:49:07 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id oy8-20020a170907104800b0096b4ec45e10sm5420767ejb.139.2023.06.06.03.49.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 03:49:07 -0700 (PDT)
Message-ID: <35bf0a69-bcf6-ae35-eb3c-e74cfcf9c571@linaro.org>
Date:   Tue, 6 Jun 2023 12:49:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [v5 3/5] dt-bindings: mfd: Add aspeed pwm-tach binding
Content-Language: en-US
To:     Billy Tsai <billy_tsai@aspeedtech.com>, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        lee@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, corbet@lwn.net,
        p.zabel@pengutronix.de, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org,
        patrick@stwcx.xyz
References: <20230606094535.5388-1-billy_tsai@aspeedtech.com>
 <20230606094535.5388-4-billy_tsai@aspeedtech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230606094535.5388-4-billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2023 11:45, Billy Tsai wrote:
> Add device binding for aspeed pwm-tach device which is a multi-function
> device include pwm and tach function.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> 
> ---
>  .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
> new file mode 100644
> index 000000000000..f98c11ff3f8a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2021 Aspeed, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/aspeed,ast2600-pwm-tach.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PWM Tach controller
> +
> +description: |
> +  The PWM Tach controller is represented as a multi-function device which
> +  includes:
> +    PWM
> +    Tach
> +
> +maintainers:
> +  - Billy Tsai <billy_tsai@aspeedtech.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - aspeed,ast2600-pwm-tach
> +      - const: syscon
> +      - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1

NAK. You got here clear comment. You cannot have simple MFD with
resources. It is not simple anymore.

Everywhere else you also ignored comments.

Best regards,
Krzysztof

