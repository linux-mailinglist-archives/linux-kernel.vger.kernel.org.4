Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057716FA27A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjEHIlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjEHIlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:41:16 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 834B315EFC;
        Mon,  8 May 2023 01:41:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E53308111;
        Mon,  8 May 2023 08:41:14 +0000 (UTC)
Date:   Mon, 8 May 2023 11:41:13 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Wadim Egorov <w.egorov@phytec.de>
Cc:     Nishanth Menon <nm@ti.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, upstream@lists.phytec.de,
        vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com
Subject: Re: [PATCH 2/2] arm64: dts: ti: Add basic support for
 phyBOARD-Lyra-AM625
Message-ID: <20230508084113.GV14287@atomide.com>
References: <20230504140143.1425951-1-w.egorov@phytec.de>
 <20230504140143.1425951-2-w.egorov@phytec.de>
 <20230504142643.pkzsftrsrqph4vql@banked>
 <20230505093930.GS14287@atomide.com>
 <8db31b08-5a8b-f317-a954-c228a08004a8@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8db31b08-5a8b-f317-a954-c228a08004a8@phytec.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Wadim Egorov <w.egorov@phytec.de> [230505 13:38]:
> 
> Am 05.05.23 um 11:39 schrieb Tony Lindgren:
> > * Nishanth Menon <nm@ti.com> [230504 14:33]:
> > > Just wondering: if the carrier board can easily work with different
> > > SoMs.. in which case, we could do overlay to create the som + carrier
> > > overlay to create rdk dtb - this might allow the scheme to scale to
> > > additional SoMs and carrier combinations.. and the SoM dtb could be
> > > sufficient for something like a bootloader.
> > It might be best to limit the overlay usage to devices that might see
> > dual use on the carrier board.. Not sure if setting up the entire
> > carrier board makes sense as an overlay :) Not sure if folks want to
> > debug boot issues on a remote server for example if an overlay is
> > needed to boot with Ethernet :)
> 
> Our idea is to create overlays for SoM variants, e.g. an overlay for a SoM
> without SPI NOR flash populated.
> If we want to reuse a carrier board, we could factor out the carrier board
> dts into a dtsi file and provide the needed combinations in form of
> different dts files.

It probably makes sens to limit the overlays for optional features that
are not hardwired.

> In the bootloader world the situation is a bit different.
> Here we would like to have a universal phycore_am62x "board" that should be
> able to handle most carrier board designs using that SoM. And since u-boot
> is moving towards having a single source of device trees, this concept will
> probably no longer work anymore. So your idea with a SoM dtb sounds
> interesting.
> I wonder what ideas other SoM vendors have or how it is handled on other
> architectures.

I'm not sure what the best way to organize things is if there are many
SoM and carrier board variants, I guess it depends on the number of the
possible permutations :)

Regards,

Tony
