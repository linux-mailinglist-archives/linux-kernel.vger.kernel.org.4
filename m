Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5180690F55
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 18:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjBIRfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 12:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBIRfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 12:35:37 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744E04216;
        Thu,  9 Feb 2023 09:35:36 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id bd6so2269727oib.6;
        Thu, 09 Feb 2023 09:35:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDg+0168zHr+2g1dStzDLeHsdA5LJsyBUjIXGQnr0Uw=;
        b=gn+5FWReEXgPlJ6dbbq8/0iqe4/yRNcSND+zPnLnfWe98/E9hyWRMX7jGq6svzfL1P
         QUSGG3OJArd6rVrrro+lqBOpVXPnEtYwvwHXjhrJcqyKjyYlon9Rn/hOGdU7CO5q3SHL
         fzeYdCVCURQUNzI0MpW2JtEJxo6Jo0QtJR3O9SLYqEFmVg52JIgPzKPEQ/EbwOjx9nHj
         IAlfbOOYVnQ+Z9IoTh0DFfasP/y1mVw1L6ZOrKXFjuU8kMhHjqoPLLHNH/WqEcfJHWCd
         4498k3f/IpUKByS3wkRy3bAjgEHb+2Fd3i5qMgOwD82aULQLA6bqx6kbZg3U3gUcWtMu
         WS3g==
X-Gm-Message-State: AO0yUKWQeQggX2AM3eairXlGEOsOCVr4JVF8CG7fcwaPB+ZA9V0wK3rF
        N20iiiAzlVoyVLOrgPD+7m+6DFp58g==
X-Google-Smtp-Source: AK7set/+azMMFBXOEiuPtaHsvq8e3IvjnwMin5dScWkMDL2fWCaP2EyrZgGMmOcrSa3aOQo3MObWmw==
X-Received: by 2002:a05:6808:7cf:b0:35b:ae91:db53 with SMTP id f15-20020a05680807cf00b0035bae91db53mr6067889oij.42.1675964135655;
        Thu, 09 Feb 2023 09:35:35 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h7-20020a056808014700b0037d59e90a07sm502835oie.55.2023.02.09.09.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 09:35:35 -0800 (PST)
Received: (nullmailer pid 543618 invoked by uid 1000);
        Thu, 09 Feb 2023 17:35:34 -0000
Date:   Thu, 9 Feb 2023 11:35:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        soc@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: omap: add phytec pcm-049 som
 and pcm-959 dev board
Message-ID: <20230209173534.GA539622-robh@kernel.org>
References: <20230209025525.148872-1-colin.foster@in-advantage.com>
 <20230209025525.148872-2-colin.foster@in-advantage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209025525.148872-2-colin.foster@in-advantage.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 06:55:24PM -0800, Colin Foster wrote:
> Add documentation for additional OMAP SOMs and development platforms,
> provided by Phytec as the PCM-049 SOM and the PCM-959 development kit.
> 
> Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> v2->v3
>     * Add Krzysztof Acked
> 
> v1->v2
>     * New patch
> 
> ---
>  Documentation/devicetree/bindings/arm/omap/omap.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
> index fa8b31660cad..0a28215dfa12 100644
> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> @@ -131,6 +131,9 @@ Boards (incomplete list of examples):
>  - OMAP4 PandaBoard : Low cost community board
>    compatible = "ti,omap4-panda", "ti,omap4430", "ti,omap4"
>  
> +- OMAP4 PCM-959 : Commercial dev kit with PCM-049 SOM
> +  compatible = "phytec,pcm959", "phytec,pcm049", "ti,omap4460", "ti,omap4430", "ti,omap4";

OMAP maintainers, if no one is going to convert all of omap.txt over to 
schema, can we at least start an empty schema and add to it instead of 
here...

Rob
