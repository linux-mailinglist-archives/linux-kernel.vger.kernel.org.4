Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5258B702C0E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241691AbjEOL4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240712AbjEOLzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:55:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C3930E7
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 04:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=vZrfgBjWoOalZbYIgPvX05q9cG
        mL2rBbyENpR77hkpgoHa/zBPqfLsoqoPmcAI1xb+Zxuc2lHXJRt5tHjaDUm10dsvH043No8d+krqs
        j81Nk70EutKje/XNj6oDk2jJ/iRW6VUSGUMvGYdfmevzCRw86pNuRh3pxlsf9EysoxhkH+xqJL1xi
        fiXRZJoDgArCTzXYm9JSLOlFvm3vq86RQrJ3DVtZXDerBR4+5fGAT9dlGvroGB7CPrQqc61sRrpX4
        37jFbW6d2X6BhNUhwcuovG6KKs52boWiRndh+C9deN0o/+0WZSJcTSIUcm0Q2XEwveYLkLCn3GLUU
        bl5WecUA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pyWj9-0022MZ-2o;
        Mon, 15 May 2023 11:50:55 +0000
Date:   Mon, 15 May 2023 04:50:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v5 6/6] mm/gup: remove vmas array from internal GUP
 functions
Message-ID: <ZGIcnz29Fhgvjz+Q@infradead.org>
References: <cover.1684097001.git.lstoakes@gmail.com>
 <23f5b6e75ccf31565355cd37bf1253d20f2e6388.1684097002.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23f5b6e75ccf31565355cd37bf1253d20f2e6388.1684097002.git.lstoakes@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
