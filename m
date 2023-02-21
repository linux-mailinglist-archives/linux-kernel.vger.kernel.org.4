Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6F769E28C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbjBUOkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbjBUOkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:40:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3325A26CD1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 06:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676990373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zny8KiMYb1HNZkaNKN8BQ6gfmEmcu946THplslfDzwM=;
        b=Cgoaf/W7I3Fmero396K6e3uAYwWMZe4smipuest0JPp/GC546+7c9d3u86bHa5lYRehpKa
        TLk+d4OsrVOjgc+0ffH94QOAeggODUCdCr/1TKZVxdv2+2BZce3QdZKJI7MpXFo2niMZOK
        HqvZuJhautp7TQc1IhtcB5sU8SfI1Ps=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-6yaa8cDXPqSRA91NVmOFQQ-1; Tue, 21 Feb 2023 09:39:28 -0500
X-MC-Unique: 6yaa8cDXPqSRA91NVmOFQQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7266E1C04195;
        Tue, 21 Feb 2023 14:39:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 755DF40B4138;
        Tue, 21 Feb 2023 14:39:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230221184225.0e734f0e@canb.auug.org.au>
References: <20230221184225.0e734f0e@canb.auug.org.au> <20230221174401.7198357d@canb.auug.org.au> <20230220152933.1ab8fa4a@canb.auug.org.au> <Y/N8hVWeR3AjssUC@casper.infradead.org> <20230220190157.3b43b9a7@canb.auug.org.au> <Y/Pe2xHklSr1hDtz@casper.infradead.org> <2351091.1676963957@warthog.procyon.org.uk>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steve French <smfrench@gmail.com>,
        Steve French <stfrench@microsoft.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>, Paulo Alcantara <pc@cjr.nz>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: linux-next: manual merge of the mm-stable tree with the cifs tree
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2885896.1676990364.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 21 Feb 2023 14:39:24 +0000
Message-ID: <2885897.1676990364@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Andrew has already asked for it to be merged, so its up to Linus.
> =

> You could fetch it yourself and do a trial merge and send me your
> resolution ..
> =

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-202=
3-02-20-13-37

Okay, did that.  See attached.  Also here:

https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/=
?h=3Diov-cifs-mm

David
---
commit 71ad4f67439e60fe04bbf7aed8870e6f83a5d15e
Author: David Howells <dhowells@redhat.com>
Date:   Tue Feb 21 13:23:05 2023 +0000

    cifs: Handle transition to filemap_get_folios_tag()
    =

    filemap_get_folios_tag() is being added and find_get_pages_range_tag()=
 is
    being removed in effectively a single event.  This causes a problem fo=
r
    the:
    =

        cifs: Change the I/O paths to use an iterator rather than a page l=
