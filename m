Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC406EB3B5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 23:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbjDUVhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 17:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjDUVhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 17:37:02 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CDC113;
        Fri, 21 Apr 2023 14:37:01 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-18665c1776dso1897428fac.2;
        Fri, 21 Apr 2023 14:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682113021; x=1684705021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGdrdfDi3Lq6WvVDhiuJ7kQri9Uadj4krtd1AJ3qJwk=;
        b=OGGYrq6deeaKGnApJ3OrX+fBjsTAzgi+z3SVVPk1r5T5awKUohUNL13Ygb55KFEGbX
         CvvnFvZceALUgnEgJsQUZJdxMN2j4jTxTCYoMP9uB098zhcpUxNT0n2jznDp6N8cW6/N
         f5kKrgsJ6X6S8rJ0kuFyrqvPiiVDq+CZgMKteKjbWMdLP83DVS/hU7pFQtq5ywf36O6I
         FH5i2I+2EuBKVmVtDYAwO/opS7lYFuuVt0GcaJVvn9VxKx9w68i6obsZ63n0H7us2E99
         +YS2cKBd74AZ6UhGKdBaD3HeS5ZFNNgpYpU25fzOsb1l9SucZgxbJsBlbRds+zKKuUxZ
         vTfA==
X-Gm-Message-State: AAQBX9dCaym5mY9xRtPsxUJ5E39lAYdYL4gVlL5mdfvDFdtXsOaSYUVG
        1onuaJ/4RKa+Fx2B4ef6IXeK3jL98A==
X-Google-Smtp-Source: AKy350b66fHcYy0v/TQundiSahCAnJ1NbesgLLJNdtRNbXFMyCG3ZlpmEHSwtYMpYVhku12BwUI3Hw==
X-Received: by 2002:a05:6871:84:b0:17f:e13:9c96 with SMTP id u4-20020a056871008400b0017f0e139c96mr5263310oaa.51.1682113020868;
        Fri, 21 Apr 2023 14:37:00 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 26-20020a056870135a00b001765b2f6c53sm2180223oac.9.2023.04.21.14.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 14:37:00 -0700 (PDT)
Received: (nullmailer pid 1799330 invoked by uid 1000);
        Fri, 21 Apr 2023 21:36:59 -0000
Date:   Fri, 21 Apr 2023 16:36:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     zev@bewilderbeest.net, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: regulator: Add support for multiple
 supplies
Message-ID: <20230421213659.GA1786000-robh@kernel.org>
References: <20230420192402.3695265-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420192402.3695265-1-Naresh.Solanki@9elements.com>
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

On Thu, Apr 20, 2023 at 09:24:01PM +0200, Naresh Solanki wrote:
> Add optional DT property 'regulator-supplies' to handle connectors with
> multiple supplies.
> If this property is present, it will determine all regulator supplies.
> Otherwise, the 'vout' supply will be used as a fallback.
> 
> This change improves support for connector like PCIe connectors on
> mainboards that can be powered by 12V and 3.3V supplies.
> 
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ...
> Change in V2:
> - Added example
> - Update property type & description.
> - Improve commit message
> ---
>  .../bindings/regulator/regulator-output.yaml  | 21 ++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/regulator-output.yaml b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
> index 078b37a1a71a..a9dce26991ff 100644
> --- a/Documentation/devicetree/bindings/regulator/regulator-output.yaml
> +++ b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
> @@ -21,13 +21,22 @@ properties:
>    compatible:
>      const: regulator-output
>  
> -  vout-supply:
> +  regulator-supplies:
> +    $ref: /schemas/types.yaml#/definitions/string-array
>      description:
> -      Phandle of the regulator supplying the output.
> +      Optional property that specifies supply names provided by
> +      the regulator. Defaults to "vout" if not specified. The
> +      array contains a list of supply names.
> +      Each supply name corresponds to a phandle in the
> +      patternProperties.
> +
> +patternProperties:
> +  ".*-supply":
> +    description:
> +      Specifies the phandle for various supplies

While you say use 'vout-supply' for a single supply, nothing enforces 
that anymore.

>  
>  required:
>    - compatible
> -  - vout-supply
>  
>  additionalProperties: false
>  
> @@ -37,3 +46,9 @@ examples:
>            compatible = "regulator-output";
>            vout-supply = <&output_reg>;
>        };
> +      out2 {
> +          compatible = "regulator-output";
> +          regulator-supplies = "sw0", "sw1";
> +          sw0-supply = <&out2_sw0>;
> +          sw1-supply = <&out2_sw1>;

Names in the consumer are relative to the consumer. You appear to be 
naming these by the supplier. Just add vout[0-9]-supply and iterate over 
that name in the driver. Then you don't need "regulator-supplies". 
Really, you never did. You could just find all properties ending in 
"-supply".

Rob
