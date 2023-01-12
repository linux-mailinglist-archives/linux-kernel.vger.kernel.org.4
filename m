Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C48667ED4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbjALTOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240702AbjALTOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:14:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07660C21;
        Thu, 12 Jan 2023 11:03:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9784B6215D;
        Thu, 12 Jan 2023 19:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA97C433D2;
        Thu, 12 Jan 2023 19:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673550193;
        bh=KlKqclW0OKM9LQ5zaFLdxIt7Q4jNRrSX1/G9FRtg6pQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FtGmRGZ3nu1AjjsSjkTvnxAmXlZd0G4mkRUDoEjQ+svG3rlBm7eaVtirWN5YjDlq0
         JKs52M7rXMhKCdjqFxKTWxJ3siucXP/SKari6+C82FprwboNL0Pu1rE5ZBiyZSiUQD
         yE4WUrBUM7WkwbJlhr7ZUzajY+SFOTAL6sl9ee6w=
Date:   Thu, 12 Jan 2023 20:03:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-kernel@vger.kernel.org, pabeni@redhat.com,
        slipper.alive@gmail.com, stable-commits@vger.kernel.org
Subject: Re: Patch "net/ulp: prevent ULP without clone op from entering the
 LISTEN status" has been added to the 5.4-stable tree
Message-ID: <Y8BZboDOQ1I+VTAC@kroah.com>
References: <16735310493146@kroah.com>
 <Y8AP6Lqo9sfX9Bb8@kroah.com>
 <20230112105731.0da81d58@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112105731.0da81d58@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 10:57:31AM -0800, Jakub Kicinski wrote:
> On Thu, 12 Jan 2023 14:49:28 +0100 Greg KH wrote:
> > On Thu, Jan 12, 2023 at 02:44:09PM +0100, gregkh@linuxfoundation.org wrote:
> > > 
> > > This is a note to let you know that I've just added the patch titled
> > > 
> > >     net/ulp: prevent ULP without clone op from entering the LISTEN status
> > > 
> > > to the 5.4-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary  
> > 
> > Oops, nope, this broke the build for 5.4 and older kernels, now
> > dropping.
> 
> There's no clone op, right?

Correct.

> If you're willing to futz with it I think
> you just need to remove the "and the ops don't have ->clone" part of
> the conditions. Any presence of ops on older kernels should make us
> bail.

Ok, that should not be hard, I'll try messing with that tomorrow on the
train...

thanks,

greg k-h
