Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8ED6CCED3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 02:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjC2AeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 20:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC2AeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 20:34:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFBB1BC0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 17:34:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EB81B81F66
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 00:34:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A36C433D2;
        Wed, 29 Mar 2023 00:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680050041;
        bh=g089sGSaaERFzueEez0e66+EbLsOH6ztVTsG7Po75Lo=;
        h=Date:From:To:Cc:Subject:From;
        b=X4am4hbMxv4DpSN4wvHdA/XhxYZMlUCQk2lY5uTPQM1GbuEjyHROe2IBAKA/zdQ2m
         QMufrrwYOQQlhZYcsKUqwnWwlLGsRCBH5742xrz+xw4cGvuS8btPgADoFYIHASlmce
         trzt65KHHA7d8s0+1BGP4RpbdhQTMAvDgsspbQ8PmaQhQSHexMFHhoFGj8DLy4T+4T
         JQ97PcWcCC3AsHggtV5A2UQchoq2qzOy7bqlXHzA21cg/CXkb2UN9HkA3Ug9bkJrcr
         hzvDU6ov0DpKWZoufvoFX/r7EaNy8R0we4cBwIb249M01FdSquRy8HLtLh5bH4/3BY
         EFvXN8w8zwCsw==
Date:   Tue, 28 Mar 2023 17:33:59 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: [GIT PULL] f2fs fix for 6.3-rc5
Message-ID: <ZCOHd4jYn8zUCEZ0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you please consider this pull request?

Thanks,

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-fix-6.3-rc5

for you to fetch changes up to 0b04d4c0542e8573a837b1d81b94209e48723b25:

  f2fs: Fix f2fs_truncate_partial_nodes ftrace event (2023-03-10 08:57:49 -0800)

----------------------------------------------------------------
f2fs fix for 6.3-rc5

This fixes a tracepoint field size in f2fs, and another patch [1] to reveal this
bug comes in rc5 as well.

[1] https://patchwork.kernel.org/project/linux-trace-kernel/patch/20230309221302.642e82d9@gandalf.local.home/

----------------------------------------------------------------
Douglas Raillard (1):
      f2fs: Fix f2fs_truncate_partial_nodes ftrace event

 include/trace/events/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
