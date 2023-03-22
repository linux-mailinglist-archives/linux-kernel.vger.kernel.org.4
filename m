Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214636C50B7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCVQ3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjCVQ3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:29:49 -0400
X-Greylist: delayed 432 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Mar 2023 09:29:33 PDT
Received: from outbound-smtp24.blacknight.com (outbound-smtp24.blacknight.com [81.17.249.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99A33C22
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:29:33 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp24.blacknight.com (Postfix) with ESMTPS id AF994C0C72
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 16:22:19 +0000 (GMT)
Received: (qmail 19064 invoked from network); 22 Mar 2023 16:22:19 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Mar 2023 16:22:19 -0000
Date:   Wed, 22 Mar 2023 16:22:18 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Hildenbrand <david@redhat.com>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] mm: prefer xxx_page() alloc/free functions for order-0
 pages
Message-ID: <20230322162218.x7soyuwflru7dutd@techsingularity.net>
References: <50c48ca4789f1da2a65795f2346f5ae3eff7d665.1678710232.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <50c48ca4789f1da2a65795f2346f5ae3eff7d665.1678710232.git.lstoakes@gmail.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 12:27:14PM +0000, Lorenzo Stoakes wrote:
> Update instances of alloc_pages(..., 0), __get_free_pages(..., 0) and
> __free_pages(..., 0) to use alloc_page(), __get_free_page() and
> __free_page() respectively in core code.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
