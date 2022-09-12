Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0615B623D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 22:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiILUds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 16:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiILUdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 16:33:46 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A9348C89;
        Mon, 12 Sep 2022 13:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6w8PQBqR6HdnX1SoBWf39MoFT/GYBph2BTf28EIyMSs=; b=UG28dgXx2zplqODUZ3sEK1ECLk
        ZO2rc4SM0OWvg+7C4MdF86VjY3qzkM3aqmfuT4zWReeEfiD6gztCCrqUEH0nWOA0SGgeXvzdvX0hs
        +kRT+cWWIUlOHxUvckbLdNKCrg+3GVEDf28oWIqv4IeKjrIolUM8n2RBnfm8wZJcsTRu7b6sv49EL
        8aPMKYsIm6wUUWIhUQ1SbxSRb0yFPVj76HKQjbGAHY3HsmxZARCeEluitX3Kofr4S3Bm/d1CgXlba
        eZndrsz09gpXb1xjnpJIjsREsMWuL8qXLEq6DatqNUs6hBIDbFuU69x/yYl7EqZaIjvQHfmkFR5Yh
        cjqP3B3w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34272)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oXq7g-00026J-0Q; Mon, 12 Sep 2022 21:33:40 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oXq7e-0008Qc-Tw; Mon, 12 Sep 2022 21:33:38 +0100
Date:   Mon, 12 Sep 2022 21:33:38 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Li Yang <leoyang.li@nxp.com>, shawnguo@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: Re: [PATCH v4 1/2] arm64: dts: lx2160a: update PCIe nodes to match
 rev2 silicon
Message-ID: <Yx+XonDqmpE4KGhD@shell.armlinux.org.uk>
References: <20220817202538.21493-1-leoyang.li@nxp.com>
 <20220817202538.21493-2-leoyang.li@nxp.com>
 <CAOesGMhz8PYNG_bgMX-6gka77k1hJOZUv6xqJRqATaJ6mFbk6A@mail.gmail.com>
 <CAOesGMjsegmLUVxbjZJ3kgxnDkVTyxy5BB=is2CM_7Se7TQrWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOesGMjsegmLUVxbjZJ3kgxnDkVTyxy5BB=is2CM_7Se7TQrWQ@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 11:54:06AM -0700, Olof Johansson wrote:
> On Mon, Sep 12, 2022 at 12:05 AM Olof Johansson <olof@lixom.net> wrote:
> >
> > Hi,
> >
> > On Wed, Aug 17, 2022 at 1:26 PM Li Yang <leoyang.li@nxp.com> wrote:
> > >
> > > The original dts was created based on the non-production rev1 silicon
> > > which was only used for evaluation.  Update the PCIe nodes to align with
> > > the different controller used in production rev2 silicon.
> >
> > How can I confirm what version of silicon I have on a system?
> >
> > My non-evaluation commercially purchased system (HoneyComb LX2K) has:
> >
> > # cat /sys/bus/soc/devices/soc0/revision
> > 1.0
> >
> > And I will be really grumpy if this system stops working. It's what I
> > use to do all my maintainer work, even if that's been fairly dormant
> > this year.
> >
> > It's overall setting off red flags to update an in-place devicetree to
> > a "new revision" of silicon instead of adding a new DT for said
> > revision. 2160A has been on the market for several years, so it just
> > seems odd to all of the sudden retroactively make things
> > non-backwards-compatible.
> 
> Confirmed that this patch renders my HoneyComb unbootable -- PCIe doesn't probe.
> 
> Shawn, please revert, and be on the lookout for similar problematic
> approaches in the future. Thanks!

I think you may also need to beware of the MC firmware revision - I
seem to remember reading in the changelog notes for it that NXP
dropped support in the MC firmware for the older silicon, though I
may be misremembering. It's been a while since I really looked at
the LX2160A from the point of view of maintaining or developing
anything for it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
