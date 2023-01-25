Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C332C67B288
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 13:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbjAYMXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 07:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbjAYMWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 07:22:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B70A72BD;
        Wed, 25 Jan 2023 04:22:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 259F0B8199F;
        Wed, 25 Jan 2023 12:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A05C433D2;
        Wed, 25 Jan 2023 12:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674649368;
        bh=vWlk6Pf2n+qySYXb7Jo8S4jGyJymWOjnRGQIVh7XVy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lyGyLr8exeibpwwo7uart4zLX/2LvXCSzdZOrbS34B9uV0MFss8Dgkr5+q0bunFsO
         SC9JDdVGISelH6NYeZ4K0VEn1vf3uncQMfMSepGdPrtgUWJKyz/NwCf1vIcvak2YWF
         7ZnPq6lr8g6HKMOo8Xqi/cKsCVdpfTQHLY8akEMM=
Date:   Wed, 25 Jan 2023 13:22:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Viken Dadhaniya <vdadhani@qti.qualcomm.com>
Cc:     "Viken Dadhaniya (QUIC)" <quic_vdadhani@quicinc.com>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mukesh Savaliya (QUIC)" <quic_msavaliy@quicinc.com>,
        "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>,
        "Visweswara Tanuku (QUIC)" <quic_vtanuku@quicinc.com>,
        "Aniket RANDIVE (QUIC)" <quic_arandive@quicinc.com>
Subject: Re: [PATCH V1 1/1] Serial: core: Add compat ioctl support
Message-ID: <Y9EfFQ33Mpms3tTF@kroah.com>
References: <20221222044925.27846-1-quic_vdadhani@quicinc.com>
 <Y6Pv5WWtM63DwCAl@kroah.com>
 <PH0PR02MB7431B1CA343760B422D34B97EBCE9@PH0PR02MB7431.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR02MB7431B1CA343760B422D34B97EBCE9@PH0PR02MB7431.namprd02.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 11:27:49AM +0000, Viken Dadhaniya wrote:
> Hi Greg,
> 
> Please find response inline.

As they should be :)

> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Thursday, December 22, 2022 11:19 AM
> > To: Viken Dadhaniya (QUIC) <quic_vdadhani@quicinc.com>
> > Cc: jirislaby@kernel.org; linux-serial@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Mukesh Savaliya (QUIC) <quic_msavaliy@quicinc.com>;
> > Vijaya Krishna Nivarthi (Temp) (QUIC) <quic_vnivarth@quicinc.com>; Visweswara
> > Tanuku (QUIC) <quic_vtanuku@quicinc.com>; Aniket RANDIVE (QUIC)
> > <quic_arandive@quicinc.com>
> > Subject: Re: [PATCH V1 1/1] Serial: core: Add compat ioctl support

That's horrible, please fix your email client.

> > How was this tested?  What is currently broken that now works properly (or the
> > other way around?)
> >
> 
> We are running 32-bit user-space application on 64-bit kernel, and vendor specific ioctl command issued by application is not reaching the vendor driver.
> Without these changes, the IOCTL call was returning from the tty framework rather than reaching to the vendor driver. IOCTL call is successfully reaching the vendor uart driver via tty framework after adding compat ioctl and functionality is working as expected and below is the dump stack with compat ioctl.

What in-kernel tty ioctl is having a problem that a compat ioctl layer
is needed?  Let's fix that up.

As you know, we can't do anything about out-of-tree drivers.  Nor do you
want us to, so this really feels like a broken driver, it should NOT be
creating random new ioctls on the tty device node, that is NOT what it
is there for.

> [ 1265.554002] Hardware name: Qualcomm Technologies, Inc. Monaco IDP V1.0 (DT)
> [ 1265.554008] Call trace:
> [ 1265.554011] dump_backtrace.cfi_jt+0x0/0x8
> [ 1265.554023] show_stack+0x1c/0x2c
> [ 1265.554032] dump_stack_lvl+0x80/0xc8
> [ 1265.554041] dump_stack+0x1c/0x2c
> [ 1265.554049] msm_geni_serial_ioctl+0x2cc/0x3d0 [msm_geni_serial]

This function is not in our kernel tree, so it looks to be a bug in that
driver, sorry.  Do NOT paper over out-of-tree driver bugs in the core
kernel (hint, are you sure you are even allowed to do that?)

> [ 1265.554099] uart_ioctl+0x1a4/0x1d8
> [ 1265.554109] uart_compat_ioctl+0x14/0x28
> [ 1265.554117] tty_compat_ioctl+0x1a8/0x2dc
> [ 1265.554125] __arm64_compat_sys_ioctl+0x158/0x1d0
> [ 1265.554132] invoke_syscall+0x60/0x150
> [ 1265.554140] el0_svc_common.llvm.3148309083493694862+0xc8/0x114
> [ 1265.554148] do_el0_svc_compat+0x20/0x30
> [ 1265.554154] el0_svc_compat+0x28/0x90
> [ 1265.554162] el0t_32_sync_handler+0x7c/0xbc
> [ 1265.554169] el0t_32_sync+0x1b8/0x1bc
>  
> > This patch implies that _every_ driver with an ioctl must create a
> > compat_ioctl() callback, are you sure that is the case?
> > 
> 
> this depends on user application and kernel version. for 32-bit application to run on 64-bit kernel, compat_ioctl is requried.

Again, what in-tree tty ioctls are affected by this?

thanks,

greg k-h
