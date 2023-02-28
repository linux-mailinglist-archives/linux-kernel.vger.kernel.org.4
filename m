Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230516A5C45
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjB1Pq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjB1Pq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:46:58 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FFF30EB0;
        Tue, 28 Feb 2023 07:46:50 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id q11-20020a056830440b00b00693c1a62101so5851475otv.0;
        Tue, 28 Feb 2023 07:46:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOZcGd1oA7KTIN6ScdKo19pTRirA0V0P219jqFHgpsk=;
        b=UsGz8d/o6I4jnQkDwS3F+rr9ysD617uxaNV8Q82gStZHVdpIBIMGCWIIdqCnD/V73y
         AT5GyRJUz3+h4pyux0OKyQlKckEOoD5n6j7ZHsNnSUOnzPpwTw8YXadmei0zRuy+yroB
         wnKKJCmd1hC9hgKS0rpDWuMxZViwgD0qW5lrDGIJGb8RsSLSOTTQoNGzl3gECrWYrriu
         XvBK3vE4XQOpQRty3NcHAInQ4Idx5T8j4l44IaX/oEMArTcYkSBOVcH5Jk2EBqz9mcgs
         VXXHGQc4Nphd+62Q0fqxW51QT04pWJLLPdIabp4NBWHmMLji8sntmaPOycBvTJ1AZIAx
         vZGQ==
X-Gm-Message-State: AO0yUKX7bmaI378jAmgVLCTz3tQiPwyw20Pdz3KMmJ3SwgMkRB1BUYL/
        gXhN/5Wwmj2rYSpIcdEMlw==
X-Google-Smtp-Source: AK7set8dyFOGw+fLFS6HC9s6W78LURHcGo2G/CSRLtLs+3UqekNY0HS2op+TXSAy7UOmZh22mW0zJA==
X-Received: by 2002:a9d:178c:0:b0:68f:339f:832d with SMTP id j12-20020a9d178c000000b0068f339f832dmr1495446otj.35.1677599210014;
        Tue, 28 Feb 2023 07:46:50 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m55-20020a05683026f700b00693d8a315eesm3827597otu.31.2023.02.28.07.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 07:46:49 -0800 (PST)
Received: (nullmailer pid 3307966 invoked by uid 1000);
        Tue, 28 Feb 2023 15:46:48 -0000
Date:   Tue, 28 Feb 2023 09:46:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Piyush Malgujar <pmalgujar@marvell.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, ulf.hansson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, yamada.masahiro@socionext.com,
        devicetree@vger.kernel.org, jannadurai@marvell.com,
        cchavva@marvell.com
Subject: Re: [PATCH v3 5/6] dt-bindings: mmc: sdhci-cadence: SD6 support
Message-ID: <20230228154648.GA3298015-robh@kernel.org>
References: <20230227183151.27912-1-pmalgujar@marvell.com>
 <20230227183151.27912-6-pmalgujar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227183151.27912-6-pmalgujar@marvell.com>
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

On Mon, Feb 27, 2023 at 10:31:50AM -0800, Piyush Malgujar wrote:
> From: Jayanthi Annadurai <jannadurai@marvell.com>
> 
> Add support for SD6 controller support.

On what h/w?

> 
> Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
> Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
> ---
>  .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 24 +++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index 8b1a0fdcb5e3e2e8b87d8d7678e37f3dad447fc1..0dba17c4f17f82c8ae68e46225ed72418e8361ff 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/mmc/cdns,sdhci.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Cadence SD/SDIO/eMMC Host Controller (SD4HC)
> +title: Cadence SD/SDIO/eMMC Host Controller (SD4HC, SD6HC)
>  
>  maintainers:
>    - Masahiro Yamada <yamada.masahiro@socionext.com>
> @@ -18,7 +18,9 @@ properties:
>        - enum:
>            - microchip,mpfs-sd4hc
>            - socionext,uniphier-sd4hc
> -      - const: cdns,sd4hc
> +      - enum:
> +          - cdns,sd4hc
> +          - cdns,sd6hc

Other than FPGA implementations IP vendor compatible strings are pretty 
much useless. Define a compatible for your h/w.

>  
>    reg:
>      maxItems: 1
> @@ -111,6 +113,24 @@ properties:
>      minimum: 0
>      maximum: 0x7f
>  
> +  cdns,iocell-input-delay-ps:
> +    description: Delay in ps across the input IO cells
> +
> +  cdns,iocell-output-delay-ps:
> +    description: Delay in ps across the output IO cells
> +
> +  cdns,delay-element-ps:
> +    description: Delay element in ps used for calculating phy timings
> +
> +  cdns,read-dqs-cmd-delay-ps:
> +    description: Command delay used in HS200 tuning
> +
> +  cdns,tune-val-start-ps:
> +    description: Staring value of data delay used in HS200 tuning
> +
> +  cdns,tune-val-step-ps:
> +    description: Incremental value of data delay used in HS200 tuning

Wouldn't any controller implementation need these possibly? IIRC, we 
have some common properties for this. If not, survey what we do have and 
come up with something common. Or you can imply all this from the h/w 
specific compatible you are going to add.

Rob
