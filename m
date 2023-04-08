Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B6C6DB927
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 08:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjDHGGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 02:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjDHGGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 02:06:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A78DC66A
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 23:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=FSAuJyqLlRwLojcGY0uJ8g8ZAyrKXEp/l8FpS90Rmtg=; b=hU0+Q7xC4qo6vMPcF8mrLKUPxZ
        ilXBjTbB/ObSoD+Qy8a7vC+EWpKNal6d9ELdL8heFFs5Ua8nxmMpelA4BFBjpRxE9smGptudDfFEm
        KlMCPY05zj9+gcFWRbARYwgJ5He2Wm113gok5v/wB3AhILSjVPkPOGRtzdiljB0MSbYVkoGiQDYqh
        odxfMxsSZvGFaEcOvZ/CDpmJWEUOXZkukHG9b/Y7y6wIaG+Hd7RtkaZo+j4k6lKKgfGjtRpahpYnx
        kYpmg2hokhu6pYYfgC32t9XtUqcgfW8PWKEuijXFf6mt46ijGvB8tZWPRept2Bpkty7jbNRoZwZ2G
        y22tOgPg==;
Received: from 213-225-8-166.nat.highway.a1.net ([213.225.8.166] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pl1i3-00Bo2E-2k;
        Sat, 08 Apr 2023 06:06:00 +0000
Date:   Sat, 8 Apr 2023 08:05:56 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping fixes for Linux 6.3
Message-ID: <ZDEERJRl1jrw2kQn@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0eee5ae1025699ea93d44fdb6ef2365505082103:

  swiotlb: fix slot alignment checks (2023-03-22 09:03:17 +0100)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.3-2023-04-08

for you to fetch changes up to bbb73a103fbbed6f63cb738d3783261c4241b4b2:

  swiotlb: fix a braino in the alignment check fix (2023-04-06 16:45:12 +0200)

----------------------------------------------------------------
dma-mapping fix for Linux 6.3

 - fix a braino in the swiotlb alignment check fix (Petr Tesarik)

----------------------------------------------------------------
Petr Tesarik (1):
      swiotlb: fix a braino in the alignment check fix

 kernel/dma/swiotlb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
