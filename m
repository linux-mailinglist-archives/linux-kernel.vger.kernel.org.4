Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A3C69E345
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 16:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbjBUPVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 10:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234212AbjBUPVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 10:21:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2F72278E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 07:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676992866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D3x81ZF9i7R2YJc8qS/vE7vBCOzR2GkkphkXuVX57T4=;
        b=dzgyxGGKo1I20IsEkVT7k1ehji9aCNGuDnzMY9q8O8ntp5fkmLG4x8XQxxlx8MPM0oJCWH
        RbQk5S2ReHvDMm9JtxvlORjZkQQgudjrrMl9fohcRAVyLZxHxtapcS3RiueUN74S1cVMVi
        cpxdt3rYTfaVA3eNoQVK0n3DzQPSzFA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-N8Vgh8ntMci89j6VoTDdMw-1; Tue, 21 Feb 2023 10:21:02 -0500
X-MC-Unique: N8Vgh8ntMci89j6VoTDdMw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 897BE3813F22;
        Tue, 21 Feb 2023 15:20:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1077140EBF4;
        Tue, 21 Feb 2023 15:20:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y/TbYGXC4HKunymf@casper.infradead.org>
References: <Y/TbYGXC4HKunymf@casper.infradead.org> <20230221184225.0e734f0e@canb.auug.org.au> <20230221174401.7198357d@canb.auug.org.au> <20230220152933.1ab8fa4a@canb.auug.org.au> <Y/N8hVWeR3AjssUC@casper.infradead.org> <20230220190157.3b43b9a7@canb.auug.org.au> <Y/Pe2xHklSr1hDtz@casper.infradead.org> <2351091.1676963957@warthog.procyon.org.uk> <2885897.1676990364@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
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
Subject: Re: linux-next: manual merge of the mm-stable tree with the cifs tree
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2888445.1676992843.1@warthog.procyon.org.uk>
Date:   Tue, 21 Feb 2023 15:20:43 +0000
Message-ID: <2888446.1676992843@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> > +			/* At this point we hold neither the i_pages lock nor the
> > +			 * page lock: the page may be truncated or invalidated
> > +			 * (changing page->mapping to NULL), or even swizzled
> > +			 * back from swapper_space to tmpfs file mapping
> 
> Where does this comment come from?  This is cifs, not tmpfs.  You'll
> never be asked to writeback a page from the swap cache.  Dirty pages
> can be truncated, so the first half of the comment is still accurate.
> I'd rather it moved down to below the folio lock, and was rephrased
> so it described why we're checking everything again.

Actually, it's in v6.2 cifs and I just move it in the patch where I copy the
afs writepages implementation into cifs.  afs got it in 2007 when I added
write support[1] and I suspect I copied it from cifs.  cifs got it in 2005
when Steve added writepages support[2].  I think he must've got it from
fs/mpage.c and the comment there is prehistoric.

David

31143d5d515ece617ffccb7df5ff75e4d1dfa120 [1]
37c0eb4677f733a773df6287b0f73f00274402e3 [2]

