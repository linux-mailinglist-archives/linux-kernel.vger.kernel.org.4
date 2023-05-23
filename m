Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC1270D395
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbjEWGGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbjEWGGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:06:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE2A119
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 23:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Cu3w1DuGiZvnpJp9hA5iYO4+S8ACeWvD7fPOFwTEApY=; b=yqbjnNtxq4kJd6ZUyHm1A6FgpK
        f3mEjqf0oiObOjorBNIiMxBafBzrZOcfm9AL5HUs8MSc7h9EFNBoUD/wNNUXDeJKwI2jtFQMbCzRG
        TNj7ItekEawlS6puU8HbyzgU6az3ABNbb6NNP/zK7mS7nuPDc80N8Xiw9blCTbzt5bS2V1ZyrGSnB
        l8PREeawaUl8mwsa/G7MeONzthvCiuHyPtR2b5N6nvTkZbW+ZohuqIyRzFHzjmv3B08N8+7JL7Dyi
        mKugWQjK7DKbKTpmuWW+BK5d0Q5Ajk8wHWfN1etrjwoYH1q/l9u/k7FNdUb9i3apkkNruud7OL4xp
        vqqFKAzg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1LAF-0092Qc-1T;
        Tue, 23 May 2023 06:06:31 +0000
Date:   Mon, 22 May 2023 23:06:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/9] mm: vmalloc: Rename adjust_va_to_fit_type() function
Message-ID: <ZGxX569FVffCl7R/@infradead.org>
References: <20230522110849.2921-1-urezki@gmail.com>
 <20230522110849.2921-3-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522110849.2921-3-urezki@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 01:08:42PM +0200, Uladzislau Rezki (Sony) wrote:
>  static __always_inline int
> -adjust_va_to_fit_type(struct rb_root *root, struct list_head *head,
> -		      struct vmap_area *va, unsigned long nva_start_addr,
> -		      unsigned long size)
> +va_clip(struct rb_root *root, struct list_head *head,
> +	struct vmap_area *va, unsigned long nva_start_addr,
> +	unsigned long size)

Same comment as before, not going to repeat it for futher reviews.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
