Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741BE5BC9E0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiISKuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiISKtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:49:15 -0400
Received: from outbound-smtp59.blacknight.com (outbound-smtp59.blacknight.com [46.22.136.243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757372C11F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 03:42:22 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp59.blacknight.com (Postfix) with ESMTPS id 195E1FA832
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 11:42:21 +0100 (IST)
Received: (qmail 11852 invoked from network); 19 Sep 2022 10:42:20 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 19 Sep 2022 10:42:20 -0000
Date:   Mon, 19 Sep 2022 11:42:14 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Subject: Re: [PATCH] mm: check high-order page when free it to pcp
Message-ID: <20220919104158.6vbzmzxk2dy6tu6w@techsingularity.net>
References: <1663559238-22918-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1663559238-22918-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 11:47:18AM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> High-order pcp page escaped from checking when both of DEBUG_VM and debug_pagealloc
> are all disabled if it allocated again from pcp_list without going to global
> free list, which should be introduced by 44042b4498.
> 
> fix:44042b4498
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Is this based on the comment mentioning order-0 pages above
free_pcp_prepare()? I ask because the comment is wrong and in both
instances should have s/order-0//

-- 
Mel Gorman
SUSE Labs
