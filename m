Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C09973E5E8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjFZQ7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjFZQ64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:58:56 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E43E6E;
        Mon, 26 Jun 2023 09:58:55 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-780c8df59caso174674439f.3;
        Mon, 26 Jun 2023 09:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687798734; x=1690390734;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C68yqM+uQF5bxYAeEfhwAi+z+PT5sKlVa+KlpLAFqEs=;
        b=domnIbquoD3pNJ2vhmmcQesAbWglDHmLcViXD2Bnr0Wbi6JpJ60a76who3SKMNGkRi
         VDIcn/Czd5OkgWlPTQg3Y+US4K0RgnODdAn6pJncHaobQIcNQknmley2m+GYYI4v+DLY
         TsNAFm3f8RgZ/XDDPtVftsYMMhTQuwiU/rdwyQ753t+/By04ybxX4CCv/WGGwM1tfCgJ
         jyT+ddOjP//+hgAJ2/wTU3w1TRlGVVoOGniFp1KJIflBd7vuqO3+znLdR0RMl2XIMHAu
         wJvO3O5HG0weOG86zVrcJPIOD6DWub9pWY8gP62H1WZaXyo27XjaUDtWAZWcKpz1bRfP
         L13g==
X-Gm-Message-State: AC+VfDynbynpDas5SY7k7Wmwt07cOe92ppdC9K9N8hqEjGOdVaJ1TFhh
        1WEkmMlJ1VJZhGC4/9v43Q==
X-Google-Smtp-Source: ACHHUZ5CEus2w7VnsWg2fQvqYZxwoYG1DHsqvjJsZhIQE0zdvVKxJF1eFuTYxc/ujTcghM0JMksElw==
X-Received: by 2002:a05:6602:131e:b0:783:4c29:b978 with SMTP id h30-20020a056602131e00b007834c29b978mr6702809iov.12.1687798734371;
        Mon, 26 Jun 2023 09:58:54 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id dq42-20020a0566384d2a00b00423230a3085sm1841238jab.99.2023.06.26.09.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:58:53 -0700 (PDT)
Received: (nullmailer pid 3390691 invoked by uid 1000);
        Mon, 26 Jun 2023 16:58:51 -0000
Date:   Mon, 26 Jun 2023 10:58:51 -0600
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
Subject: Re: [PATCH V2] dt-bindings: nvmem: fixed-cell: add compatible for
 MAC cells
Message-ID: <20230626165851.GA3387880-robh@kernel.org>
References: <20230626113716.17674-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230626113716.17674-1-zajec5@gmail.com>
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

On Mon, Jun 26, 2023 at 01:37:16PM +0200, Rafał Miłecki wrote:
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
> This commit adds a *generic* compatible string: "mac-base". As always it
> needs to be carefully reviewed.
> 
> OpenWrt project currently supports ~300 home routers that have NVMEM
> cell with binary-stored base MAC.T hose devices are manufactured by
> multiple vendors. There are TP-Link devices (76 of them), Netgear (19),
> D-Link (11), OpenMesh (9), EnGenius (8), GL.iNet (8), ZTE (7),
> Xiaomi (5), Ubiquiti (6) and more. Those devices don't share an
> architecture or SoC.
> 
> Another 200 devices have base MAC stored in an ASCII format (not all
> those devices have been converted to DT though).
> 
> It would be impractical to provide unique "compatible" strings for NVMEM
> layouts of all those devices. It seems like a valid case for allowing a
> generic binding instead. Even if this binding will not be sufficient for
> some further devices it seems to be useful enough as it is.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V2: Drop "mac-ascii" as length can be checked instead
>     Fix "allOf" by adding required: [ compatible ]
> ---
>  .../bindings/nvmem/layouts/fixed-cell.yaml    | 26 +++++++++++++++++++
>  .../bindings/nvmem/layouts/fixed-layout.yaml  | 12 +++++++++
>  .../devicetree/bindings/nvmem/nvmem.yaml      |  5 +++-
>  3 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml b/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
> index e698098450e1..036a9ed88893 100644
> --- a/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
> @@ -11,6 +11,15 @@ maintainers:
>    - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>  
>  properties:
> +  compatible:
> +    oneOf:
> +      - const: mac-base
> +        description: >
> +          Cell with base MAC address to be used for calculating extra relative
> +          addresses.
> +          It can be stored in a plain binary format (cell length 12) or as an

Don't you mean a length of 6?

> +          ASCII text like "00:11:22:33:44:55" (cell length 17).
> +
>    reg:
>      maxItems: 1
>  
> @@ -25,6 +34,23 @@ properties:
>          description:
>            Size in bit within the address range specified by reg.
>  
> +allOf:
> +  - if:
> +      required: [ compatible ]
> +    then:
> +      if:
> +        properties:
> +          compatible:
> +            contains:
> +              const: mac-base
> +      then:
> +        properties:
> +          "#nvmem-cell-cells":
> +            description: The first argument is a MAC address offset.
> +            const: 1
> +        required:
> +          - "#nvmem-cell-cells"
> +
>  required:
>    - reg
>  
> diff --git a/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
> index c271537d0714..b3a09e8864f1 100644
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
> +            compatible = "mac-base";
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
