Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFC972160D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 12:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjFDK1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 06:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjFDK1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 06:27:00 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4824C120
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 03:26:53 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-977c89c47bdso177577366b.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 03:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685874412; x=1688466412;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AJSHI/wM8OxoIZMScQKHzgdshhk+Z+V6iSUOb3f+fUo=;
        b=WBLIufn6FaDKJRlxmznzODTyp1EIkLlA9g0b7y9YQaN397riJeRgHOvmEhWu6QQTfg
         SIcsO05Y0x5Fo1CswjmM7AnZhLK/2Y6BLTVOVNW9UcKm8rKWzuKnbmChqwJsbbfr52ar
         jvioklNjVDfKH2xnlvzIibk3XTxlqrDVrsrgQHNUoWT7nETIhEc96bg+EzJBBrzeaNYL
         BUq1uwWS+eFrUcrkJX3a5BivOWVLvL/+tV7n8qnju7ZJKj665NBcpyPfwgjleO9dUHZV
         C2NjCIb0Tgorq+YFUbunBkpv4MIECxPrlKlHFPoL+mzVzizOvGfLUqmJlmePrjp2lCZJ
         zMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685874412; x=1688466412;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AJSHI/wM8OxoIZMScQKHzgdshhk+Z+V6iSUOb3f+fUo=;
        b=b//Q92rNQ0SR0meAzBZQ/79K2g20mFGKhYhmueq+//b2NwPSdZ8v468PxoPIDMBuJe
         IUc5KuL//QT9l6GA2tVoMPN7rSrcwYcCS2Iu+jMblNi0Xld4TwlYkpa7Bw+XKVNql5R5
         9WMo3+q/zNE2aTEQTL9JkTK+sTp/443HeI5BoZJXGwUIez0UvY42asT1gBkPL1MCgs6t
         jckSxE00W1Iyw4Umu+Bw4xWVMbtig+Dg5vQEIM8CAbJ0TI6I0WW6ZgQ28b0OSQpp+u4g
         TeoSq4VKa1rgpukMKF84lwNw/yRWS4G/hdnuxl8KzRgZrc8rCwqj3rri06ZBSCHjW3Ce
         QbbQ==
X-Gm-Message-State: AC+VfDyFZbMms3U0GqA3puukixeycnH0g2Su98vkPTYmtoEY04Q9PWmw
        Cea53jxcIbX19DpHVH0mob3xaw==
X-Google-Smtp-Source: ACHHUZ4JYlaRMEe60I46ZCyR3ZzQ9mtSGPn76sEYeljxg2b0VEu14Ft6nUd4H17cb/XZHAbY26cixw==
X-Received: by 2002:a17:907:1c25:b0:977:d48f:97ad with SMTP id nc37-20020a1709071c2500b00977d48f97admr1102482ejc.75.1685874411803;
        Sun, 04 Jun 2023 03:26:51 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id qu25-20020a170907111900b00974530bb44dsm2905545ejb.183.2023.06.04.03.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jun 2023 03:26:51 -0700 (PDT)
Message-ID: <cd4501ab-a088-cd2a-51c8-a469a66b7af5@linaro.org>
Date:   Sun, 4 Jun 2023 12:26:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: stm32: document audio of graph
 port for i2s
Content-Language: en-US
To:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230531140912.819373-1-olivier.moysan@foss.st.com>
 <20230531140912.819373-2-olivier.moysan@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230531140912.819373-2-olivier.moysan@foss.st.com>
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

On 31/05/2023 16:09, Olivier Moysan wrote:
> When linking the STM32 I2S to another DAI component, according
> to audio graph cards bindings, an OF graph port property is expected
> in the node. Document the port property.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml b/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
> index a040d4d31412..3bc917a45802 100644
> --- a/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
> +++ b/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
> @@ -61,6 +61,10 @@ properties:
>      description: Configure the I2S device as MCLK clock provider.
>      const: 0
>  
> +  port:
> +    $ref: audio-graph-port.yaml#
> +    unevaluatedProperties: false
> +

Extend the example.

Best regards,
Krzysztof

