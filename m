Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779D874B095
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 14:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjGGMUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 08:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjGGMU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 08:20:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CD21BC9
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 05:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i0bVXfM3fbikHRu+gaxlWvrwaoP+TpCBb+FCOlWYXFE=; b=V1a4gHnm8AMimnYfLWQjwdqMPP
        I3VWMK+FYUr1Q+4Y7HzwOIksU1R+84o9dSHLPT659NoZMElYzBTEW3la73yZB3KPes+UOTEH2f+pV
        7N0W2qD1XfL5GpyDC5Ktesga9cLYVjIV4gS620dTytUKJIsgillHJ99/nf8rEiZDtCtYxOWNw2A6L
        ba8Iri6BaMI9JHGJx4rcfLR/7W1BMyvm0hKpHsANg/18UrF7IjUVeN85XCxOA71bmYR0IUh7rZ3Mu
        eke/XTclT253hP9bNAOC1tQn4TaTBhx5OBPRvWKdcMRhv6YpqERGpYhoU9heGEEDMBm5zWXjnu4Xi
        O7pn04Qg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qHkRd-00C0i1-5u; Fri, 07 Jul 2023 12:20:17 +0000
Date:   Fri, 7 Jul 2023 13:20:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: correct stale comment of function check_pte
Message-ID: <ZKgDAcwyOUr/xxal@casper.infradead.org>
References: <20230707153953.1380615-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707153953.1380615-1-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 11:39:53PM +0800, Kemeng Shi wrote:
> Commit 2aff7a4755bed ("mm: Convert page_vma_mapped_walk to work on PFNs")
> replaced page with pfns in page_vma_mapped_walk structure and updated
> "@pvmw->page" to "@pvmw->pfn" in comment of function page_vma_mapped_walk.
> 
> This patch update stale "page" to "pfn" in comment of check_pte.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
