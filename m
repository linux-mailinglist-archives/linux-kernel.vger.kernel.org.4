Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEC664C46C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 08:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237518AbiLNHge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 02:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237448AbiLNHg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 02:36:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807BB17887;
        Tue, 13 Dec 2022 23:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xtGvJqv66/ykz3Qr+8aO2CCnJRTrBf9OElRV5HVQD5s=; b=SE911BZ3UA6Yo4AgZabvT2JlJk
        ey9p6bLwgLHJmIhDSByJxP0gKo7CfhBEMbdmfTVIVyBqBh+ljnr/JHDbqQ6kPU/Ee8wlNKRceDvsO
        lvc2jid9Y991G+1xrtHH3GpfRC4tci1/TNwmIj4gkkYudfS58t+S+KL0IXYLgzNq7ny4DvBIox4nR
        zSLQKzzls8gnVLgVF/E02dc1w81F/SDwDp0HtbT6+YApwrIPCD7uYHcCMaL8R2Mdo+bphd5Rt4LQX
        DAX+FO9bj38O8XALTAlaIRT8AkXYvJWg9pkeM8i66J8Ca8qHThw0XY42FJdF1DwIFtw6PjIYDkNO/
        SewNhnZw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5MJU-00E5uD-2f; Wed, 14 Dec 2022 07:36:24 +0000
Date:   Tue, 13 Dec 2022 23:36:24 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Puma Hsu <pumahsu@google.com>
Cc:     gregkh@linuxfoundation.org, mka@chromium.org,
        dianders@chromium.org, albertccwang@google.com, raychi@google.com,
        howardyen@google.com, leejj@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: core: add vendor hook for usb suspend and resume
Message-ID: <Y5l8+AaumAIUQ6gu@infradead.org>
References: <20221214070650.703793-1-pumahsu@google.com>
 <20221214070650.703793-2-pumahsu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214070650.703793-2-pumahsu@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one gives a rats ass about the "vendor".  If at all the
implementation matters, and for that you better send along the
implementation so that people can actually review this.
