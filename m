Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCBF69CF6B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 15:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjBTOak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 09:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjBTOai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 09:30:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD7411EA2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 06:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676903390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x5p6lK28Ra573v7+UHzSn0UqRqk59msus4yoHKjo37Y=;
        b=Jt0UNBnHGCzm+L0RHqWxYpFD41YEs3W9hip31AxTf8nLgxEAAptoWRZtIx+ApYWrphCDti
        4Uu6wBVJsv0cmWFjFZKzO2x5Y3dL0w3jGmTPVHlOqB7K3PUJAgOBph3xJVEAYtcCyW21JU
        PsK0sG0XYcYDf5axjqNlszHrYAWPlMs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-BUWw3wZaOMeCm6RwB8xb4Q-1; Mon, 20 Feb 2023 09:29:44 -0500
X-MC-Unique: BUWw3wZaOMeCm6RwB8xb4Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF90329AB44F;
        Mon, 20 Feb 2023 14:29:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 702734097544;
        Mon, 20 Feb 2023 14:29:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y/N8hVWeR3AjssUC@casper.infradead.org>
References: <Y/N8hVWeR3AjssUC@casper.infradead.org> <20230220152933.1ab8fa4a@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Steve French <stfrench@microsoft.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: Re: linux-next: manual merge of the mm-stable tree with the cifs tree
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1676389.1676903381.1@warthog.procyon.org.uk>
Date:   Mon, 20 Feb 2023 14:29:41 +0000
Message-ID: <1676391.1676903381@warthog.procyon.org.uk>
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

Matthew Wilcox <willy@infradead.org> wrote:

> Doesn't look too bad to me.  Dave's commit is just removing the
> functions, so it doesn't matter how they're being changed.
> 
> The real question in my mind is why for-next is being updated two days
> before the merge window with new patches.  What's the point in -next
> if patches are being added at this late point?

It's more of a transfer of a subset of my iov/splice patches from the
linux-block tree to the cifs tree.  I thought Jens would've dropped my branch
from his tree for the moment.

David

