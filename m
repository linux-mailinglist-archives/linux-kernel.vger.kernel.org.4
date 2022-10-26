Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2DF60EA94
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbiJZUuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbiJZUuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:50:24 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74A0631F9;
        Wed, 26 Oct 2022 13:50:21 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id g10so20306870oif.10;
        Wed, 26 Oct 2022 13:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HykrIfDGj0Emwb0ltWiGLZGl2PcTl3HkdAqnWg1OeHs=;
        b=gyJn1LwtZnto6T6KX5woSq3gTSjAP8sei/VgtHJkcCAoA6dcXE33Gu9quK/nmCyhJj
         WqWRNLBppkVn22akepRle2YdQIU9adqSvpTPApbpT/cjitrjtNJUo67D9rjQ/zKRziFH
         /BOVYYtzK3Gvl0bHP1WTWnOBsfHfZSxoD1rkQBGBeC8hzs3WvXoQmdrZGL2NgF9Z6dn/
         kiP/Adatjt0gjfzN3C9Cf5phsYqUJpKGtP1BuzrwjozBOoAGpioy8uisSaMJJBrS4nyQ
         sahlNsDBD2zPAwXhjIlv8/ibuAdzfNno4ekCTE0GjnletwO5sBEHxAz7HzTi1Gu6VA99
         N26Q==
X-Gm-Message-State: ACrzQf2V3B4R4WvIOAPrmSa1DG7AEZ+qMQz2l27qXkDcZ4gbriE0B2ZQ
        6zHhEpsmDcQ+Ms4029L5Rg==
X-Google-Smtp-Source: AMsMyM6KS8E4GJgpsN95NTujJva07W8KKKeA3reyNOFR2b1fz7WjG1LUzrKyh0h31G0KPSeL8vLmTg==
X-Received: by 2002:aca:c155:0:b0:355:1aa6:d7ad with SMTP id r82-20020acac155000000b003551aa6d7admr3004216oif.0.1666817421025;
        Wed, 26 Oct 2022 13:50:21 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z3-20020a4ad583000000b00480816a5b8csm1268377oos.18.2022.10.26.13.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 13:50:20 -0700 (PDT)
Received: (nullmailer pid 1294279 invoked by uid 1000);
        Wed, 26 Oct 2022 20:50:22 -0000
Date:   Wed, 26 Oct 2022 15:50:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     jh80.chung@samsung.com, ulf.hansson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCHv6 1/6] dt-bindings: mmc: synopsys-dw-mshc: document
 "altr,sysmgr-syscon"
Message-ID: <20221026205022.GA1291041-robh@kernel.org>
References: <20221026141631.696863-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026141631.696863-1-dinguyen@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 09:16:26AM -0500, Dinh Nguyen wrote:
> Document the optional "altr,sysmgr-syscon" binding that is used to
> access the System Manager register that controls the SDMMC clock
> phase.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v6: make "altr,sysmgr-syscon" optional
> v5: document reg shift
> v4: add else statement
> v3: document that the "altr,sysmgr-syscon" binding is only applicable to
>     "altr,socfpga-dw-mshc"
> v2: document "altr,sysmgr-syscon" in the MMC section
> ---
>  .../bindings/mmc/synopsys-dw-mshc.yaml        | 23 ++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> index ae6d6fca79e2..0e2024eb9018 100644
> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> @@ -6,9 +6,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Synopsys Designware Mobile Storage Host Controller Binding
>  
> -allOf:
> -  - $ref: "synopsys-dw-mshc-common.yaml#"
> -
>  maintainers:
>    - Ulf Hansson <ulf.hansson@linaro.org>
>  
> @@ -38,6 +35,26 @@ properties:
>        - const: biu
>        - const: ciu
>  
> +allOf:
> +  - $ref: synopsys-dw-mshc-common.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: altr,socfpga-dw-mshc
> +    then:
> +      properties:
> +        altr,sysmgr-syscon:
> +          $ref: /schemas/types.yaml#/definitions/phandle-array
> +          items:
> +            - description: phandle to the sysmgr node
> +            - description: register offset that controls the SDMMC clock phase
> +            - description: register shift for the smplsel(drive in) setting

This goes in the top-level. Use if/then schema to add constraints, not 
define properties.

> +    else:

Then you'll need to negate the if:  if: { not: { properties: ... }}

> +      properties:
> +        altr,sysmgr-syscon: false
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.25.1
> 
> 
