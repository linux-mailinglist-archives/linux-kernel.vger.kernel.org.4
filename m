Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE55661A65
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 23:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjAHWRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 17:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjAHWRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 17:17:40 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA58711145;
        Sun,  8 Jan 2023 14:17:38 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id g7so6643224qts.1;
        Sun, 08 Jan 2023 14:17:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YJxqzF+OktwaYrRSfTrgkUqbVaKniIxL4rf0S9hLeYs=;
        b=aC/fnOj2nLn5thZpMNpoiAdUIsZ44bgw3T60N0hO/i65DXGSzmJoWwfn8OUOiKq2na
         Tyn61qd7g2lj+n84FaCyfCbP5aIyvh+iydv1sc5xvHb4uhrlfCaszWNpR8R0nsAtlTs/
         zKsH0XJ/KK9yDeohZd5dUc89NV1768T3Cfc3IPL/+8MBuCe0fTLMVlNmHtkUs8fGbn7A
         RREuQwv+hv76bQDwtzl9caaKk9i4tibaOxQvA3kNbnclQhY+ntr5N4IWcqsILlydCV2Y
         zItyx15gvkbvfRHb19IaWQrEyZuCuxDdCE6Nqo1d03ZUSxL8hqUqL1Kqnw5VNmi217jp
         5TWA==
X-Gm-Message-State: AFqh2kqkgRLlWbp+btXAgqkEl3P1cBdaPCIaZhNdpfY0Pj55Y6fOVcIr
        ez83p3NSQQg16HIbe5rw8Q==
X-Google-Smtp-Source: AMrXdXslZdmGQLfGS4uV0n72J4bR6x5uClR/bWk65ivFL2vpx639o71TwWdpiIJcCa/43mzuNhPwHQ==
X-Received: by 2002:ac8:73cc:0:b0:3a7:e2d2:5030 with SMTP id v12-20020ac873cc000000b003a7e2d25030mr94100902qtp.2.1673216257943;
        Sun, 08 Jan 2023 14:17:37 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80a5:9b51:39ae:24d1:33f3:811e])
        by smtp.gmail.com with ESMTPSA id x15-20020a05620a448f00b006ea7f9d8644sm4336131qkp.96.2023.01.08.14.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 14:17:37 -0800 (PST)
Received: (nullmailer pid 351826 invoked by uid 1000);
        Sun, 08 Jan 2023 22:17:34 -0000
Date:   Sun, 8 Jan 2023 16:17:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        u-boot@lists.denx.de,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 1/3] dt-bindings: nvmem: u-boot,env: add MAC's
 #nvmem-cell-cells
Message-ID: <20230108221734.GA345366-robh@kernel.org>
References: <20230105171038.13649-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230105171038.13649-1-zajec5@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 06:10:36PM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> U-Boot's "ethaddr" environment variable is very often used to store
> *base* MAC address. It's used as a base for calculating addresses for
> multiple interfaces. It's done by adding proper values. Actual offsets
> are picked by manufacturers and vary across devices.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  Documentation/devicetree/bindings/nvmem/u-boot,env.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> index cbc5c69fd405..1c139bd689ea 100644
> --- a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> @@ -50,7 +50,11 @@ properties:
>  
>    ethaddr:
>      type: object
> -    description: Ethernet interface's MAC address
> +    description:
> +      Ethernet interfaces base MAC address. The first argument is an offset.

The 2nd sentence belongs in the '#nvmem-cell-cells' description.

> +    properties:
> +      "#nvmem-cell-cells":
> +        const: 1
>  
>  additionalProperties: false
>  
> @@ -72,6 +76,7 @@ examples:
>              reg = <0x40000 0x10000>;
>  
>              mac: ethaddr {
> +                #nvmem-cell-cells = <1>;
>              };
>          };
>      };
> -- 
> 2.34.1
> 
> 
