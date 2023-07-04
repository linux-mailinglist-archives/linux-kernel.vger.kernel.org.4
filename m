Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFBD746DC9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjGDJkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjGDJkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:40:32 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1C41FDC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 02:38:23 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-992b2249d82so633079466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 02:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688463501; x=1691055501;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ERnzPIPRvWevLboQhEVq6zSzhxrqqEGbLmA9tpsiGI0=;
        b=irSJlz54V83Ic3w9B7kkZVmPaAKj8rOOaqqHxt4z2EndhT+6OFdL5rl1MkfCEmcUk+
         U2b3+TQaYECpAxUhcgDPZVbeP7cp3TFOAOkaJ+YG79KoF6emCpXHgWnalOOjl96k8AGO
         BChhV9m4pIftAdSk9Kp1xjUO6V2DN+iBtuL63QZ8cLHiYbO3Jv4Dy+MG4fJ3Y/JvkmxW
         mqL67qqV68/4OU3HY+83C8Poen6m1u0qJGosTpTvaiFR854RekzI3K1js02j3ikaa9WU
         Hesu4hGDWk+U1b7eVMifuWg7maaeU1ydnTd+JRFeYMTltdJ0/71rP0kIpgJELFgP9HlB
         hS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688463501; x=1691055501;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ERnzPIPRvWevLboQhEVq6zSzhxrqqEGbLmA9tpsiGI0=;
        b=l2VDOBuGwKtJvP15gOfSo1CEw0Cn1PBDyD8zyeQrsBtfJ0UdiIdRwk3/Kl4yPSCyZb
         SP1hDhcuufV7YiEx+T2MBkIXTStVHzyM0QAweOGIN/Jv87nwm3rO3x63OLmTISViFeFd
         2RCIqu51Lz2wWX/lPAXq0Xp7TSaR/63u+Slo4RpLhXR/MaL93cX+dEwVS0TMzpwGdht8
         r5hhpgOlulhPYHKpwiV3WGHjeQbClGikrSh8x8iokuVfZOXL/wyAC8WbxJt52El3K2LK
         Pvb7LgCa0hm9QNzCu5crKh20+cPMUOpr/HIwrWJhoVYDWKzlngWE4opwentSvvcvjveT
         kyRw==
X-Gm-Message-State: ABy/qLbKY47QQXtxsA/YqhdUI/jDL+qqcu9TgcLXXvhkF80OwD9xe6su
        ufB40rFP5dbNOC20TiHrgPZM0Q==
X-Google-Smtp-Source: APBJJlExmWdalCwz4mhd46wIPBv+5Ajxdam8PI8PX4rD0du+csKdm67scVujAXZWR1HmZMfM3p/34Q==
X-Received: by 2002:a17:906:594b:b0:988:a632:774a with SMTP id g11-20020a170906594b00b00988a632774amr10860901ejr.27.1688463501122;
        Tue, 04 Jul 2023 02:38:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id e19-20020a170906249300b0098e4aef0791sm11602644ejb.66.2023.07.04.02.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 02:38:20 -0700 (PDT)
Message-ID: <1b65e8d1-d5e1-0d6b-1248-d9683be44db8@linaro.org>
Date:   Tue, 4 Jul 2023 11:38:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RESEND v1 1/2] dt-binding: spi: constrain minItems of clocks and
 clock-names
Content-Language: en-US
To:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20230704092200.85401-1-william.qiu@starfivetech.com>
 <20230704092200.85401-2-william.qiu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230704092200.85401-2-william.qiu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2023 11:21, William Qiu wrote:
> The SPI controller only need apb_pclk clock to work properly on JH7110 SoC,
> so there add minItems whose value is equal to 1. Other platforms do not
> have this constraint.
> 
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>

I don't get why this is resent, but subject prefix is still wrong. It's
dt-bindings.

> ---
>  Documentation/devicetree/bindings/spi/spi-pl022.yaml | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-pl022.yaml b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
> index 91e540a92faf..42bb34c39971 100644
> --- a/Documentation/devicetree/bindings/spi/spi-pl022.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
> @@ -11,6 +11,7 @@ maintainers:
> 
>  allOf:
>    - $ref: spi-controller.yaml#
> +  - $ref: /schemas/arm/primecell.yaml#

This looks unrelated, so keep it as separate commit with its own rationale.

> 
>  # We need a select here so we don't match all nodes with 'arm,primecell'
>  select:
> @@ -34,12 +35,16 @@ properties:
>      maxItems: 1
> 
>    clocks:
> +    minItems: 1
>      maxItems: 2
> 
>    clock-names:
> -    items:
> -      - const: sspclk
> -      - const: apb_pclk
> +    oneOf:
> +      - items:
> +          - const: apb_pclk
> +      - items:
> +          - const: sspclk
> +          - const: apb_pclk

Are you sure that your clock is APB pclk in such case?

Best regards,
Krzysztof

