Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29886EAA8C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjDUMkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 08:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjDUMjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:39:47 -0400
Received: from outbound-smtp03.blacknight.com (outbound-smtp03.blacknight.com [81.17.249.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216BC118C9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 05:39:14 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp03.blacknight.com (Postfix) with ESMTPS id 78CF6C0BEB
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 13:39:13 +0100 (IST)
Received: (qmail 8794 invoked from network); 21 Apr 2023 12:39:13 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Apr 2023 12:39:13 -0000
Date:   Fri, 21 Apr 2023 13:39:11 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 04/26] mm: page_isolation: write proper kerneldoc
Message-ID: <20230421123911.bccz3jgpeqa6foas@techsingularity.net>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-5-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230418191313.268131-5-hannes@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 03:12:51PM -0400, Johannes Weiner wrote:
> And remove the incorrect header comments.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Split out.

-- 
Mel Gorman
SUSE Labs
