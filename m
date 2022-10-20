Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C01605EBA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiJTLWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiJTLWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:22:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48A4C5096
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=VSIwmhqP/jNSEJa1XOiHn2dQLB
        S+eyj8XWjSxzIB6y3abhre9Jh0fzlaCSdmN7rR3Bxa3CT+eG3tPrZHxl+w3hXsovA1rYU0AFZRSAw
        opPDi9CImfjLY0G3IrfYB3MaPP1cHShc4G81Pq9O+m3/0YU6apJRomGZpYFJW0ELmCesz0UmBP1rU
        RyoRkzeiYNO9474rEWcgt6juff490nzgZhR4QQNquJr3W1Lv0ozL3hLPpSaJIHFTL0CLHkGmr9wwb
        2H8lg+kPYsU9bAf3uSQILoxrye8ypgm6uFQCYgikuvv8+KBwPXWq9OMQGWOEe9zdRXkurBb6WIFcq
        Ehjicy6Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olTcu-00E1Nd-CS; Thu, 20 Oct 2022 11:22:16 +0000
Date:   Thu, 20 Oct 2022 04:22:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 1/7] mm: vmalloc: Add alloc_vmap_area trace event
Message-ID: <Y1EvaIpPRTB6SbO0@infradead.org>
References: <20221018181053.434508-1-urezki@gmail.com>
 <20221018181053.434508-2-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018181053.434508-2-urezki@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
