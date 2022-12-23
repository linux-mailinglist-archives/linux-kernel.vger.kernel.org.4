Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6042E6552D6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 17:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbiLWQ3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 11:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiLWQ3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 11:29:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE051D0E3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 08:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=TRM1wdu9NTFEGMOK2mydrSApB9
        PxVwBfA7Zu4qUnlgU9TZ3BiU6eQN0sxqbxK5Cf0lTYeBND7GaXVszlKVu6U8uOVGIVgkH7G3BGRrq
        M/3qD5KqoKb5R8qWjl49yIzlHGKkK0s2oMIT2SI8RditaltBbLuW4tfw1Rlp6rGjhUgsh9++cVNMQ
        5F/Xw5QjuuYDzVV2psV/Ym7hBt21L3ufjJG1Mml74T+DXjT70uAx5rSagSFJGQQd4Ut653JBPQ4Ew
        upTiH6+pwbcY/vPF5EKrKBFZHhFQLxBQnQDo6evwa6/unt61mT+itoC2TfNqOYhZVQ7EXqdiQTVXz
        Kbrlxr5g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8kvP-009zNX-Jy; Fri, 23 Dec 2022 16:29:35 +0000
Date:   Fri, 23 Dec 2022 08:29:35 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Tony Battersby <tonyb@cybernetics.com>,
        Kernel Team <kernel-team@meta.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 05/11] dmapool: speedup DMAPOOL_DEBUG with init_on_alloc
Message-ID: <Y6XXbzTDHlL5u4y8@infradead.org>
References: <20221216201625.2362737-1-kbusch@meta.com>
 <20221216201625.2362737-6-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216201625.2362737-6-kbusch@meta.com>
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