ist
    =

    patch[1] on the cifs/for-next branch as it's adding a new user of the
    latter (which is going away), but can't yet be converted to using the
    former (which doesn't yet exist upstream).
    =

    Here's a conversion patch that could be applied at merge time to deal =
with
    this.  The new cifs_writepages_region() is based directly on
    afs_writepages_region() and the AFS changes in the mm tree[2]:
    =

        commit acc8d8588cb7e3e64b0d2fa611dad06574cd67b1
        Author: Vishal Moola (Oracle) <vishal.moola@gmail.com>
        afs: convert afs_writepages_region() to use filemap_get_folios_tag=
()
    =

    can be replicated in cifs almost exactly.
    =

    Signed-off-by: David Howells <dhowells@redhat.com>
    cc: Stephen Rothwell <sfr@canb.auug.org.au>
    cc: Steve French <sfrench@samba.org>
    cc: Shyam Prasad N <nspmangalore@gmail.com>
    cc: Rohith Surabattula <rohiths.msft@gmail.com>
    cc: Tom Talpey <tom@talpey.com>
    cc: Paulo Alcantara <pc@cjr.nz>
    cc: Jeff Layton <jlayton@kernel.org>
    cc: linux-cifs@vger.kernel.org
    cc: Vishal Moola (Oracle) <vishal.moola@gmail.com>
    Link: https://lore.kernel.org/r/20230216214745.3985496-15-dhowells@red=
hat.com/ [1]
    Link: https://lore.kernel.org/r/20230104211448.4804-6-vishal.moola@gma=
il.com/ [2]

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 58801d39213a..52af9cf93c65 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2856,78 +2856,85 @@ static int cifs_writepages_region(struct address_s=
pace *mapping,
 				  struct writeback_control *wbc,
 				  loff_t start, loff_t end, loff_t *_next)
 {
+	struct folio_batch fbatch;
 	struct folio *folio;
-	struct page *head_page;
+	unsigned int i;
 	ssize_t ret;
 	int n, skips =3D 0;
 =

+	folio_batch_init(&fbatch);
+
 	do {
 		pgoff_t index =3D start / PAGE_SIZE;
 =

-		n =3D find_get_pages_range_tag(mapping, &index, end / PAGE_SIZE,
-					     PAGECACHE_TAG_DIRTY, 1, &head_page);
+		n =3D filemap_get_folios_tag(mapping, &index, end / PAGE_SIZE,
+					   PAGECACHE_TAG_DIRTY, &fbatch);
 		if (!n)
 			break;
 =

-		folio =3D page_folio(head_page);
-		start =3D folio_pos(folio); /* May regress with THPs */
+		for (i =3D 0; i < n; i++) {
+			folio =3D fbatch.folios[i];
+			start =3D folio_pos(folio); /* May regress with THPs */
 =

-		/* At this point we hold neither the i_pages lock nor the
-		 * page lock: the page may be truncated or invalidated
-		 * (changing page->mapping to NULL), or even swizzled
-		 * back from swapper_space to tmpfs file mapping
-		 */
-		if (wbc->sync_mode !=3D WB_SYNC_NONE) {
-			ret =3D folio_lock_killable(folio);
-			if (ret < 0) {
-				folio_put(folio);
-				return ret;
-			}
-		} else {
-			if (!folio_trylock(folio)) {
-				folio_put(folio);
-				return 0;
+			/* At this point we hold neither the i_pages lock nor the
+			 * page lock: the page may be truncated or invalidated
+			 * (changing page->mapping to NULL), or even swizzled
+			 * back from swapper_space to tmpfs file mapping
+			 */
+			if (wbc->sync_mode !=3D WB_SYNC_NONE) {
+				ret =3D folio_lock_killable(folio);
+				if (ret < 0) {
+					folio_batch_release(&fbatch);
+					return ret;
+				}
+			} else {
+				if (!folio_trylock(folio))
+					continue;
 			}
-		}
 =

-		if (folio_mapping(folio) !=3D mapping ||
-		    !folio_test_dirty(folio)) {
-			start +=3D folio_size(folio);
-			folio_unlock(folio);
-			folio_put(folio);
-			continue;
-		}
+			if (folio->mapping !=3D mapping ||
+			    !folio_test_dirty(folio)) {
+				start +=3D folio_size(folio);
+				folio_unlock(folio);
+				continue;
+			}
 =

-		if (folio_test_writeback(folio) ||
-		    folio_test_fscache(folio)) {
-			folio_unlock(folio);
-			if (wbc->sync_mode !=3D WB_SYNC_NONE) {
-				folio_wait_writeback(folio);
+			if (folio_test_writeback(folio) ||
+			    folio_test_fscache(folio)) {
+				folio_unlock(folio);
+				if (wbc->sync_mode !=3D WB_SYNC_NONE) {
+					folio_wait_writeback(folio);
 #ifdef CONFIG_CIFS_FSCACHE
-				folio_wait_fscache(folio);
+					folio_wait_fscache(folio);
 #endif
-			} else {
-				start +=3D folio_size(folio);
-			}
-			folio_put(folio);
-			if (wbc->sync_mode =3D=3D WB_SYNC_NONE) {
-				if (skips >=3D 5 || need_resched())
-					break;
-				skips++;
+				} else {
+					start +=3D folio_size(folio);
+				}
+				if (wbc->sync_mode =3D=3D WB_SYNC_NONE) {
+					if (skips >=3D 5 || need_resched()) {
+						*_next =3D start;
+						return 0;
+					}
+					skips++;
+				}
+				continue;
 			}
-			continue;
-		}
 =

-		if (!folio_clear_dirty_for_io(folio))
-			/* We hold the page lock - it should've been dirty. */
-			WARN_ON(1);
+			if (!folio_clear_dirty_for_io(folio))
+				/* We hold the page lock - it should've been dirty. */
+				WARN_ON(1);
 =

-		ret =3D cifs_write_back_from_locked_folio(mapping, wbc, folio, start, e=
nd);
-		folio_put(folio);
-		if (ret < 0)
-			return ret;
+			ret =3D cifs_write_back_from_locked_folio(mapping, wbc,
+								folio, start, end);
+			if (ret < 0) {
+				folio_batch_release(&fbatch);
+				return ret;
+			}
+
+			start +=3D ret;
+		}
 =

-		start +=3D ret;
+		folio_batch_release(&fbatch);
 		cond_resched();
 	} while (wbc->nr_to_write > 0);
 =

