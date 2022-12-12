Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCDE649A32
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 09:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiLLIlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 03:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiLLIlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 03:41:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12C3BEF
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 00:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0qMngGvo9tWSlRBC9+H8YplkNjsSQIhhqbVTvhNodKI=; b=XdYbOTEuj6AZucpXIkPZZ8eX13
        106hFAqwHQn0fnaFMRHIZg0Zw9lp1JJzMDxdahK96wmnC476V9QrQrYZQi+cyNMUYHXyzRcnE3PiB
        FqxBwbAo1yxk/m1LlUA6ytst8QsUPFrzoGXbnM30FfH40phEVIsQep3pPpVJ2dSIcDp1IQIyjpHtA
        G34xG5KSfeQyE1mABKkbeMgm/YOolj8b7mqBiSW5Quh9r+G/ofM9DZIuwL8wFYps7OTY7WtEzvI8p
        DKLkZOErejQkFU1bvpWJxe/kE1qLGoFQ8JgYesgcZ6FGqDO7Dk3EFDGlnklZ8n9NCQcWvtsJWoloM
        U6evXugw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4eN2-00APjF-Sv; Mon, 12 Dec 2022 08:41:08 +0000
Date:   Mon, 12 Dec 2022 00:41:08 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Xander Moerkerken <xandermoerkerken@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Xander Moerkerken <xander.moerkerken@gmail.com>,
        Xander Moerkerken <xander.moerkerken@omron.com>
Subject: Re: [PATCH] Added ability to vmalloc executable memory
Message-ID: <Y5bpJHQJZIhTMbPU@infradead.org>
References: <20221209131052.64235-1-xander.moerkerken@omron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209131052.64235-1-xander.moerkerken@omron.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 02:10:52PM +0100, Xander Moerkerken wrote:
> From: Xander Moerkerken <xander.moerkerken@gmail.com>
> 
> Since release 5.8-rc1 the pgprot got removed from __vmalloc
> because the only usage was PAGE_KERNEL as argument.
> However, this removes the ability to input other arguments
> such as 'PAGE_KERNEL_EXEC', which can be used to allocate
> memory in which you can execute.

.. which is very much intentional.
