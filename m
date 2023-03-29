Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268386CF7B8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 01:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjC2Xuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 19:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjC2Xuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:50:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B40F1722
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 16:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oyV0m3hpkmf/Omm6/ygnd+OzLKd+xn/T/2Yt4qkeb2k=; b=ut3ZlDnM9Hqib8b5Mnhg6DPxVR
        rjn8vcgXe5a0tG7JKoL9mXfvZCmeGwjNbW4L+8TkhU93oF65YHQ+w9o81Kp9AcfZ2Apb6yE0Z2O6o
        dzm0hLjC/dGvFXrXQv+G2h5fWhzQ1OVd/5jvxPQ02Pp//34vEAQ5tZ7F96wgyhJXOQrLcyX/Ire3x
        cr1CXYZct8x4ArTXQBcqitMME3vF/FjuYqPFMRhbgS0TPmfAx1D9RJSgXXIV2U9Jhel6woa/WNkGt
        ydC4Mkqsk3QxqgZqP0BZf7Iw6Hge5ZpNptkKcLSDA6InfbUHpJkT+qAY8OvKwyYvb8WT49jmGc2kh
        +Drr07Ig==;
Received: from [182.171.77.115] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phfYl-0026AV-0g;
        Wed, 29 Mar 2023 23:50:31 +0000
Date:   Thu, 30 Mar 2023 08:50:28 +0900
From:   Christoph Hellwig <hch@infradead.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Desnes Nunes <desnesn@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        noreply@ellerman.id.au, Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH -next] dma-debug: Use %pa to format phys_addr_t
Message-ID: <ZCTOxOGDPoJoZDNW@infradead.org>
References: <20230329071405.1568021-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329071405.1568021-1-geert+renesas@glider.be>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've applied this as it is the first fix I got into my mailbox for it.

Arnd sent one a little later, which uses %pap instead of %pa, which
confused me a bit.  The documentation seems to allow both without
any recommendation which one to use, which confuses me even further.
