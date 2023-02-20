Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5505469C401
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 02:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjBTBsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 20:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjBTBs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 20:48:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CAFC155
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 17:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676857665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s/pNa6h5YLmgrkyXgxKUZbYLSWfU78j3qdVrSDGDh/8=;
        b=KVIZn6ICQ3HR53ajc3MjrIA42LrobLyHT7FkZABCJ8jTNFx9JsFt/dN6ssX2TThfOBL/ep
        W5Oas1F6Exc7e89ytAm7YCI5cL9lkaFCeafprD/x0eR3QH4eSDm3U6YRZJF9uuBdFQfU3w
        AHhIXpUjmiA+atdAuHrmynjd8nXvE9g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-92rrE8BHMZWRdMdTGwb12Q-1; Sun, 19 Feb 2023 20:47:42 -0500
X-MC-Unique: 92rrE8BHMZWRdMdTGwb12Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A72FF3813F2A;
        Mon, 20 Feb 2023 01:47:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3C50140EBF6;
        Mon, 20 Feb 2023 01:47:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230220120234.161a6002@canb.auug.org.au>
References: <20230220120234.161a6002@canb.auug.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the block tree
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1214276.1676857660.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 20 Feb 2023 01:47:40 +0000
Message-ID: <1214277.1676857660@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> The following commits are also in Linus Torvalds' tree as different
> commits (but the same patches):
> =

>   78e11ab5adf7 ("mm: Pass info, not iter, into filemap_get_pages()")
>   a53cad008099 ("splice: Add a func to do a splice from a buffered file =
without ITER_PIPE")
>   f2aa2c5707ac ("splice: Add a func to do a splice from an O_DIRECT file=
 without ITER_PIPE")
>   51e851b5d16f ("iov_iter: Define flags to qualify page extraction.")
>   0fff5a38a770 ("iov_iter: Add a function to extract a page list from an=
 iterator")

In Linus's tree?  Did you mean the block tree?

David

