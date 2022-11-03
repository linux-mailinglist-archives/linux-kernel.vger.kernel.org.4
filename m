Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3045461804D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiKCO7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKCO72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:59:28 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9B065F70
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 07:59:27 -0700 (PDT)
Received: from 8bytes.org (p5b00664c.dip0.t-ipconnect.de [91.0.102.76])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id D14EA260033;
        Thu,  3 Nov 2022 15:59:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1667487567;
        bh=HTUsTy233yIiWp1C/zye7Xevk8uy5uBNvs5YyKtRlG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vgU5PXg7bRQqqMVptuQYq7DSJ2v4CNm2bjBLUi2vPE1EtDSFc5eSR5BsvYGnr233D
         T1ajeSHHA/rZGPXI0lEh0RiQ3uyNETgw7obyVgskGbrk2lPkU4XIp7xx/TkPyD9PLt
         c2AeARe2Cj8iJNdaXae4dTfOXEc16b6ND03m7xEdWWQ60EGaF1NHEihnu1nFLJ+lVG
         Uxqp9laxJUJ5YIApjFc1l55WhdkqaHqfUUqwQN8L1jSplQWmBbrW7U5jxD6Wulkfh6
         7dSEBqrq+szAgQDbURXddZIh2t7i7MpVcYOIMpg0Wr6yGV1S/SMCOuaRDVG4xy5tW7
         EnQBWG71lZTKQ==
Date:   Thu, 3 Nov 2022 15:59:25 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Simon Xue <xxm@rock-chips.com>
Subject: Re: [PATCH] iommu/rockchip: fix permission bits in page table
 entries v2
Message-ID: <Y2PXTfk4Et7r5/QD@8bytes.org>
References: <20221102063553.2464161-1-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102063553.2464161-1-michael.riesch@wolfvision.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 07:35:53AM +0100, Michael Riesch wrote:
>  drivers/iommu/rockchip-iommu.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Applied, thanks.
