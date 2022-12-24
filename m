Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA7F655B41
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 22:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiLXVRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 16:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiLXVR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 16:17:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6C4BF55;
        Sat, 24 Dec 2022 13:17:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83DF360B27;
        Sat, 24 Dec 2022 21:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5051DC433D2;
        Sat, 24 Dec 2022 21:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671916636;
        bh=mY/VWAfQF1bhkSpjc9GIhMWPcWvvJp+NigHVr9j8XE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CnO+gzU0DAzoUMNcBH4MKPCYlBGwVII/n/znreE4I55N2DdLTm1tT9fGg411ZgRhp
         A/LrOtjFzfWFtb42vaRo4U9hjTwf6wGPgKaRpyXHzkERVUxtMYdsr7TtfdCS6NXFgQ
         ITaHv1GzgdWRa3Ch7kh7/hmQcXtcWjcaB1lXAWaDfqfHfZg/GBUv/YLMrH7CVMLVvJ
         Om1DhwJhY4W5D4uEZbWQlRN59Im7eeeJc5eMMwgaZCjGun645VJSZ5aVEJj+k+8NBE
         O9IWvZkq81mFiEqp8BNQ1qMnHG6aLpDmX4/QVCQL9lvUZ7Qw7+QHiPomgQD1Y5A+N5
         bJDL/3S4r8wfQ==
Date:   Sat, 24 Dec 2022 14:17:13 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Maier <balagi@justmail.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH] pktcdvd: remove driver.
Message-ID: <Y6dsWVspi9tGNid5@kbusch-mbp.dhcp.thefacebook.com>
References: <Y6bObzIoHrJMotI3@kroah.com>
 <20221224101139.sgvhr2n3pbrs4agm@pali>
 <Y6bvh48kTTzbMX6M@kroah.com>
 <20221224133425.vlcxbaaynihiom4a@pali>
 <Y6cXRbGUsarzoJEw@zn.tnic>
 <20221224154842.o4ngrwmskduowttm@pali>
 <Y6chm9khdG4pmNhN@zn.tnic>
 <20221224160055.ln3dbhx7dnut7dwi@pali>
 <Y6cma26FKzBQD8AN@zn.tnic>
 <20221224163602.6bqr32tkf2ulx6po@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221224163602.6bqr32tkf2ulx6po@pali>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 24, 2022 at 05:36:02PM +0100, Pali Rohár wrote:
> On Saturday 24 December 2022 17:18:51 Borislav Petkov wrote:
> > 
> > So you don't have to get all worked up about it - if it is really used,
> > I'm sure the maintainers involved will do the right decision. The point
> > is, finding out whether something still has users and with the latest
> > kernel is not always trivial.
> 
> I agree that finding out such information is hard. But do not take me
> wrong, but if people are lazy and do not look into in-tree kernel
> documentation and check it, then I'm loosing motivation to keep in-tree
> kernel documentation up-to-date...

As a matter of procedure, could patches deprecating modules perhaps add
a loud kernel warning message somewhere in the module's execution path
as a means to mitigate any surprises for people using it?
