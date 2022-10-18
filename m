Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9702D60303E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiJRPxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiJRPxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:53:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2DCD7E1A;
        Tue, 18 Oct 2022 08:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=zf4gOcI6C87scCaKQU1pT9sh6A
        yUWEyyw87qh1lBwPTHTqke1kzwIVtX4vu7GWCMymusv4xKiEwpSe99CtTjLv/TikxKQ4eSJ/b+i27
        8kXbZ9X5lusgDpdwiDMfgwTG9AmUf7cdEFNcO8aL7XPzwHijGWGT8rt2BRbQtAFO4nARdzGP+avT0
        0PmUwVRJBvUHf09qpuQwCjIWG9SrBXvB0UkrrEf8PTk+wq/S5BfarkAhSjGYDRRbP/6go38kTUOE+
        nMGUIRrmnPgDGsxNTUQOXlCFibQzQ1hG8/pIw0adCphJr8ASU4y8d2d72s+Qc4igosaHTyfVGMeiy
        VGCC+ytA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okotd-0081xt-3D; Tue, 18 Oct 2022 15:52:49 +0000
Date:   Tue, 18 Oct 2022 08:52:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] blktrace: fix possible memleak in
 '__blk_trace_remove'
Message-ID: <Y07L0U0qppqv4cfg@infradead.org>
References: <20221018145135.932240-1-yebin@huaweicloud.com>
 <20221018145135.932240-3-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018145135.932240-3-yebin@huaweicloud.com>
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
