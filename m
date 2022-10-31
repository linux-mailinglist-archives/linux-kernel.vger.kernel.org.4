Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8897B613B60
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbiJaQdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiJaQdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:33:16 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9313112A9C;
        Mon, 31 Oct 2022 09:33:15 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-13c569e5ff5so13621823fac.6;
        Mon, 31 Oct 2022 09:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/ek65kq7yHOaURSYRqzebh5SC1fg52rynZgdILWhX4=;
        b=pcj5Jh9lvGYnV2OcRkswCR6hCFVQgc7Jf85ZChg3IXVG6TR5LZAxktqLG8/T5du7M+
         o8bHytQXTCE899kHGIVglOcTZosEZX2Y3xlxnB7J7PtM9BAHhqCLPqu4okVSH3Ni5r5c
         pDYHf5QFyf2sKaDhi8dAZhn+KMtwu9LsAQ9qgKYQx/KOfW2SZVYuL2Yq8vY5g3RayKHQ
         4LAFKjOheEgi3O9A+qh+anzhcJRaefETAT5VJJ80dg0drqwvCyaif0zvLBlvt+F/CK7u
         K9lWqHFXb+JYCkPOYdAuYiChBEe0cFgzgLZC/fHirnUxNCVSEFZ8RvC+cVnW+aGRWt72
         HNhA==
X-Gm-Message-State: ACrzQf01rY5N1wCeo03qcYBBuYE+tWy0eKt2hcPlWIym5FRc461im/JQ
        ECJPYw2bhlaIT3spKrTKJw==
X-Google-Smtp-Source: AMsMyM5n6ycmXWieT0+iQQXHvxoao0+Kzj4kL9UzGXba08k2+w2fKVvTiKB9k2bkjWX01BQO6gLn3A==
X-Received: by 2002:a05:6870:15d4:b0:12b:8d8d:1001 with SMTP id k20-20020a05687015d400b0012b8d8d1001mr8166471oad.137.1667233994806;
        Mon, 31 Oct 2022 09:33:14 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f2-20020a4ad802000000b0047f72b6988fsm2503291oov.45.2022.10.31.09.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 09:33:14 -0700 (PDT)
Received: (nullmailer pid 2978384 invoked by uid 1000);
        Mon, 31 Oct 2022 16:33:16 -0000
Date:   Mon, 31 Oct 2022 11:33:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, mperttunen@nvidia.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1 1/2] dt-bindings: PCI: tegra234: Add ECAM support
Message-ID: <20221031163316.GA2968837-robh@kernel.org>
References: <20221027051214.22003-1-vidyas@nvidia.com>
 <20221027051214.22003-2-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027051214.22003-2-vidyas@nvidia.com>
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

On Thu, Oct 27, 2022 at 10:42:13AM +0530, Vidya Sagar wrote:
> Add support for ECAM aperture for Tegra234.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  .../devicetree/bindings/pci/nvidia,tegra194-pcie.yaml  | 10 ++++++++--
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml          |  2 +-
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
> index 75da3e8eecb9..15cc2d2055bb 100644
> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
> @@ -27,6 +27,7 @@ properties:
>        - nvidia,tegra234-pcie
>  
>    reg:
> +    minItems: 4
>      items:
>        - description: controller's application logic registers
>        - description: configuration registers
> @@ -35,13 +36,17 @@ properties:
>            available for software access.
>        - description: aperture where the Root Port's own configuration
>            registers are available.
> +      - description: aperture to access the configuration space through ECAM.
> +          This is applicable only for Tegra234.

Is it really only Tegra234 or that's all you've tested or care 
about? For the former, I agree with Krzysztof.

Rob
