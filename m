Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FF1602FFC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiJRPrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiJRPru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:47:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCAFC1482;
        Tue, 18 Oct 2022 08:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N+5/iLqRjJZ49g/Fro/wNcdxlKR2HYbob0/Uw29F8ao=; b=2Aag03d3e/1if9ekHWyZr8YGVr
        U3czhepWnnKcm5PF8keL0qcvyo7v28XMlVMVoX2Gf7V8YBKJRE6i3X0QxKBEqYio8b9Agbon19tFU
        jx4DcYtbMmDvTF/DreJST8W5QrpRglea7thWBDqFz0BQG8VGXGoj2g5oazhWk54xG7dXlh4dLQzxM
        I9fJ+6IOLyqTcRMO5yYkvAJHIGjEEZEuIEUtEdl6ClH60GAO3+6S5UZ6GyvcsdZLqixr4eWjvrL7M
        ex6Qqm40P4L4N+Nxy9UiQ/IwQnOF30ZF6jWlNCO3KUVBOWjCser9pRBhOwXIO3G2ooKSbcIbMIfCH
        O36rqAIw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okooi-007vw6-2Q; Tue, 18 Oct 2022 15:47:44 +0000
Date:   Tue, 18 Oct 2022 08:47:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     jack@suse.cz, hch@infradead.org, ebiggers@kernel.org,
        paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH v4 3/6] blk-wbt: make enable_state more accurate
Message-ID: <Y07KoNPeq+RBKubG@infradead.org>
References: <20220930031906.4164306-1-yukuai1@huaweicloud.com>
 <20220930031906.4164306-4-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930031906.4164306-4-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 11:19:03AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently, if user disable wbt through sysfs, 'enable_state' will be
> 'WBT_STATE_ON_MANUAL', which will be confusing. Add a new state
> 'WBT_STATE_OFF_MANUAL' to cover that case.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
