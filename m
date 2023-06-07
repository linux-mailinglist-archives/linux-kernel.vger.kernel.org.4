Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D33725601
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238644AbjFGHkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238408AbjFGHjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:39:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C3A30FF;
        Wed,  7 Jun 2023 00:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=uFJ/YLyasn02ccX4eOnPN90GJE
        ZXSadDNXdmXgzlGpqxVfyn1LuXll8QWajHB1C5k42xmowA61EKHp8hHIsBaGIexP1cMN1und6YZjn
        cguL618L/Wv6O7jrl3wD75Wwz+uKZB2ZaNlH77W/+4k5YsIxLzbLCMqSJtUgzGFCR+XkNZrKF6jj0
        FKZVtUfXntHxrLzfUABYRjeZl7mMwWx2aHPA51P3yyMFD0TFpHWhOhJ7U91wSopztEd0FdL+rWj2w
        KqLAZF+DmQXepg0oqUG85ajHHSP2m9ZS7NB3oSgIX0w8i7ghkNI1HqsBnNGLgMJOXKlRvNDEWTo8g
        N+cnR/Rw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q6njY-004lfP-37;
        Wed, 07 Jun 2023 07:37:32 +0000
Date:   Wed, 7 Jun 2023 00:37:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Zhong Jinghua <zhongjinghua@huaweicloud.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        zhongjinghua@huawei.com, yi.zhang@huawei.com, yukuai3@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH -next] nbd: Add the maximum limit of allocated index in
 nbd_dev_add
Message-ID: <ZIAzvKZuGrcQUx82@infradead.org>
References: <20230605122159.2134384-1-zhongjinghua@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605122159.2134384-1-zhongjinghua@huaweicloud.com>
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

