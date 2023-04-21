Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38136EACDC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 16:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjDUO2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 10:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjDUO2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:28:47 -0400
Received: from outbound-smtp28.blacknight.com (outbound-smtp28.blacknight.com [81.17.249.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F52776A7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:28:45 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp28.blacknight.com (Postfix) with ESMTPS id AAC08CCCDC
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:28:43 +0100 (IST)
Received: (qmail 30212 invoked from network); 21 Apr 2023 14:28:43 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Apr 2023 14:28:43 -0000
Date:   Fri, 21 Apr 2023 15:28:41 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 12/26] mm: page_alloc: per-migratetype free counts
Message-ID: <20230421142841.parju3gmqmpefigq@techsingularity.net>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-13-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230418191313.268131-13-hannes@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 03:12:59PM -0400, Johannes Weiner wrote:
> Increase visibility into the defragmentation behavior by tracking and
> reporting per-migratetype free counters.
> 
> Subsequent patches will also use those counters to make more targeted
> reclaim/compaction decisions.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Visibility into fragmentation behaviour is information that is
almost certainly only useful to a developer and even then, there is
/proc/pagetypeinfo. At minimum, move this patch to later in the series
but I'm skeptical about its benefit.

-- 
Mel Gorman
SUSE Labs
