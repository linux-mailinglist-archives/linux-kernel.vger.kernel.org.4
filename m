Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D46F6C7074
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 19:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjCWSqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 14:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjCWSq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 14:46:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1602F25B81
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 11:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679597141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zkEo5KV5pWtY0chRAyhZO0yxLe6DPrfJex1y5U7s5pA=;
        b=gp8wERYbHSK7cbgvTZsY1A5P//gPD0g5HStsbHk0EQPedxULb5FBrEKFNaklsFfGzimfcw
        ThUhIuD/n7fdebcesJFUR79Z2b29GA2Me72xBFh7i/XA6HVkCJM8/5qPGoHyBuBs64q4HQ
        TWumidyTuCqzI/BTFmyUv8uCKce/B2g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-108-SsonzWg2PRm_e_dynO_K-Q-1; Thu, 23 Mar 2023 14:45:39 -0400
X-MC-Unique: SsonzWg2PRm_e_dynO_K-Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3DF05855300;
        Thu, 23 Mar 2023 18:45:39 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 50520400D796;
        Thu, 23 Mar 2023 18:45:38 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 fix for v6.3-rc4
Date:   Thu, 23 Mar 2023 19:45:37 +0100
Message-Id: <20230323184537.749868-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

Hi Linus,

please consider pulling the following fix.

Thanks,
Andreas

The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git gfs2-v6.3-rc3-fix

for you to fetch changes up to 260595b439776c473cc248f0de63fe78d964d849:

  Reinstate "GFS2: free disk inode which is deleted by remote node -V2" (2023-03-23 19:37:56 +0100)

----------------------------------------------------------------
gfs2 fix

- Reinstate commit 970343cd4904 ("GFS2: free disk inode which is deleted
  by remote node -V2") as reverting that commit could cause
  gfs2_put_super() to hang.

----------------------------------------------------------------
Bob Peterson (1):
      Reinstate "GFS2: free disk inode which is deleted by remote node -V2"

 fs/gfs2/dentry.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

