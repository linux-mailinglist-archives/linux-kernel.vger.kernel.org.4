Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484B57078DF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 06:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjERESH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 00:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjERESD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 00:18:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206733AAA
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 21:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1UkRTnG9pt6yTIbXf3r4jh/iUhSYo0Jwhlp1pCFdysI=; b=LWFDjkjUZKOq8y6q3gRj1JW562
        8uttjI6RmyASXiTbM28Utd0s5L1eo8oj+cBPbbB/MY9xku4WS2v8GlvSWPNN+qqqvr4Hz5zHkQUEk
        wrYYz0ApZLr/6ice3HaIAZ9YAFyN0/FNlbxFClqUAoAYb7ougzFT8LZW/M/9Mr1YggC1pYSNtS1Lm
        jOtj3Pp3hj02A1piTzquQkisWhGUljF17TgDT/huew9Lirv/hHj+FqHmgyK61867cCn3IFYcC37lC
        6WdwRDseDMNn1ItuZ14ru/jOTrZiZV+hMtndK5dAoL/i9XC1sgkWzQQ92s2I7j5lSZduRbUXRYLvj
        Jkh4FYXw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzV5K-00Bpgb-0E;
        Thu, 18 May 2023 04:17:50 +0000
Date:   Wed, 17 May 2023 21:17:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Actions <linux-actions@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Jan Kara <jack@suse.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH 0/2] SPDX conversion for UDF
Message-ID: <ZGWm7oCXr69jGOlp@infradead.org>
References: <20230517083344.1090863-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517083344.1090863-1-bagasdotme@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shouldn't this include a Cc to the linuxx-spdx list, especially for
a review of the odd ecma_167.h clause?
