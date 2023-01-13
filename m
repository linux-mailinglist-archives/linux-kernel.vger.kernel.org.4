Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815A3669C9C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjAMPkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjAMPj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:39:59 -0500
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3EEDE81413;
        Fri, 13 Jan 2023 07:31:42 -0800 (PST)
Received: from 8bytes.org (p549ad69d.dip0.t-ipconnect.de [84.154.214.157])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 4E268261BE3;
        Fri, 13 Jan 2023 16:31:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1673623899;
        bh=W0eZQ+91SuOKkGncj7gzewhbmwWHOsQ0mNd5zAk/Afg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kd3MvqU4M0jhYsQnXTuWTVSnh8u/ySUWg+9yJInC5Nf3HOGNvLRTmxR/rphYWg4Sf
         PYoiGuU583mXBOij5+1S2oKSMygZ/8aUhdw84fm70YckG2AD8H2FDMNIZ49oxXjD9D
         w4tILH5cAYM+tRhz4OZOHveIUSmEKYzGPPx/mA+YGZxmqn+Q3/vekAHvP02rIASyhW
         QvklPlTBURl0l8H95wV/d3XxGm/4Ocyp9bnQ2a/7SEwQKabkeMEyEbocQabC+eW3dH
         yy3qLdHjJzKsUgk2R044hZ54dsY0RJRqNqB6RnCH1xm/3ACcxEcHX9VGBeq5qzTIx4
         i5ISakzVcqpvw==
Date:   Fri, 13 Jan 2023 16:31:37 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     "Chengci.Xu" <chengci.xu@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v6 0/4] MT8188 IOMMU SUPPORT
Message-ID: <Y8F5WUCr5bzv9SgS@8bytes.org>
References: <20221223101439.494-1-chengci.xu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223101439.494-1-chengci.xu@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias,

On Fri, Dec 23, 2022 at 06:14:35PM +0800, Chengci.Xu wrote:
> Chengci.Xu (4):
>   dt-bindings: mediatek: mt8188: Add binding for MM & INFRA IOMMU
>   iommu/mediatek: Adjust mtk_iommu_config flow
>   iommu/mediatek: Add enable IOMMU SMC command for INFRA master
>   iommu/mediatek: Add MT8188 IOMMU Support
> 
>  .../bindings/iommu/mediatek,iommu.yaml        |  12 +-
>  drivers/iommu/mtk_iommu.c                     | 113 +++-
>  .../memory/mediatek,mt8188-memory-port.h      | 482 ++++++++++++++++++
>  include/soc/mediatek/smi.h                    |   1 +
>  4 files changed, 584 insertions(+), 24 deletions(-)
>  create mode 100644 include/dt-bindings/memory/mediatek,mt8188-memory-port.h

Please let me know when this can be merged.
