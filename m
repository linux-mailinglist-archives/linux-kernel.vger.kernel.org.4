Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BAC6E47B4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjDQM3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjDQM3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:29:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F9F6A54
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 05:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681734490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mDlfmVq9VmEcdC5lvxXNSUHWf1poZr9mHB1Wi1RcM08=;
        b=fRRMoDKp6TstfQtknte+03Z7PNormBw3gnRnQ6lKsH8dlejjzUnvyDpgASBAocKKSiqp+n
        tfwmrN/HMDjLVmW1bVKVgTxYRHH45yljD3B8UOSoGl6pTk0SrXWKElZmYDUtALkbnqqPeA
        Ntj3o+TU04oACBBq9MDsoblYOVosUw8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-BV0gRXcbP_CV48a3S1UCkA-1; Mon, 17 Apr 2023 08:28:07 -0400
X-MC-Unique: BV0gRXcbP_CV48a3S1UCkA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08373855310;
        Mon, 17 Apr 2023 12:28:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 632FF51FF;
        Mon, 17 Apr 2023 12:28:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <e8bc6158-86b2-18e5-efea-c165e2a3f196@kernel.dk>
References: <e8bc6158-86b2-18e5-efea-c165e2a3f196@kernel.dk> <20230413182542.1133335-1-broonie@kernel.org> <0c6b661c-f7ff-cf12-b7f0-00b6b2f1317b@amd.com> <3c4b9025-2667-ca8c-7427-502068b8168e@amd.com>
To:     Ayush Jain <ayush.jain3@amd.com>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        broonie@kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Santosh.Shukla@amd.com, Kalpana.Shetty@amd.com,
        Narasimhan V <Narasimhan.V@amd.com>, sfr@canb.auug.org.au
Subject: Re: linux-next: Tree for Apr 13
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 17 Apr 2023 13:28:04 +0100
Message-ID: <1488010.1681734484@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> wrote:

> On 4/14/23 1:25=E2=80=AFAM, Ayush Jain wrote:
> ...
> > -If we create a filesystem on the raw disk -- Test completes with a Pass
> >=20
> > -If there is no Filesystem on the raw disk(loop, nvme) -- Test hangs wi=
th the provided trace

fio is running directly on a block device?

Also, does Hugh's patch by any chance fix it?

	https://lore.kernel.org/linux-block/2d5fa5e3-dac5-6973-74e5-eeedf36a42b@go=
ogle.com/

(I'd guess probably not as it fixes shmem).

David

