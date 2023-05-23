Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7DA70D3DB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbjEWGUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbjEWGTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:19:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B64E18B;
        Mon, 22 May 2023 23:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=E3za+pRQKoKCVofrMtAmbV5NMn
        GQ2B6q4S9MjGYx3+HCqha5EvLxXsdjHIbUwy00b/q6mhgogaCfGerWFj4rIjZjIF5LnDwHRsA70tZ
        a68wpXuICQ/01rLOjXfvfDL4qLkeEWbcXMQKf1SPgD7QjXw2tJN5+xWmKZ3otTZdPRkU1IIfuVK88
        k2XvXF/0ks5RoCOZSI+jhUaDb2VrcfwSoURkP+SqRixIEp17C3SgCpcj7RVhwu7ijMB+vX4VsV3Jb
        px0h1w+Atw22YtBX80y9go2x1rb12w6nhA4tHLzgEcSfi7pN52hbSi5iL2vyvPSFpv085XOTHbw91
        zK7Bz+Ow==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1LN1-0093zs-28;
        Tue, 23 May 2023 06:19:43 +0000
Date:   Mon, 22 May 2023 23:19:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     linan666@huaweicloud.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linan122@huawei.com,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH] block: remove redundant req_op in blk_rq_is_passthrough
Message-ID: <ZGxa/0BsZ0DJ+AK6@infradead.org>
References: <20230522085355.1740772-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522085355.1740772-1-linan666@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
