Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC961698C9E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 07:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjBPGJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 01:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjBPGJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 01:09:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23832193F8;
        Wed, 15 Feb 2023 22:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Fs3zdBc1VKjApf/pkUDbn9eZgt
        9QsFE4gKglz6HKki1XjNSOpjKKZ7Iz5zZvZcgXKcirOxbCzqWEkfH+LLxINU86fersO8fZPuR4KId
        VduM1v46L97buQFSfVnENOlO3TTpiKcsoqDyTfR3/RO2zrL35vfH5mQjMYmGTKa1tC766+daol8Yj
        SLUGKejT/uNwYYwpC6iZuNAe8oA8594ebPAvtWoMP7WuBy0VEKbNx38YU9yLtDuKdCS2gzp9b7aAS
        fUVIq7rpFc+CVeUiPs/td9okNgXhvuJ7o3WHqPRvGVVZQu9h6uHO0dcEJBlX9gam/MtThVbiyrbet
        +lMKurfQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSXRy-008eRw-VF; Thu, 16 Feb 2023 06:08:58 +0000
Date:   Wed, 15 Feb 2023 22:08:58 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jinke Han <hanjinke.666@bytedance.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, muchun.song@linux.dev
Subject: Re: [PATCH] block: Fix io statistics for cgroup in throttle path
Message-ID: <Y+3IepgVkmbc5gor@infradead.org>
References: <20230216032250.74230-1-hanjinke.666@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216032250.74230-1-hanjinke.666@bytedance.com>
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
