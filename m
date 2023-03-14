Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F246B9616
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjCNN1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjCNN0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:26:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED1E5F511
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+BkzovrVJzPzcLdkwhRIKd8pQ8NbVCXk9KhgYJj2Ke8=; b=Rd5l+sXlzQbZDYJzt5bi4Sp9n9
        CxSkIA1z4SOMQbYfKekamcnzaj06eCoijGuieCrBx7FMo1AQsp4emlW53rHq226/jnrhDhJJoLeMo
        w+WahXFiOdqot934bpb+wmWuUDSEeR2xNnNJ4qBolicQEIkc7ugqYMAqajKX26MM68vRFVE4yNcGp
        9eNCsLWX/+QY7qwl/LmOLr5y8eOthIMbXeSI4VacK1pTPsnnY+lrrsqKuOLSfd74oQlilKZu9RSSw
        sAngWdL/5wrZ7SLMU8vqndlsH3Ynaroru9dEmNZB8dJ2C7t3WpWBxB14arNs/+lh8Q6eGn7IIt8eF
        mI9YK62g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pc4d1-00CvqQ-74; Tue, 14 Mar 2023 13:23:47 +0000
Date:   Tue, 14 Mar 2023 13:23:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        vishal.moola@gmail.com, sidhartha.kumar@oracle.com,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com
Subject: Re: [PATCH v2 0/3] userfaultfd: convert userfaultfd functions to use
 folios
Message-ID: <ZBB1YxPmze070Ltb@casper.infradead.org>
References: <20230314131350.924377-1-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314131350.924377-1-zhangpeng362@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 01:13:47PM +0000, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> This patch series converts several userfaultfd functions to use folios.
> And this series pass the userfaultfd selftests and the LTP userfaultfd
> test cases.

That's what you said about the earlier patchset too.  Assuming you
ran the tests, they need to be improved to fid the bug that was in the
earlier version of the patches.
