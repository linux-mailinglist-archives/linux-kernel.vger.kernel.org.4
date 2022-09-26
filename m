Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33A25EA98F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiIZPFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235117AbiIZPEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:04:47 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 26 Sep 2022 06:37:18 PDT
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C706AAED84;
        Mon, 26 Sep 2022 06:37:17 -0700 (PDT)
Received: from 8bytes.org (p549ad5ad.dip0.t-ipconnect.de [84.154.213.173])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 31E9E222642;
        Mon, 26 Sep 2022 13:38:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1664192335;
        bh=u0B6XPViiyWAnRZXSeK3V+bLPIyGlSA8ECSz5x8D8I8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZEqsYVedeZ/S22GY2PmZZFTx5QoCi/yyLT0EvXbZ/Y0/R5kCT0OMvho5Z7ZZKuEm+
         695rmfuM1KAIoA2A8lOOzCZADpZEhtQOeT7XGFt6We3XPi6BV+ZEiHlQOHDIgMkUuv
         VCjt5TZenOeF+Gax2SE0JLbG8KYjMXEpvmQlQ5iRFy2VyAE7pr8o8aefkc60UwsvFw
         /Mdls73oTev7ahdys3cyZDqkAtluDq2VEGZ7LMe/TY0NGVx1XwcQTyD5qUgIesrvA1
         gXPycW1mcGN5Mmmq4zzoAd/vPLo4jfFHfiAOQY6ViRn10oi0Wa/lsJz6Pnq/R4D/Ar
         cd0mqIWkN6wRw==
Date:   Mon, 26 Sep 2022 13:38:53 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     yong.wu@mediatek.com, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org
Subject: Re: [PATCH v6 0/3] MediaTek Helio X10 MT6795 - M4U/IOMMU Support
Message-ID: <YzGPTbRhT1d/EIs9@8bytes.org>
References: <20220913151148.412312-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913151148.412312-1-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 05:11:45PM +0200, AngeloGioacchino Del Regno wrote:
> AngeloGioacchino Del Regno (3):
>   dt-bindings: mediatek: Add bindings for MT6795 M4U
>   iommu/mediatek: Introduce new flag TF_PORT_TO_ADDR_MT8173
>   iommu/mediatek: Add support for MT6795 Helio X10 M4Us
> 
>  .../bindings/iommu/mediatek,iommu.yaml        |  4 +
>  drivers/iommu/mtk_iommu.c                     | 21 +++-
>  include/dt-bindings/memory/mt6795-larb-port.h | 95 +++++++++++++++++++
>  3 files changed, 118 insertions(+), 2 deletions(-)
>  create mode 100644 include/dt-bindings/memory/mt6795-larb-port.h

Applied, thanks.
