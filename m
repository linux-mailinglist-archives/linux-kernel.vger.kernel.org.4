Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F49681AFD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238010AbjA3UAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238143AbjA3T7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:59:47 -0500
Received: from out-145.mta0.migadu.com (out-145.mta0.migadu.com [IPv6:2001:41d0:1004:224b::91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6A9470B0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:59:44 -0800 (PST)
Date:   Mon, 30 Jan 2023 20:59:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
        t=1675108779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oDXEr4tevG+VL9CgJZUG91in/A0kV3NohS4+eilPyY0=;
        b=Dk9hrcKLg6J15nt1uvUwiH2WNSHjrXjxdfBe9kav2HVwNfuGuB46meRfLu0ATP714SBYmM
        5mBixVUdN+gnXm6mmBATYA/VwWWbAEmbE6WbEpiM4B990lSV3N0zbh4iQvVDa7TcAl/DR6
        H3y/OSaK96QSmwwFPqc3M8TBzdbTXNg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Henrik Grimler <henrik@grimler.se>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, jenneron@protonmail.com,
        markuss.broks@gmail.com, martin.juecker@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 0/2] ARM: dts: add mmc aliases for Exynos devices
Message-ID: <Y9ghpylhwvB54E0w@localhost>
References: <CGME20230128133213eucas1p274ea3393199fe711fba8f542197e1dea@eucas1p2.samsung.com>
 <20230128133151.29471-1-henrik@grimler.se>
 <e41a0a4c-b9c6-e396-313e-ea2990b2dd6f@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e41a0a4c-b9c6-e396-313e-ea2990b2dd6f@samsung.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On Mon, Jan 30, 2023 at 02:28:27PM +0100, Marek Szyprowski wrote:
> On 28.01.2023 14:31, Henrik Grimler wrote:
> > It is convenient to have fixed mmcblk numbering of the eMMC and sdcard
> > so that assigned numbers will not change from boot-to-boot or
> > depending on if storage devices are actually attached or not.
> >
> > Anton Bambura has done the work for the chromebooks while I have
> > looked at the other devices.  On the chromebooks, mmc0 is used for
> > eMMC and mmc1 for sdcard, while mmc0 is used for eMMC and mmc2 for
> > sdcard on the other boards, simply because Anton and I had different
> > preferences.
> >
> > Also remove mshc aliases, as they should not be needed after [1] as
> > I understand it.
> 
> Thanks for this patchset. Long time ago I've tried to submit something 
> similar, but that time it has been rejected:
> 
> https://lore.kernel.org/all/20201105114804.18326-1-m.szyprowski@samsung.com/

Thanks for testing!  I missed that you had sent it before, Krzysztof
pointed it out in v1 as well.

> I hope that the mshc alias removal will help here.
> 
> BTW, similar patchset is needed for arch/arm64/boot/dts/exynos

Sure, I do not have any of the currently supported arm64 boards to
test with, but can send the same type of patch for arm64 as well.

[1] 

Best regards,
Henrik Grimler

> > [1] https://lkml.kernel.org/lkml/20211124184603.3897245-1-john@metanate.com
> >
> > ---
> >
> > Changes since v1:
> > * Move mshc alias cleanup to a separate commit
> > * Use mmc0 and mmc1 (instead of mmc0 and mmc2) for eMMC and sdcard on
> >    chromebooks
> > * Address Krzysztof's review comments:
> >   - Make changes per device rather than in soc dtsi
> >
> >
> > Henrik Grimler (2):
> >    ARM: dts: exynos: drop mshc aliases
> >    ARM: dts: exynos: add mmc aliases
> >
> >   arch/arm/boot/dts/exynos3250-artik5-eval.dts        | 5 +++++
> >   arch/arm/boot/dts/exynos3250-artik5.dtsi            | 5 +++++
> >   arch/arm/boot/dts/exynos3250-monk.dts               | 1 +
> >   arch/arm/boot/dts/exynos3250-rinato.dts             | 2 ++
> >   arch/arm/boot/dts/exynos3250.dtsi                   | 3 ---
> >   arch/arm/boot/dts/exynos4210-i9100.dts              | 6 ++++++
> >   arch/arm/boot/dts/exynos4210-origen.dts             | 5 +++++
> >   arch/arm/boot/dts/exynos4210-smdkv310.dts           | 4 ++++
> >   arch/arm/boot/dts/exynos4210-trats.dts              | 6 ++++++
> >   arch/arm/boot/dts/exynos4210-universal_c210.dts     | 6 ++++++
> >   arch/arm/boot/dts/exynos4412-itop-elite.dts         | 5 +++++
> >   arch/arm/boot/dts/exynos4412-midas.dtsi             | 3 +++
> >   arch/arm/boot/dts/exynos4412-odroid-common.dtsi     | 5 +++++
> >   arch/arm/boot/dts/exynos4412-origen.dts             | 5 +++++
> >   arch/arm/boot/dts/exynos4412-p4note.dtsi            | 6 ++++++
> >   arch/arm/boot/dts/exynos4412-smdk4412.dts           | 4 ++++
> >   arch/arm/boot/dts/exynos4412-tiny4412.dts           | 4 ++++
> >   arch/arm/boot/dts/exynos4412.dtsi                   | 1 -
> >   arch/arm/boot/dts/exynos5250-arndale.dts            | 5 +++++
> >   arch/arm/boot/dts/exynos5250-smdk5250.dts           | 2 ++
> >   arch/arm/boot/dts/exynos5250-snow-common.dtsi       | 3 +++
> >   arch/arm/boot/dts/exynos5250-spring.dts             | 5 +++++
> >   arch/arm/boot/dts/exynos5250.dtsi                   | 4 ----
> >   arch/arm/boot/dts/exynos5260-xyref5260.dts          | 5 +++++
> >   arch/arm/boot/dts/exynos5410-odroidxu.dts           | 2 ++
> >   arch/arm/boot/dts/exynos5410-smdk5410.dts           | 5 +++++
> >   arch/arm/boot/dts/exynos5420-arndale-octa.dts       | 5 +++++
> >   arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi | 5 +++++
> >   arch/arm/boot/dts/exynos5420-peach-pit.dts          | 3 +++
> >   arch/arm/boot/dts/exynos5420-smdk5420.dts           | 5 +++++
> >   arch/arm/boot/dts/exynos5420.dtsi                   | 3 ---
> >   arch/arm/boot/dts/exynos5422-odroid-core.dtsi       | 5 +++++
> >   arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi  | 4 ++++
> >   arch/arm/boot/dts/exynos5422-samsung-k3g.dts        | 4 ++++
> >   arch/arm/boot/dts/exynos5800-peach-pi.dts           | 3 +++
> >   35 files changed, 133 insertions(+), 11 deletions(-)
> >
> >
> > base-commit: 9ca5a7ce492d182c25ea2e785eeb72cee1d5056b
> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 
