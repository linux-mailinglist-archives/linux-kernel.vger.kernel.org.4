Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A2E69E375
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 16:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbjBUPcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 10:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbjBUPcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 10:32:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E992BF3D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 07:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676993455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qOJ59zDhTh5Tn0O8EMI+d3jwrV9+hCbfQZDyidxifJ8=;
        b=Frke/ZpXHKmVIeZX2TT3YprOnNTuVwD56rTaSwlvEKuH6F7AZmvTuk/xZE8lLzZ4ScFPNB
        +UhHfdlwHxRPACr7F9o2FbqbqK0VohAMtzccVE//eVBYQMoRUyct19GcqRWWQAtEbm3LFj
        h+6KPx8OuMUkwcaHaVuwIN/Z30dXJjk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-85pzX2ROOHS2d6kNx5Nkiw-1; Tue, 21 Feb 2023 10:30:50 -0500
X-MC-Unique: 85pzX2ROOHS2d6kNx5Nkiw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C190738012E9;
        Tue, 21 Feb 2023 15:30:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 17AF940BC781;
        Tue, 21 Feb 2023 15:30:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <2888446.1676992843@warthog.procyon.org.uk>
References: <2888446.1676992843@warthog.procyon.org.uk> <Y/TbYGXC4HKunymf@casper.infradead.org> <20230221184225.0e734f0e@canb.auug.org.au> <20230221174401.7198357d@canb.auug.org.au> <20230220152933.1ab8fa4a@canb.auug.org.au> <Y/N8hVWeR3AjssUC@casper.infradead.org> <20230220190157.3b43b9a7@canb.auug.org.au> <Y/Pe2xHklSr1hDtz@casper.infradead.org> <2351091.1676963957@warthog.procyon.org.uk> <2885897.1676990364@warthog.procyon.org.uk>
cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Cc:     dhowells@redhat.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steve French <smfrench@gmail.com>,
        Steve French <stfrench@microsoft.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>, Paulo Alcantara <pc@cjr.nz>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Obsolete comment on page swizzling (written by Hugh)?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2889871.1676993446.1@warthog.procyon.org.uk>
Date:   Tue, 21 Feb 2023 15:30:46 +0000
Message-ID: <2889872.1676993446@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> > > +			/* At this point we hold neither the i_pages lock nor the
> > > +			 * page lock: the page may be truncated or invalidated
> > > +			 * (changing page->mapping to NULL), or even swizzled
> > > +			 * back from swapper_space to tmpfs file mapping
> > 
> > Where does this comment come from?  This is cifs, not tmpfs.  You'll
> > never be asked to writeback a page from the swap cache.  Dirty pages
> > can be truncated, so the first half of the comment is still accurate.
> > I'd rather it moved down to below the folio lock, and was rephrased
> > so it described why we're checking everything again.
> 
> Actually, it's in v6.2 cifs and I just move it in the patch where I copy the
> afs writepages implementation into cifs.  afs got it in 2007 when I added
> write support[1] and I suspect I copied it from cifs.  cifs got it in 2005
> when Steve added writepages support[2].  I think he must've got it from
> fs/mpage.c and the comment there is prehistoric.

The ultimate source is Hugh Dickins, it would seem:

	commit 820ef9df32856bb54fe5bc995153feb276420e15
	Author: Andrew Morton <akpm@digeo.com>
	Date:   Fri Nov 15 18:52:38 2002 -0800

	[PATCH] handle pages which alter their ->mapping

	Patch from Hugh Dickins <hugh@veritas.com>

	tmpfs failed fsx+swapout tests after many hours, a page found zeroed.
	Not a truncate problem, but mirror image of earlier truncate problems:
	swap goes through mpage_writepages, which must therefore allow for a
	sudden swizzle back to file identity.

	Second time this caught us, so I've audited the tree for other places
	which might be surprised by such swizzling.  The only others I found
	were (perhaps) in the parisc and sparc64 flush_dcache_page called
	from do_generic_mapping_read on a looped tmpfs file which is also
	mmapped; but that's a very marginal case, I wanted to understand it
	better before making any edit, and now realize that hch's sendfile
	in loop eliminates it (now go through do_shmem_file_read instead:
	similar but crucially this locks the page when raising its count,
	which is enough to keep vmscan from interfering).

Maybe we should delete or amend the comment now?

David

