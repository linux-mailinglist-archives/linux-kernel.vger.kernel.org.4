Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079786D1261
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjC3WoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjC3WoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:44:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179C110AB8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 15:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=lTLIbbxbky13nUCsW3l6ilyAtIxc9wDeo61C7fhVk+A=; b=NPbs4KCrjzxCRI1mU8uJBqxU5t
        wHRIFNCmP2ceMR9KpAs3LuIEn1sQlQuq0hJYKr3oLqsu6Z7XzWQuKIgfpPUMdgBU0B8xcwGUYaErL
        v2+ixOgr1+LcU22js9hZrIxTHvheRObZmMF/ciEog4jAlb5pJw9ai5Wej9+CaneIjy5D57YoWo1ug
        aUBAoeV1tEyJIq7a/m7pyqvC00o+JHMB/vjxv1IpuR9D8PNkEJFY4lM9KdzA+POWFV1lkonUgoHlr
        WKN4ISETU9UY4LOW87dm5yyNY66hcts60X/BifWruf+c8ETAFQqiUt8TBrpHjVS7K/l3+xuF4nwTI
        4xwN4M9A==;
Received: from [182.171.77.115] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pi0zr-005FV0-32;
        Thu, 30 Mar 2023 22:43:56 +0000
Date:   Fri, 31 Mar 2023 07:43:52 +0900
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping fixes for Linux 6.3
Message-ID: <ZCYQqGH+kCQLDLa0@infradead.org>
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

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.3-2023-03-31

for you to fetch changes up to 0eee5ae1025699ea93d44fdb6ef2365505082103:

  swiotlb: fix slot alignment checks (2023-03-22 09:03:17 +0100)

----------------------------------------------------------------
dma-mapping fixes for Linux 6.3

 - fix for swiotlb deadlock due to wrong alignment checks (GuoRui.Yu,
   Petr Tesarik)

----------------------------------------------------------------
GuoRui.Yu (1):
      swiotlb: fix the deadlock in swiotlb_do_find_slots

Petr Tesarik (2):
      swiotlb: use wrap_area_index() instead of open-coding it
      swiotlb: fix slot alignment checks

 kernel/dma/swiotlb.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)
