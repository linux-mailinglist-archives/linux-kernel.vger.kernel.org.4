Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBF76A1BF9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjBXMNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjBXMND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:13:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD69963A2F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 04:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677240745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fzv8kKvKUnDQl9L+lsYADmjdu4rL9VzyOE69oB2LK2Y=;
        b=J07xIeR9i9f6CLRLyrDz+vnS4kABXDcPp3pAo4cUCa+0bPU5pu5eaiNf2XjhOgFCPPzX3X
        Jj4qzOTVKZ26s7EUDninpnu7Oc83Iwh/UhA7RUOSSQwbNRHcf9wAfsy3+TUIjaTywfwoRy
        +hnEUhxDWlqujfXZ1C1l1t1JwFwZ6ks=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-FvU3Mpm2NdSaHJanVekUVg-1; Fri, 24 Feb 2023 07:12:21 -0500
X-MC-Unique: FvU3Mpm2NdSaHJanVekUVg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34A6D3C0CD4B;
        Fri, 24 Feb 2023 12:12:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4D8C1121314;
        Fri, 24 Feb 2023 12:12:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <2009825.1677229488@warthog.procyon.org.uk>
References: <2009825.1677229488@warthog.procyon.org.uk> <CAHk-=whAAOVBrzwb2uMjCmdRrtudGesYj0tuqdUgi8X_gbw1jw@mail.gmail.com> <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Vishal Moola <vishal.moola@gmail.com>,
        Steve French <stfrench@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Paulo Alcantara <pc@cjr.nz>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Xin Hao <xhao@linux.alibaba.com>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] MM updates for 6.3-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2134429.1677240738.1@warthog.procyon.org.uk>
Date:   Fri, 24 Feb 2023 12:12:18 +0000
Message-ID: <2134430.1677240738@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem appears to be here:

			if (folio_mapping(folio) != mapping ||
			    !folio_test_dirty(folio)) {
				folio_unlock(folio);
				goto skip_write;
			}

in my version it's:

			if (folio->mapping != mapping ||
			    !folio_test_dirty(folio)) {
				start += folio_size(folio);
				folio_unlock(folio);
				continue;
			}

In your version, skip_write doesn't advance start if it too many skips occur.
Changing your version to match fixes the problem - or, at least, the
symptoms.  I'm not sure exactly why it's occurring, but the -EBADF (-9) is
coming from cifs_get_writable_file() not finding an open file.  I think this
is a Steve question.

With Vishal's change to use filemap_get_folios_tag() instead of
find_get_pages_range_tag(), the most common file write case (open, write,
write, ..., write, close) in which all the data is added to the pagecache in
one contiguous lump without seeking, hits this a lot.

Unfortunately, unlike find_get_pages_range_tag(), filemap_get_folios_tag()
doesn't allow you to set a limit on the number of pages it will return.

David

