Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB52630DAF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 10:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbiKSJMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 04:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKSJL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 04:11:57 -0500
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4E7E1DA6B;
        Sat, 19 Nov 2022 01:11:56 -0800 (PST)
Received: from 8bytes.org (p200300c27724780086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7724:7800:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id C49A62A02E2;
        Sat, 19 Nov 2022 10:11:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1668849116;
        bh=Mnj+XKy1eq+cpp4M1nNQ/BJ5gwNgtt/9NmvCYlk98lM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TkWUk44EuE6Qzf35kclftWpLfCtg5ilCYc4uaPR850QcfeUrf1tp1Xm1Ey8URAcvp
         KPyU/rgiN1ln6vSNBM325IHlDDXjPBHs0iRmodqDjuzaL0p3qOU0jV6SjJOmUGXy32
         aZCZXRxrcB3MT4F88H565tRMhKpsaqIv/5Iu9xz2zYZh4FZtMcZJGNcoekVl8hpuD6
         q+2xw5rkrkBCeqXuPxDrwFq4N3LAGWW/kFPJHKks3Z+8eA6drLrbp/T4p/aQQ/WV6k
         2f07Coc9oEeoftLXAwMzfR04vHUrJaWJYUqa4xmZkeRSNkDOGSIR6xRVYz9lNp8aSb
         7XISudJwIVM+w==
Date:   Sat, 19 Nov 2022 10:11:54 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-mediatek@lists.infradead.org,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6 0/3] iommu/mediatek: Add mt8365 iommu support
Message-ID: <Y3id2iJdLxdr6L5o@8bytes.org>
References: <20221001-iommu-support-v6-0-be4fe8da254b@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221001-iommu-support-v6-0-be4fe8da254b@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 04:18:06PM +0100, Alexandre Mergnat wrote:
> Fabien Parent (3):
>       dt-bindings: iommu: mediatek: add binding documentation for MT8365 SoC
>       iommu/mediatek: add support for 6-bit encoded port IDs
>       iommu/mediatek: add support for MT8365 SoC

Applied, thanks.
