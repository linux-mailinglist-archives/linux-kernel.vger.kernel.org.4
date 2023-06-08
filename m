Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4550D728215
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbjFHODF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbjFHODD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:03:03 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E87198C;
        Thu,  8 Jun 2023 07:03:01 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-33d5df1a862so2012875ab.0;
        Thu, 08 Jun 2023 07:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686232980; x=1688824980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrR2lggXfgMeE3/kO5jG+9MtO/Rr7jUHSG2ALLBrFF8=;
        b=CAt/m5wR8OfzvDJUXeO19bB7pMphp7x1Zjzi/pfBYYU7+lHSEHFl1NoXEV5eO4nKl0
         JDdP+aHPn1UU4US1+UAGcFGHG5HO9NLX85U8t9omdRuTNR8vidFJ1d6aFEIb2KoUOKhR
         R84ymThtGJ7/RC1hYzCHUvmw6lZ4+LKiJNcnC0n5qMmLOVi9EwKom3HHZpNNz6JVRBsB
         kSpRsS0j3aH3C1dkCWxhlU8t8apHAKUDlqoHAKTyjjzWPA7Eeyr0zUrD9hno9ej3OYwm
         2d3wmgGoE5TndwNwTK+gUlpP06bG3BL6PRBc+09zRaMBSoA1kOvFu4CyozEb6sMGaO8h
         EWDw==
X-Gm-Message-State: AC+VfDxXhrDrpRG3mLj6ftKUGBj2EGMRTZ4dJHryJqdEH3d5ZAa201Gw
        MoIL0yp5Gnim9NLM125JhU37dnWzmg==
X-Google-Smtp-Source: ACHHUZ5Ogm2JbVDqQTBk7S2jK9f5U9ZvjR7/zzBLBYW1CWlCGRwKf8REBVpl31BrQnK//Nisphzp7Q==
X-Received: by 2002:a92:c752:0:b0:33c:b395:a89d with SMTP id y18-20020a92c752000000b0033cb395a89dmr9317596ilp.14.1686232980545;
        Thu, 08 Jun 2023 07:03:00 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id x24-20020a02ac98000000b00420c5d10c38sm295571jan.74.2023.06.08.07.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 07:02:58 -0700 (PDT)
Received: (nullmailer pid 2499157 invoked by uid 1000);
        Thu, 08 Jun 2023 14:02:56 -0000
Date:   Thu, 8 Jun 2023 08:02:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, devicetree-spec@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: reserved-memory: Add
 alloc-{bottom-up,top-down}
Message-ID: <20230608140256.GA2478894-robh@kernel.org>
References: <20230510-dt-resv-bottom-up-v1-0-3bf68873dbed@gerhold.net>
 <20230510-dt-resv-bottom-up-v1-1-3bf68873dbed@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510-dt-resv-bottom-up-v1-1-3bf68873dbed@gerhold.net>
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

On Mon, May 15, 2023 at 12:12:16PM +0200, Stephan Gerhold wrote:
> Right now the allocation behavior for dynamic reserved memory is
> implementation-defined. On Linux it is dependent on the architecture.
> This is usually fine if the address is completely arbitrary.
> 
> However, when using "alloc-ranges" it is helpful to allow controlling
> this. That way you can make sure that the reservations are placed next
> to other (static) allocations to keep the free memory contiguous if
> possible.

That should already be possible with all the information you 
already have. IOW, you are looking at all the region and "alloc-ranges" 
addresses to decide top-down or bottom-up. Why can't the kernel do that.

Alternatively, if you really care about the allocation locations, don't 
use dynamic regions.

> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  .../bindings/reserved-memory/reserved-memory.yaml  | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
> index c680e397cfd2..56f4bc6137e7 100644
> --- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
> +++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
> @@ -52,6 +52,18 @@ properties:
>        Address and Length pairs. Specifies regions of memory that are
>        acceptable to allocate from.
>  
> +  alloc-bottom-up:
> +    type: boolean
> +    description: >
> +      Specifies that the memory region should be preferably allocated
> +      at the lowest available address within the "alloc-ranges" region.
> +
> +  alloc-top-down:
> +    type: boolean
> +    description: >
> +      Specifies that the memory region should be preferably allocated
> +      at the highest available address within the "alloc-ranges" region.

What happens when both are set?

> +
>    iommu-addresses:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      description: >
> @@ -93,6 +105,10 @@ properties:
>        system can use that region to store volatile or cached data that
>        can be otherwise regenerated or migrated elsewhere.
>  
> +dependencies:
> +  alloc-bottom-up: [alloc-ranges]
> +  alloc-top-down: [alloc-ranges]
> +
>  allOf:
>    - if:
>        required:
> @@ -178,4 +194,27 @@ examples:
>          };
>        };
>      };
> +
> +  - |
> +    / {
> +      compatible = "foo";
> +      model = "foo";
> +
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      reserved-memory {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        ranges;
> +
> +        adsp_mem: adsp {
> +          size = <0x0 0x600000>;
> +          alignment = <0x0 0x100000>;
> +          alloc-ranges = <0x0 0x86800000 0x0 0x10000000>;
> +          alloc-bottom-up;
> +          no-map;
> +        };
> +      };
> +    };
>  ...
> 
> -- 
> 2.40.1
> 
