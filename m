Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35A874C676
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 19:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjGIRCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 13:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGIRCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 13:02:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96ED2DD
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 10:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=MYL8Dzx8oc+g3T8tMzOM72r7kEsw5MHr2MLIzYudHnE=; b=AtwdZ49v2FkuNE7VHd1FBKFuUl
        OZOrKcsFHzMjFhVfZVcjYYcGq5GcDMHSyjlcpEY3Axk6LLrTYtncMwr+2NcXgc7eskb2/B3aupPfV
        wUpbc89g2LamyJRvTLk+Bc8CxRWre6ftDap+IcChXEIsIIp0nY0pG72aHMytjChtL8H2HBMGnGwDu
        1QN9rkK/nHgvgSfXxBpvC+pFn9Rk67EfTdBxh9mj946vw+VEUU26+UOCT4vL+TNNFfsdOQj+M6ewd
        W5DOuf2xvm1BRb+esndsSxsdDlvwmGoxGC1YBpQpmhS4mBynjZX+Jhib8f7NVi0fP1zHJHKimnj8+
        qg+4Mvww==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qIXnZ-009T7k-1p;
        Sun, 09 Jul 2023 17:02:14 +0000
Date:   Sun, 9 Jul 2023 19:02:08 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping fixes for Linux 6.5
Message-ID: <ZKroEFssSwC0Lnn8@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0a2f6372a43ff5e948b8b10be34d4473f6c2ef6c:

  drm/nouveau: stop using is_swiotlb_active (2023-06-07 15:11:26 +0200)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.5-2023-07-09

for you to fetch changes up to 8ac04063354a01a484d2e55d20ed1958aa0d3392:

  swiotlb: reduce the number of areas to match actual memory pool size (2023-06-29 07:10:28 +0200)

----------------------------------------------------------------
dma-mapping fixes for Linux 6.5

 - swiotlb area sizing fixes (Petr Tesarik)

----------------------------------------------------------------
Petr Tesarik (2):
      swiotlb: always set the number of areas before allocating the pool
      swiotlb: reduce the number of areas to match actual memory pool size

 kernel/dma/swiotlb.c | 46 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 11 deletions(-)
