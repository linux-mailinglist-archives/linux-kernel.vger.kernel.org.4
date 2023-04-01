Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5ACF6D31EC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 17:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjDAPPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 11:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjDAPPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 11:15:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF2911EA0
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 08:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C6H0rrg5NJ+2lYtireHy454h3AJn13XdmPAVV6vVWgc=; b=ZSuCN07jL/SIC0g2Rz9ooxcdD6
        7iZ/vnk7Mti73k29bOGwlhJ5oWBMDXG1LfFuNj9fLpPiZuLOm+iWxg61udPit5t0hiMfTj6zINR6i
        hesQgmNVyNfEO7faG0JWXneIzIF6frMRFJIdM+FiU99G2U9+pdo0DeBDgkzsyEyV7K/u3fCe/amVD
        UEjXaFMvszAtcuGmDZVPm8vXa3/qMROqjmUThR2VrwijEuSnrC747j3AHfzaXn0BoJY9d5Ke3fBIj
        0RkejF+HrdCNAMO2k+5+FtMv/JuufdUJbyjbBFNRUwtjg3pvbq1XRH2IvntMlkRoXF+ZuH5ertCe2
        eIelZXmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1picwj-00CW7k-5l; Sat, 01 Apr 2023 15:15:13 +0000
Date:   Sat, 1 Apr 2023 16:15:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH] mm: remove all the slab allocators
Message-ID: <ZChKgQ35wLEpcQ0i@casper.infradead.org>
References: <20230401094658.11146-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230401094658.11146-1-vbabka@suse.cz>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2023 at 11:46:58AM +0200, Vlastimil Babka wrote:
> As the SLOB removal is on track and the SLAB removal is planned, I have
> realized - why should we stop there and not remove also SLUB? What's a
> slab allocator good for in 2023? The RAM sizes are getting larger and
> the modules cheaper [1]. The object constructor trick was perhaps
> interesting in 1994, but not with contemporary CPUs. So all the slab
> allocator does today is just adding an unnecessary layer of complexity
> over the page allocator.

Acked-by: Poisson D'Avril (Oracle) <willy@infradead.org>
