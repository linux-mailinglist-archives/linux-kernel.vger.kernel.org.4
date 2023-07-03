Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5870F746627
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 01:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjGCXU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 19:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjGCXU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 19:20:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA15BFB;
        Mon,  3 Jul 2023 16:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=zRSf4m9jljbSBgJd1u1nkIHZSTBl9hKs7qeiFu0rofw=; b=pKnAPCRHqkakphOtwlnXmSbwK0
        FIFTmFZ/22tG6k50dRUYqbnbMCXDEVTQ+4Ix8WTfTCcupJ60usNQqDqDrzr2QR9HtX9ps0/as6ATW
        F/HPkR++fON5Keru84UZCkKWoLZ11bF8yI7Vkw53kE5T1UX5JpLRLCWXMeRWlzccquxrROPaOu7iY
        gAJet4u3XQlJJRpdtrsdMrqF4/8aUIxvwJbh+MLXNTpxenCuwE9YCmNaqGtd8Nz1M22SPyAigiNQI
        7GSZb/XoifCILNWLu4kaLgjNTmE7QpNQb35TsGI0ze1yw8ixfl/fU1z58eLGzAq0S5ve+k8UOdpZP
        /35liZUA==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qGSqH-00Bcwn-1Y;
        Mon, 03 Jul 2023 23:20:25 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3] Documentation: admin-guide: correct "it's" to possessive "its"
Date:   Mon,  3 Jul 2023 16:20:24 -0700
Message-ID: <20230703232024.8069-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct 2 uses of "it's" to the possessive "its" as needed.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: Jonathan Corbet <corbet@lwn.net>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
v2: add Rev-by: Darrick
v3: rebase/resend

 Documentation/admin-guide/mm/numa_memory_policy.rst |    2 +-
 Documentation/admin-guide/xfs.rst                   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -- a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
--- a/Documentation/admin-guide/mm/numa_memory_policy.rst
+++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
@@ -109,7 +109,7 @@ VMA Policy
 	* A task may install a new VMA policy on a sub-range of a
 	  previously mmap()ed region.  When this happens, Linux splits
 	  the existing virtual memory area into 2 or 3 VMAs, each with
-	  it's own policy.
+	  its own policy.
 
 	* By default, VMA policy applies only to pages allocated after
 	  the policy is installed.  Any pages already faulted into the
diff -- a/Documentation/admin-guide/xfs.rst b/Documentation/admin-guide/xfs.rst
--- a/Documentation/admin-guide/xfs.rst
+++ b/Documentation/admin-guide/xfs.rst
@@ -192,7 +192,7 @@ When mounting an XFS filesystem, the fol
 	are any integer multiple of a valid ``sunit`` value.
 
 	Typically the only time these mount options are necessary if
-	after an underlying RAID device has had it's geometry
+	after an underlying RAID device has had its geometry
 	modified, such as adding a new disk to a RAID5 lun and
 	reshaping it.
 
