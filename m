Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3694769D683
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 23:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjBTW4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 17:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBTW4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 17:56:08 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7241F91D;
        Mon, 20 Feb 2023 14:56:03 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id c11so3173585oiw.2;
        Mon, 20 Feb 2023 14:56:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYGFpd9GU+JENPbJLudnhXGQHElorftzXREixJ5gOhw=;
        b=PcxmUvVG4ngfbdyiWt94mHnUTlyKIRk/kewRHy0BMRQRzwPfU7TMG5Vtw2xFZvCZWT
         OalCjchncH+7V26kFMFI5mPse8on8IxfwibTawr2pdypGlrtsxGNepNoNx+I86fQKvgp
         z+vgqW/UCAiuXyZHwugN0DVhZvKWde9rJ4+YJ98t3WPVYcvYrDxzinACQtVYKmy7MYIU
         K0g5ocwJEJNrvyjqdhamyUl2EBcNvA8zJgcJL04U+InMLRdR15F+A959SCuU6HhmhEUP
         stwXxSGoaGTEgGUj/QDVJmRwVhOdmNbZ1acegMQgu2Ss/JhL/DXm4VW7WIq3WhayS2i8
         OHpw==
X-Gm-Message-State: AO0yUKWqN48TA+LDzBBzMbPh/+BpNWsl55QHmREEuu7Cz2OVy0jRvd4O
        5JFQX7ePqSTETa5BU7RQKoC9T+DONw==
X-Google-Smtp-Source: AK7set9Q1vDIBcq1JTQXLqThjuKC6KcYB16w6rpvFlIrUVN587KknWRoNx9iYitO8c5mHuJfPQqe2Q==
X-Received: by 2002:a05:6808:3c8:b0:378:5987:6dc9 with SMTP id o8-20020a05680803c800b0037859876dc9mr5134784oie.9.1676933763064;
        Mon, 20 Feb 2023 14:56:03 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p84-20020acad857000000b00378ce4197casm5382660oig.8.2023.02.20.14.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 14:56:02 -0800 (PST)
Received: (nullmailer pid 548521 invoked by uid 1000);
        Mon, 20 Feb 2023 22:56:01 -0000
Date:   Mon, 20 Feb 2023 16:56:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 2/3] ASoC: dt-bindings: sama7g5-pdmc: add
 microchip,startup-delay-us binding
Message-ID: <20230220225601.GA545317-robh@kernel.org>
References: <20230217124151.236216-1-claudiu.beznea@microchip.com>
 <20230217124151.236216-3-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217124151.236216-3-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 02:41:50PM +0200, Claudiu Beznea wrote:
> Add microchip,startup-delay-us binding to let PDMC users to specify
> startup delay.

The diff tells me all this. Why does this need to be per platform?

> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml   | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml b/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml
> index c4cf1e5ab84b..9b40268537cb 100644
> --- a/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml
> +++ b/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml
> @@ -67,6 +67,12 @@ properties:
>      maxItems: 4
>      uniqueItems: true
>  
> +  microchip,startup-delay-us:
> +    description: |
> +      Specifies the delay in microseconds that needs to be applied after
> +      enabling the PDMC microphones to avoid unwanted noise due to microphones
> +      not being ready.
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.34.1
> 
