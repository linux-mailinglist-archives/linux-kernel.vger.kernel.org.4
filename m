Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5370569CE64
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 14:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbjBTN7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 08:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjBTN7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 08:59:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6721EBE5;
        Mon, 20 Feb 2023 05:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BDP+GXZzksa3aQWqV2A3A4f9tq1StQVPiy8S81efm1s=; b=p9q3AMbI+icsav00MNd4G4w2PG
        yXAliSSxVqUaclV3ZXF/+ItfsOVUdpeiRi/dGsIgp0j+OU45ZEGtHKsMQZSteeg5Etzfp8lnBFe0K
        moJsbV796AYxVTnPuW5+1MwuhkwjuYIMF4k6oF2IRPaQRlq9wHb+zKnmSVUXel96xC/IpX+SUlSUc
        /tqaHM8G/uLAKehz9NKuQvBJczqYsal9teH0SvQNFhkBW4/Q0SIf+GKls3MnBLXARKJl3dKih9Aqx
        297jQngNqmT8ShoaRw87hCQhfEc52SE+VH9ef5c854JMu6h1gprJXtjJEhTkC7vXh+WUcJt+cdBo5
        qfJfLjAA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pU6gX-00BlzV-KL; Mon, 20 Feb 2023 13:58:29 +0000
Date:   Mon, 20 Feb 2023 13:58:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Steve French <stfrench@microsoft.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: Re: linux-next: manual merge of the mm-stable tree with the cifs tree
Message-ID: <Y/N8hVWeR3AjssUC@casper.infradead.org>
References: <20230220152933.1ab8fa4a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220152933.1ab8fa4a@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 03:29:33PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the mm-stable tree got a conflict in:
> 
>   fs/cifs/file.c
> 
> between commit:
> 
>   c8859bc0c129 ("cifs: Remove unused code")
> 
> from the cifs tree and commits:
> 
>   4cda80f3a7a5 ("cifs: convert wdata_alloc_and_fillpages() to use filemap_get_folios_tag()")
>   d585bdbeb79a ("fs: convert writepage_t callback to pass a folio")
> 
> from the mm-stable tree.
> 
> This is a real mess :-(

Doesn't look too bad to me.  Dave's commit is just removing the
functions, so it doesn't matter how they're being changed.

The real question in my mind is why for-next is being updated two days
before the merge window with new patches.  What's the point in -next
if patches are being added at this late point?

