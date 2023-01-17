Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511BE66D7D4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbjAQIO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236091AbjAQIOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:14:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852FA28871;
        Tue, 17 Jan 2023 00:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hs6xB6oZRtwK5KU0WsavVZCWfWo6DQtTXgAv85S6LVI=; b=NII6Wf+rVA+PTWBNEd4t4U9yLC
        mq5lZ3isXSUOjjIpXzeumhFpTWnezxcFmg9PBLCscwPozjk1A2tx8MlMzHi2fcfaCRTNNpyQv4K1c
        3UZ4Be0BYB0cVKucMDoXaEE2Zc6S9CabORbKxIWNr6LpBtNdbbVYSrDBh7DiVtKMcZ0Lk3QandTQ/
        GvAz1qV+XabVnJAbTNahw5WJS0uHa3tJ/tGEyqCvjy/JscKWPZOm1Ah9MvM5/L9IHB2MT0Jd/7jza
        va3PaiHxCmh1FOs7pJV6m1w4OWbbvJDip+T4gWlGi6fSSuSzNACASIHwZemDp8HK3QOJCsSesdh19
        PCjLxaZQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHh75-00DHtx-7Z; Tue, 17 Jan 2023 08:14:35 +0000
Date:   Tue, 17 Jan 2023 00:14:35 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jie Wang <wangjie2011cs@163.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: check disk flag before setting scan bit
Message-ID: <Y8ZY6+goxBrkHT8c@infradead.org>
References: <20230117075329.14968-1-wangjie2011cs@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117075329.14968-1-wangjie2011cs@163.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 03:53:29PM +0800, Jie Wang wrote:
> No need to scan partitions for disk who has set flag GENHD_FL_NO_PART in
> driver code. In disk_scan_partitions function, the same checking is
> existing, so we believe this change is reasonable.
> 
> In our case, some virtual block devices are not managed by GPT, then scan
> partition operation is not a must. So we set GENHD_FL_NO_PART flag in
> driver intended to avoid partitions being dropped/added.

What driver?
