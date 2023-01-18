Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83CF67258A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjARRwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjARRwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:52:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558DC4742B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EosJuC+qxSv/j6gB1hQ2u7676pcskikauufO7mHu07U=; b=Nr4chUe6duhL/Lmi7pVTcfN1H+
        KCY8lOFk+85h4THJ8QkMUzCnJj1NOLQRkrLG6F3bCZjnw5/5PYXTDJhYhMjol2OqM44l9c0xR+v8Y
        yxnJqF35l3E2ZhI495t3boU3M1kvoj/gyVeAUd9v9wlg3SjKlwBs8v9maCAvqzyFvhis2Q1lgcT7S
        sZBWEa1+vVJv87zTD4/aIQZmJivvCXWf4IWhBadl27A8tMfD9HPW8u/8Zp2BW7l5aFqlm/CjSMZi7
        HjaplYA+y+i60SspdR48mrcvOTho70+BoMvS5q9JjNxqXIibGPtFDIzTAYLWZRa1foxU+DpJIm+E+
        s+dg26xQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pICbV-000CIo-HV; Wed, 18 Jan 2023 17:52:05 +0000
Date:   Wed, 18 Jan 2023 17:52:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, naoya.horiguchi@nec.com
Subject: Re: [PATCH v2] mm/hugetlb: convert get_hwpoison_huge_page() to folios
Message-ID: <Y8gxxQKolAX/vGGw@casper.infradead.org>
References: <20230118174039.14247-1-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118174039.14247-1-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 09:40:39AM -0800, Sidhartha Kumar wrote:
> Straightforward conversion of get_hwpoison_huge_page() to
> get_hwpoison_hugetlb_folio(). Reduces two references to a head page in
> memory-failure.c
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
