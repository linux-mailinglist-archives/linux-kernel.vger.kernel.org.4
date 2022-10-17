Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6386016A0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiJQSvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJQSvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:51:40 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24617691A5;
        Mon, 17 Oct 2022 11:51:39 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1364357a691so14292550fac.7;
        Mon, 17 Oct 2022 11:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GiJGN1wykXSQ00DVk7YPI2dlZqV1IWIoUviA+sQDHg0=;
        b=aFFM2cj8FVKLO9WHUnLln9BHixgHauwrvUFIze8pEmvCiee4au5WZBJL/amWOOlZx3
         +LT7FZju2fq/N5Gnkv3I8PEfYZg++eO6+MMrmfGgtCVHy5oKSemQNOb04J0mywrLGZFR
         chRtqL6plb7xCKZjwQDVA8eEGTiyozAva71gAXUM0ZpL5sZDKI2UGqUq4eq8+XWNqHYy
         qJsLQ3WPFTDxjsqWIO5i92HvjL094k04XEBY3n7YuWohHJrf3hjsPuaDV67/iVNeBOeO
         V+4dLRgb7Cj07FUmYYTrEuoMNp4xDLhdLx5HmyJiurjHfSRcvWibBJI0AWjxdHtpHGNN
         RpNA==
X-Gm-Message-State: ACrzQf1ArwvWRoKvQ5zOfREto6TRSdBge5AN49NElSMr0BjfchJa+9Mz
        Rnia/gBSwDSSvNn4oaGViDUu+kQT4g==
X-Google-Smtp-Source: AMsMyM6U30yroNpKFEKjCm7TCa6yB+1N8pcSiQ3DbD3vbcRuDFpLFvQGdmxPGsO1PpfLcrfrsqc6TQ==
X-Received: by 2002:a05:6870:6488:b0:131:a45b:a8ca with SMTP id cz8-20020a056870648800b00131a45ba8camr6395086oab.260.1666032698384;
        Mon, 17 Oct 2022 11:51:38 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 52-20020a9d0bb7000000b006619f38a686sm5073054oth.56.2022.10.17.11.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 11:51:37 -0700 (PDT)
Received: (nullmailer pid 2273470 invoked by uid 1000);
        Mon, 17 Oct 2022 18:51:38 -0000
Date:   Mon, 17 Oct 2022 13:51:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Naresh Solanki <naresh.solanki@9elements.com>
Subject: Re: [PATCH linux v2 1/3] spi: dt-bindings: aspeed: Add a ranges
 property
Message-ID: <20221017185138.GA2264550-robh@kernel.org>
References: <20221017091624.130227-1-clg@kaod.org>
 <20221017091624.130227-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221017091624.130227-2-clg@kaod.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 11:16:22AM +0200, Cédric Le Goater wrote:
> "ranges" predefines settings for the decoding ranges of each CS.

Please explain the problem, not what the change is.

> Cc: Naresh Solanki <naresh.solanki@9elements.com>
> Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  .../devicetree/bindings/spi/aspeed,ast2600-fmc.yaml      | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
> index fa8f4ac20985..a11cbc4c4c5c 100644
> --- a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
> +++ b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
> @@ -38,6 +38,14 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  ranges:
> +    minItems: 1
> +    maxItems: 5
> +    description: |
> +      Defines the address mapping for child devices with four integer
> +      values for each chip-select line in use:
> +      <cs-number> 0 <physical address of mapping> <size>
> +
>  required:
>    - compatible
>    - reg
> @@ -58,6 +66,7 @@ examples:
>          compatible = "aspeed,ast2600-fmc";
>          clocks = <&syscon ASPEED_CLK_AHB>;
>          interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> +        ranges = <0 0 0x20000000 0x2000000>, <1 0 0x22000000 0x2000000>;

By having ranges here, 'reg' in child nodes become translatable 
addresses. But they are not because they are SPI chip-selects. Only 
memory mapped addresses should be translatable. 

Probably the ranges here should be in 'reg' of the controller.

>  
>          flash@0 {
>                  reg = < 0 >;
> -- 
> 2.37.3
> 
> 
