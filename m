Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C88664B9CB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 17:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbiLMQcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 11:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbiLMQcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 11:32:11 -0500
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1B1E0CC;
        Tue, 13 Dec 2022 08:32:11 -0800 (PST)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1443a16b71cso13160187fac.13;
        Tue, 13 Dec 2022 08:32:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDwF6SAQDM6fjUwYm0h9OujqGNr6BVsL3CNkq7crNpQ=;
        b=PYn+JHcYO67U6bbHyPCR90MJSlBXCe+WdKESZq2JWnyv09kocBBhXizNh5SwHAxWW1
         V/+l3cTztQ1F/hEhgLnEDFL40qRmcT4il44jc9QD1Qz4zHPHUuYaeAt0/PrAbm5cZmoB
         seum2OXsWQmA6dR/pFMje2X3jfJCxw2w5OCkwkWHuy3AI62VNwWf4SdSXdLEnFof7fbw
         qbVxVEUj2gLgG/HL8y1vSZz9KGiq/ybWPV3b/vvqPoDtzpBgxwLDOdfRtxisgMeNJ4W/
         HZ6odr4D4aj5WlEYj7iA55UmTd79YGsX5vYIalVdseWVCt2aM5HyK5XbZaWrjx36MpzV
         LX6w==
X-Gm-Message-State: ANoB5pnRYxnyiNMN73OFeZ1OhIQldeicnZlCfBIJn4L1WsQp8H/5vGiI
        ObcSS66T5HvQXNNFswgPWvHMyvdn3A==
X-Google-Smtp-Source: AA0mqf5XQGRkKkepgjknMVf6SyMWLo7pqvvDq3ZLDIZ41+F9JgfxY50LFm+xmkKYlSiHWgs3OcDezw==
X-Received: by 2002:a05:6870:4c8b:b0:14b:7e4f:f0ca with SMTP id pi11-20020a0568704c8b00b0014b7e4ff0camr545587oab.31.1670949130248;
        Tue, 13 Dec 2022 08:32:10 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f43-20020a056871072b00b00144bb1013e6sm1596271oap.4.2022.12.13.08.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 08:32:09 -0800 (PST)
Received: (nullmailer pid 2010757 invoked by uid 1000);
        Tue, 13 Dec 2022 16:32:09 -0000
Date:   Tue, 13 Dec 2022 10:32:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/15] spi: dt-bindings: snps,dw-ahb-ssi: Add generic
 dw-ahb-ssi version
Message-ID: <20221213163209.GA1684072-robh@kernel.org>
References: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
 <20221212180732.79167-15-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212180732.79167-15-sudip.mukherjee@sifive.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 06:07:31PM +0000, Sudip Mukherjee wrote:
> Add new snps,dw-ahb-ssi version to the bindings.

Yes, I can see that in the diff. Tell me something useful here. Why 
do we need a new compatible? What does this compatible imply in the 
h/w that the existing ones don't. How do I know which compatible to 
use?

Really, this should probably only be a fallback with an SoC specific 
compatible. Future quirk properties which are not board specific only 
will be rejected. You've been warned.

> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
> ---
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index d33b72fabc5d8..af36df67a4c0e 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -45,6 +45,7 @@ properties:
>          enum:
>            - snps,dw-apb-ssi
>            - snps,dwc-ssi-1.01a
> +          - snps,dw-ahb-ssi
>        - description: Microsemi Ocelot/Jaguar2 SoC SPI Controller
>          items:
>            - enum:
> -- 
> 2.30.2
> 
> 
