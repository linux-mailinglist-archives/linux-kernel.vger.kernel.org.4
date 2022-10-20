Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540FD605947
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiJTIEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiJTIEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:04:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBEA12080;
        Thu, 20 Oct 2022 01:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=J4I46y/HsM+y8jCJsQJX9XRacI
        78HTZYdzK6qQKh/vheOAge339wjJuZdgXxtfL8iaGNsYvbz6jYzkzCZJfbwNH4dnZgRqAqecWD/ic
        NVfNfTDxLbpQaeg0f3fJRSVORBjb6I7TY4u8Ea03Qq53LrXuES0ExCjqKPLFrdDhZR5G5QrRBuryo
        mcNfayda1roe57F9jOI9awxvwNug6JOQshzsegLT8vUicVhDlXvqkD1IV2mdzjBo/3e0yvhHdzHdb
        jwCTUG4p7t2jCJSXH82gVdKb4R55Cy82UfwD4i6NumEnbMa+rkLBfw4OQvkW70hMUKLK3azgYKGAA
        R1ZHbeqA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olQXJ-00C3Q6-Ky; Thu, 20 Oct 2022 08:04:17 +0000
Date:   Thu, 20 Oct 2022 01:04:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH v3 1/3] blktrace: introduce 'blk_trace_{start,stop}'
 helper
Message-ID: <Y1EBAdJROmwc37HS@infradead.org>
References: <20221019033602.752383-1-yebin@huaweicloud.com>
 <20221019033602.752383-2-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019033602.752383-2-yebin@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
