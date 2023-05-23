Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22D570E3CD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237610AbjEWQvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbjEWQvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:51:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893B9C2;
        Tue, 23 May 2023 09:51:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20D1F61958;
        Tue, 23 May 2023 16:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9238C433D2;
        Tue, 23 May 2023 16:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684860673;
        bh=izyCzL7IxwPYSjQwQ4VWfRTuDpLIk4BkEayJvTPAB30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hdwimHNYQj4/yfHUvCqQHWJ7pdOeKTJr3fgpcgipgCBE5cCa+XCbuw5ynPX36VGRX
         fCMZqBEKsN2QxuqQB7eAvhVLxWfLu1uXRcbz6XSLy9spqOqxvLRbBofaNBsr9sJ4KQ
         2p2WxzsirgoAt6Efvl3ptSis04HcN920XuKNBjb4=
Date:   Tue, 23 May 2023 17:51:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chris Paterson <Chris.Paterson2@renesas.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "patches@kernelci.org" <patches@kernelci.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "pavel@denx.de" <pavel@denx.de>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>,
        "srw@sladewatkins.net" <srw@sladewatkins.net>,
        "rwarsow@gmx.de" <rwarsow@gmx.de>
Subject: Re: [PATCH 6.3 000/364] 6.3.4-rc1 review
Message-ID: <2023052357-deepen-celery-bdd5@gregkh>
References: <20230522190412.801391872@linuxfoundation.org>
 <OSBPR01MB3783F0D4C6006FFF6DF9AA28B7439@OSBPR01MB3783.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB3783F0D4C6006FFF6DF9AA28B7439@OSBPR01MB3783.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 08:29:05PM +0000, Chris Paterson wrote:
> Hello Greg,
> 
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Monday, May 22, 2023 8:05 PM
> > 
> > This is the start of the stable review cycle for the 6.3.4 release.
> > There are 364 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 24 May 2023 19:03:25 +0000.
> > Anything received after that time might be too late.
> 
> I'm seeing a few build failures with Linux 6.3.4-rc1 (20efcce0526d) due to the drivers/usb/host/xhci.c driver:
> 
> drivers/usb/host/xhci.c:497:19: error: static declaration of 'xhci_try_enable_msi' follows non-static declaration
>   497 | static inline int xhci_try_enable_msi(struct usb_hcd *hcd)
>       |                   ^~~~~~~~~~~~~~~~~~~
> In file included from drivers/usb/host/xhci.c:22:
> drivers/usb/host/xhci.h:2146:5: note: previous declaration of 'xhci_try_enable_msi' was here
>  2146 | int xhci_try_enable_msi(struct usb_hcd *hcd);
>       |     ^~~~~~~~~~~~~~~~~~~
> 
> Example build failure: https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/4328533790#L2178
> Pipeline: https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/875108293
> 
> Commit 78887e3e5f00 ("xhci: Avoid PCI MSI/MSIX interrupt reinitialization at resume") adds the offending code.
> I'm only seeing this for the 6.3 rc.

Thanks, I've dropped the offending change and will push out a -rc2.

greg k-h
