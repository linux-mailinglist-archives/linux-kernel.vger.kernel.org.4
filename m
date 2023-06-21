Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC86738124
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjFUKrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjFUKql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:46:41 -0400
Received: from outbound-smtp57.blacknight.com (outbound-smtp57.blacknight.com [46.22.136.241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158D010FF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 03:45:24 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp57.blacknight.com (Postfix) with ESMTPS id 4CB6DFA814
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:45:23 +0100 (IST)
Received: (qmail 12769 invoked from network); 21 Jun 2023 10:45:23 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Jun 2023 10:45:23 -0000
Date:   Wed, 21 Jun 2023 11:45:21 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: page_alloc: use the correct type of list for free
 pages
Message-ID: <20230621104521.g4qln2k4css5acjj@techsingularity.net>
References: <7e7ab533247d40c0ea0373c18a6a48e5667f9e10.1687333557.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <7e7ab533247d40c0ea0373c18a6a48e5667f9e10.1687333557.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 04:14:28PM +0800, Baolin Wang wrote:
> Commit bf75f200569d ("mm/page_alloc: add page->buddy_list and page->pcp_list")
> introduces page->buddy_list and page->pcp_list as a union with page->lru, but
> missed to change get_page_from_free_area() to use page->buddy_list to clarify
> the correct type of list for a free page.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
