Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604786ED1F0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 18:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjDXQDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 12:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjDXQDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 12:03:02 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0119072BD;
        Mon, 24 Apr 2023 09:02:54 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-18e26c08349so2408893fac.0;
        Mon, 24 Apr 2023 09:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682352174; x=1684944174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnzfYEatrJSwokCAbLh8ogw9ZFGMSla77/kxbiv4hOM=;
        b=aweU4cCR0IPirBYORTCFBygRX9Wcsqoq8lDtjgJpBpWQiUoLuX49EDL9sxrXcDE2M4
         kj+8MGKNU/2MToUBFfWRqxDx8hWPLscQcrMeijmroi5AYxGAu3gLr1ZUXr+KVKoWCqWe
         GAzlY8JBX0gqRhUHvsylPo7YtBNePqFr9IXHlWO1VArzEN7QDOMHVGkWw6b5nwaTbY9e
         5e+tPOBEEyyui9ynBb4zNij8Yf1wpM6EL0QbPmO+GGABzWjUyZ2PfFRL/0dfRMQwlk46
         mBNXHJ2rfZ6flubYDqBdjJqLD5qKFAf9lfHC9NL9ZBY5DoSKjH8h4uxxqQESoeuwcuHf
         gAwA==
X-Gm-Message-State: AAQBX9fOd0Z6YeWrOC1DwmCAXBn4rBGaEzTyIZe2HCwow5BhDRykaT5e
        9m8InN+MDtspBVWR8p8Y7hRGjIEm7A==
X-Google-Smtp-Source: AKy350YFprky0QexCA+YNuK9/WujoCDaw7Udk1v+D5cUN5ctLb84vKBwYCYQ9n67gbZyOlPwf0q5vQ==
X-Received: by 2002:a05:6870:b491:b0:187:e5c4:4a50 with SMTP id y17-20020a056870b49100b00187e5c44a50mr10330412oap.17.1682352174290;
        Mon, 24 Apr 2023 09:02:54 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c2-20020ae9ed02000000b007339c5114a9sm3660638qkg.103.2023.04.24.09.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:02:53 -0700 (PDT)
Received: (nullmailer pid 2717300 invoked by uid 1000);
        Mon, 24 Apr 2023 16:02:52 -0000
Date:   Mon, 24 Apr 2023 11:02:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/43] dt-bindings: pwm: Add DT bindings ep93xx PWM
Message-ID: <20230424160252.GC2701399-robh@kernel.org>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230424123522.18302-15-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424123522.18302-15-nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 03:34:30PM +0300, Nikita Shubin wrote:
> Add YAML bindings for ep93xx SoC.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  .../bindings/pwm/cirrus,ep93xx-pwm.yaml       | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/cirrus,ep93xx-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/cirrus,ep93xx-pwm.yaml b/Documentation/devicetree/bindings/pwm/cirrus,ep93xx-pwm.yaml
> new file mode 100644
> index 000000000000..8f67eb152f8b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/cirrus,ep93xx-pwm.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/cirrus,ep93xx-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logick ep93xx PWM controller
> +
> +maintainers:
> +  - Thierry Reding <thierry.reding@gmail.com>

This is someone that cares about this platform/binding, not who applies 
patches. Same thing elsewhere.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - cirrus,ep9301-pwm
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: SoC PWM clock
> +
> +  clock-names:
> +    items:
> +      - const: pwm_clk

*-names is kind of pointless with only 1 entry. And 'pwm' is redundant 
because names are local to the device. 'clk' is redundant because it's 
all clocks.

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/cirrus,ep93xx-clock.h>
> +    pwm0: pwm@80910000 {
> +        compatible = "cirrus,ep9301-pwm";
> +        reg = <0x80910000 0x10>;
> +        clocks = <&syscon EP93XX_CLK_PWM>;
> +        clock-names = "pwm_clk";
> +    };
> +
> +...
> -- 
> 2.39.2
> 
