Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6259667F80E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 14:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbjA1NcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 08:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjA1NcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 08:32:08 -0500
Received: from out-221.mta0.migadu.com (out-221.mta0.migadu.com [IPv6:2001:41d0:1004:224b::dd])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4DD47ED3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 05:32:06 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
        t=1674912722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gii0pPj6VeZKKPDXoO57lVUG947qgGlEwm6QW2vsTR8=;
        b=Q26Cre8nvzZhkghaDhna66H8TSd364vFymgvnhzUh3HI4PbAA4kDPn2Rk0xB4hcy75nLZU
        45+irYRrkmCE22lpckgMfnY8LDd7eZVY96Wp74gn2iYdTQOioLyBfWi60WM6c9JgPbn15E
        ugeWKLZPYXLtIeQ9eqgiimtstSlkf4w=
From:   Henrik Grimler <henrik@grimler.se>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, m.szyprowski@samsung.com,
        jenneron@protonmail.com, markuss.broks@gmail.com,
        martin.juecker@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Cc:     Henrik Grimler <henrik@grimler.se>
Subject: [PATCH v2 0/2] ARM: dts: add mmc aliases for Exynos devices
Date:   Sat, 28 Jan 2023 14:31:49 +0100
Message-Id: <20230128133151.29471-1-henrik@grimler.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is convenient to have fixed mmcblk numbering of the eMMC and sdcard
so that assigned numbers will not change from boot-to-boot or
depending on if storage devices are actually attached or not.

Anton Bambura has done the work for the chromebooks while I have
looked at the other devices.  On the chromebooks, mmc0 is used for
eMMC and mmc1 for sdcard, while mmc0 is used for eMMC and mmc2 for
sdcard on the other boards, simply because Anton and I had different
preferences.

Also remove mshc aliases, as they should not be needed after [1] as
I understand it.

[1] https://lkml.kernel.org/lkml/20211124184603.3897245-1-john@metanate.com

---

Changes since v1:
* Move mshc alias cleanup to a separate commit
* Use mmc0 and mmc1 (instead of mmc0 and mmc2) for eMMC and sdcard on
  chromebooks
* Address Krzysztof's review comments:
 - Make changes per device rather than in soc dtsi


Henrik Grimler (2):
  ARM: dts: exynos: drop mshc aliases
  ARM: dts: exynos: add mmc aliases

 arch/arm/boot/dts/exynos3250-artik5-eval.dts        | 5 +++++
 arch/arm/boot/dts/exynos3250-artik5.dtsi            | 5 +++++
 arch/arm/boot/dts/exynos3250-monk.dts               | 1 +
 arch/arm/boot/dts/exynos3250-rinato.dts             | 2 ++
 arch/arm/boot/dts/exynos3250.dtsi                   | 3 ---
 arch/arm/boot/dts/exynos4210-i9100.dts              | 6 ++++++
 arch/arm/boot/dts/exynos4210-origen.dts             | 5 +++++
 arch/arm/boot/dts/exynos4210-smdkv310.dts           | 4 ++++
 arch/arm/boot/dts/exynos4210-trats.dts              | 6 ++++++
 arch/arm/boot/dts/exynos4210-universal_c210.dts     | 6 ++++++
 arch/arm/boot/dts/exynos4412-itop-elite.dts         | 5 +++++
 arch/arm/boot/dts/exynos4412-midas.dtsi             | 3 +++
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi     | 5 +++++
 arch/arm/boot/dts/exynos4412-origen.dts             | 5 +++++
 arch/arm/boot/dts/exynos4412-p4note.dtsi            | 6 ++++++
 arch/arm/boot/dts/exynos4412-smdk4412.dts           | 4 ++++
 arch/arm/boot/dts/exynos4412-tiny4412.dts           | 4 ++++
 arch/arm/boot/dts/exynos4412.dtsi                   | 1 -
 arch/arm/boot/dts/exynos5250-arndale.dts            | 5 +++++
 arch/arm/boot/dts/exynos5250-smdk5250.dts           | 2 ++
 arch/arm/boot/dts/exynos5250-snow-common.dtsi       | 3 +++
 arch/arm/boot/dts/exynos5250-spring.dts             | 5 +++++
 arch/arm/boot/dts/exynos5250.dtsi                   | 4 ----
 arch/arm/boot/dts/exynos5260-xyref5260.dts          | 5 +++++
 arch/arm/boot/dts/exynos5410-odroidxu.dts           | 2 ++
 arch/arm/boot/dts/exynos5410-smdk5410.dts           | 5 +++++
 arch/arm/boot/dts/exynos5420-arndale-octa.dts       | 5 +++++
 arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi | 5 +++++
 arch/arm/boot/dts/exynos5420-peach-pit.dts          | 3 +++
 arch/arm/boot/dts/exynos5420-smdk5420.dts           | 5 +++++
 arch/arm/boot/dts/exynos5420.dtsi                   | 3 ---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi       | 5 +++++
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi  | 4 ++++
 arch/arm/boot/dts/exynos5422-samsung-k3g.dts        | 4 ++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts           | 3 +++
 35 files changed, 133 insertions(+), 11 deletions(-)


base-commit: 9ca5a7ce492d182c25ea2e785eeb72cee1d5056b
-- 
2.39.1

