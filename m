Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384E2724AAF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238378AbjFFR46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjFFR44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:56:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065A5D3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 10:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rbOpRG4y/OAGcHxrYXoP3NvhSpxft/lgsEhQrGrKTKs=; b=I+no4+kNd8XOxGRRDNPObtshCh
        tLKpaCPSRsPxLzW3m7bMNy2UuuI7tsJmLsWpeiZQkpmFQBfJbHdvuq1WcG8NSyFXs3QSOM8z+onjm
        TgTH7qIG4KAR5j85Zndy7W+DSzegRDEODnQPa1Js4WWhRdcOJPgWlZErA3nyLbnnUfdUsz6qBtcld
        M1QNzgSXBR+0+POaWVjls9s4ynnr7q4RsGUlCBzcZVEcmKF9vuJplaHIlVkJeb7nXMV323YT8gns8
        DxEAW1xXoGPE+9vb5i/x0vDmfVwCeUqGKxXCmfVZuI7jnSFu2wUrrIjFWObdnMP7PxJKn54sO2ywj
        UNAUUIOA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6avI-00DNwS-Df; Tue, 06 Jun 2023 17:56:48 +0000
Date:   Tue, 6 Jun 2023 18:56:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, sidhartha.kumar@oracle.com,
        vishal.moola@gmail.com, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
Subject: Re: [PATCH v2 3/3] mm/hugetlb: Use a folio in hugetlb_fault()
Message-ID: <ZH9zYGsqHa9JHNj3@casper.infradead.org>
References: <20230606062013.2947002-1-zhangpeng362@huawei.com>
 <20230606062013.2947002-4-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606062013.2947002-4-zhangpeng362@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 02:20:13PM +0800, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> We can replace seven implicit calls to compound_head() with one by using
> folio.
> 
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
