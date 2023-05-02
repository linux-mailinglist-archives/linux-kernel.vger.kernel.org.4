Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB726F3FE8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 11:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjEBJNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 05:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjEBJNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 05:13:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64FF84C07;
        Tue,  2 May 2023 02:13:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54A484B3;
        Tue,  2 May 2023 02:14:16 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 727743F5A1;
        Tue,  2 May 2023 02:13:30 -0700 (PDT)
Date:   Tue, 2 May 2023 10:13:17 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Ludwig Kormann <ludwig.kormann@in-circuit.de>
Cc:     samuel@sholland.org, jernej.skrabec@gmail.com, wens@csie.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] arm: dts: sunxi: Add ICnova A20 ADB4006 board
 support
Message-ID: <20230502101317.39767a0d@slackpad.lan>
In-Reply-To: <10a2e893-18b6-d9c2-1db7-3d500cc0891c@in-circuit.de>
References: <20230420102409.1394618-1-ludwig.kormann@in-circuit.de>
        <10a2e893-18b6-d9c2-1db7-3d500cc0891c@in-circuit.de>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 May 2023 10:06:20 +0200
Ludwig Kormann <ludwig.kormann@in-circuit.de> wrote:

Hi,

> Hello,
> 
> thanks for the reviews so far!
> 
> Is there anything I can do / need to do for my patch series for it to 
> get merged before -rc1?

The cutoff date for most board DT patches to get into a release is
around -rc5/-rc6 of the *previous* release: patches should live in
linux-next for a while. Also most pull requests need to "trickle up" the
stream first (from the sunxi tree to the SoC tree, then into mainline).
So -rc1 is out of reach now.

> The patch series was based on the "for-next" branch in jernej's tree, 
> but it seems that it was too late for the "dt-for-6.4" merge.

Yes.

> So I'm just trying to understand in general what the best way in this 
> situation would be:
> - wait if someone else takes the patch series before -rc1
> - wait for -rc1 and rebase, rework, send a new version of the patch 
> series (because of the planned restructuring of the ARM dts directory)

Yes, this is the way to go. The maintainers will probably take care of
any minor conflicts (like in the Makefile), so (the upcoming) -rc1
should be the base tree. For new DT files the conflict potential should
be minimal anyway.
Just make sure to run "make dt_binding_check" and "make dtbs_check"
again, because the rules might have been updated meanwhile.

Cheers,
Andre


> - wait for -rc3 (?) and rebase & rework the patch series for jernej's 
> tree for the "dt-for-6.5" branch
> 
> Thanks for your help.
> 
> kind regards
> Ludwig Kormann
> 
> 
> Am 20.04.23 um 12:24 schrieb Ludwig Kormann:
> > Add board support for ICnova A20 SomPi compute module on
> > ICnova ADB4006 development board.
> >
> > v3:
> > - drop stray blank lines at end of files
> > - separate patch for bindings
> > - update licensing to "GPL-2.0 OR MIT"
> > - fix typo: ICNova -> ICnova
> >
> > v2:
> > - use short licensing header
> > - remove deprecated elements from led nodes
> > - disable csi power supply
> > - add missing pins in usbphy node
> > - split dts into SoM dtsi and carrier board dts
> >
> > v1 of this patch was sent to the uboot mailing list [1].
> >
> > [1] https://lists.denx.de/pipermail/u-boot/2023-April/514605.html
> >
> > Ludwig Kormann (2):
> >    dt-bindings: arm: sunxi: add ICnova A20 ADB4006 binding
> >    arm: dts: sunxi: Add ICnova A20 ADB4006 board
> >
> >   .../devicetree/bindings/arm/sunxi.yaml        |   6 +
> >   arch/arm/boot/dts/Makefile                    |   1 +
> >   .../boot/dts/sun7i-a20-icnova-a20-adb4006.dts | 137 ++++++++++++++++++
> >   arch/arm/boot/dts/sun7i-a20-icnova-a20.dtsi   |  62 ++++++++
> >   4 files changed, 206 insertions(+)
> >   create mode 100644 arch/arm/boot/dts/sun7i-a20-icnova-a20-adb4006.dts
> >   create mode 100644 arch/arm/boot/dts/sun7i-a20-icnova-a20.dtsi
> >  

