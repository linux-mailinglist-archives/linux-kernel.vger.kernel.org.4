Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BD864778E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 21:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiLHU5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 15:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiLHU44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 15:56:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B7F8F0B1
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 12:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gusrjqGtF3EWWrH8XS3Cy8AToTM2/ZhBBd0S8TkvBrw=; b=eRAq1WAdlXVzkmQS7hGu0nozRC
        15wcLiOpBNO2azsiE9umptASk9KZ9FxNZz4gVAkUNTm0J9MzvrhYtev0TLe4baVp/9zI+UtUqr5tn
        zTv8MFHYYRjPXDl1oiFORi0a1eEqBGQGAwfDt1PxVm3Cg7+CBFVXAEZmS4juW/mf74fqcGO0IJDTT
        xusx6Dm7jvLQUKAQrU382+dowwCaTDRKBRuc5naWKkMApYAxVsq4udYeQUsN6ofDC7BvL+BK9WorO
        vszA67KV3gs7Zlsxeer20cYuM0isf+5vP2/6Bm7r1Kxz9m4Q+4T4GRniIWPUXslZbESBAIMblE8JG
        fpB5SvxQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p3Nwr-007JjJ-Md; Thu, 08 Dec 2022 20:56:53 +0000
Date:   Thu, 8 Dec 2022 20:56:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-mm@kvack.org, damon@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        sj@kernel.org
Subject: Re: [PATCH v3 1/4] mm/memory: Add vm_normal_folio()
Message-ID: <Y5JPlRFggaLKQ3F5@casper.infradead.org>
References: <20221208203503.20665-1-vishal.moola@gmail.com>
 <20221208203503.20665-2-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208203503.20665-2-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 12:35:00PM -0800, Vishal Moola (Oracle) wrote:
> Introduce a wrapper function called vm_normal_folio(). This function
> calls vm_normal_page() and returns the folio of the page found, or null
> if no page is found.
> 
> This function allows callers to get a folio from a pte, which will
> eventually allow them to completely replace their struct page variables
> with struct folio instead.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
