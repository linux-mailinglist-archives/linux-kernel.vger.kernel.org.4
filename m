Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0309E65D62B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239646AbjADOk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbjADOkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:40:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7167339FB8
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 06:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tl+X9g/RXdgA9M9RbC1T7PBcdBUoa0eZwHN8F9AnKE0=; b=ffTR+47XkzJtIBLKhbWc1Iexaw
        IPEi6QOyVh4W310g/oDbvPEUeGQv/U1wQwFwhMS3YDgxHbakoEJONtVqIK+wps1wX69uqNTMEamob
        TSxX4yu8eu+vrUZfDfPRRkQeUDZT+hGxcvyv8nRgu2VZ0KGYRICfLwmAGpYDlsAWCTa7YpeGksJeO
        Fp8P4CR3l2/wWu5/72KCxjUhfLRWnoZnfHCPTnif3nqKFp90bK0Auo/dWeHoSqF5RWldWps5gkANS
        9621/Hjdv1lxkunF1OLbsk0Pf/jXor33JRTfnRjy4CHkMV2OVSTYCvCDfnjpH47NBz/5Hc89/zsXa
        1/1KSBlQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pD4wM-00F7hD-Om; Wed, 04 Jan 2023 14:40:26 +0000
Date:   Wed, 4 Jan 2023 14:40:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: Remove a sentence from kmap_local_folio() kdocs
Message-ID: <Y7WP2gyTRqTZWAQZ@casper.infradead.org>
References: <20230104121845.15770-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104121845.15770-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 01:18:45PM +0100, Fabio M. De Francesco wrote:
> In the kdocs of kmap_local_folio() there is a an ambiguous sentence
> which suggests to use this API "only when really necessary".

Looks like you removed it from kmap_local_page() docs in 72f1c55adf70
after I copied it in 53c36de0701f.  That information should probably
also be in this changelog.

>   * While it is significantly faster than kmap() for the higmem case it

Also, s/higmem/highmem/ (both in the kmap_local_page() and
kmap_local_folio() docs)

