Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D14732701
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 08:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241912AbjFPGDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 02:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjFPGDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:03:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CBD2D5F;
        Thu, 15 Jun 2023 23:03:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2014861324;
        Fri, 16 Jun 2023 06:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5379C433C0;
        Fri, 16 Jun 2023 06:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686895418;
        bh=sgWs5bg47oqHbVFZQ6HyP0Wx0LjaMMrwADN/KT9dvBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rkw9n0v/cgDY3PF89cpAUnhgcWU3+lFX7lx+Fw3bU3CmS3ReWVzyQ+R5G+kPUmSV6
         EDCYxnU3t4nFLp3tUOM+R+l8EpjsUz5vixB73IzhNctyn5xCTSmMcEKhxKO66DPE89
         zgKGZmX2umyMglVG9utYQY8hrsPzMjxCdeiOQvcE=
Date:   Fri, 16 Jun 2023 08:03:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hongyu Xie <xiehongyu1@kylinos.cn>
Cc:     linux@armlinux.org.uk, jirislaby@kernel.org, corbet@lwn.net,
        rdunlap@infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, xy521521@gmail.com,
        oe-kbuild-all@lists.linux.dev, lkp@intel.com, bagasdotme@gmail.com
Subject: Re: [RESEND PATCH v4 -next] tty: serial: add panic serial helper
Message-ID: <2023061606-hunk-overdraft-8d04@gregkh>
References: <20230614025512.27746-1-xiehongyu1@kylinos.cn>
 <2023061502-submerge-preachy-4413@gregkh>
 <fbfbbad5-2418-5c1a-87f1-dc2ca20204aa@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fbfbbad5-2418-5c1a-87f1-dc2ca20204aa@kylinos.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 10:31:15AM +0800, Hongyu Xie wrote:
> 在 2023/6/15 18:17, Greg KH 写道:
> > On Wed, Jun 14, 2023 at 10:55:12AM +0800, Hongyu Xie wrote:
> > > It was inspired by kgdboc.
> > > 
> > > This is a debug module that allows you to get all kernel logs
> > > after panic.
> > > 
> > > Normally you need to attach a USB-to-UART tool or enable kdump
> > > before panic happens to get log from kernel after panic. If you
> > > didn't do that and kdump is not working, you can't get any log to
> > > know what happened before panic. If you have a USB-to-UART tool
> > > and the UART port on your computer is working. This module helps
> > > you to get all kernel log after panic() is called.
> > > 
> > > To use this, see Documentation/dev-tools/panic_serial_helper.rst.
> > > 
> > > Tested on an arm64 device.
> > > 
> > > Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
> > > ---
> > 
> > Why  is this a RESEND?  What's wrong with the previous version?
> Nobody review v4 for over a week.

That's fine, but you need to say _why_ this is being resent, otherwise
we have no idea, and this just moves to the bottom of our review queue.

thanks,

greg k-h
