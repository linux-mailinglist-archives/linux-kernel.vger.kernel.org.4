Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BD8611AF6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 21:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiJ1TjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 15:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJ1Ti7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:38:59 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45701DB8A0;
        Fri, 28 Oct 2022 12:38:58 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1322d768ba7so7423522fac.5;
        Fri, 28 Oct 2022 12:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPezRWwe1uqvQUH0IxzPFGw41VKXKjVRgrFnddPWA+U=;
        b=D7OuE9DBb2FCfmzWpahC90EVwbbP2z2E0pJmNgyoQuzJksB2YoKS4X65m1aQHr+AuB
         8A7sfctngIPjzJKZ9e3j7DVAWu0vce5il33Xo6MeGNho7rQ46VZGNaUapkQKo4lWiGfs
         ylcVNRtf1gQkIwIBQKpczhPkT5AgbDTzIUwznGIxvvJDrp3sJQmdE9/8LrWrSF55qj73
         e5OzszFu3WsA97KBHutwRy/Cq5O983o6+vm/zolItgu5EcAzGFDj0V2DgJGT5D0L84XM
         yEz5mXFWZn5znrXA4i9WoE4C2P26fZDRLGwXkNLjGi4nLrNHFl78Fdh2g/0AP3036d4g
         7cTg==
X-Gm-Message-State: ACrzQf22I1u4PX0FB5adbbta/DBohd4c82t/mWwllVyqJBdARUH1a9on
        /cSVts0cyTtIiWNOwQOVAw==
X-Google-Smtp-Source: AMsMyM6nE2WfzyiR0qouKxqYcNHNAhOZm0r5K+MsLRWplVxKXJkbEX48dCTlj6PsAz90t8p3y/VoGw==
X-Received: by 2002:a05:6870:d351:b0:13c:5da4:b09d with SMTP id h17-20020a056870d35100b0013c5da4b09dmr5471906oag.1.1666985938094;
        Fri, 28 Oct 2022 12:38:58 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r26-20020a9d751a000000b00662335e1642sm1988555otk.77.2022.10.28.12.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 12:38:57 -0700 (PDT)
Received: (nullmailer pid 2191906 invoked by uid 1000);
        Fri, 28 Oct 2022 19:38:59 -0000
Date:   Fri, 28 Oct 2022 14:38:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: phy: Fix UniPhier SATA controller node
 names in example
Message-ID: <20221028193859.GA2188803-robh@kernel.org>
References: <20221027044920.23194-1-hayashi.kunihiko@socionext.com>
 <20221027044920.23194-3-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027044920.23194-3-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 01:49:20PM +0900, Kunihiko Hayashi wrote:
> The word "glue" is ambiguous for the controller node name. Should put
> "sata-controller" instead of "ahci-glue" on the controller node.
> And rename a phy node to "sata-phy".
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml  | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
> index a3cd45acea28..89b8b133777a 100644
> --- a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
> @@ -117,14 +117,14 @@ additionalProperties: false
>  
>  examples:
>    - |
> -    ahci-glue@65700000 {
> +    sata-controller@65700000 {

But is this really the SATA controller aka AHCI?

In cases where we don't have a standardized name, I don't think it makes 
sense changing node names from one non-standard name to another.

>          compatible = "socionext,uniphier-pxs3-ahci-glue",
>                       "simple-mfd";
>          #address-cells = <1>;
>          #size-cells = <1>;
>          ranges = <0 0x65700000 0x100>;
>  
> -        ahci_phy: phy@10 {
> +        ahci_phy: sata-phy@10 {
>              compatible = "socionext,uniphier-pxs3-ahci-phy";
>              reg = <0x10 0x10>;
>              #phy-cells = <0>;
> -- 
> 2.25.1
> 
> 
