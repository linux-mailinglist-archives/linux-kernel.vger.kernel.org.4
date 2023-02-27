Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3D46A432C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjB0No7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjB0No5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:44:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA20B1DBA6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=kthNuM3cDdQLN2x9vGwqdcJQpz2gfMsyHNto6T4kbM4=; b=rtWzklvLyr8qwUCTb7KMI7SpxV
        ddURBP2ILPO6pxjipAgVFHPn2wKZY7/rFRjgBNgHYdVMXVPhYSybOdnISDeIgWdQWRiMt5y22WN5P
        hFHkjhnkovKi7CbeoG1g93T757L30zuhR4rNqxS1iRA7UVrESbX9TO+7jTGhdqbG8cw6sbqRhTI3r
        XF389yvY5fh7F8VTO4I84IbXvwo0BApFAoGlrDkEoeXlY4ywqmbGcHT3n/Qp0N6Ha5SuAUEz+0lYM
        PnIV8CSHUnXiOQusMq1scBwfwcvyOihijqgSyM5DRhEDBZxsGcMVYdRGBzeiekUqHC3JtJHADjv76
        K+P0WYtg==;
Received: from [136.36.117.140] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWdoE-009q7u-FO; Mon, 27 Feb 2023 13:44:54 +0000
Date:   Mon, 27 Feb 2023 06:44:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping updates for Linux 6.3
Message-ID: <Y/yz1im8klkg0J84@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 033c40a89f55525139fd5b6342281b09b97d05bf:

  Merge tag 'apparmor-v6.2-rc9' of git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor (2023-02-15 14:53:08 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.3-2022-02-27

for you to fetch changes up to 9b07d27d0fbb7f7441aa986859a0f53ec93a0335:

  swiotlb: mark swiotlb_memblock_alloc() as __init (2023-02-22 06:44:48 -0800)

----------------------------------------------------------------
dma-mapping updates for Linux 6.3

 - remove a not very useful and now unused swiotlb API
   (Christoph Hellwig)
 - fix a section mismatch (Randy Dunlap)

----------------------------------------------------------------
Christoph Hellwig (1):
      swiotlb: remove swiotlb_max_segment

Randy Dunlap (1):
      swiotlb: mark swiotlb_memblock_alloc() as __init

 include/linux/swiotlb.h |  5 -----
 kernel/dma/swiotlb.c    | 11 ++---------
 2 files changed, 2 insertions(+), 14 deletions(-)
