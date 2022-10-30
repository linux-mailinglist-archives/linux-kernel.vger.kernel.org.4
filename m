Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776DE6129C5
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 10:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiJ3J5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 05:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiJ3J5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 05:57:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087A4D102;
        Sun, 30 Oct 2022 02:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Es72KeOaZpA6K+UBk66htKhwB9
        W16d4I0c25YGEypJc1CsX9tlzt8WNYTve1nYKGuq1mt9zPKwtp7hZitNTVY1RNTG0Ls7E9wqHg9S6
        pQgWJcSUlfDCzLAeJQmGYKynuRWeIlTw//Tbtn49qSiHp1zv8GzpQKDwXkkFaC7tJ7jMAn77IhSi/
        MQmbe91y4hDAA9t0kJ87Y99nEe1Bz7S7rlnK50UG0OAfHEi8IcrQNV6wSostj0SI56g1IWW8p6A1P
        NrokoSNKiXYwOvnupCBH+XuzANKDQqGfAryxK+9Zrq3OaNrIWMCW/u3hA7aBa4qA9/+zD8Z3M0xH9
        F4KdFRjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1op54M-00F4ld-Ot; Sun, 30 Oct 2022 09:57:30 +0000
Date:   Sun, 30 Oct 2022 02:57:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: move queue_is_mq out of blk_mq_cancel_work_sync
Message-ID: <Y15Kiq+Y5r63RLR3@infradead.org>
References: <20221030094730.1275463-1-nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221030094730.1275463-1-nickyc975@zju.edu.cn>
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
