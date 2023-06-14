Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E56573021D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237353AbjFNOjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjFNOjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:39:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02880E57
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7LtrcjOCk2BnzxN0Jt4p8hT+KoPfReY8Ogm80yp1sbI=; b=ORT/z25SNU3uyjuoj7kbWTG3vp
        gjD/7Y2j7Xm+ebGa2oCdX2KN54jI5/oyJDbbyWkvu3E5CNRekL5CqtcqTAGNVFkvgBCMIaCNbQ1Mo
        Fyw681BjIY2ZOQsiolvMgxUL0wAaSLQ18DrmASG26esp+Bmj8k9XrJzjYG7mcfR8Oni48yhf6WPDN
        FcpJ1f7Z8M2V8b0G+OPCtGgOG2w2z8NAPl5tDNOn6pkY3dKLwKn/176dHUXOsA4i/vbNwLkjx0wBl
        C/8WOapJSb1+0ox3OkjG9JaujwZ2fFYn/VXdIojbZxN4AQZM/EbhSzZLRhJcg4E8zt617qUSTPK0+
        yCcBa2Hg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9ReM-006QgV-H2; Wed, 14 Jun 2023 14:39:06 +0000
Date:   Wed, 14 Jun 2023 15:39:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: kill lock|unlock_page_memcg()
Message-ID: <ZInRClwKwJCATA4Y@casper.infradead.org>
References: <20230614143612.62575-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614143612.62575-1-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 10:36:12PM +0800, Kefeng Wang wrote:
> Since commit c7c3dec1c9db ("mm: rmap: remove lock_page_memcg()"),
> no more user, kill lock_page_memcg() and unlock_page_memcg().
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
