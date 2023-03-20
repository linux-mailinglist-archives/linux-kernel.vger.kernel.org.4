Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7129D6C0A6C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 07:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjCTGOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 02:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCTGOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 02:14:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E381E28F;
        Sun, 19 Mar 2023 23:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=j+vmEiYvgHiyq5Coz2OWao5+T9
        tZhKB8Qi1wjfzJzfWWBU+aLZ5YPtzR3Hh+obk36L45zwkSXut2X3WNyMbJ6fKgCyGUXmTKiODW8YZ
        r63gMXsapDsA2HNbTk67h5QM0JZNPTX7xUWMYDgJbcfEUZ0AHe2adZixS11NCBlmpC1qRKPbBCF61
        IIvXqnzvOIRUyvY0v8J0lXGEFi5BzHJ9zDiRhMxpJqJxmvw62V8QQB2uAyoP/K78eNOXUXZ3TtKNf
        RPJk3/v85VI3bZigTA1IjmzQJaThVq5MrytGClRR/wpFYpvkx9rR5NwZIGSKQ/N1lLY9LWNv7OAVE
        +8rC9g1w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pe8mo-008DSP-2I;
        Mon, 20 Mar 2023 06:14:26 +0000
Date:   Sun, 19 Mar 2023 23:14:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 1/3] blk-integrity: use sysfs_emit
Message-ID: <ZBf5wnacbihD9kXY@infradead.org>
References: <20230309-kobj_release-gendisk_integrity-v3-0-ceccb4493c46@weissschuh.net>
 <20230309-kobj_release-gendisk_integrity-v3-1-ceccb4493c46@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309-kobj_release-gendisk_integrity-v3-1-ceccb4493c46@weissschuh.net>
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
