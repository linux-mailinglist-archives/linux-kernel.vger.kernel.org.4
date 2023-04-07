Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186C46DAEE9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 16:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjDGOm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 10:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjDGOmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 10:42:54 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DC7F7
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 07:42:52 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id g5so2537429wrb.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 07:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680878571; x=1683470571;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YaOlozGSnw9Y7fDgqjcUFYA4GgoO3+wl2jKckce8L5A=;
        b=QtizWJS7vuhUodCnYsQsSlajZqPLAGXXp1ZW/QGMX3RQUrD9cl1ByO/Yy9JiCc9EV7
         nrMXe1XJxXLp/ZznKViQpVn4QaWa72ZYCLmnH/l3jPsfLh8JS1EIbRxBzh6GeZKPiakK
         RPnCRkTbg8I4aBVIYgGqMUYfJE2F5pCskeYRzNVqIPRS8gt9VukTXAfTav/TIoxDv7kF
         eJe3AgCAWg2WRPUaJaUcgqM3Mc0Bfdtj/fVnbGz9m9sLtSsnWaI9sbpy5JoajpcqZQYf
         GW1ifCHAHkEHBijQVq2wHzlJhrPL7zLZqQWAMib583TyORx6kMNcn4apxpy6MKSlEfyv
         0T8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680878571; x=1683470571;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YaOlozGSnw9Y7fDgqjcUFYA4GgoO3+wl2jKckce8L5A=;
        b=Op5uL1wNU8GlkGcafqD+ZmYe9nAHSFyyucOatt300HjNc3ajhs6e85RiUdK99EAyam
         i24AeFgls6wpTlYQyvpuQQrXJlbbO2JAmcXbw682alzWm8fKrUDAXB6IinBVFB5xOQ+C
         8fn8dN0N8XXlOK9YXlKOQh6eF3PDTYwrG4v5FpzqCNp3gZqCZ0DQs0x3IYeO11XkZ8qq
         opzYJa9OIk70IGNxlgxKFvBhGDvJxykbg6yO9YaMG03z30K7PQEyghBhlw0Gj7yeMJbt
         nESkQVS4ApVzFOOwinshX1uOA1kHr6VENOsyv6Yl4LnPWXJHvAutH5dlBzzoCXx9SvBb
         JYXQ==
X-Gm-Message-State: AAQBX9dRBfdA0o7Ldx+psZgELISa9ZErCbaoG0Ql+WejYdTamXKi57zg
        fhuT428Y9xmEKNY2lT5/xX2z2Q==
X-Google-Smtp-Source: AKy350aeVnRBuhANMWkVH5LZ0N8qNk35i656AmJqPizaE31yarn72S34sgq1gg8oV2N4JiGQZS+WfQ==
X-Received: by 2002:a5d:50d0:0:b0:2ce:ae4c:c429 with SMTP id f16-20020a5d50d0000000b002ceae4cc429mr1540731wrt.4.1680878570973;
        Fri, 07 Apr 2023 07:42:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:d0cf:7013:b9fa:35f6? ([2a01:e0a:982:cbb0:d0cf:7013:b9fa:35f6])
        by smtp.gmail.com with ESMTPSA id e17-20020adffc51000000b002ef2e148d59sm4035408wrs.16.2023.04.07.07.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 07:42:50 -0700 (PDT)
Message-ID: <37b4faa1-a957-3ba3-e37a-0c1edef6fbaa@linaro.org>
Date:   Fri, 7 Apr 2023 16:42:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] dt-bindings: arm: amlogic: add C3 bindings
Content-Language: en-US
To:     Kelvin Zhang <kelvin.zhang@amlogic.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
References: <20230407102704.1055152-1-kelvin.zhang@amlogic.com>
Organization: Linaro Developer Services
In-Reply-To: <20230407102704.1055152-1-kelvin.zhang@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kelvin,

On 07/04/2023 12:27, Kelvin Zhang wrote:
> Document the new C3 SoC/board device tree bindings.
> 
> C3 is an advanced edge AI processor designed for smart IP camera
> applications, which does not belong to Meson series.
> 
> Therefore, modify the title field accordingly.
> 
> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
> ---
>   Documentation/devicetree/bindings/arm/amlogic.yaml | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
> index 274ee0890312..08d59842655c 100644
> --- a/Documentation/devicetree/bindings/arm/amlogic.yaml
> +++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
> @@ -4,7 +4,7 @@
>   $id: http://devicetree.org/schemas/arm/amlogic.yaml#
>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>   
> -title: Amlogic MesonX
> +title: Amlogic SoC based Platforms
>   
>   maintainers:
>     - Kevin Hilman <khilman@baylibre.com>
> @@ -205,6 +205,13 @@ properties:
>                 - amlogic,ad401
>             - const: amlogic,a1
>   
> +      - description: Boards with the Amlogic C3 C302X/C308L SoC
> +        items:
> +          - enum:
> +              - amlogic,aw409
> +              - amlogic,aw419
> +          - const: amlogic,c3
> +
>         - description: Boards with the Amlogic Meson S4 S805X2 SoC
>           items:
>             - enum:
> 
> base-commit: e134c93f788fb93fd6a3ec3af9af850a2048c7e6

I'll apply it in my v6.5/arm64-dt since I already sent the v6.4 PRs,
since it's early for v6.5 the branch will eventually be rebase when v6.4-rc1 is tagged

Neil
