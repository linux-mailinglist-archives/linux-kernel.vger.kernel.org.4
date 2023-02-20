Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD10C69D060
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjBTPOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjBTPOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:14:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0D020575;
        Mon, 20 Feb 2023 07:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8Dz7+E0DgtNe+NnToeaQ7oDkq6qlY0laWzUyQElblbw=; b=l5Y/xa7PROSW81A3IZgOy1SZNN
        7NKb00qJ2CBDI+F+o2JzOzvSHp8n17ds5C0p79kcQMQTztHchuBP1aq+VDOihbn8R9wHSeJJDv6I9
        Kc+/VbhIUKJ6lydcTq0dd4YtnWxLcF1R/MTDY3XCosBn2aHEp9n0KsY3RS6dd2VgPCOrPzNCr0vgN
        ggjwP7NbsrRIQQ9pGJjuc5iTz4iJo3IA6BogNBwW+YHajyCfSOKKydUSLAILfrn0yTFhc3kFhywfs
        eI4/IU03BPzdv+eIzxSYHjFtGlzMrfoJo6iGJ/Wao2w/vE5aNe9t/5tWU06HW1JXYs4QwpdeoZdNA
        V4XIQj9w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pU7qc-00Boho-Sy; Mon, 20 Feb 2023 15:12:58 +0000
Date:   Mon, 20 Feb 2023 15:12:58 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Steve French <stfrench@microsoft.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: Re: linux-next: manual merge of the mm-stable tree with the cifs tree
Message-ID: <Y/ON+ugfcFBdeZ4i@casper.infradead.org>
References: <Y/N8hVWeR3AjssUC@casper.infradead.org>
 <20230220152933.1ab8fa4a@canb.auug.org.au>
 <1676391.1676903381@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1676391.1676903381@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 02:29:41PM +0000, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > Doesn't look too bad to me.  Dave's commit is just removing the
> > functions, so it doesn't matter how they're being changed.
> > 
> > The real question in my mind is why for-next is being updated two days
> > before the merge window with new patches.  What's the point in -next
> > if patches are being added at this late point?
> 
> It's more of a transfer of a subset of my iov/splice patches from the
> linux-block tree to the cifs tree.  I thought Jens would've dropped my branch
> from his tree for the moment.

Your iov/splice patches don't conflict.  The part that you snipped says
it's c8859bc0c129 ("cifs: Remove unused code")
