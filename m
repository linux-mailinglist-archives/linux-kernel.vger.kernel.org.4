Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C9868DAB2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjBGO0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjBGO0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:26:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F923BDA9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 06:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675779942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FNwOLNIcIOa8N+GIFK2MFiHQPefHbhJcU7pUi7i1bsY=;
        b=bortJQEQIlpab3fmAUsU/N1bvmrX1tiOt90VpW9/CgN6sqY1hU0VSrOAuNq90mL5wtxYIi
        ekfiT3HjNz/llbaQBkL9h1zUdNZpdc1BCeMaX0bkA3ypcUe6Yy66tLusqfTOCeReDwQv5a
        syG8D4YhaLowxh0EAXkT73Ruhh5CNzY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-i4xfSdVsNHmBbDvrASF2fw-1; Tue, 07 Feb 2023 09:25:39 -0500
X-MC-Unique: i4xfSdVsNHmBbDvrASF2fw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 907D688B7A2;
        Tue,  7 Feb 2023 14:25:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 84F4A2026D38;
        Tue,  7 Feb 2023 14:25:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y+JBak3Tt8Pdw3yE@nvidia.com>
References: <Y+JBak3Tt8Pdw3yE@nvidia.com> <20230207153706.1821393e@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     dhowells@redhat.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3189180.1675779936.1@warthog.procyon.org.uk>
Date:   Tue, 07 Feb 2023 14:25:36 +0000
Message-ID: <3189181.1675779936@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Gunthorpe <jgg@nvidia.com> wrote:

> David can you send a patch to the block tree to fix it?

I'll see.  Given that the patch series introduces a memory corruptor bug that
someone might bisect through, I want to see if Jens will let me replace it to
put the fix first, in which case I can just alter the patch that adds the
FOLL_PIN usage.

David

