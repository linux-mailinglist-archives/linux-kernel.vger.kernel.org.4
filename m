Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2372F670F8D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjARBHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjARBHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:07:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7183AAA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BBlui51k9QNpW6zNJf4sWR+5IEH1nBlafO8mgl+bOQc=; b=ZY5S0zw+FvmexSWdyWx0i3wchz
        ODG1QqwpGQ6OtbWGXMgQw11gPbwB/euJbJeirwQkca3FIZpAyAuTm0t7oyZGBXqgSEmGUJ4N7fNpC
        473cOaOIbzKNAFzxSaO95t4k/DYKpQuk8tC0wS/6TjAoxgET3pt4sTuu/eWemaKkfDJg3X21GgG/v
        L6VBLEQ7nBsePTRJo6+Ey9nHRDfw/xQWPi2XwKOxm+bOaqQa1Esjfx58C/wQhRpSXLOUvbomc+5Nv
        UI7PcnR7sztFxZ2kI51vWt6AMPklv2xl1gd8HrsJ/0fDCG8G6kePvJWf//BKaq9ppRR94UgdX9TW+
        fk+bu/GQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHwmH-00ACy7-4V; Wed, 18 Jan 2023 00:58:09 +0000
Date:   Wed, 18 Jan 2023 00:58:09 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH 1/3] mm: return the number of pages successfully paged out
Message-ID: <Y8dEITaIfETA/Z/+@casper.infradead.org>
References: <20230117231632.2734737-1-minchan@kernel.org>
 <20230117155312.5464d01c2d639b1ac44f9330@linux-foundation.org>
 <Y8c+tFfwSTwlRFOk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8c+tFfwSTwlRFOk@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 04:35:00PM -0800, Minchan Kim wrote:
> Yes, both are correct in my view since pageout is initiated after
> unmapping the page from page table and think that's better wording
> to be in description. Let me use the explanation in the description
> at next spin. Thanks.

For the next spin, you'll want to do it against mm-unstable as
deactivate_page() is now folio_deactivate().
