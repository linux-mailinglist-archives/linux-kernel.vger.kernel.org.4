Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9884E655A42
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 14:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiLXNeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 08:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiLXNec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 08:34:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259CCDF8E;
        Sat, 24 Dec 2022 05:34:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C33DBB8213E;
        Sat, 24 Dec 2022 13:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5EFC433EF;
        Sat, 24 Dec 2022 13:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671888869;
        bh=aDgytOpQqUONDbhmxvUr660jBiqpbJZQ2ZyExwDCdSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W0lb0dkD5iwNh97uBbfLpcjSWVWGVGkKUytZ89YCNOIBJczW40zyqLc+ByZm7iN63
         qddFAD2mQSW9J6ssBHZUowJlH9XkixuuDf2Ts7Cg1WFi0w1OEqCdMvFwSV/skIgVVc
         DRnaSE8QEY5E7z+JUj28ZCIcZOhu4dROx5kMsD9dX7YrEUVEY2U9hhD0R+Ccsmoagl
         5EpYUmCbR7RCMu3cPU8z1pc4pNpRKmgujjR3jNSfJdOnrvs9pSWAJDvwg5pTI4h9so
         GfOkryEBNqYMxE3qd6FvkFF/MDCcj9EoxSQiHLI3e34hBFxlCtWHB11ESLTqmtkabc
         R88+ThuYV7c/w==
Received: by pali.im (Postfix)
        id 12E3D720; Sat, 24 Dec 2022 14:34:26 +0100 (CET)
Date:   Sat, 24 Dec 2022 14:34:25 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Maier <balagi@justmail.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH] pktcdvd: remove driver.
Message-ID: <20221224133425.vlcxbaaynihiom4a@pali>
References: <20221202182758.1339039-1-gregkh@linuxfoundation.org>
 <20221224095353.w32xhmyzlft6qi4v@pali>
 <Y6bObzIoHrJMotI3@kroah.com>
 <20221224101139.sgvhr2n3pbrs4agm@pali>
 <Y6bvh48kTTzbMX6M@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y6bvh48kTTzbMX6M@kroah.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 December 2022 13:24:39 Greg Kroah-Hartman wrote:
> On Sat, Dec 24, 2022 at 11:11:39AM +0100, Pali Rohár wrote:
> > On Saturday 24 December 2022 11:03:27 Greg Kroah-Hartman wrote:
> > > On Sat, Dec 24, 2022 at 10:53:53AM +0100, Pali Rohár wrote:
> > > > On Friday 02 December 2022 19:27:58 Greg Kroah-Hartman wrote:
> > > > > Way back in 2016 in commit 5a8b187c61e9 ("pktcdvd: mark as unmaintained
> > > > > and deprecated") this driver was marked as "will be removed soon".  5
> > > > > years seems long enough to have it stick around after that, so finally
> > > > > remove the thing now.
> > > > 
> > > > Why to remove? This driver is still widely used, userspace in active
> > > > maintenance and in last two years userspace software received more fixes
> > > > for CD-RW support and pktcdvd.
> > > 
> > > It was marked as "please remove" back in 2016, why wasn't that changed
> > > if people were actually using this?
> > 
> > And how should I know it if I was informed about it just today?
> 
> Using the "Why was I not informed?" defense isn't usually the best way
> to discuss things when we have 800+ maintainers and 4000+ developers
> here :)

And asking question back is not the best way too.

> > > > Just now community person informed me that somebody is going to remove
> > > > kernel support.
> > > 
> > > Isn't there better ways to support the hardware needed than this driver?
> > 
> > Is there any other driver in kernel which provide block layer for it?
> > I do not know about any other.
> 
> What about the venerable sg.c driver (enabled with CONFIG_CHR_DEV_SG)?
> Does that not work properly for your specific hardware?

No, it is not a mountable rw block device suitable for CD-RW and DVD-RW.

> Anyway, have a nice holiday!
> 
> greg k-h
