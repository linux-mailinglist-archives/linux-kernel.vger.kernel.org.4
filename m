Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2488C712061
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 08:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242300AbjEZGmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 02:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242301AbjEZGmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 02:42:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B35198
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 23:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=411KGqD8IaDnPUkvIUc2KqzrLmyQ9q/ej5S6eECWqFI=; b=PcQqrs88WilvjLOuH6grbpPton
        +ghxrPI9BmRD/kgaGvA93AbBWtjOoyA8TTFDoe2K46n8/HGew9uWtWtWm7S+dGvql8u3zFmrrh5g4
        lRxvlCL9EmMMPpJgh+9jaKxSnQQfl/SRI+ofh9sJdokrwlo6JbC7EiKEqMkbLhTnp0nEkFfTPuXgt
        UnhVCzNDPc4nFSqdPceaTR2Wz1D1KEC5Tf/Rg7aeILPKcQhQGFVTf4BCzeGL+Ruq0BF+w7JEeVG2h
        w6iR26QSWbEdfbaSIneWhk6tzQVeoizeGhzjckaVDlI0ylj5A6xABLnxaHYerPWgnnZqGLJEb5wiQ
        4gmUBI5A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2R9m-001IfJ-0y;
        Fri, 26 May 2023 06:42:34 +0000
Date:   Thu, 25 May 2023 23:42:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@infradead.org, m.szyprowski@samsung.com, iommu@lists.linux.dev,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        logang@deltatee.com
Subject: Re: [PATCH] dma-mapping: Name SG DMA flag helpers consistently
Message-ID: <ZHBU2nDuYtV9mLLJ@infradead.org>
References: <fa2eca2862c7ffc41b50337abffb2dfd2864d3ea.1685036694.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa2eca2862c7ffc41b50337abffb2dfd2864d3ea.1685036694.git.robin.murphy@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
