Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2996174193B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjF1UEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:04:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41248 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230021AbjF1UEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687982620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3b+24GCjaobItx3MRyMR1XkTqI67FLcalri9EqkKw18=;
        b=KSTcB0m9yigkPxwDPmHTd878M8osjKOjfK0TAWeTfIQUGJ2J1eq3hTI70IwnwFVJfI+Tal
        gVH2XfyW85mVctOIwS/UGi6VeB128lFA6LE2wcibukeNK9RhNhev4jY1h4l/AfWSSMbrBI
        9xD61sYtQhBByHZ6SZ4YTtRPXNx9JRM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-HEee_UGnP26zO6Noq9HCwA-1; Wed, 28 Jun 2023 16:03:26 -0400
X-MC-Unique: HEee_UGnP26zO6Noq9HCwA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 550A4802A55;
        Wed, 28 Jun 2023 20:03:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A167E14682F7;
        Wed, 28 Jun 2023 20:03:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZJyKef22444mooNE@casper.infradead.org>
References: <ZJyKef22444mooNE@casper.infradead.org> <20230626173521.459345-1-willy@infradead.org> <3130123.1687863182@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>
Subject: Re: [PATCH 00/12] Convert write_cache_pages() to an iterator
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3697884.1687982590.1@warthog.procyon.org.uk>
Date:   Wed, 28 Jun 2023 21:03:10 +0100
Message-ID: <3697885.1687982590@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> I'm looking at afs writeback now.

:-)

>  fs/iomap/buffered-io.c    |  14 +-
>  include/linux/pagevec.h   |  18 +++
>  include/linux/writeback.h |  22 ++-
>  mm/page-writeback.c       | 310 +++++++++++++++++++++-----------------
>  4 files changed, 216 insertions(+), 148 deletions(-)

Documentation/mm/writeback.rst too please.

David

