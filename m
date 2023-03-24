Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC2B6C86DF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 21:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjCXUel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 16:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjCXUej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:34:39 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A711717B;
        Fri, 24 Mar 2023 13:34:39 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id bf30so2143862oib.12;
        Fri, 24 Mar 2023 13:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679690078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9FU1okYjNaTTvHlzFDbnyfTKzLx7kyIZ/RZ3UO1QI8=;
        b=roWwwSktPCVljTsiLoEIA6kZ2uuHQKnxVvUuZhVyj8noVmMPVZvpiRkZ3AFz+XZBxx
         h6Urqs5n5+WLPYR81HOD/e2ugNyW4acVCjSTX/mZH0xJYj2CnqgRZdBtiScVhOaeNBAh
         UpudSxCR1c+4uNgZwacf/TPMm/gaxw776iQXvEY9nMte4hPLLGmIbsjvhskTINswKgmL
         rPKSag7u9gcyxQSi0a5dG6r6+QC23iKbx9YTclKe4FxpviXJ4znxiTcdkF31hk0Cca6w
         wEozSrwKTp9utZoDxkCE1N3eDhaQKrNYlAWUHOVcDW/TsToAcXBMrJBQDhqFxpIgj+Vc
         KskA==
X-Gm-Message-State: AO0yUKVi2DAfu/5GvGX0DUZtGDgB0sbCtgtj7blfJ9QLyoHC7lVvM7KN
        fCYwcGeMy5XUcTKiJyL+dg==
X-Google-Smtp-Source: AK7set/KwOyEyWEDcM3nn+7L9qghYTCY+NGAz+QDvS2Y+PVAuwKAhkaFRH+XuAdy/7QN1kftkUbYSg==
X-Received: by 2002:a05:6808:1a22:b0:387:1ac9:17d with SMTP id bk34-20020a0568081a2200b003871ac9017dmr2055119oib.40.1679690078303;
        Fri, 24 Mar 2023 13:34:38 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e17-20020a544f11000000b0038778d9d8efsm1529641oiy.56.2023.03.24.13.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 13:34:38 -0700 (PDT)
Received: (nullmailer pid 2459085 invoked by uid 1000);
        Fri, 24 Mar 2023 20:34:37 -0000
Date:   Fri, 24 Mar 2023 15:34:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bharat Bhushan <bbhushan2@marvell.com>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net,
        krzysztof.kozlowski+dt@linaro.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: marvell octeonTX2 GTI
 watchdog driver
Message-ID: <20230324203437.GA2439497-robh@kernel.org>
References: <20230324145652.19221-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324145652.19221-1-bbhushan2@marvell.com>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 08:26:51PM +0530, Bharat Bhushan wrote:
> Add binding documentation for the Marvell octeonTX2
> GTI watchdog driver.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
>  .../watchdog/marvel-octeontx2-wdt.yaml        | 43 +++++++++++++++++++

The comics?

Use compatible string for filename.

>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/marvel-octeontx2-wdt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/marvel-octeontx2-wdt.yaml b/Documentation/devicetree/bindings/watchdog/marvel-octeontx2-wdt.yaml
> new file mode 100644
> index 000000000000..586b3c1bd780
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/marvel-octeontx2-wdt.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/marvel-octeontx2-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell OcteonTX2 GTI watchdog
> +
> +allOf:
> +  - $ref: "watchdog.yaml#"

Drop quotes

> +
> +maintainers:
> +  - Bharat Bhushan <bbhushan2@marvell.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mrvl,octeontx2-gti-wdt

'mrvl' is deprecated. Use 'marvell'

> +
> +  reg:
> +    maxItems: 2

Need to define what each entry is.

> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 36

Need to define what each entry is. How does the h/w have a variable 
number of interrupts?

> +
> +required:
> + - compatible
> + - reg
> + - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    watch-dog@802000040000 {

watchdog@...

> +      compatible = "mrvl,octeontx2-gti-wdt";
> +      reg = <0x8020 0x40000 0x0 0x20000>;
> +      interrupts = <0 38 1>, /* Core-0 */
> +                   <0 39 1>; /* Core-1 */
> +    };
> +
> +...
> -- 
> 2.17.1
> 
