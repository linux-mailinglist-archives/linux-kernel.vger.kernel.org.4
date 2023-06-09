Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9E1729F6B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241997AbjFIP6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242008AbjFIP6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:58:23 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D812E1730
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:58:21 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-977e7d6945aso345961666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 08:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686326300; x=1688918300;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JTIUcKxxwzYhOws0JQfGmC6RAGAZi61ikoNQLRb3OQ0=;
        b=A5UGoQdlG3N270pU/JhmbVjSOYGvQjIHjRp3ZSWWnIANTBQQOA3+c10D/i13AB4ido
         NMZo6fbTMOBYSQWlHzkgYbXNHp+MhWza4AxBNkFHhkPBkIrS9XrjqC24Zi9i6lcD7EQw
         Qc5FzqPk956W4p2ZFNcG2GkXBpxUGBjuvspe5OFuLeGQ6OpY/YoC0j+QqPHIFx1SzBOC
         GbMlDQknFSd9PpaGexg7uTB4l9izICxtsfVSgxunY5mXvEuYtBbwvKjnB+y6Zh/2ywu2
         vNOUUNsFC0lWSXmyM02JFRWF0+Qsm8C0+JAS2nXM8W6xPU6/dwZlvucjTcdrdn81FbEO
         dr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686326300; x=1688918300;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JTIUcKxxwzYhOws0JQfGmC6RAGAZi61ikoNQLRb3OQ0=;
        b=Arnmkx4LrbsBNc0gKbQ1NFslzT4p08mpLOIQ3oy94PQPMO4wSLWDN9W/ebQKLLhYJC
         y8Z9p8qbBYJSCI2F+2DFPFzHIP8/fkEM7J3VBlRscsDBtkFtr4PrGNTA6uc9S2Bw7rTJ
         Fb/6CGaEBGziTtvAdaf+hf2qAVrDkB6nfGLecdT4JWc5sD7s53cH9mlgRw7cmIoaoWdH
         q8GJ+THtq7nh2z0th7ChRw5o9H4JomiB9G8XhjcXhroJRC3mL05/BszZT98UAS8I0bsS
         izFz9XyC0wVGMIyhb0Pnxi4TvAwgh+3RYxdCCgFWPgFJvh2hxUSUT33kebxXDzrFeTyS
         cdZg==
X-Gm-Message-State: AC+VfDzOEUokeXwRiaOKaRDNIQG0bxkTS471BeTw39xZ7cy1aMQUH8cR
        Wl69A4i9uTjiw7F8osG7/+lIqw==
X-Google-Smtp-Source: ACHHUZ6RHjDqkjCGZg0vTzsh+utDK4w8FReYKbqgq1a/1iTp5C525vseKC5bkxZvQUWGQmXXOxdNcg==
X-Received: by 2002:a17:907:9306:b0:974:1e85:6a69 with SMTP id bu6-20020a170907930600b009741e856a69mr2357545ejc.16.1686326300309;
        Fri, 09 Jun 2023 08:58:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id f8-20020a1709062c4800b0094edbe5c7ddsm1461854ejh.38.2023.06.09.08.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 08:58:19 -0700 (PDT)
Message-ID: <1bf1890f-d24c-12a1-217d-27579a2464a6@linaro.org>
Date:   Fri, 9 Jun 2023 17:58:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/3] dt: bindings: add bindings for TQMa93xxLA SOM
Content-Language: en-US
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc:     Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com
References: <20230609132915.634338-1-alexander.stein@ew.tq-group.com>
 <20230609132915.634338-2-alexander.stein@ew.tq-group.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230609132915.634338-2-alexander.stein@ew.tq-group.com>
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

On 09/06/2023 15:29, Alexander Stein wrote:
> From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> 
> TQMa93xxLA is a SOM variant in the TQ-Systems GmbH TQMa93xx series using
> NXP i.MX93 CPU on an LGA type board.
> MBa93xxCA is a starterkit base board for TQMa93xxLA on an adapter board.

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

It is dt-bindings, not something else.

A nit, subject: drop second/last, redundant "bindings for". The
"dt-bindings" prefix is already stating that these are bindings. One
bindings is enough.


> 
> Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  .../devicetree/bindings/arm/fsl.yaml          | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 2510eaa8906dd..8048c7f6a299d 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -1219,6 +1219,25 @@ properties:
>                - fsl,imxrt1170-evk         # i.MXRT1170 EVK Board
>            - const: fsl,imxrt1170
>  
> +      - description:
> +          TQMa93xxLA and TQMa93xxCA are two series of feature compatible SOM
> +          using NXP i.MX93 SOC in 11x11 mm package.
> +          TQMa93xxLA is designed to be soldered on different carrier boards.
> +          TQMa93xxCA is a compatible variant using board to board connectors.
> +          All SOM and CPU variants use the same device tree hence only one
> +          compatible is needed. Bootloader disables all features not present
> +          in the assembled SOC.
> +          MBa93xxCA mainboard can be used as starterkit for the SOM
> +          soldered on an adapter board or for the connector variant
> +          MBa93xxLA mainboard is a single board computer using the solderable
> +          SOM variant
> +        items:
> +          - enum:
> +              - tq,imx93-tqma9352-mba93xxca # TQ-Systems GmbH i.MX93 TQMa93xxCA/LA SOM on MBa93xxCA
> +              - tq,imx93-tqma9352-mba93xxla # TQ-Systems GmbH i.MX93 TQMa93xxLA SOM on MBa93xxLA SBC

xx sound like wildcard which you should not use. If you open the product
page, it also suggests that.

Best regards,
Krzysztof

