Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534B060594C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiJTIFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiJTIE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:04:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122DF40E24;
        Thu, 20 Oct 2022 01:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=EUAzoil1vZTBa6Cx57WTSTe+zj
        THVDVUczxcRPGENZVTxxr4FWh4AqsMYfZH6EjKcMDooZchXpaGFYGNwLlhUXlss4dkOi3r5GoZlxL
        6zZIuYwlP8jCmxEgbDSUNUtmkitk7+02QkGq7cupe2dRktAURDOojBWwsv0j1H0yCyAyQNqDLKaVf
        N5fT3aFYsGYx3To++LhcXP8vrIUYDAFekzs/oQskAyIljlYp+TB3UFy/zJtVWRRVvBj6U32AaqGGG
        0Pz/MgeI0lTGFQQ9R/ksFQCPY5sVs/245f1HxpBZEZzHnz712e5BC4vD+Ta1wKh7tCq4/hcTwaIBh
        rHid3WhQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olQXu-00C3dk-8K; Thu, 20 Oct 2022 08:04:54 +0000
Date:   Thu, 20 Oct 2022 01:04:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH v3 3/3] blktrace: remove unnessary stop block trace in
 'blk_trace_shutdown'
Message-ID: <Y1EBJk/y6o/EAN9c@infradead.org>
References: <20221019033602.752383-1-yebin@huaweicloud.com>
 <20221019033602.752383-4-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019033602.752383-4-yebin@huaweicloud.com>
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
