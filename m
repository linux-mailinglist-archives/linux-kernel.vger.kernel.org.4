Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6724612978
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 10:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiJ3JeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 05:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiJ3JeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 05:34:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6C2C22;
        Sun, 30 Oct 2022 02:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=WcJiU5X6PvxdiZPJws4GoHmPGJ
        31Q47DbjSIjWkG9ULGAOwaBGvgN/tGnUXBmHMaVZfY6AKb69ue3hAyBM1mILHfSfPH4hIBCpxvJQq
        2/rMSIpi4NfxWn45M6NHlv6XNKMWuo+S+eWRZtYGvT7YERtUCKMogCiZo/vEB38UBGj4DokAh5NYn
        cqgmgTCRULL9i0lzm92sytat9EnFxbE8HyKzG83F/76A3bkWFB7fHgLmRqD8AUKkPEmSv3CutGPQt
        Ob4K5Nj1ONTLsevmR2jG62IM1mvAKxBhLOy/hfpoks2DXSamwNTAjwXutyhTnAy6OznWi99hL2dtW
        g3Ddijkw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1op4hj-00EsLR-LH; Sun, 30 Oct 2022 09:34:07 +0000
Date:   Sun, 30 Oct 2022 02:34:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, mcgrof@kernel.org, hare@suse.de
Subject: Re: [PATCH] block: Fix possible memory leak for rq_wb on add_disk
 failure
Message-ID: <Y15FD2yMJlvxCrsR@infradead.org>
References: <20221029071355.35462-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221029071355.35462-1-chenzhongjin@huawei.com>
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
