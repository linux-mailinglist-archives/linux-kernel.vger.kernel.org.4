Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D5F6827D0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjAaI6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjAaI6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:58:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFF550857;
        Tue, 31 Jan 2023 00:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PSgTNOXeCkqiZRLaVHTFK7t9OD/eqWirEYTJ2eqLpI4=; b=y8eeER7HCXnTkU9vifq/pdN/Af
        nl6O8WHFFZpFrAguYUrScJ7P8P43DVAHBHIQDaFN8aA5UMIWOmEuxKeracudoxkva8XNhK1F9JTmq
        ebXBnu0VMtbjYRqnvWmBsO2NezZn//sPtkU9N/r0+FXBjEu6u1c8+ABJX7J5PMEGAmQmv5ZXJSosb
        O7wUWSjxfne3Q9TCC+VKAf3iNVtvkPOTFduYQrWmAS66hahdUK6HlMm8D+P0KsbFrWBErA9ZXY4oS
        FTXEaRH+h8HXBfNFGK5Wo4kHgrzrdkD9GnncL8XBnel5ROmySk9LiNXOhC/4FG2/G8SVqOVdOy9Qf
        1N+Pml2w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMmNz-006rTv-JY; Tue, 31 Jan 2023 08:53:03 +0000
Date:   Tue, 31 Jan 2023 00:53:03 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] block: Support creating a struct file from a
 block device
Message-ID: <Y9jW73uAtE3HdCou@infradead.org>
References: <20230126033358.1880-1-demi@invisiblethingslab.com>
 <20230126033358.1880-2-demi@invisiblethingslab.com>
 <Y9d692WEX/ZvBhXI@infradead.org>
 <Y9gZAJGgdjFtsm9I@itl-email>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9gZAJGgdjFtsm9I@itl-email>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 02:22:39PM -0500, Demi Marie Obenour wrote:
> What do you recommend instead?  This solves a real problem for
> device-mapper users and I am not aware of a better solution.

You could start with explaining the problem and what other methods
you tried that failed.  In the end it's not my job to fix your problem.
I generally gladly help, but this kind of attitude doesn't get very
far.
