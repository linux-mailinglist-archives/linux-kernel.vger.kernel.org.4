Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B830724A82
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238811AbjFFRrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238691AbjFFRrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:47:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3741BE47
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 10:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TK/Dcn9Bt8fRxqKsSAoJKIh3aT09jUvUosAc+9LRi8s=; b=pvPoGteATGP9yQcAhaFKtclM0c
        d/Ozya5iDCMBRvWLVh5Zy6hrbd43iXGYwgkEEi4hEoLiMYwGK39yV7N48lFv03CrOSAoBAWQFmFY9
        k4YwOgVWRq4oSz5TgbwgMR03a7RXKwnYIo0Lx5k0ib7ez1pEvEiCdBUy7gStMvGFvTIPFlEP5HOhH
        HSl36wiKfggqCjoUyfu7YCmm8aFdTLRwU0XPZYJKkTemLR0/e6U97YWtbw0X+K+7DvC4MbZBHG87O
        EfAZFg2CVYzcSguFWtzKr+/AmHPjI06EnwFkSYmejb4cIzCcw9y54MXTcOQlUxLA2vUANMbMGM+bt
        eAUylIsw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6aln-00DNKY-HM; Tue, 06 Jun 2023 17:46:59 +0000
Date:   Tue, 6 Jun 2023 18:46:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, sidhartha.kumar@oracle.com,
        vishal.moola@gmail.com, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com, Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2 1/3] mm/hugetlb: Use a folio in
 copy_hugetlb_page_range()
Message-ID: <ZH9xE80MpmAKQG6A@casper.infradead.org>
References: <20230606062013.2947002-1-zhangpeng362@huawei.com>
 <20230606062013.2947002-2-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606062013.2947002-2-zhangpeng362@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 02:20:11PM +0800, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> We can replace five implict calls to compound_head() with one by using
> pte_folio. The page we get back is always a head page, so we just
> convert ptepage to pte_folio.
> 
> Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
