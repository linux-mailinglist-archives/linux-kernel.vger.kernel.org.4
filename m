Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEF66C4DCA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjCVOd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjCVOdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:33:23 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 271E9190
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:32:57 -0700 (PDT)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 04EBB242DAB;
        Wed, 22 Mar 2023 15:32:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1679495576;
        bh=s+7L1226YGyniLAi3NdgOJRlQwqK8vojAHQR+OJMYgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nVWbu39TgEVIkf1MTfy1XuN0hh1A1na6gS1U0J6iVKoQUF7uU07Zr1of28uFtY1+d
         WvyfbQYwXPDgb5muU+fC7s5E9YcDmIR1J3Ers8UwCTG8lZowgEByQbLcaKUD6SDY+8
         6NYPgN1f04qsGnFY7D7u9mvj4V9w5fvZAYU47NB9XJDKlax5lRKK1kkFWcW6UzHHTl
         j9WNaRENM3jIi7ZM+V6fmhERmgeReKMuGA8V+oGXQbiIKB75ec1IntqW6Y9d7bRCVB
         JEQj70Gnh6O5eWX7GGzhk37bbL4sAIv0pO+opbRT/rYKFXAFrrS4Ql0lstIveQoRKR
         dERQot6cbraMg==
Date:   Wed, 22 Mar 2023 15:32:54 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, iommu@lists.linux.dev,
        linux-mediatek@lists.infradead.org,
        Yunfei Wang <yf.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jianjiao.zeng@mediatek.com, chengci.xu@mediatek.com
Subject: Re: [PATCH v2] iommu/mediatek: Set dma_mask for PGTABLE_PA_35_EN
Message-ID: <ZBsRlgJIaQieIbzU@8bytes.org>
References: <20230316064251.7346-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316064251.7346-1-yong.wu@mediatek.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 02:42:51PM +0800, Yong Wu wrote:
>  drivers/iommu/mtk_iommu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Applied, thanks.
