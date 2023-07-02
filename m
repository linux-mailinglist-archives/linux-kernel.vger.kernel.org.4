Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA54744BDD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 02:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjGBABo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 20:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGBABl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 20:01:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47651725
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 17:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Cnx5nn2JwPvpg5UMJc1N/dgf7g9fBF/GD3b8oqGdO5A=; b=m2lI0Tz+C3i30o2JIf8Yu3ahe4
        R3W/cUL28h2U9lVdDTgNcq7WhbeV0XXBM/wsOGU5qgYp46iVvMhQ2Lz5qRVaTeqWNAzu634BFIZsA
        +qLKljuBru0Vjr4ExYtaCrBc7GDiFAvg0kUANxfVY5TBBEzhb2mZzZC69IhWEZrAL4eFktLLrHHML
        Aztq/ztGccPOlZOTPKMaMzmzfKkI23Oil0iXPfhiz+m9tviH2+7P2QQ0x1NMrDgbZRi8XdIv2lYDG
        ZM72j/TLbacSQ9IGQaO7YWxdwioaHRPREoHgrrD5zxjujnPiQjzq9i9I9VonsZxM92lW+55RofM0h
        Wmvq7Kxw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qFkWx-006xiH-Vl; Sun, 02 Jul 2023 00:01:32 +0000
Date:   Sun, 2 Jul 2023 01:01:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sidhartha.kumar@oracle.com, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com
Subject: Re: [PATCH v2 1/2] mm: use a folio in fault_dirty_shared_page()
Message-ID: <ZKC+W+8uaB9z2TV9@casper.infradead.org>
References: <20230701032853.258697-1-zhangpeng362@huawei.com>
 <20230701032853.258697-2-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230701032853.258697-2-zhangpeng362@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 01, 2023 at 11:28:52AM +0800, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> We can replace four implicit calls to compound_head() with one by using
> folio.
> 
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
