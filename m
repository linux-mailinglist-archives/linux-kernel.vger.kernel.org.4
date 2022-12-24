Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D5B6559BE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 11:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiLXKDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 05:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiLXKDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 05:03:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A9A959C;
        Sat, 24 Dec 2022 02:03:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2336C60A51;
        Sat, 24 Dec 2022 10:03:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88AC9C433EF;
        Sat, 24 Dec 2022 10:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671876211;
        bh=z6vauG+yojR9tbLySl4qCSuCZDdhNY6BicAY/0AR/F4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PAOFPg1uBW5rirxza7Yxw7WAAFk0EndQBF5GVm40h622S95uOXZhYWNJ03VEoLycy
         OQhow8DDZgfr/TcrzervVwVMOAaJ/DCrNVPyaZLH/QkCohh+zWk4Xpf78lNXdoJ5CL
         I7QUQq/alo2REEkH+9L0XjvwmcWo5fDOxwGrvQSc=
Date:   Sat, 24 Dec 2022 11:03:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Maier <balagi@justmail.de>,
        Peter Osterlund <petero2@telia.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] pktcdvd: remove driver.
Message-ID: <Y6bObzIoHrJMotI3@kroah.com>
References: <20221202182758.1339039-1-gregkh@linuxfoundation.org>
 <20221224095353.w32xhmyzlft6qi4v@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221224095353.w32xhmyzlft6qi4v@pali>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 24, 2022 at 10:53:53AM +0100, Pali Rohár wrote:
> On Friday 02 December 2022 19:27:58 Greg Kroah-Hartman wrote:
> > Way back in 2016 in commit 5a8b187c61e9 ("pktcdvd: mark as unmaintained
> > and deprecated") this driver was marked as "will be removed soon".  5
> > years seems long enough to have it stick around after that, so finally
> > remove the thing now.
> 
> Why to remove? This driver is still widely used, userspace in active
> maintenance and in last two years userspace software received more fixes
> for CD-RW support and pktcdvd.

It was marked as "please remove" back in 2016, why wasn't that changed
if people were actually using this?

> Just now community person informed me that somebody is going to remove
> kernel support.

Isn't there better ways to support the hardware needed than this driver?

thanks,

greg k-h
