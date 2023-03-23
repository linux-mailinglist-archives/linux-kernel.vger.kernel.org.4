Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABF16C5AEC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 01:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjCWAFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 20:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCWAFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 20:05:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D198A73
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 17:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679529867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OSGV8RL3evgcHIQsh1cwedUHXKi7F4oO7ZKCwnrrLpo=;
        b=cVjhpEOtGBK790HV3ALGwROyjUZoEmLuWneUVUZg7IK5KJOmk75ZxKJDJ7CdtEmnr9qLSM
        o+93YkMKdAPNGJAYRtAYPf7SbNMfNP/AXuYUqa+IrnQNdro+eaxIzMMEdTUDb/KMpDqF7X
        kCTJR+FnHqhDqMv9zTX6lGNQgcfy2l8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-PcQhHoZdP26H2tuNI_MmeQ-1; Wed, 22 Mar 2023 20:04:23 -0400
X-MC-Unique: PcQhHoZdP26H2tuNI_MmeQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64BA71C05AB8;
        Thu, 23 Mar 2023 00:04:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 92CACC15BA0;
        Thu, 23 Mar 2023 00:04:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230322162638.d940201434ac3a3a29968979@linux-foundation.org>
References: <20230322162638.d940201434ac3a3a29968979@linux-foundation.org> <20230323100204.0917cecf@canb.auug.org.au> <3431084.1679526799@warthog.procyon.org.uk> <82ade7f2-017e-af6b-2fb3-eb1a3f570505@kernel.dk>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: Re: linux-next: manual merge of the block tree with the mm tree
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3434804.1679529862.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 23 Mar 2023 00:04:22 +0000
Message-ID: <3434805.1679529862@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> wrote:

> Or I can just steal "iov_iter: Kill ITER_PIPE"...

You'd need to steal the eight patches before it too.

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/=
?h=3Dfor-6.4/splice

	iov_iter: Kill ITER_PIPE
	cifs: Use generic_file_splice_read()	=

	splice: Do splice read from a file without using ITER_PIPE
	tty, proc, kernfs, random: Use direct_splice_read()	=

	coda: Implement splice-read	=

	overlayfs: Implement splice-read
	shmem: Implement splice-read	=

	splice: Make do_splice_to() generic and export it
	splice: Clean up direct_splice_read() a bit

David

