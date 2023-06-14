Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A65730ADF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 00:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjFNWnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 18:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjFNWnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 18:43:43 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9A71BF9;
        Wed, 14 Jun 2023 15:43:42 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-77ac14ff51bso286770439f.3;
        Wed, 14 Jun 2023 15:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686782621; x=1689374621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKGcfzr/p/3/4KMXU7XbxZ/xW3lQr6BAlDHKWT9Oujc=;
        b=Ub7jSme0+gA/G+1N4r9U8cVaA14leDdBE2l+WRCuAYc34O0LAoeuPXzliZ7QI/y3LJ
         y3nZXb4nO8RyabdaL0Dd2ui5HFyBEQIaniss9A/fLnXh0KI13zeDnXRmV4jAuGdPCrRJ
         O2ati0j71rY4qkfFDcg94KJWvUJw0S7vHTcNqwbA8K9uUyrB78EBkap4nJu0PNZD9gtI
         tP2qYw7UV7AI06cWPZnwOtszrK4r9MFI65alcoS4aG7CRs9X7Zia2zYSJNhPkQf4PuD8
         T1TWraD0z/nGZ1c5u913TPtMq3dOOL5OVgxuSpZP2tKZDVBSO/sHqFRh2+tPIwpeXLIi
         YbjQ==
X-Gm-Message-State: AC+VfDyXt0Johj2hnwNxKxGSHcZUfadXOjJwpAxdtG4jqiTZ2x+OF5/Z
        wCC48bCI6k8snV/IBMFOjBbETD80Vw==
X-Google-Smtp-Source: ACHHUZ6lygdrz16O6hhXp1oh6hsk1t75L5t3R45RyVE304fcKg+/x7h2K9VVCD3aevb1eYFkGvcjyQ==
X-Received: by 2002:a6b:4401:0:b0:760:f795:ccdf with SMTP id r1-20020a6b4401000000b00760f795ccdfmr14226968ioa.8.1686782621260;
        Wed, 14 Jun 2023 15:43:41 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id u19-20020a02c953000000b0041672c963b3sm5286814jao.50.2023.06.14.15.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 15:43:40 -0700 (PDT)
Received: (nullmailer pid 2999712 invoked by uid 1000);
        Wed, 14 Jun 2023 22:43:38 -0000
Date:   Wed, 14 Jun 2023 16:43:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Linux MTD List <linux-mtd@lists.infradead.org>,
        f.fainelli@gmail.com, rafal@milecki.pl, kursad.oney@broadcom.com,
        joel.peshkin@broadcom.com, computersforpeace@gmail.com,
        anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
        tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: Re: [PATCH 05/12] dt-bindings: mtd: brcmnand: Updates for bcmbca SoCs
Message-ID: <20230614224338.GA2990941-robh@kernel.org>
References: <20230606231252.94838-1-william.zhang@broadcom.com>
 <20230606231252.94838-6-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606231252.94838-6-william.zhang@broadcom.com>
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

On Tue, Jun 06, 2023 at 04:12:45PM -0700, William Zhang wrote:
> Use new compatiable brcm,nand-bcmbca to support BCMBCA broadband
> product. The old compatible string is still kept in the driver so old
> dtb can still work.

I don't understand why you need to change this. 


> Add brcm,nand-use-wp property to have an option for disabling this
> feature on broadband board design that does not use write protection.
> Add brcm,nand-ecc-use-strap to get ecc setting from board strap for
> broadband board designs because they do not specify ecc setting in dts
> but rather using the strap setting.
> 
> Remove the requirement of interrupts and interrupt-names properties to
> reflect the driver code.
> 
> This patch also includes a few minor fixes to the BCM63xx compatibles
> and add myself to the list of maintainers.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---
> 
>  .../bindings/mtd/brcm,brcmnand.yaml           | 64 +++++++++++++------
>  1 file changed, 43 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> index 1571024aa119..1fe1c166a9db 100644
> --- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> @@ -9,6 +9,7 @@ title: Broadcom STB NAND Controller
>  maintainers:
>    - Brian Norris <computersforpeace@gmail.com>
>    - Kamal Dasu <kdasu.kdev@gmail.com>
> +  - William Zhang <william.zhang@broadcom.com>
>  
>  description: |
>    The Broadcom Set-Top Box NAND controller supports low-level access to raw NAND
> @@ -18,9 +19,10 @@ description: |
>    supports basic PROGRAM and READ functions, among other features.
>  
>    This controller was originally designed for STB SoCs (BCM7xxx) but is now
> -  available on a variety of Broadcom SoCs, including some BCM3xxx, BCM63xx, and
> -  iProc/Cygnus. Its history includes several similar (but not fully register
> -  compatible) versions.
> +  available on a variety of Broadcom SoCs, including some BCM3xxx, MIPS based
> +  Broadband SoC (BCM63xx), ARM based Broadband SoC (BCMBCA) and iProc/Cygnus.
> +  Its history includes several similar (but not fully register compatible)
> +  versions.
>  
>    -- Additional SoC-specific NAND controller properties --
>  
> @@ -53,9 +55,9 @@ properties:
>                - brcm,brcmnand-v7.2
>                - brcm,brcmnand-v7.3
>            - const: brcm,brcmnand
> -      - description: BCM63138 SoC-specific NAND controller
> +      - description: BCMBCA SoC-specific NAND controller
>          items:
> -          - const: brcm,nand-bcm63138
> +          - const: brcm,nand-bcmbca
>            - enum:
>                - brcm,brcmnand-v7.0
>                - brcm,brcmnand-v7.1
> @@ -65,11 +67,15 @@ properties:
>            - const: brcm,nand-iproc
>            - const: brcm,brcmnand-v6.1
>            - const: brcm,brcmnand
> -      - description: BCM63168 SoC-specific NAND controller
> +      - description: BCM63xx SoC-specific NAND controller
>          items:
> -          - const: brcm,nand-bcm63168
> -          - const: brcm,nand-bcm6368
> -          - const: brcm,brcmnand-v4.0
> +          - enum:
> +              - brcm,nand-bcm63168
> +              - brcm,nand-bcm6368
> +          - enum:
> +              - brcm,brcmnand-v2.1
> +              - brcm,brcmnand-v2.2
> +              - brcm,brcmnand-v4.0
>            - const: brcm,brcmnand

Completely changing what's valid here too. You're breaking the ABI.

Rob
