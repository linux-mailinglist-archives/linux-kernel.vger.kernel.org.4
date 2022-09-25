Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E7D5E9171
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 09:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiIYHaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 03:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiIYHaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 03:30:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A082C648;
        Sun, 25 Sep 2022 00:30:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27BDA61286;
        Sun, 25 Sep 2022 07:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3348EC433C1;
        Sun, 25 Sep 2022 07:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664091011;
        bh=iHRwgtpmT8IOWrtRKXFWjHHFf8cC5eSWZNDQ46u7lkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L8iLcT9YrvZ6U1Y8EHOZSd0t9aAPlFrk/7pq2p9L2SXPckKU7KuCK0/x/Ex1f7CJX
         spXdJ4EaMaLX5dpenuj4WZdwOM1ibJRrDLh3WkekhmmNbwEQnV1NxlvO2WNDf207d8
         za7CQyuAZlGGYU8xWIDb8LpeWW/2SVxGBTTBWRJ4=
Date:   Sun, 25 Sep 2022 09:28:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_dma: Convert to use
 uart_xmit_advance()
Message-ID: <YzADGdooXnOPygdK@kroah.com>
References: <20220909091102.58941-1-andriy.shevchenko@linux.intel.com>
 <Yyxs8o7tB6BVS0Kt@kroah.com>
 <1ae6a32c-9f3d-ee56-a26a-7a90b4ee2bfe@linux.intel.com>
 <YyxySWYgJ7ceavcM@kroah.com>
 <Yyx5KGjVgyiasqyv@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yyx5KGjVgyiasqyv@smile.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 06:03:04PM +0300, Andy Shevchenko wrote:
> On Thu, Sep 22, 2022 at 04:33:45PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Sep 22, 2022 at 05:24:55PM +0300, Ilpo Järvinen wrote:
> > > On Thu, 22 Sep 2022, Greg Kroah-Hartman wrote:
> > > > On Fri, Sep 09, 2022 at 12:11:02PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > > > Breaks the build :(
> > > 
> > > I'd guess it's because uart_xmit_advance() is current only in tty-linus,
> > > not in tty-next.
> > 
> > Probably, can someone resend this when 6.1-rc1 is out?
> 
> Sure.

Nevermind, I took them now, thanks.

greg k-h
