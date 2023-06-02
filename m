Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2580671F8CD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 05:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbjFBDPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 23:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjFBDPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 23:15:32 -0400
Received: from out-33.mta1.migadu.com (out-33.mta1.migadu.com [95.215.58.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A0D136
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 20:15:29 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685675726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nsI8nkSdsUMlq9WnVDt4XHE6Ly9J8R9FU6lPfDlDbxI=;
        b=YPYjXMN78ab4uNsuydYY12vCvXYLvObh7U09Zwz/4lhwCN2m0hzqA4k7Sb+EZyMHidyTUs
        4L9xe33GOWqpHN1pwEcTA01LBkOGBU+HdbDPwaS4iHmspfoERzE5JsFMQvhm+Jqf8s3P8H
        4tVAUTASy8PqGRcHmy7fqxVPhAxrIQg=
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] mm/hugetlb: Use a folio in copy_hugetlb_page_range()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230602015408.376149-2-zhangpeng362@huawei.com>
Date:   Fri, 2 Jun 2023 11:14:46 +0800
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, mike.kravetz@oracle.com,
        sidhartha.kumar@oracle.com, vishal.moola@gmail.com,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com
Content-Transfer-Encoding: 7bit
Message-Id: <4D9E2D77-1A94-4A55-843F-C26142666479@linux.dev>
References: <20230602015408.376149-1-zhangpeng362@huawei.com>
 <20230602015408.376149-2-zhangpeng362@huawei.com>
To:     Peng Zhang <zhangpeng362@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 2, 2023, at 09:54, Peng Zhang <zhangpeng362@huawei.com> wrote:
> 
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> We can replace five implict calls to compound_head() with one by using
> pte_folio. However, we still need to keep ptepage because we need to know
> which page in the folio we are copying.
> 
> Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

