Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F46E6F9153
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 12:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjEFKxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 06:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjEFKxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 06:53:12 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1663055B2
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 03:53:11 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-94ef0a8546fso440539866b.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 03:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683370389; x=1685962389;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R+UErNxwinHQ3Gbr526y3MMdqkGlpH1N4yA85BQu/jQ=;
        b=ZnnPcnv8ZBylQRbOhTSgc7oOzcDTDJvIepvAiTQC79+MygS56SCqReDEyF0mvUhgHU
         EAjNO5d0xcDcvPJabqJsnAvQaB4wF4QVBi/aoMWpjjFAalyT0lHrai5RZ/TN6WliMMso
         QseBxIY0eDXDKpjBxfWhXaCbikTrNjNX5O13OFwA91j+X0fvUMozhhUNwauaZyGmrm/R
         RF9YD7HZZ8Va24bLly+sx7TTMY2iILIkmn4YRe4mRCXesg2TvuetmkZbiSNw5YUD8CQi
         w0uE57IQnBinE+2+RppNVO/9dqxOYxDYLvBaa2u4MkEliXG8mo0JBb3Fc68/O9RiT5ZV
         yvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683370389; x=1685962389;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+UErNxwinHQ3Gbr526y3MMdqkGlpH1N4yA85BQu/jQ=;
        b=DYF130kfh2I8E5iGASRPl8gaZAV8Iprpqr2Mg0kmcQHMOtSa00sTYPdUZRbeDalmVG
         hUQgqLYn+0UaoTIwEoxfmNpp1gpKZzgmFCN9UPiHgCBLCbnnYiuK7NzqPU9i2FOG0DBi
         V+lKFlgmKKaZTKneh3oA4MzEJfFFDmuDnt3+UuXlBO5DEbTJYl1HcP+zkD5SZosDOUYl
         HRTkt4w++KWkVTC246sHf+H5pufrUFPyzInqWeNuYmys5TcPYGjTn2eKV4o8CavMVimn
         L9tfZHn3An8zAmxRxJvy32tWLwNEJCqNkNndY0Sed44BGpQd4Zab6eyNvmm6GcCcg+5J
         Y5xA==
X-Gm-Message-State: AC+VfDwPvaxhAH3MiHv90tAyYz4ZCkT00YixlFXcrBKzxtdvRFx27gP3
        LnlepYAlw4YewrrdXh+857/jZw==
X-Google-Smtp-Source: ACHHUZ6i+Y7zVINwjFBxl6CnKYAnCnn/zV1ojQVX9NQ093UjfJjxB0nkCiJ8/BQ6zNwikObpGIENCw==
X-Received: by 2002:a17:907:60c9:b0:965:c42d:ac71 with SMTP id hv9-20020a17090760c900b00965c42dac71mr4128109ejc.51.1683370389513;
        Sat, 06 May 2023 03:53:09 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:efe5:7c03:a10a:7a40? ([2a02:810d:15c0:828:efe5:7c03:a10a:7a40])
        by smtp.gmail.com with ESMTPSA id ig2-20020a1709072e0200b00959b810efcbsm2142263ejc.36.2023.05.06.03.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 03:53:08 -0700 (PDT)
Message-ID: <e38cbcdf-5963-fb00-d7b2-66d4129f9fce@linaro.org>
Date:   Sat, 6 May 2023 12:53:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 1/6] dt-bindings: spi: sun6i: add DT bindings for
 Allwinner R329 SPI
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
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Maxime Ripard <mripard@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20230506073018.1411583-1-bigunclemax@gmail.com>
 <20230506073018.1411583-2-bigunclemax@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230506073018.1411583-2-bigunclemax@gmail.com>
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

On 06/05/2023 09:30, Maksim Kiselev wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> Allwinner R329 SPI has two controllers, and the second one has helper
> functions for MIPI-DBI Type C.

I wonder what is the difference of DBI compatible. You refer to "helper
functions", which sounds like driver... do you mean some parts of SPI
controller?

> 
> Add compatible strings for these controllers
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml        | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> index de36c6a34a0f..2c1b8da35339 100644
> --- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> @@ -21,6 +21,8 @@ properties:
>      oneOf:
>        - const: allwinner,sun6i-a31-spi
>        - const: allwinner,sun8i-h3-spi
> +      - const: allwinner,sun50i-r329-spi
> +      - const: allwinner,sun50i-r329-spi-dbi

As Conor pointed out, nothing improved here.

Best regards,
Krzysztof

