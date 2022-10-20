Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C599C6057E0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiJTHHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiJTHHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:07:40 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0888D14C534
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:07:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9CF04CE2509
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 07:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3C6C433D6;
        Thu, 20 Oct 2022 07:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666249655;
        bh=5vrQ4C20DD+nj92Hyn6OUvjArtEEknzGS96jSH4NC0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bmHHsZRgVyHSnkW6USsjrxMMUPRPSHUZY7Rxz4tTj+AH6sAs5GsbqEHFGz+jMIzny
         tJ2yE3N5AHmb3PYooOD55UMFunqnPNl16draY60edNReC9KI71Ko6CX3PzswPnAVTA
         idVMfTj3mMw79OuT4z5ULXFkC/ZG+MmQdQHkRBJw=
Date:   Thu, 20 Oct 2022 09:07:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Emily Peri <eperi1024@gmail.com>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: rtl8723bs: fix white space warnings
Message-ID: <Y1DztSHmsjFWpXJy@kroah.com>
References: <cover.1666230736.git.eperi1024@gmail.com>
 <45558673b486808e7978e2e4838c6ce5a2485b8b.1666230736.git.eperi1024@gmail.com>
 <Y1DVH+UatalfjDN5@kroah.com>
 <Y1DcimyMZwkSDm+C@marshmallow>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1DcimyMZwkSDm+C@marshmallow>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 10:28:42PM -0700, Emily Peri wrote:
> On Thu, Oct 20, 2022 at 06:57:03AM +0200, Greg KH wrote:
> > On Wed, Oct 19, 2022 at 07:10:51PM -0700, Emily Peri wrote:
> > > Fix the following checkpatch warnings in rtw_ioctl_set:
> > > 1) Add missing blankline after declaration
> > > 2) Replace spaces used for indent with tab
> > > 3) Remove space before tab
> > 
> > When you have to list the different things you do, you should really
> > break that up into individual patches.  This should be 3.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Thanks greg for the feedback! I got the idea to put them all in the same
> patch from the PatchPhilosophy guide, which suggested combining a bunch
> of white space corrections into one commit. But, it sounds like I
> misinterpreted what the guide was saying. Maybe if there are identical
> warnings, such as "trailing white space" in the driver code, could those
> corrections go together in a single patch?
> 

Yes, you are correct, you could do a "fix all trailing whitespace in
this file" in one patch.

thanks,

greg k-h
