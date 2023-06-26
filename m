Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB8D73D6E8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 06:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjFZEjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 00:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjFZEjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 00:39:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C0CD7
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 21:39:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CED0C60C7B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 04:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082ACC433C8;
        Mon, 26 Jun 2023 04:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687754354;
        bh=Of4ysmu672KpbjZBfuoU0uRNcf9i4Uh3dPRn8YJ9Owc=;
        h=Date:From:To:Cc:Subject:From;
        b=XYevjjKMvRGIB4unL1n2cFePA+8Zjt2hmeFm42ccVi7bjbITuTRWsElC+DaqXhIxT
         FqVlh63eJzP9SGqNMMVJLhRPC3K9Nv+Y8l7pWxIEr4V6edsnvVuMz6ngBFWrE2ZIqe
         j3sprhNbitNQ5QvE63FHBaDeGdaRqWAOjUjcyDcQfLkDYk6+u9LvSj+M6XLXeMgBqN
         Wv9XdmUmGvcTfsSisXWiGgowukEtb/ptHrQG15kkL863gRsHgJHzoqHfjtqqsn1Ew9
         f2I46GDp+iBdtXti8akswksS46vpVBObgBg2eGyaR4tJT4flagETR3Z6S/I2cyk8TG
         gW8Sri3ODz0pA==
Date:   Mon, 26 Jun 2023 12:39:07 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jingbo Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale <dhavale@google.com>,
        Yue Hu <huyue2@coolpad.com>, Yangtao Li <frank.li@vivo.com>,
        Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] erofs updates for 6.5-rc1
Message-ID: <ZJkWa+t/WBCXs9XT@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale <dhavale@google.com>, Yue Hu <huyue2@coolpad.com>,
        Yangtao Li <frank.li@vivo.com>, Chao Yu <chao@kernel.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you consider this pull request for 6.5-rc1?

No outstanding new feature available for this cycle.  Most of these
commits are decompression cleanups which are part of the ongoing
development for subpage/folio compression support as well as xattr
cleanups for the upcoming xattr bloom filter optimization [1].

In addition, there are bugfixes to address some corner cases of
compressed images due to global data de-duplication and arm64 16k
pages.

All commits have been in -next for a while and no potential merge
conflict is observed.

Thanks,
Gao Xiang

[1] https://lore.kernel.org/r/20230621083209.116024-1-jefflexu@linux.alibaba.com

The following changes since commit 7877cb91f1081754a1487c144d85dc0d2e2e7fc4:

  Linux 6.4-rc4 (2023-05-28 07:49:00 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.5-rc1

for you to fetch changes up to 8241fdd3cdfe88e31a3de09a72b5bff661e4534a:

  erofs: clean up zmap.c (2023-06-22 21:16:34 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix rare I/O hang on deduplicated compressed images due to loop
   hooked chains;

 - Fix compact compression layout of 16k blocks on arm64 devices;

 - Fix atomic context detection of async decompression;

 - Decompression/Xattr code cleanups.

----------------------------------------------------------------
Gao Xiang (8):
      erofs: allocate extra bvec pages directly instead of retrying
      erofs: avoid on-stack pagepool directly passed by arguments
      erofs: kill hooked chains to avoid loops on deduplicated compressed images
      erofs: adapt managed inode operations into folios
      erofs: use struct lockref to replace handcrafted approach
      erofs: use poison pointer to replace the hard-coded address
      erofs: fix compact 4B support for 16k block size
      erofs: clean up zmap.c

Jingbo Xu (6):
      erofs: convert erofs_read_metabuf() to erofs_bread() for xattr
      erofs: use absolute position in xattr iterator
      erofs: unify xattr_iter structures
      erofs: make the size of read data stored in buffer_ofs
      erofs: unify inline/shared xattr iterators for listxattr/getxattr
      erofs: use separate xattr parsers for listxattr/getxattr

Sandeep Dhavale (1):
      erofs: Fix detection of atomic context

Yangtao Li (1):
      erofs: remove unnecessary goto

Yue Hu (3):
      erofs: fold in z_erofs_decompress()
      erofs: remove the member readahead from struct z_erofs_decompress_frontend
      erofs: clean up z_erofs_pcluster_readmore()

 fs/erofs/compress.h     |   3 +-
 fs/erofs/decompressor.c |   8 +-
 fs/erofs/internal.h     |  41 +--
 fs/erofs/super.c        |  69 +----
 fs/erofs/utils.c        |  86 +++----
 fs/erofs/xattr.c        | 670 +++++++++++++++++-------------------------------
 fs/erofs/zdata.c        | 269 +++++++++----------
 fs/erofs/zmap.c         |  75 +++---
 8 files changed, 438 insertions(+), 783 deletions(-)
