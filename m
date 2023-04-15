Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4245D6E3240
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 18:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjDOQEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 12:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjDOQE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 12:04:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D77E1BE1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 09:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M3f0tIbZDw4BYYTvAn/I3PyGrQQdEwG1iuWGGViQqu0=; b=HzUYva4ocTcDkz1rYhCD0RCe/e
        jeFJUe7IjVEjWa8unTzNeyQjBEDAD45Evl0WwB+CwrytNo4JEVvFyCqcrnIRpB59k5gOWZwXij7gM
        +gzsOjIAOrz4O9f5SAJUER1ond+l+PklWO0rt8mNbdT0tbcj36qhHgAZccE5kXGTvm7d+mty3po4W
        O5zGQxrZbOFJruV+XJOV++F+sleci0M/uWe5A+7W9Qf5BwDX0tpeQEJiN3OyET07YP5dLAS7XcKk8
        LRxSLvN+ksJUWohg4cUIRyUJJL0OY4RWggIsuS/RmMcoxGnFkZ6ifW+GjMXdJy0lUAOJAA0ZuzQQa
        Nejnn6rg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pniNh-009iCt-LF; Sat, 15 Apr 2023 16:04:05 +0000
Date:   Sat, 15 Apr 2023 17:04:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: rename reclaim_pages() to reclaim_folios()
Message-ID: <ZDrK9R9wLlfrUWMZ@casper.infradead.org>
References: <20230415092716.61970-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230415092716.61970-1-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2023 at 05:27:16PM +0800, Kefeng Wang wrote:
> As commit a83f0551f496 ("mm/vmscan: convert reclaim_pages() to use
> a folio") changes the arg from page_list to folio_list, but not
> the defination, let's correct it and rename it to reclaim_folios too.

I didn't bother.  It's not inaccurate; we're reclaiming the pages
in the folios.
