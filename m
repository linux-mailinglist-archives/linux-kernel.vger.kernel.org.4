Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DAA73F46C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 08:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjF0GVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 02:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjF0GVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:21:16 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3588D1FC7;
        Mon, 26 Jun 2023 23:21:14 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 735B36732D; Tue, 27 Jun 2023 08:21:10 +0200 (CEST)
Date:   Tue, 27 Jun 2023 08:21:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>,
        Min Li <min15.li@samsung.com>, axboe@kernel.dk,
        willy@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: add check that partition length needs to be
 aligned with block size
Message-ID: <20230627062110.GA18485@lst.de>
References: <CGME20230627031105epcas5p3010432ebd447ad865c3ddd986b3ffee0@epcas5p3.samsung.com> <20230627110918.7608-1-min15.li@samsung.com> <8ea3bdfb-f2d9-ee5e-f623-02b2b134490d@kernel.org> <20230627045924.GA16913@lst.de> <2023062753-speech-straw-f2f6@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023062753-speech-straw-f2f6@gregkh>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 08:18:32AM +0200, Greg KH wrote:
> > No, the lack of checks goes back all the way to when this code was
> > added long before git was a thing.  So I don't think a Fixes tag makes
> > all that much sense here.
> 
> Ok, then how about a normal "cc: stable@kernel.org" added to the s-o-b
> area so it gets picked up for all stable trees as this is an issue that
> has always been there?

Yes, that sounds sensible.
