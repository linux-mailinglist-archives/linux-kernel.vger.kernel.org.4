Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0EA6E98FF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbjDTQBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjDTQBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:01:31 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE928110;
        Thu, 20 Apr 2023 09:01:30 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id c17-20020a4aa4d1000000b005418821052aso783375oom.6;
        Thu, 20 Apr 2023 09:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682006490; x=1684598490;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mIpdpe/NpR/Ih+cQndC/G+rH56/6XJaiFLeSU8K5oA0=;
        b=WijXUS6T6QWuDPimJfAW988Zx7ImcnbTa7nQW0fqT57JquB7KfWSN9F82unEbyd4Bl
         qM7+Vag7UXbuiTg8k62pqMkygod26HcHvCGelhL59AcH5yZXAuD7wgSFktvrw1SYEbKD
         p32FIUkSGUHXFFiqkfROs3JcK7tiQQxULGANkn0+d78/NVlZduLAsTtfL+nUmLVyJSRS
         RE8ThYit8mhFqYLXdmII1r6S0rI+6hQ7kB+0SPl9Qo1w74fLiXo2BGoSd+YeUlOs6Gkv
         9aAZ02X1vGCEpEaPDlYTKdQVcBqhPG4M8M/z0LY/g6hNoKp8iV/QQHNaDeWT9jU5kwhg
         vzBg==
X-Gm-Message-State: AAQBX9fmjKMBo+bX6s7x2+b823EXKaGtO90ZeF37RszS1jfYYBq7nWP7
        +lZX2HO5mBqOWiqFWfBYVg==
X-Google-Smtp-Source: AKy350bt+0X2w1Rb34a72ni3IOj9CQFLCcOcDdhi78zN3O8KOC08bs/0RKiA7zeCHsbuuGFdNtrbGw==
X-Received: by 2002:a4a:95af:0:b0:546:1d7b:20be with SMTP id o44-20020a4a95af000000b005461d7b20bemr765333ooi.7.1682006489810;
        Thu, 20 Apr 2023 09:01:29 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v12-20020a4aad8c000000b0054542d3219asm748526oom.11.2023.04.20.09.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 09:01:29 -0700 (PDT)
Received: (nullmailer pid 2950580 invoked by uid 1000);
        Thu, 20 Apr 2023 16:01:28 -0000
Date:   Thu, 20 Apr 2023 11:01:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 1/3] dt-bindings: nvmem: brcm,nvram: add
 #nvmem-cell-cells for MACs
Message-ID: <20230420160128.GA2945386-robh@kernel.org>
References: <20230406110804.12024-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230406110804.12024-1-zajec5@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 01:08:02PM +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Broadcom's NVRAM contains MACs for Ethernet interfaces. Those MACs are
> usually base addresses that are also used for calculating other MACs.
> 
> For example if a router vendor decided to use gmac0 it most likely
> programmed NVRAM of each unit with a proper "et0macaddr" value. That is
> a base.
> 
> Ethernet interface is usually connected to switch port. Switch usually
> includes few LAN ports and a WAN port. MAC of WAN port gets calculated
> as relative address to the interface one. Offset varies depending on
> device model.
> 
> Wireless MACs may also need to be calculated using relevant offsets.
> 
> To support all those scenarios let MAC NVMEM cells be referenced with an
> index specifying MAC offset.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../devicetree/bindings/nvmem/brcm,nvram.yaml        | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
> index 36def7128fca..a921e05cc544 100644
> --- a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
> @@ -36,14 +36,26 @@ properties:
>    et0macaddr:
>      type: object
>      description: First Ethernet interface's MAC address
> +    properties:
> +      "#nvmem-cell-cells":
> +        description: The first argument is a MAC address offset.
> +        const: 1

Not a new issue, but these nodes are missing 'additionalProperties: 
false'. Can you add that. With that,

Reviewed-by: Rob Herring <robh@kernel.org>

