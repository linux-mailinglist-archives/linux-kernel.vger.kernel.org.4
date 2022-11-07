Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC53E61FEF5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 20:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbiKGT5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 14:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbiKGT47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 14:56:59 -0500
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB71D26AE6;
        Mon,  7 Nov 2022 11:56:58 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-13b23e29e36so13904161fac.8;
        Mon, 07 Nov 2022 11:56:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3mjAx7lLL85qpCZOJ6hUnCvzcFS81mcIgGEn4asyos=;
        b=OvvFymnpaxwaWfuZUXHuwQyE1Aqb9tHN8wlhpWCKevoeuBIhVSxQlbnxa/7oQX/IH0
         R1biC/QVEfpj6E9Qz/9t5W9Eb+staUVcxkGSIHIeLj9NNFmLUYK+9RtpwP5ZhbbAfv5A
         3hagtK0w8MYeB8jahXJ4gqwsxI8uh62FNaM2851gfgqK7y8in4hKMcimnGcas1zvwwr3
         VhFYE8VS0ZkEAtR7uJDsQCnqnIOqs6x45JfPSPBt9GIenXa6BveCQa/DdoWwnP00INIq
         Rnp9HnkyfoRz0ZTsOkhd35a9VmZlP1dDdZvEtW7wl7dbDdqii3WYXZv80Tkbr5xQi3vA
         ffOQ==
X-Gm-Message-State: ACrzQf3B2mkPyGzb1Mf21fkRfSPNNsa2O5bgT7fw5XpXpYBZvz/jZjB0
        rtVsOLbgMmqKcLpFOdKgsw==
X-Google-Smtp-Source: AMsMyM5NYYJ3aS7MNOxMCRLSi7vINBfg4MRphj85IP5FOHjm2GVj/CoRXPEGpzKn0tuY+9X5jYR8DQ==
X-Received: by 2002:a05:6870:41c4:b0:131:55a3:3069 with SMTP id z4-20020a05687041c400b0013155a33069mr30758903oac.159.1667851018033;
        Mon, 07 Nov 2022 11:56:58 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g92-20020a9d2de5000000b0066c4092ae4csm3272165otb.10.2022.11.07.11.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 11:56:57 -0800 (PST)
Received: (nullmailer pid 1487934 invoked by uid 1000);
        Mon, 07 Nov 2022 19:56:59 -0000
Date:   Mon, 7 Nov 2022 13:56:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     jh80.chung@samsung.com, ulf.hansson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCHv8 1/6] dt-bindings: mmc: synopsys-dw-mshc: document
 "altr,sysmgr-syscon"
Message-ID: <20221107195659.GA1483239-robh@kernel.org>
References: <20221103151525.474833-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103151525.474833-1-dinguyen@kernel.org>
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

On Thu, Nov 03, 2022 at 10:15:20AM -0500, Dinh Nguyen wrote:
> Document the optional "altr,sysmgr-syscon" binding that is used to
> access the System Manager register that controls the SDMMC clock
> phase.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v8: remove "" around synopsys-dw-mshc-common.yaml#
> v7: and "not" for the required "altr,sysmgr-syscon" binding
> v6: make "altr,sysmgr-syscon" optional
> v5: document reg shift
> v4: add else statement
> v3: document that the "altr,sysmgr-syscon" binding is only applicable to
>     "altr,socfpga-dw-mshc"
> v2: document "altr,sysmgr-syscon" in the MMC section
> ---
>  .../bindings/mmc/synopsys-dw-mshc.yaml        | 33 +++++++++++++++++--
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> index ae6d6fca79e2..a37cd7a68417 100644
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
> @@ -38,6 +35,36 @@ properties:
>        - const: biu
>        - const: ciu
>  
> +  altr,sysmgr-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to the sysmgr node
> +          - description: register offset that controls the SDMMC clock phase
> +          - description: register shift for the smplsel(drive in) setting
> +    description:
> +      This property is optional. Contains the phandle to System Manager block
> +      that contains the SDMMC clock-phase control register. The first value is
> +      the pointer to the sysmgr, the 2nd value is the register offset for the
> +      SDMMC clock phase register, and the 3rd value is the bit shift for the
> +      smplsel(drive in) setting.
> +
> +allOf:
> +  - $ref: synopsys-dw-mshc-common.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: altr,socfpga-dw-mshc
> +    then:
> +      not:
> +        required:
> +          - altr,sysmgr-syscon

'required' evaluates true when all properties in the list are present.

So altr,sysmgr-syscon must not be present.

> +    else:
> +      properties:
> +        altr,sysmgr-syscon: false

Else altr,sysmgr-syscon must not be present. ???

Rob
