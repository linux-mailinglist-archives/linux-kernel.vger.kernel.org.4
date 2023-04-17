Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401296E4AED
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjDQOIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjDQOIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:08:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149B81FDE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681740418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x3k70U2wqMYkVPZDRioWTe3Rvp0nYCtXWyD8EZYgUNA=;
        b=NAYPZr7NSoQpIvXJdZvMz59zi+gZoJ+u16ZA8hUWQALCE/LVP2dVsm60shnXKKWgbFfET1
        GQJ9ZWR5qX0Wnx+hXeOYjKsYg61jQcYLJkzZDHvviap5hvYRP1iQr+lqoDfjdNyqQNQyA/
        RPyvbfNbBVUBMLAYrrWmvAhtnFm+DZ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-mlfIU9LYMH6A2Uv9mJgbMw-1; Mon, 17 Apr 2023 10:06:50 -0400
X-MC-Unique: mlfIU9LYMH6A2Uv9mJgbMw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64CCD8828C1;
        Mon, 17 Apr 2023 14:06:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 022D5492B0D;
        Mon, 17 Apr 2023 14:06:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1551344.1681739138@warthog.procyon.org.uk>
References: <1551344.1681739138@warthog.procyon.org.uk> <e8bc6158-86b2-18e5-efea-c165e2a3f196@kernel.dk> <20230413182542.1133335-1-broonie@kernel.org> <0c6b661c-f7ff-cf12-b7f0-00b6b2f1317b@amd.com> <3c4b9025-2667-ca8c-7427-502068b8168e@amd.com>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Ayush Jain <ayush.jain3@amd.com>, broonie@kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Santosh.Shukla@amd.com, Kalpana.Shetty@amd.com,
        Narasimhan V <Narasimhan.V@amd.com>, sfr@canb.auug.org.au
Subject: Re: linux-next: Tree for Apr 13
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1558439.1681740407.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 17 Apr 2023 15:06:47 +0100
Message-ID: <1558440.1681740407@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> The problem might be summed up by the following snippet:
> =

> 	openat(AT_FDCWD, "/dev/loop0", O_RDONLY) =3D 3
> 	newfstatat(3, "", {st_mode=3DS_IFBLK|0660, st_rdev=3Dmakedev(0x7, 0), .=
..}, AT_EMPTY_PATH) =3D 0
> 	splice(3, NULL, 1, NULL, 1048576, 0)    =3D 0

Ah.  In filemap_splice_read():

	do {
		cond_resched();

		if (*ppos >=3D i_size_read(file_inode(in)))
			break;

but i_size_read(file_inode(in)) for a blockdev returns 0, it would seem.  =
What
should I use instead?

David

