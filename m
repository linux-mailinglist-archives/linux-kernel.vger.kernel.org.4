Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F17E6F975F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 09:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjEGHoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 03:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjEGHoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 03:44:04 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC6712082
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 00:44:01 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-965f7bdab6bso381794266b.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 00:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683445440; x=1686037440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8X7J0rVubekG+DrRrQuBm6C1ywPBgjwPpumVcwGX+HQ=;
        b=rWcUEwlQJpV+ycrxz/+0KJoAxqQmMQrWo5GfzIqEGoPRyDBz2d+L+9XPBTpuPW1BEE
         7inHPMTKghSfeJUSlzMt86K5tsOSxTMXP5xgRr5v6RQZr+XoSBXOqu0tVMfEK8indjkg
         amJt97l/vCXBHr5voY09o91QhrNvuqv/COZGiDHzxQQlFvzA7LT7lr6Pn+MdmiDIt81r
         SmO8prh7tQTVsEGg7Iws7vQJGL1joiSAYJG8VVopngkhm0M4Ed4Mr4vSpYHTU5riPO9C
         6jrsbrvwvYYrMbkqolOpSF9y+nTjtI7KUM28I9V8gQNZCiZ2roM+GHncS/R2ljPwVSZg
         qmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683445440; x=1686037440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8X7J0rVubekG+DrRrQuBm6C1ywPBgjwPpumVcwGX+HQ=;
        b=KqVSUpZK46rBOYjZ29oFANNJX5pUP3XGJysuFVGETi/zq5SIN6971MqDQrVSENzpJA
         0xWcaqM1iKYRO9OLL+Is+KhSdE975CfiXROGIxve4udnUIyOnh/lbmRQPTDOZx8Kgi4H
         FIJ8bhSKDnBqRDItW8Z3JWYMmXTHWX9/0rkxSMG+6ZTe2k5uDtIxnfa4HTROCUbSIqlB
         szC3DvyeOcrMNGpJPHk8+RRCt43a5bC70mhcfplUWbpmc/KIagyPCDFnr0sUPUJScwtw
         2CD62+8S0zQLQvHSXs/W/oDEL/BJ7LcqvmGrbIoYSglbGVP5NyMuuKcvPtVhKEKxpPZQ
         jS8A==
X-Gm-Message-State: AC+VfDwpuddjttKVwyOWUAxBntt+hRcXm2HFe9Z9/ENVCNF2jVZh5bnR
        +m2Tj/jIDGJ4pB4xlrX+FtOg1g==
X-Google-Smtp-Source: ACHHUZ5JGEdSovi3dxyHchKR/hKO87oq5KWsTOg10yOhk2jCXZqX6mRsswt41WqNAgRTvqy5CBpc2A==
X-Received: by 2002:a17:907:360c:b0:94a:845c:3528 with SMTP id bk12-20020a170907360c00b0094a845c3528mr5491362ejc.45.1683445439836;
        Sun, 07 May 2023 00:43:59 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:183b:950f:b4d5:135a? ([2a02:810d:15c0:828:183b:950f:b4d5:135a])
        by smtp.gmail.com with ESMTPSA id g4-20020a170906348400b009659cdb2f98sm3319965ejb.23.2023.05.07.00.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 00:43:59 -0700 (PDT)
Message-ID: <ec31e502-6b40-ca5d-1294-2e5f174a37b9@linaro.org>
Date:   Sun, 7 May 2023 09:43:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 1/5] dt-bindings: spi: sun6i: add DT bindings for
 Allwinner R329/D1/R528/T113s SPI
Content-Language: en-US
To:     Maksim Kiselev <bigunclemax@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Maxime Ripard <mripard@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20230506232616.1792109-1-bigunclemax@gmail.com>
 <20230506232616.1792109-2-bigunclemax@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230506232616.1792109-2-bigunclemax@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2023 01:26, Maksim Kiselev wrote:
> Listed above Allwinner SoCs has two SPI controllers. First is the regular
> SPI controller and the second one has additional functionality for
> MIPI-DBI Type C.
> 
> Add compatible strings for these controllers
> 
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> ---
>  .../devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml   | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> index de36c6a34a0f..807dde457e3b 100644
> --- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> @@ -21,6 +21,7 @@ properties:
>      oneOf:
>        - const: allwinner,sun6i-a31-spi
>        - const: allwinner,sun8i-h3-spi
> +      - const: allwinner,sun50i-r329-spi

Keep the list ordered.

>        - items:
>            - enum:
>                - allwinner,sun8i-r40-spi
> @@ -28,6 +29,12 @@ properties:
>                - allwinner,sun50i-h616-spi
>                - allwinner,suniv-f1c100s-spi
>            - const: allwinner,sun8i-h3-spi
> +      - items:
> +          - enum:
> +              - allwinner,sun20i-d1-spi
> +              - allwinner,sun20i-d1-spi-dbi
> +              - allwinner,sun50i-r329-spi-dbi
> +          - const: allwinner,sun50i-r329-spi


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

