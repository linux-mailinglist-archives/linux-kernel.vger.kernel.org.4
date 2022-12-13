Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B7B64BA1D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 17:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbiLMQrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 11:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236329AbiLMQqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 11:46:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4698221E3A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 08:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=2fASWcD3MDWnHKMm2m0npaho2EJ4dCmlsjEfJBSNCFo=; b=uKKPjR5vkDUE9jWxBL+DVkrQ9d
        rseeItl2hbeJ/CaHjOse/jUUT+w1bD8MG2b3baWA8Xnd4c+T8MOQE4y7hT+Nr5L4AJBKydRxybkoj
        C3uYO0YpS4UpVFRHLv2yIKhf6d0+02bJcANIruCIILmS8HiDfkc6FRxhuuhNwtKIMKiZhQfXr0ZYC
        ACdPGaVJ4x5EnwgcxdFgttm1dLaCcCqluXLNZMIyAS7NT749PrJHTYkVPTnfyYx6dU90C9nYRvANu
        Ym7VtB0X4xZ9VoNlydmnNi5j9Sl55EMjIgDBuflqhoX7OWt9qCbmCGyPW9VlHC9TMgnzALysh0uaN
        0gtOYSbw==;
Received: from [2001:4bb8:192:2f53:30b:ddad:22aa:f9f9] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p58Pf-0032nk-Pc; Tue, 13 Dec 2022 16:45:52 +0000
Date:   Tue, 13 Dec 2022 17:45:49 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Subject: [GIT PULL] configfs updates for Linux 6.2
Message-ID: <Y5isPdnDCpJ4cL7g@infradead.org>
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

The following changes since commit b7b275e60bcd5f89771e865a8239325f86d9927d:

  Linux 6.1-rc7 (2022-11-27 13:31:48 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/hch/configfs.git tags/configfs-6.2-2022-12-13

for you to fetch changes up to 77992f896745c63ae64bfccfdc429ab7b3d88da5:

  configfs: remove mentions of committable items (2022-12-02 11:11:27 +0100)

----------------------------------------------------------------
configfs updates for Linux 6.2

 - fix a memory leak in configfs_create_dir (Chen Zhongjin)
 - remove mentions of committable items that were implemented
   (Bartosz Golaszewski)

----------------------------------------------------------------
Bartosz Golaszewski (1):
      configfs: remove mentions of committable items

Chen Zhongjin (1):
      configfs: fix possible memory leak in configfs_create_dir()

 Documentation/filesystems/configfs.rst | 48 ----------------------------------
 fs/configfs/dir.c                      |  2 ++
 include/linux/configfs.h               |  3 ---
 3 files changed, 2 insertions(+), 51 deletions(-)
