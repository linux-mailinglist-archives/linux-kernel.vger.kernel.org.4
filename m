Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3029C693843
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 17:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjBLQAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 11:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBLQAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 11:00:31 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C74911645
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 08:00:27 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso7323662wms.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 08:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YGU2KyNUv+sxc/bzlB7mhKjmx/Pw0oglWgIG2EZVIbA=;
        b=pKJyf0FE2hK4WHFsNqQX5P8tTIHWpurUb3P8HvUvqR5EtN3yBwmhihd+TEl9kic4y1
         Va/nTrKeZm4IrowaHq80nVweRQ/vGGSudn5yHDxR3lMocMQEmTDixjTKmbrv6TiBbaE4
         Dwz2twa0Leu0eqChwbZb+J0yF+c0QMHC7kZBrgL8T7R5A3LyF9v+eW66q5FG94Fr0grS
         6LV5+8EzIYwOeLgWUyfvUhFzwDGRJ5Fbj0MJvlDj2djC1zcssiT5G8yAjPwlXtTM5643
         wi1ujqxYS9FaEa1qiRWq85zVj8Fh/AS4ymEsCec3NgOnD3mp+HY4TF1UJVLTQRHjuTqs
         V57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YGU2KyNUv+sxc/bzlB7mhKjmx/Pw0oglWgIG2EZVIbA=;
        b=ecIOf6zZSzZwBWgTSusUfwZmQYHMGktSN3PGkk4OP8hRzZ4ucXHDIQKfZqOPRefKHf
         hFqKdUl96tInvkEmKHel3CDAx60GDcGJGUra00X53Z6r/K9ezYT7T4MS4uDzXrw1pjVk
         JmlDYlZd1GCbSu9nDao0dW8vCrOhsrR9nJJ6LNklkmPLbRRSlu5i9mQtuAEk3oaXizza
         GjJrHJY79i+aQE/+oKY4GzJb3p1Gr4dxT8tfhCzHb1bWqxubb0P3DA1A/AfKgg6yNFB3
         jAPIhlIHCiUSkhkL5fZXBq9mbhB+n9pLbtufPP89rtTxPnB9HU3UAW2rbk0OyCW7F88Q
         msLQ==
X-Gm-Message-State: AO0yUKVntHZZh4LfECTYlL4FeBIJLcmYb1ozL6EK4LNKZCdtESLxKLN5
        fbhSTENTn8xPJzMc1tItRtiQ3w==
X-Google-Smtp-Source: AK7set8z82v2CnR4/S0P/8tRVoY90b3Voh+7XtP2hugVVBxhslAeWC325zQsc3zoAGhEAkOmcDhkCw==
X-Received: by 2002:a05:600c:13c8:b0:3da:516:19ed with SMTP id e8-20020a05600c13c800b003da051619edmr16316365wmg.29.1676217625691;
        Sun, 12 Feb 2023 08:00:25 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c2-20020a05600c0a4200b003de664d4c14sm12552421wmq.36.2023.02.12.08.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Feb 2023 08:00:25 -0800 (PST)
Message-ID: <e34c139f-3477-8689-af01-29560f8c1265@linaro.org>
Date:   Sun, 12 Feb 2023 17:00:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] dt-bindings: arm: sti: addition of STi platform
 syscon
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230211210500.9919-1-avolmat@me.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230211210500.9919-1-avolmat@me.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your patch. There is something to discuss/improve. Few nits.

On 11/02/2023 22:04, Alain Volmat wrote:
> Addition of the various STi platform syscon node description.

Use imperative.
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  .../bindings/arm/sti/st,sti-syscon.yaml       | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/sti/st,sti-syscon.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/sti/st,sti-syscon.yaml b/Documentation/devicetree/bindings/arm/sti/st,sti-syscon.yaml
> new file mode 100644
> index 000000000000..e4bbc90694b3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/sti/st,sti-syscon.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/sti/st,sti-syscon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STi platform sysconfig entries


Drop "entries", does not look related to hardware.

> +
> +maintainers:
> +  - Patrice Chotard <patrice.chotard@foss.st.com>
> +
> +description: |
> +  Binding for the various sysconfig nodes used within the STi
> +  platform device-tree to point to some common configuration
> +  registers used by other nodes.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - st,stih407-sbc-syscfg
> +          - st,stih407-front-syscfg
> +          - st,stih407-rear-syscfg
> +          - st,stih407-flash-syscfg
> +          - st,stih407-sbc-reg-syscfg
> +          - st,stih407-core-syscfg
> +          - st,stih407-lpm-syscfg

How about putting them in some order?

> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    syscfg_sbc: sbc-syscfg@9620000 {

Generic node names, thus usually syscon or system-controller
> +...

Best regards,
Krzysztof

