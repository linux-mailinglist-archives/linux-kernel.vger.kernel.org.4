Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071DC6E49A8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjDQNPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjDQNO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:14:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A91C125
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IZlRCgtX5IQicJJFBQ4raUWB1nTCPFpnxgFG05BQAEA=; b=vDadV0aPunhEVOtIMmhKDe4fPu
        4NKSXbGwaPoIPecZXCOS6rIhHLgPr5HB5jm0265CJr/GICNlTb+cdVuLRC3k06bIEN4otIXwgexAZ
        7CZ/O8Mv06L1mrbvd5JfDvfypz7R23w1pUL8XmKqs8k0o4ZrnSzDV7QVvFRMF+4FJ5Qv+IzruLVwI
        MnR3dFP+jtL25jBKCSN0oEvkZAyIO9L+QogINlfv/ZaAThutXSmEJt9MKp41ipNGuorUWRDT+w5DV
        OYvDEyFberreBZl442pMX6ZBzJQBDvMUnadxJB7LjBmofTnImo1S14fFgz3KIuRc09L7pPbUDWHcn
        RVeoIR1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1poOg2-00BMa6-9h; Mon, 17 Apr 2023 13:13:50 +0000
Date:   Mon, 17 Apr 2023 14:13:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: correct arg in
 reclaim_pages()/reclaim_clean_pages_from_list()
Message-ID: <ZD1GDtAjxYE10x0a@casper.infradead.org>
References: <20230417114807.186786-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417114807.186786-1-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 07:48:07PM +0800, Kefeng Wang wrote:
> Both of them change the arg from page_list to folio_list when convert
> them to use a folio, but not the declaration, let's correct it, also
> move the reclaim_pages() from swap.h to internal.h as it only used
> in mm.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviwed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
