Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C026EE37A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbjDYNvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjDYNvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:51:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3F53A9F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682430649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cuedenV2zpDg+mwEKMh+RMpBblTnjA8zgLowf2hXfJ8=;
        b=Vq6FQPvTOKVHT12OgWSIrhztDztwa+WppBnVnFH0ImBFl2Ql0kEDmrlEbK2PSSyTlucyhT
        5fObw8CTl24sO1Re2lGs7vxt7tgFQhG6XwqSpk2Rzwh35ZMrO9xmmCdqXWsDml4lbu9YBW
        sp7hp4m88m0CEcB+bvtLDZZ/o7T8lqg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-570-cq4TivJ5P3eUi3J6A_jXbA-1; Tue, 25 Apr 2023 09:50:46 -0400
X-MC-Unique: cq4TivJ5P3eUi3J6A_jXbA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6FE43C10EC4;
        Tue, 25 Apr 2023 13:50:45 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.226.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E616140C6E67;
        Tue, 25 Apr 2023 13:50:44 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 fixes for 6.4
Date:   Tue, 25 Apr 2023 15:50:44 +0200
Message-Id: <20230425135044.1100895-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling the following gfs2 fixes.

Thanks a lot,
Andreas

The following changes since commit 1e760fa3596e8c7f08412712c168288b79670d78:

  Merge tag 'gfs2-v6.3-rc3-fix' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2 (2023-03-23 15:25:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.3-rc3-fixes

for you to fetch changes up to 644f6bf762fa903f64c59c2ec0f4d0d753527053:

  gfs2: gfs2_ail_empty_gl no log flush on error (2023-04-25 11:07:16 +0200)

----------------------------------------------------------------
gfs2 fixes

- Fix revoke processing at unmount and on read-only remount.

- Refuse reading in inodes with an impossible indirect block height.

- Various minor cleanups.

----------------------------------------------------------------
Andreas Gruenbacher (1):
      gfs2: Fix inode height consistency check

Andrew Price (3):
      gfs2: Remove duplicate i_nlink check from gfs2_link()
      gfs2: Remove ghs[] from gfs2_link
      gfs2: Remove ghs[] from gfs2_unlink

Bob Peterson (6):
      gfs2: Eliminate gfs2_trim_blocks
      gfs2: Use gfs2_holder_initialized for jindex
      gfs2: return errors from gfs2_ail_empty_gl
      gfs2: Perform second log flush in gfs2_make_fs_ro
      gfs2: Issue message when revokes cannot be written
      gfs2: gfs2_ail_empty_gl no log flush on error

Markus Elfring (1):
      gfs2: Move variable assignment behind a null pointer check in inode_go_dump

 fs/gfs2/bmap.c       |  8 --------
 fs/gfs2/bmap.h       |  1 -
 fs/gfs2/glops.c      | 23 +++++++++++++++--------
 fs/gfs2/inode.c      | 47 ++++++++++++++++++++++-------------------------
 fs/gfs2/ops_fstype.c |  9 +++------
 fs/gfs2/super.c      |  9 +++++++++
 6 files changed, 49 insertions(+), 48 deletions(-)

