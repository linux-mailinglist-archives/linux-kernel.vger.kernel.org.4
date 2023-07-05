Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B6974915F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 01:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjGEXLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 19:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjGEXLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 19:11:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD5F19A0
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 16:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688598626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ke5tgQfioUkSfs2lxW1LmyHZfufsO0C+IRL4oW7y/KI=;
        b=fsKo7vEYh9pCCiOKt0js5JCk2jzRT9ETIuNzixvrrFnH1gmM+rSeiec9VbqcWaPt84+jkz
        qBNCBxQma1Xg+SVO/RX/D0qtfRxIqlz6mCgktAiZhOkEXgVLdvAKuV2o+/tsDAF6PK2LiI
        qOP7nfMnX3fQmlaj3hr8P/1qt9//5Sc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-tgZJihUGPjyXphJ8M6gE0Q-1; Wed, 05 Jul 2023 19:10:23 -0400
X-MC-Unique: tgZJihUGPjyXphJ8M6gE0Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 376998022EF;
        Wed,  5 Jul 2023 23:10:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 59C84492B02;
        Wed,  5 Jul 2023 23:10:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZKXoBM7EQfbKKVjG@gondor.apana.org.au>
References: <ZKXoBM7EQfbKKVjG@gondor.apana.org.au> <0000000000003f2db705ffc133d2@google.com>
To:     syzbot <syzbot+f2c120b449b209d89efa@syzkaller.appspotmail.com>
Cc:     dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [crypto?] WARNING in extract_iter_to_sg
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1869586.1688598621.1@warthog.procyon.org.uk>
Date:   Thu, 06 Jul 2023 00:10:21 +0100
Message-ID: <1869587.1688598621@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz fix: iov_iter: Kill ITER_PIPE

