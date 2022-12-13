Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563B164B9DD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 17:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbiLMQfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 11:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbiLMQfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 11:35:09 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DE8115B;
        Tue, 13 Dec 2022 08:35:08 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1445ca00781so13221616fac.1;
        Tue, 13 Dec 2022 08:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJVQxyn8gXiSA1AhPudrUs7ABz5sBN5zDoG4vdYkTS8=;
        b=5ByTtm4girwObHUaNkTIi6XjpuLWWirygVFZAGoa7HUMCGYl/nYrebd3f/iLFCNT06
         4YRb0X848wdUZZGOqMbZM4jajNafuLWJYO6qs4rNBES5QgxzZHqO/v+i9FOJ5q4TJdbV
         sjJ8dRk9uQbq4V3n7UJttZ2HP0Tx/eJ02WIKmJVRLIkwBAN2hO5YnJ93xrPpb35xGGKQ
         vtaB+y8wvzHlMiBOq1EF8hB7SN3Q4heTs/ys4sVfYXvIphBrhZYkJyK7qpt8Q0Ja1WGN
         +DLkhgpy7G/h2XxhALx/QYYbZ4x1N/dYFhRnlwnjja1lvp9YrRcY6Irob2+M9yjSX5ja
         dJ2w==
X-Gm-Message-State: ANoB5pkpSqVTUyV4u1voDIZzK61/zDVDJZIrX8ZSjDlGuOuQLBS2FhFr
        BeS2TdgbOwCi/AijcnyiBQ==
X-Google-Smtp-Source: AA0mqf6gAyXmBROc/uHUvFJFQsXUK5ZsOJyrNY4N5rAb+6eVQ/bZLAv3s7BlqspIZ6lr1OzI3lo9/g==
X-Received: by 2002:a05:6870:4608:b0:13b:e0a:20e6 with SMTP id z8-20020a056870460800b0013b0e0a20e6mr10759985oao.34.1670949307632;
        Tue, 13 Dec 2022 08:35:07 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k16-20020a056870819000b0014866eb34cesm1570367oae.48.2022.12.13.08.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 08:35:07 -0800 (PST)
Received: (nullmailer pid 2014809 invoked by uid 1000);
        Tue, 13 Dec 2022 16:35:06 -0000
Date:   Tue, 13 Dec 2022 10:35:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Georgi Djakov <quic_c_gdjako@quicinc.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: Re: [RFC v2 1/2] dt-bindings: iommu: Document iova-best-fit property
 for IOMMU masters
Message-ID: <20221213163506.GA2011062-robh@kernel.org>
References: <20221212215138.17897-1-quic_c_gdjako@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212215138.17897-1-quic_c_gdjako@quicinc.com>
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

On Mon, Dec 12, 2022 at 01:51:37PM -0800, Georgi Djakov wrote:
> Document the "iova-best-fit" device-tree property, which is used to
> describe that the iommu master is constrained on memory and the system
> must put more effort when allocating IOVAs to avoid holes/gaps in
> memory. This improves the memory utilization and helps with memory
> fragmentation issues in some cases, but it could take longer to allocate
> an IOVA compared with the default "first-fit" algorithm.
> 
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> ---
>  Documentation/devicetree/bindings/iommu/iommu.txt | 4 ++++
>  1 file changed, 4 insertions(+)

No new properties in common .txt files. Schemas only.

However, this looks like kernel policy which doesn't belong in DT.

> diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt b/Documentation/devicetree/bindings/iommu/iommu.txt
> index 26ba9e530f13..ca1b4813c5bf 100644
> --- a/Documentation/devicetree/bindings/iommu/iommu.txt
> +++ b/Documentation/devicetree/bindings/iommu/iommu.txt
> @@ -88,6 +88,10 @@ prevent any driver from properly setting up the translations.
>  
>  Optional properties:
>  --------------------
> +- iova-best-fit: When present, the best-fit algorithm will be used, instead
> +  of first-fit. This reduces memory fragmentation when allocating IOVAs in
> +  some cases, but may also increase the time it takes to allocate an IOVA.
> +
>  - pasid-num-bits: Some masters support multiple address spaces for DMA, by
>    tagging DMA transactions with an address space identifier. By default,
>    this is 0, which means that the device only has one address space.
> 
