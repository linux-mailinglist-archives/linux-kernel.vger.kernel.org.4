Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321236C6C46
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjCWP13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjCWP12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:27:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F1F26CDA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:27:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FFBF627AB
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:27:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47060C433D2;
        Thu, 23 Mar 2023 15:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679585244;
        bh=HJw0cYvbjKl3Ua+BCoBTtWSQ97hOTpIlh25Ayjfx9cM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ijk5XVCvrDtTs0EwpUQ+M8T0Hig7XIBUObjoPN6gM5vYYjAvQsv9PSV+O9UWLlOxQ
         /gX+rBs8oiHz6o15Zm+kTex9xFEzL/56dGkTWULucVjjBp3meJ6tPQwBr/YzxVDUYc
         C1FYNtQdzYNSDaf8x311Be09ydKGb3FzAe+Kfg5M=
Date:   Thu, 23 Mar 2023 16:27:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     Dan Carpenter <error27@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 0/4] staging: rtl8192e: code cleanup patches
Message-ID: <ZBxv2e1mkUJ5YRfG@kroah.com>
References: <cover.1679573474.git.kamrankhadijadj@gmail.com>
 <alpine.DEB.2.22.394.2303231408000.2866@hadrien>
 <alpine.DEB.2.22.394.2303231408410.2866@hadrien>
 <090ee842-46d0-4f35-bf00-68a3e1393b72@kili.mountain>
 <ZBxu5RBG9kCRlwRB@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBxu5RBG9kCRlwRB@khadija-virtual-machine>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 08:23:17PM +0500, Khadija Kamran wrote:
> On Thu, Mar 23, 2023 at 04:34:43PM +0300, Dan Carpenter wrote:
> > On Thu, Mar 23, 2023 at 02:08:58PM +0100, Julia Lawall wrote:
> > > 
> > > 
> > > On Thu, 23 Mar 2023, Julia Lawall wrote:
> > > 
> > > >
> > > >
> > > > On Thu, 23 Mar 2023, Khadija Kamran wrote:
> > > >
> > > > > Fix several cleanup issues reported by checkpatch.pl in module
> > > > > staging/rtl8192e in file rtllib_rx.c
> > > >
> > > > Why is it resent?
> > > 
> > > OK, I see, sorry for the noise.
> > 
> > I'm still confused...  :P
> >
> 
> Hey Dan!
> 
> Sorry about the confusion. I sent the last patch with the wrong email
> mistakenly. It was causing following warning as reported by Philipp,
> Checkpatch:
> 
> WARNING: From:/Signed-off-by: email address mismatch: 'From: Khadija
> Kamran <kkamran.bese16seecs@seecs.edu.pk>' != 'Signed-off-by: Khadija
> Kamran <kamrankhadijadj@gmail.com>
> 
> I resent this patch with the correct email address. I hope I did not do
> this wrong.

That would be a totally new version, as something changed, so document
it, otherwise we are confused.

thanks,

greg k-h
