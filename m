Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E1B653DE8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 11:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbiLVKEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 05:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbiLVKDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 05:03:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBDE23EB7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 02:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AcGWlY/OlcIqRRlXKkZFQDTC1PCQwdSXbxSac1YmIAw=; b=c8W67kk+9LDCTm1Xxhbo56EVSa
        aYfahx8x0YW37wDaRHIhW9TUmqtTt5AqKt2LPLLIYIxyHTkpk1r1kZ/xuabYK219wLFOE2O7tyfzU
        JlL7QzUimYjIqy2CkMDuDq/kTrG3BfIoSlb4bVWooO15QzXOTGy7CBVATImtvLfSQUXcXw56cUR71
        3ab16bHGqPlA5A8Qso9ugvrkWJzD34456504wV4fYr/5dLa0UlYcHkH7KNn9bVIM8lRB+9AWBdYtX
        +BNdwkht3S0beiTbHUR4fZNNzJZvFcUnh8kGWqgLwyNMmTAX026aZvsnh8evG8myn0WZzIREZR4xN
        477butnQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8IQU-00A9X8-UY; Thu, 22 Dec 2022 10:03:46 +0000
Date:   Thu, 22 Dec 2022 02:03:46 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Marco Elver <elver@google.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm: remove unused alloc_pages_bulk_list()
Message-ID: <Y6Qrgu94tLAZsAN/@infradead.org>
References: <20221217001554.554913-1-lstoakes@gmail.com>
 <Y51L496TjNuiSxsG@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y51L496TjNuiSxsG@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2022 at 04:56:03AM +0000, Matthew Wilcox wrote:
> On Sat, Dec 17, 2022 at 12:15:54AM +0000, Lorenzo Stoakes wrote:
> > This function is not referenced anywhere else in the kernel, remove it.
> 
> I think we're waiting to see if any users show up.  It's only been 18
> months or so, so perhaps wait a little longer?

Is that being snarky? :)  We generally don't add dead code at all, and
certaintly don't leave it around for a year and a half.

If anyone really needs this we can add it back.

> Also, if we do get rid of this, then __alloc_pages_bulk() can lose
> the "list" argument.

Yepp.
