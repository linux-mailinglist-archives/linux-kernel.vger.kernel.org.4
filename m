Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2C9660A15
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 00:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbjAFXHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 18:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjAFXHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 18:07:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A068460A
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 15:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TR84vYn9WShU7mQuihrDE3sVN5KTjnPiAIwI8uaw7XY=; b=BleR+jVeMLiVyeU5OGRNms2olO
        I4Mmx1iWeaRDY71Lh+EPLJ15QXsDlhf5eU3q1yIMp+WKzUe3P9Nm1h5tmWxIDS+AnsnLcccxx6PBj
        ZWufKj9pXpOdWzEQp8ykmx7Xbd40jRRObVI5gJrEIljuJ0DeRUfcFYPMu66EcSPijK26GGTpdjjvL
        n/Dks04KBCyYS7TPYLaBINCFJsph+uy8Xbfwjj6kZjIEfOmNmBPd/j9hpA5m2AUrVspd//BUERygk
        OpflN+vVk7qrwj3Ab6c0UGIL+iE1kiQxphoye57f1qnetgiHdeFQsebwMOjJ0KLAbY7oTZS5lP98P
        yaPcPqMQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pDvny-00HaCV-Mk; Fri, 06 Jan 2023 23:07:18 +0000
Date:   Fri, 6 Jan 2023 23:07:18 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, vbabka@suse.cz, sj@kernel.org
Subject: Re: [PATCH mm-unstable] mm: introduce folio_is_pfmemalloc
Message-ID: <Y7ippkAfMZpL22Vr@casper.infradead.org>
References: <20230106215251.599222-1-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106215251.599222-1-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 03:52:51PM -0600, Sidhartha Kumar wrote:
> Add a folio equivalent for page_is_pfmemalloc. This removes two instances
> of page_is_pfmemalloc(folio_page(folio, 0)) so the folio can be used
> directly.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
