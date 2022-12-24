Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AF5655ABE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 17:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiLXQgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 11:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiLXQgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 11:36:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1461E108C;
        Sat, 24 Dec 2022 08:36:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4DD160A72;
        Sat, 24 Dec 2022 16:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5F4C433D2;
        Sat, 24 Dec 2022 16:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671899765;
        bh=0EIF4T19puak+3zPaJRrkSbrt6wgIvpIz8iwaG3dJ0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s+BFRJUSedEvY9T5lGayUDSkctnWHtfApja+MyvYVuDUmYA7wm8OiEbPxWCYSn5ul
         LO5XJ7Jw3m/XGi1mnR5tcus1XwySWF+hf0TM561w5rKVu9tHulwZqTwNa7Mb+cObG8
         9uvkb3WJtJfpT1XvgdNmN1J/988k+YnXJ/ZOyAn0c4fSaUbf4SQV2xt0caPfuRNGoZ
         8AS2N3PWPjFoxlroy9Z14MvUk+DlAV3BrvRO3FvMEMxEW0N9atIUgqLUcJF1ZNW4BQ
         z4ydc0GEXtR0U0FIaeW+U8B/+prc9CETEy+kpjDZ8jF/bY1QBFrvEMG+pl/aKqkRMQ
         iYwIJbTNUQ8tw==
Received: by pali.im (Postfix)
        id 2C2B8720; Sat, 24 Dec 2022 17:36:02 +0100 (CET)
Date:   Sat, 24 Dec 2022 17:36:02 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Maier <balagi@justmail.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH] pktcdvd: remove driver.
Message-ID: <20221224163602.6bqr32tkf2ulx6po@pali>
References: <20221224095353.w32xhmyzlft6qi4v@pali>
 <Y6bObzIoHrJMotI3@kroah.com>
 <20221224101139.sgvhr2n3pbrs4agm@pali>
 <Y6bvh48kTTzbMX6M@kroah.com>
 <20221224133425.vlcxbaaynihiom4a@pali>
 <Y6cXRbGUsarzoJEw@zn.tnic>
 <20221224154842.o4ngrwmskduowttm@pali>
 <Y6chm9khdG4pmNhN@zn.tnic>
 <20221224160055.ln3dbhx7dnut7dwi@pali>
 <Y6cma26FKzBQD8AN@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y6cma26FKzBQD8AN@zn.tnic>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 December 2022 17:18:51 Borislav Petkov wrote:
> On Sat, Dec 24, 2022 at 05:00:55PM +0100, Pali Rohár wrote:
> > Maybe it would be a wise to read a documentation which is in the kernel
> > source tree?
> 
> I guess you mean udftools...

Yes, pktcdvd tools (pktsetup, pktcdvd-check, cdrwtool) are (for
historical reasons) in udftools project. Ok, maybe it is unintuitive to
find them here but it is documented in kernel tree.

> > Or at least read the deletion patch itself as it is linked from there?
> 
> You mean the documentation file is pointed at there?

Yes. In Kconfig option which is being removed, is a documentation link

-	  See the file <file:Documentation/cdrom/packet-writing.rst>
-	  for further information on the use of this driver.

> > Or what else could be easier than this?
> 
> Well, apparently it ain't as easy because people do not necessarily see
> it how you see it. That's why I'm asking.

Yes, in more cases it is not easy. But in this case, when kernel in-tree
documentation about this driver was updated in the last year, it is lot
of easier than in other cases to get more information about it.

I sent this patch to keep links up-to-date for packet-writing.rst file:
https://lore.kernel.org/linux-doc/20220210192200.30828-1-pali@kernel.org/
(and it was merged)

In documentation are mentioned 3 projects which are related to packet
writing and all have valid homepages with contact information.

> I have removed ancient stuff in the past myself and it is not always
> easy to go dig out who uses it and whether it is used at all in the
> first place.
> 
> And people do not always reply and projects are dead and they maybe use
> it but the machine which has this hw hasn't been booted for a decade and
> it ain't worth the enegry to power it back on and so so on and so on...
> 
> So you don't have to get all worked up about it - if it is really used,
> I'm sure the maintainers involved will do the right decision. The point
> is, finding out whether something still has users and with the latest
> kernel is not always trivial.

I agree that finding out such information is hard. But do not take me
wrong, but if people are lazy and do not look into in-tree kernel
documentation and check it, then I'm loosing motivation to keep in-tree
kernel documentation up-to-date...
