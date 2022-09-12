Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235145B5AD6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 15:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiILNF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 09:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiILNFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 09:05:54 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2063125C4B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 06:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=R64HR0KrGmiwNZpIuE4KD+OwisrLI4ElftJ4XXe8mos=; b=hY9ofewwhZNIIYsV4huXDbLJZv
        e927eTa0EDN9+LxuNoEhkq98XSC7Kyjcr0W7H1frx9G2Of+0igm2sZPoWjyNVzcUAK/GHdMzaAiwV
        /YN9icfPuisPpwR7y7/ASk+ToQ/Ej0nJ9KG7sMP7JU3d2st+lw15GwA2bA00GdxaR1kZPTdWRXH6l
        r8/p3N6LTgxgZtD6JQBQ03LUxISLH1fYhmhZI/9Irmi3WvajeMoNVPb4Te/ELIdPMOH19CsrGuN7L
        d5c4YYk4MbYV0sIQR2qFACSu1ImXFula+cA6qgXddAyvZ/jyHB0jtwgrycSjGz23u3V8BjB94zLbB
        +Ow9/7+A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34262)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oXj8B-0001hu-WE; Mon, 12 Sep 2022 14:05:44 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oXj8A-00087m-0O; Mon, 12 Sep 2022 14:05:42 +0100
Date:   Mon, 12 Sep 2022 14:05:41 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     George Pee <georgepee@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Kirill A. Shutemov" <kirill.shtuemov@linux.intel.com>,
        Austin Kim <austindh.kim@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Report support for optional ARMv8.2 half-precision
 floating point extension
Message-ID: <Yx8upeabh9p6gGtY@shell.armlinux.org.uk>
References: <20220901141307.2361752-1-georgepee@gmail.com>
 <f765da5c-d484-adf2-e1bb-77011780dc0b@arm.com>
 <CAKj0CMv1EY5YCeQ4G6PnGP=XfELJkkN5BaN8W1TGe0fOTXfJBw@mail.gmail.com>
 <YxtIiBvAGs2vAl1P@arm.com>
 <CAKj0CMtkY_BSkAY3Lo5QbMDM1g0Wa9F8MsVuW0fyJiuPe3z4aA@mail.gmail.com>
 <YxtWUasndYl8syE1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxtWUasndYl8syE1@arm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 04:05:53PM +0100, Catalin Marinas wrote:
> On Fri, Sep 09, 2022 at 09:57:39AM -0500, George Pee wrote:
> > The details are here.  I originally thought it was a compiler bug
> > because it first showed up after a toolchain update.
> > 
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=106763
> > 
> > Since FP16 is an optional extension, wouldn't it be beneficial to a
> > user who compiled some userspace float16 code using gcc
> > -mcpu=cortex-a55 which ran on a cortex-a55 with FP16 extensions but
> > SIGILL'd on a cortex-a55 w/o FP16?
> 
> (please don't top-post)
> 
> My point is that if the kernel doesn't have full support for FP16, it
> shouldn't advertise it to user even if the hardware supports it. If you
> fix the kernel to properly handle FP16 on supporting hardware, then the
> HWCAP part is fine by me.

Presumably, the only CPUs that are going to support FP16 will have
non-trapping floating point, so the support code shouldn't be entered
at any time to emulate a half-precision instruction, but only to
handle the lazy restore of the thread's floating point registers?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
