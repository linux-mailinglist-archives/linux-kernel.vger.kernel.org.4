Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7A96F8674
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 18:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjEEQLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 12:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjEEQLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 12:11:20 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73927160BE;
        Fri,  5 May 2023 09:11:19 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-54caba50d07so1073255eaf.2;
        Fri, 05 May 2023 09:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683303079; x=1685895079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOP1ldLXZHSldN2PvQKUh9ntWyFI1kkSGvcKxpIZQ8s=;
        b=CffjlvRwfFNUPBhOgFz5oxMbP/CASfLOOyj58Yc36V3TPj6wXy+wIfEwJmaVWegJFH
         d01axNggfYYFizGIFBHjGStqYswveUGfXDR/m3Eyg9GIBcq1DOORpJV86WuV+elet/hl
         Ca8Z7C0uMiZpe4H5GfXPvB8DMnqWlOf8x9D/Phd2T78+pKvkPfprL/knk/b8uPWr/h5t
         pRLX8axvV0eHaExJkfo7oqy7pNGYeGR2qEiyAfkryT3ZgcTDl7I+HyDsSMmZxpCP1YYz
         Ws/NDJ/rOdqfD0AtioZK0wRmiLr9PU+oIh8eixgfLfwflJucv0znT9INqX/3uiuxm6o4
         vIYw==
X-Gm-Message-State: AC+VfDxPVMIsRbMwaq9OnQ/5zK6891aG+7Nz1TDXPDf73hQl7Dl8wonB
        Sc2jiWf5FzhCzh9heyYyCA==
X-Google-Smtp-Source: ACHHUZ6KWcM3hUpYy0GevbMU4xd3AZmGQATxHUMkchhHMwp2RDlU99jmQCTEm+nCMk03jw3iZ2T2Jg==
X-Received: by 2002:a05:6808:2992:b0:38e:eaf:cf1f with SMTP id ex18-20020a056808299200b0038e0eafcf1fmr810395oib.44.1683303078619;
        Fri, 05 May 2023 09:11:18 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s203-20020acadbd4000000b00389898f4c4fsm2955719oig.45.2023.05.05.09.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 09:11:17 -0700 (PDT)
Received: (nullmailer pid 3066392 invoked by uid 1000);
        Fri, 05 May 2023 16:11:17 -0000
Date:   Fri, 5 May 2023 11:11:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     srinivas.kandagatla@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] dt-bindings: nvmem: add nvmem-cell-cells property
Message-ID: <20230505161117.GA3062682-robh@kernel.org>
References: <20230505091906.1820081-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505091906.1820081-1-peng.fan@oss.nxp.com>
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

On Fri, May 05, 2023 at 05:19:06PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The driver has been using this property, so add it.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/nvmem/nvmem.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> index 75bb93dda9df..3fc3982da102 100644
> --- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> @@ -67,6 +67,9 @@ patternProperties:
>              description:
>                Size in bit within the address range specified by reg.
>  
> +      "#nvmem-cell-cells":
> +         const: 1

I don't think we can globally set this to 1. You should have a specific 
nvmem layout that uses and defines it.

Rob
