Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C986FBD65
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 04:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbjEICzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 22:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjEICzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 22:55:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7766EAE;
        Mon,  8 May 2023 19:55:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC6016303D;
        Tue,  9 May 2023 02:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7851C433D2;
        Tue,  9 May 2023 02:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683600945;
        bh=CpcFqEn4l728jFTkOQcRAHGWiKRaoD8C3B3dGVlVjPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gAR59cDXIMa19ybM7Dtb32/LO/67xYUmuXAMuNjegRWGg4pBc61bU9SBJOWxhZrdt
         ENe6GKL6cGMn4iz7dxnHvAId4bndQ3IbCAMDyo/ZIV9T7iZDUr6/kwhy3ptn2S7bip
         Jxe82z54BDSBHZS/Iy2XVq8z7yrTSuDeaOTV/4b4=
Date:   Tue, 9 May 2023 04:55:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Ronald Warsow <rwarsow@gmx.de>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: no sha256sum for 6.3.1 (was Re: Linux 6.3.1)
Message-ID: <2023050935-unsent-septic-34b7@gregkh>
References: <f0497747-2318-7355-6ea6-ff01f9eb97ef@gmx.de>
 <2023050617-stardom-granola-32e3@gregkh>
 <20230508-length-distress-784870@meerkat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508-length-distress-784870@meerkat>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 01:01:07PM -0400, Konstantin Ryabitsev wrote:
> On Sat, May 06, 2023 at 09:38:35AM +0900, Greg KH wrote:
> > > fetching new kernels via script:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/mricon/korg-helpers.git/tree/get-verified-tarball
> > > 
> > > it seems
> > > https://cdn.kernel.org/pub/linux/kernel/v6.x/sha256sums.asc
> > > 
> > > doesn't contain a hash for 6.3.1
> > 
> > Yeah, that does look odd.
> > 
> > Konstantin, I think you said you updated some things on the servers
> > right after I did the 6.3.1 release, would this have caused the
> > signature to not be recorded in this file?
> 
> Sorry, this got fixed last week. I forgot to mount the key storage after the
> final reboot. It should be all good now.

I see it there, now, thanks!

greg k-h
