Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83965661793
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 18:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjAHRhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 12:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235986AbjAHRhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 12:37:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30BAFCD6;
        Sun,  8 Jan 2023 09:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=4rQnjKTa+czAsHcefZh0EgRe3W
        SyhkngdSjy5Yooo7VIMsbhtWWNAoKh/VJdjGvPpWDZYDrrw3wsIJyifHVHl23UyG05rv5XWQaXlXX
        7HMxF5XAzH9AHKP6GDLw8YovQEPfBUH5K4VTTvxPzfRoCgdvcaL4cnr7UH1ldgQMOcLIy7C5bpaL7
        f/XUL/h57jJNicAqQ5LqDzbD452X/lOJGXB3fgi7N41xuDWisuig0qWjfz5u1L0j+YkQnaMQkSiq5
        09vdrRS+jia8dVxSiubXpjZa0dl1DA8QQrP/5ScUhYPJKEAQqUeUqcaVdfhy/Y42LjxnuBYWDSvoa
        SgCL5Wdg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEZbb-00Ef9F-1s; Sun, 08 Jan 2023 17:37:11 +0000
Date:   Sun, 8 Jan 2023 09:37:11 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] crypto: talitos - Remove GFP_DMA and add DMA alignment
 padding
Message-ID: <Y7r/RzTWsa6dGg4R@infradead.org>
References: <Y4nDL50nToBbi4DS@gondor.apana.org.au>
 <Y4xpGNNsfbucyUlt@infradead.org>
 <Y47BgCuZsYLX61A9@gondor.apana.org.au>
 <Y47g7qO8dsRdxCgf@infradead.org>
 <Y47+gxbdKR03EYCj@gondor.apana.org.au>
 <Y61WrVAjjtAMAvSh@gondor.apana.org.au>
 <Y651YoR58cCg3adj@gondor.apana.org.au>
 <Y66T1UCBTqBE6GQ4@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y66T1UCBTqBE6GQ4@gondor.apana.org.au>
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
