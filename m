Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9522465CE39
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbjADI0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjADI0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:26:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16BE29B;
        Wed,  4 Jan 2023 00:26:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49EC8615A8;
        Wed,  4 Jan 2023 08:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416E0C433EF;
        Wed,  4 Jan 2023 08:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672820772;
        bh=cQUoRiARdu/+zOek7DKostZX30DSNt2xnSAkBlA+3+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GZOtbdTWj2ISTao9FEwwzOrYZQSuYM6WDPiMerh8GF6dG2/Ezx28MjEdo8OLHxfLO
         0RkPuQjBAu4EuuLMO93AP9WCQCCYP5Uyd4dEZ5IKqD0OaziF0hH1qvh9dVnCgM+uMh
         yhB1J4/5S/DJ6+jthlwC/l+G3CUbMdp6MYVl0l04=
Date:   Wed, 4 Jan 2023 09:26:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 0/2] fix out-of-bounds access when specifying invalid
 console
Message-ID: <Y7U4IZQaEEoHfhM7@kroah.com>
References: <20221209112737.3222509-1-svens@linux.ibm.com>
 <yt9dh6x6n4tq.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dh6x6n4tq.fsf@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 08:20:49AM +0100, Sven Schnelle wrote:
> Sven Schnelle <svens@linux.ibm.com> writes:
> 
> > Hi,
> >
> > these two patches fix a crash in the tty driver when a user specifies an
> > invalid console like 'console=tty3000'. The first patch adds a check to
> > tty_driver_lookup_tty(), the second one prevents that such a console gets
> > registered in the vt driver.
> >
> > Changes in v2:
> > - trim commit message in first patch
> > - add second patch as suggested by Jiri Slaby
> >
> > Sven Schnelle (2):
> >   tty: fix out-of-bounds access in tty_driver_lookup_tty()
> >   tty/vt: prevent registration of console with invalid number
> >
> >  drivers/tty/tty_io.c | 8 +++++---
> >  drivers/tty/vt/vt.c  | 6 ++++++
> >  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> Gentle ping... I couldn't find that this was applied anywhere?

It's in my to-review queue, which is about 2000+ patches right now, give
me some time to dig it out.  In the meantime, please feel free to review
other pending patches on the list to help out with the workload.

thanks,

greg k-h
