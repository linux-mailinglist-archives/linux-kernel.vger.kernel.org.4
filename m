Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08F361EADA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 07:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiKGGTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 01:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiKGGTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 01:19:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAA2F001;
        Sun,  6 Nov 2022 22:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=3T/9sDojIjGtTIGOioCppAMred
        I6VAiazy09q6BzAdhawIZZFiD1EnAdhBa2axfzuSgFXpfCiVzIf3wMfuVmiToWWEbcR+BqDUOrzGl
        mZ1FnCgpZIHvr7Of23oo+GvYMsQ7L1A+GYiRcFk4UKeMu6vkiOjxXml1T1viT6CVEE7Y4iN8xM4kk
        i7WjqITu3NV1vsrcvt9+GRCF4MXw+bFRxpt0MDdQIXvcWJbc/FVzFG0RCeEnAIl8w1ZxOMnM0z0mu
        9+7QmlMfWGop27chKmf6mg2/PRfHR7Qv1w1q5z8iJgUMJjs4CndE2JLRNYuPqBSKJrysIxv2ENeIM
        mWlcD2LQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1orvTL-00C6ak-RV; Mon, 07 Nov 2022 06:19:03 +0000
Date:   Sun, 6 Nov 2022 22:19:03 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        Ye Bin <yebin10@huawei.com>,
        syzbot+746a4eece09f86bc39d7@syzkaller.appspotmail.com
Subject: Re: [PATCH] block: fix crash in 'blk_mq_elv_switch_none'
Message-ID: <Y2ijV7Nw2hRJR0cJ@infradead.org>
References: <20221107033956.3276891-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107033956.3276891-1-yebin@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
