Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD112603040
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiJRPx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiJRPxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:53:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587BED7E2B;
        Tue, 18 Oct 2022 08:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=JL+3mJOoLr1yLK64eDXtwOaS62
        5ANFFOxX5nTlFKFs3hoKzHtQJLIbSvCRbda9vQ5JKJ1FhA3RR1g+NBaRsPQz2fK7Ru2VdkbNJxCU6
        yVsN6Z/zJSLmP2EBqcPfapbJkiz7T1il6+AI3a1qXnVcfUEu4X/KK0IQVQysZCVCIC8uaIrqUPcbH
        SzLPtOR6cEmPBbvDE2ARvoUDfI1Kp892hQ2PmAA/sNK85ZM0so94Phyy7SX5FashvC/wWh9oDfqxL
        8kwAPF69Zj5vftK5Jq+3I1xiqaJ4TWXIl1rnXPeJLQJpINVEXxCCxdOPDOorSg7gV/qOn41yhd+sN
        M7vj34Vw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okoto-0082Ql-8n; Tue, 18 Oct 2022 15:53:00 +0000
Date:   Tue, 18 Oct 2022 08:53:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] blktrace: remove unnessary stop block trace in
 'blk_trace_shutdown'
Message-ID: <Y07L3K5tYCLpUHQU@infradead.org>
References: <20221018145135.932240-1-yebin@huaweicloud.com>
 <20221018145135.932240-4-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018145135.932240-4-yebin@huaweicloud.com>
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
