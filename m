Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62F2724A8F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238668AbjFFRvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjFFRvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:51:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6D6E54
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 10:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XjBvhZO+q7fB3Jp0UknGf25o98nsfd73W1E8HJ4erfw=; b=ui2lQYouq+E27NB5G1h0vvzCpF
        l0ucjVugngq/wyMgRekoJh11bq4cv+ozMMT9MK353/rpyev1mT/aAJIK1AQ5WT38ZTA4khSPevJUS
        WnTNLXrlOVbmNAewBqKZn3e0YfbGOcZMzrRY4l8T7tgyHea6DI1BECHy+AzMVvtevYZWV2omLoeOU
        zYF8creHL26ROp+V5bZtV29QZdcGdSmTvy26u/woAHu9tKEjVXe6hgAXNXZ++U4T+2vpjdQKMU0Ue
        +IZ2tcZo6GfS5CagCQCXQtDhkpXcgRsypmQXEj9ZQQpDI7HaaBZdpcqenOubw03FBFdUvBlGxKRqZ
        KZ/LDSBA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6ape-00DNWc-Hc; Tue, 06 Jun 2023 17:50:58 +0000
Date:   Tue, 6 Jun 2023 18:50:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, sidhartha.kumar@oracle.com,
        vishal.moola@gmail.com, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com, Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2 2/3] mm/hugetlb: Use a folio in hugetlb_wp()
Message-ID: <ZH9yAlVDk7POqgTv@casper.infradead.org>
References: <20230606062013.2947002-1-zhangpeng362@huawei.com>
 <20230606062013.2947002-3-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606062013.2947002-3-zhangpeng362@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 02:20:12PM +0800, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> We can replace nine implict calls to compound_head() with one by using
> old_folio. The page we get back is always a head page, so we just
> convert old_page to old_folio.
> 
> Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
