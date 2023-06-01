Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4C27197A7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbjFAJug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjFAJub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:50:31 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B865A18C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 02:50:29 -0700 (PDT)
Received: from 8bytes.org (p200300c2773e310086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:773e:3100:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 05203224BC8;
        Thu,  1 Jun 2023 11:50:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1685613028;
        bh=xEqsgsE38eCXYXY7O8duufhtCqHfv4vqpHwODdP2KJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cCQzkY1L+2Lg8fvEY/wUofVUMctdZx5EHEXrBfGBEA4CI05S0yxu7W0ahzwFkZ7zO
         xh0k2gFU7WMFEmTzLRxGtxgsMGYsA1h+Ucmy9mqKCXJVafdae+l7RPzAXJ8bAIpK8b
         f4T2cgClLkgbasqy+ExBb8M2MDHHM+Q1ohbkeE/QoNRrz1zqfYTWEX0KzVfJ81Vxu1
         X4NSExFiyVJbOOLorK8mO0/tVcfeB7jfE3TOIexjVWz1FHGvs2XWP8PZwDa3Kn0Z+J
         272fF0BHA15yKEgQhQudew9874ZmZ4dlFFHBjbOgC7B/Rkx1MtU7ae6cfZITl3CQsd
         PGgKli2e29NGQ==
Date:   Thu, 1 Jun 2023 11:50:26 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, iommu@lists.linux.dev,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] iommu/mediatek: Flush IOTLB completely only if
 domain has been attached
Message-ID: <ZHhp4mZZkQbBoGWg@8bytes.org>
References: <20230526085402.394239-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526085402.394239-1-wenst@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 04:53:59PM +0800, Chen-Yu Tsai wrote:
> Fixes: 08500c43d4f7 ("iommu/mediatek: Adjust the structure")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Applied for 6.4, thanks.

