Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C746744BE0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 02:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjGBACK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 20:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjGBACI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 20:02:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4E91725
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 17:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R0KXdTM+U+RgYWhEOtgdyHpkK7ky0GzNiiR/kTynaEc=; b=EHDfPmtheSsLTu8cHYzmhB6VQC
        adgB2KZmpTP8qS7mect8GNl02heToZBmIa4/+DZqxxOTLWeouDsfsERoAt2uNN/bzUMJhAdkfmALW
        6QhPCmD5RyEh3Qb6CySHROCgolKELdqD0GyEq5WRp5ohv3dEK2iwChtF8cgR8GtjXLD2ucSlGp9Lu
        XD11svEuoYsIHo6ym5V2XWdooBVQPhhfrfJT8xzd0noG+qWbAwTrOkUSh8Uyv4Q7mqmox9fDP/Nkx
        Wc3aKLrtKC+oNM2RXNk9UVVBrNWtqQxzzHM3JevHb4duFh3pIqSdn21OX6TQ/Umnc5aph4QE3CG1v
        va5n11ew==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qFkXS-006xkl-6r; Sun, 02 Jul 2023 00:02:02 +0000
Date:   Sun, 2 Jul 2023 01:02:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sidhartha.kumar@oracle.com, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com
Subject: Re: [PATCH v2 2/2] mm: remove page_rmapping()
Message-ID: <ZKC+evd7Z2wuDjOo@casper.infradead.org>
References: <20230701032853.258697-1-zhangpeng362@huawei.com>
 <20230701032853.258697-3-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230701032853.258697-3-zhangpeng362@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 01, 2023 at 11:28:53AM +0800, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> After converting the last user to folio_raw_mapping(), we can safely
> remove the function.
> 
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

Thank you!

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

