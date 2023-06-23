Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4DD73C0AA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 22:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjFWUmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 16:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbjFWUmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 16:42:05 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872C235AE;
        Fri, 23 Jun 2023 13:41:23 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-780d179ffddso38386139f.1;
        Fri, 23 Jun 2023 13:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687552818; x=1690144818;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ot8TQl0fG1cRM0UPfyPtiV0P85KVORof9aumFFE+MAo=;
        b=S5oVMK7IxFpLzCkUt5LuyzDIMo/VIl9BURGW29Yklrzbpyk787VoGRmiDctgvvj3qs
         RmM0SayT+a/xg6jYO4ArNXouwU5/+yCymyggUHzpotmUP2l7O/5vi0kqmov22IQruyKw
         x82+1MoizaWoQQvol8Jk/ZukfzdTJlgKB0eZTAvULITmgzoN/pvAdAfrWDHNwc4lUJw5
         Nk4CQyqkbqb3j/qMkqT0rZ9zgmsx3bToG4VhB+7mTNgwV9+6UgOzOLu4HiFJVROw9F74
         G8b0DHAcqlYTsaGLQnu2L2BoJLyZfQPC12MlT4m12/U7EAvqYp/cOAT05uUQ+5mCtauk
         U3jA==
X-Gm-Message-State: AC+VfDzUPOoflS63qmL63RLkXY2WttbWtMLoVCI+yZGyJGdTK6U6vxKd
        8JQgxXEZGM7nULZ99GFdiA==
X-Google-Smtp-Source: ACHHUZ4ySz/gaJTt2dhyNcDp+w1NwFoIO+PkHghv/0UHyNCmJBxMCEOz3chGGoIVtZ2bUXQIPwCg5Q==
X-Received: by 2002:a5d:96c1:0:b0:76f:1664:672 with SMTP id r1-20020a5d96c1000000b0076f16640672mr20422866iol.13.1687552818624;
        Fri, 23 Jun 2023 13:40:18 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id ep22-20020a0566384e1600b00411b8c1813asm2809539jab.159.2023.06.23.13.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 13:40:17 -0700 (PDT)
Received: (nullmailer pid 1082374 invoked by uid 1000);
        Fri, 23 Jun 2023 20:40:16 -0000
Date:   Fri, 23 Jun 2023 14:40:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] dt-bindings: nvmem: fixed-cell: add compatibles for MAC
 cells
Message-ID: <20230623204016.GA1060715-robh@kernel.org>
References: <20230616213033.8451-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230616213033.8451-1-zajec5@gmail.com>
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

On Fri, Jun 16, 2023 at 11:30:33PM +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> A lot of home routers have NVMEM fixed cells containing MAC address that
> need some further processing. In ~99% cases MAC needs to be:
> 1. Optionally parsed from ASCII format
> 2. Increased by a vendor-picked value
> 
> There was already an attempt to design a binding for that at NVMEM
> device level in the past. It wasn't accepted though as it didn't really
> fit NVMEM device layer.
> 
> The introduction of NVMEM fixed-cells layout seems to be an opportunity
> to provide a relevant binding in a clean way.
> 
> This commit adds two *generic* compatible strings: "mac-base" and
> "mac-ascii". As always those need to be carefully reviewed.
> 
> OpenWrt project currently supports ~300 home routers that would benefit
> from the "mac-base" binding. Those devices are manufactured by multiple
> vendors. There are TP-Link devices (76 of them), Netgear (19),
> D-Link (11), OpenMesh (9), EnGenius (8), GL.iNet (8), ZTE (7),
> Xiaomi (5), Ubiquiti (6) and more. Those devices don't share an
> architecture or SoC.
> 
> Amount of devices to benefit from the "mac-ascii" is hard to determine
> as not all of them were converted to DT yet. There are at least 200 of
> such devices.
> 
> It would be impractical to provide unique "compatible" strings for NVMEM
> layouts of all those devices. It seems like a valid case for allowing a
> generic binding instead. Even if this binding will not be sufficient for
> some further devices it seems to be useful enough as it is.

I'm generally okay with this approach as it's not trying to handle all 
permutations with properties. Anything odd can have a specific 
compatible easily.

> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> If this binding gets approved I will still need a minor help with YAML.
> 
> For some reason my conditions in fixed-cell.yaml don't seem to work as
> expected. I tried to make "#nvmem-cell-cells" required only for the
> "mac-base" but it seems it got required for all cells:

Answer below.

>   DTC_CHK Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.example.dtb
> Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.example.dtb: nvmem-layout: calibration@4000: '#nvmem-cell-cells' is a required property
>         From schema: Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
> 
> Cell "calibration" doesn't have any "compatible" so it shouldn't require
> "#nvmem-cell-cells".
> Can someone hint me what I did wrong, please?
> ---
>  .../bindings/nvmem/layouts/fixed-cell.yaml    | 35 +++++++++++++++++++
>  .../bindings/nvmem/layouts/fixed-layout.yaml  | 12 +++++++
>  .../devicetree/bindings/nvmem/nvmem.yaml      |  5 ++-
>  3 files changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml b/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
> index e698098450e1..047e42438a4f 100644
> --- a/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
> @@ -11,6 +11,17 @@ maintainers:
>    - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>  
>  properties:
> +  compatible:
> +    oneOf:
> +      - const: mac-base
> +        description: >
> +          Cell with base MAC address to be used for calculating extra relative
> +          addresses.
> +      - const: mac-ascii
> +        description: >
> +          Cell with base MAC address stored in an ASCII format (like
> +          "00:11:22:33:44:55").

Isn't ASCII detectable? Just look at the length or that all values are 
0x3?. Though I can't make sense of the lengths your examples have.

> +
>    reg:
>      maxItems: 1
>  
> @@ -25,6 +36,30 @@ properties:
>          description:
>            Size in bit within the address range specified by reg.
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mac-base

This will be true with no compatible property. You need 'required: [ 
compatible ]' in addition.

> +    then:
> +      properties:
> +        "#nvmem-cell-cells":
> +          description: The first argument is a MAC address offset.
> +          const: 1
> +      required:
> +        - "#nvmem-cell-cells"
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mac-ascii
> +    then:
> +      properties:
> +        "#nvmem-cell-cells":
> +          description: The first argument is a MAC address offset.
> +          const: 1
> +
>  required:
>    - reg
>  
> diff --git a/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
> index c271537d0714..05b8230cd18c 100644
> --- a/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
> @@ -44,6 +44,18 @@ examples:
>          #address-cells = <1>;
>          #size-cells = <1>;
>  
> +        mac@100 {
> +            compatible = "mac-base";
> +            reg = <0x100 0xc>;
> +            #nvmem-cell-cells = <1>;
> +        };
> +
> +        mac@110 {
> +            compatible = "mac-ascii";
> +            reg = <0x110 0x11>;
> +            #nvmem-cell-cells = <1>;
> +        };
> +
>          calibration@4000 {
>              reg = <0x4000 0x100>;
>          };
> diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> index 980244100690..9f921d940142 100644
> --- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> @@ -49,7 +49,10 @@ properties:
>  patternProperties:
>    "@[0-9a-f]+(,[0-7])?$":
>      type: object
> -    $ref: layouts/fixed-cell.yaml
> +    allOf:
> +      - $ref: layouts/fixed-cell.yaml
> +      - properties:
> +          compatible: false
>      deprecated: true
>  
>  additionalProperties: true
> -- 
> 2.35.3
> 
