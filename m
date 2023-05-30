Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C89716937
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjE3QZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbjE3QYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:24:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FA5124
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pWWdPmiGz+I1qZLHvpqK5zN+jIL1btM5goMCaUaSM3Y=; b=vgG9td/BWQJK4sQpQpyRFGpLzm
        FV/mUQzdJTxiY9qHZ8PEXkGz8ezRUXP3cXBGGjFaDkRV+QYc257kTmEff8P5pAPex6GUiYNnU7tvG
        sMLGARgjjd2lcsduL5n5qnr3TEmIvfRPLBGbr4VYqhPaw/vqddpvRdsh98z5ZqFUIy7vhLIncZ4ZT
        f5gazCUG5quqnxanUNN8ZSj1cEaY8zLfg/fq6LXmJX0sJxSMqfuQNNpiYh5QQJPiUjZEP16G6YxKU
        YPXQGElIXOnjPhhdrLSe+JFtZLNFdpylQmxzHcrU/Dks61bbWzz+yUNKFNBDhb7KjXvrcpRq0xGDv
        O9Gop7sg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q4292-00EYmV-1p;
        Tue, 30 May 2023 16:24:24 +0000
Date:   Tue, 30 May 2023 09:24:24 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Daniel Gomez <da.gomez@samsung.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Pankaj Raghav <p.raghav@samsung.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: Increase block size variable size to 32-bit
Message-ID: <ZHYjOFNo0eV+VeCL@bombadil.infradead.org>
References: <CGME20230530154254eucas1p241e57af99e4d4ee0e1a677904c3db68c@eucas1p2.samsung.com>
 <20230530154231.8313-1-da.gomez@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530154231.8313-1-da.gomez@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 03:42:53PM +0000, Daniel Gomez wrote:
> Increase block size variable size to 32-bit unsigned to be able to
> support block devices larger than 32k (starting from 64 KiB).
> 
> Physical and logical block size already support unsigned 32-bit.
> 
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
