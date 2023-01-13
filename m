Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC166697D1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbjAMM5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241497AbjAMM4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:56:36 -0500
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B51BBCE3A;
        Fri, 13 Jan 2023 04:44:44 -0800 (PST)
Received: from 8bytes.org (p200300c277327f0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7732:7f00:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id ED600262340;
        Fri, 13 Jan 2023 13:44:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1673613884;
        bh=MscDIF3GsS7zhLNLVm/WiZfXdK2GItkr1gCY7Yuq/gI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rPPebLs22xmYECIA08EQJNTrmdxY/5R/5bZCTMtoBcDNUjONEC2f+5UAg8dAZe75+
         tqE8v/3rLs7mCO3KLHwvNGsPVWQBtuVvqPwY3CkNFofuCjIbjORA2kfOpk1F+SJqHS
         vu74z7MbR0+vA3ZD6tOFAUFqsWrOHy3641EGSVcGnfOUn2ROmYiifTNyvZaaOZVeup
         CHaSNd8Wxg0IAfMYSzJLIyNFFsgFkFpLl3vTxK06O5163O32q9h66/GXsfrk9ouli+
         wblcy2rD81UzrGfIbXJ5pJIvmpHtRjWubRPBGt7+fMH6SD1A1suPCFFH1DEGwtb3oG
         3OjlH5HQuawEA==
Date:   Fri, 13 Jan 2023 13:44:42 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Honghui Zhang <honghui.zhang@mediatek.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>, iommu@lists.linux.dev,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iommu/mediatek-v1: Fix an error handling path in
 mtk_iommu_v1_probe()
Message-ID: <Y8FSOqUqQpTa+zAU@8bytes.org>
References: <593e7b7d97c6e064b29716b091a9d4fd122241fb.1671473163.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <593e7b7d97c6e064b29716b091a9d4fd122241fb.1671473163.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 07:06:22PM +0100, Christophe JAILLET wrote:
> Fixes: b17336c55d89 ("iommu/mediatek: add support for mtk iommu generation one HW")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Another option would be to use devm_clk_get_enabled(). This would save a
> few LoC in mtk_iommu_v1_hw_init() and in the remove function.
> However, it would change the order of function calls in the remove function
> so I leave it as-is.
> Let me know if it is fine and if you prefer this alternative.
> ---
>  drivers/iommu/mtk_iommu_v1.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.
