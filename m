Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4560612A5B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 12:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJ3Le3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 07:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ3Le1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 07:34:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF13DDFB;
        Sun, 30 Oct 2022 04:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e/BysuOQ8Pqp1xaMNqM0pZQkTdtzMo17/V2QpxEOmGs=; b=q9HHcfkGZXfhGa4B2kz/QRodI+
        tFDUBImYScb13i/uTitJL7d9UXCGXY4MJhZ59/f/fekGuh5v/aR/tjnh1OSMsAgHT7fIc8yVBjI7/
        9tkYvfidLi1nj6BBPjIkUBDyIGhWkYQaMS/09doMM7RqVImzYVcxPdnYNqz8rOqPhLG/r+bkAAHG1
        Gck+HFzDb4x0NWa1gG52BwaGqnuw3qWvtgGMFr5Q1skBHITYz7ORIxllR12VOPaKF9rCy51FPZMFJ
        6VF0mYC7WGjGpoNOi8afG6sbCUr89aDAwLqFq6RwZ4tQDSGqQNuY6enldApuVeer99I5SNhIBoRcP
        RGvUSmpA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1op6a5-00Fdi0-3g; Sun, 30 Oct 2022 11:34:21 +0000
Date:   Sun, 30 Oct 2022 04:34:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Wei Chen <harperchen1110@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: INFO: rcu detected stall in blk_mq_requeue_work
Message-ID: <Y15hPTsbLRdl8cRZ@infradead.org>
References: <CAO4mrfffEyq9JzT=GJxzf7fUzXa0Pmx4J40qVDUepasnZ2QDgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO4mrfffEyq9JzT=GJxzf7fUzXa0Pmx4J40qVDUepasnZ2QDgw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2022 at 06:34:35PM +0800, Wei Chen wrote:
> HEAD commit: 64570fbc14f8 Linux 5.15-rc5
> git tree: upstream
> compiler: gcc 8.0.1
> console output:
> https://drive.google.com/file/d/1KgH89-sBhQbB2t-kx_ChpMM1F-7leKuo/view?usp=share_link
> kernel config: https://drive.google.com/file/d/1uDOeEYgJDcLiSOrx9W8v2bqZ6uOA_55t/view?usp=share_link
> 
> Unfortunately, I don't have any reproducer for this crash yet.

Can you please limit your report to linux lists for issues that are:

 a) reproducable
 b) actually happen on a recent upstream kernel.

