Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F2767514B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjATJgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjATJgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:36:24 -0500
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D2C940EA;
        Fri, 20 Jan 2023 01:36:23 -0800 (PST)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id A827D262AAF;
        Fri, 20 Jan 2023 10:36:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1674207381;
        bh=E27B5P92vamwc0WgGeMPoDYf0t5y2F4XmTYYeL00rZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=7wgFBMnyfil5Ub6uuA3bZ1Cb6XNhWuaz4uatZCFKatC8jTWgGw68EmRMKxrCn7vBP
         9Es1c2D7sA4pg+Rza5dsGnDW6Y97UgWLWwOF+OBdK1k1CkKu9HhdsCPdRY8a3sHtCg
         Q1t3w7lRYtJ340kn9XB8/nI1q0mz7D/I9AXXhlTNIvNtnlaq6Ot5RycICBRaYRLZ7a
         Uqkyfknre+kYfNgRTd7uDVtIeLGFohhYzAywWzBdHVauvD6s8UMgvWPjPlBOlquBtX
         frT5CwJ1RGsEkMc8LVXhuj+NLmHPwCOwu8MdSOlu04XbbDebn2bRewVqfFV7FnikOa
         hdp1iXe66ESwQ==
Date:   Fri, 20 Jan 2023 10:36:20 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Janne Grunau <j@jannau.net>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, iommu@lists.linux.dev,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] iommu: dart: Apple t8110 DART support
Message-ID: <Y8pglA0vvtZmKKnx@8bytes.org>
References: <20230113105029.26654-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113105029.26654-1-marcan@marcan.st>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 07:50:23PM +0900, Hector Martin wrote:
> Hector Martin (7):
>   dt-bindings: iommu: dart: add t8110 compatible
>   iommu: dart: Add suspend/resume support
>   iommu: dart: Support >64 stream IDs
>   iommu: dart: Support a variable number of TTBRs per stream
>   iommu: dart: Fix DART_PARAMS1/2 bit define names
>   iommu: dart: Support different variants with different registers
>   iommu: dart: Add t8110 DART support
> 
>  .../devicetree/bindings/iommu/apple,dart.yaml |   1 +
>  drivers/iommu/apple-dart.c                    | 557 ++++++++++++++----
>  2 files changed, 448 insertions(+), 110 deletions(-)

Applied, thanks Hector.
