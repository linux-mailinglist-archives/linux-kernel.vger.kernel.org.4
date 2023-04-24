Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C713C6EC4A2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 07:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjDXFDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 01:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjDXFDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 01:03:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4CBBC
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 22:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Fw3Q/n6S38+C/d98cyLSeGtrxL8rb+ThNNRUdcaHZZg=; b=m4AsMCh1Y1/2Rgf+NulOKnYNWr
        Blshy5M4+y9xXBt+h00ESXVmm+0gA9ctRKYurYv6tw8HekgNR4r80tljDqCg05P+HP47eqz1p6WkG
        L+2y8bx14bqIMNfQopESs+Ues612R/21hCJVBhAXmm67cTNOCqgj3ZwcAJidhcTnx0wtGRRS82Pqk
        rLUZYZCWnjdrx7ANmL///nubtybQtLQYxKRR91BTkegBlifgWHXlVao9pv7HTBa93HkYfWZxXD52H
        BH+j5wt0jGnO7orABhZRBwUuwxWh9+qIR9GQrADAiwsSkAcpxg3ERzAgeF7xMCZNcs8UK3jPxRuqp
        TuYKYKjg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pqoM0-00FKoB-0X;
        Mon, 24 Apr 2023 05:03:08 +0000
Date:   Sun, 23 Apr 2023 22:03:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 22/22] workqueue: Don't implicitly make UNBOUND
 workqueues w/ @max_active==1 ordered
Message-ID: <ZEYNjGr+14Anqgow@infradead.org>
References: <20230421025046.4008499-1-tj@kernel.org>
 <20230421025046.4008499-23-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421025046.4008499-23-tj@kernel.org>
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

On Thu, Apr 20, 2023 at 04:50:46PM -1000, Tejun Heo wrote:
> There aren't that many UNBOUND w/ @max_active==1 users in the tree and the
> preceding patches audited all and converted them to
> alloc_ordered_workqueue() as appropriate. This patch removes the implicit
> promotion of UNBOUND w/ @max_active==1 workqueues to ordered ones.

And because you only Cc'ed me on this patch but not the rest of the
series there is no way to make me see it.  Either cc me everywhere
because it's actually important, or preferably just drop fringe Ccs.
