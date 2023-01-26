Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF60C67C8BB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236646AbjAZKj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjAZKjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:39:55 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F5AB448;
        Thu, 26 Jan 2023 02:39:53 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
        t=1674729591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Jlyhz7Tw4ACTk+tYAveEaZgRUem40bJcytO+ZmQ6+us=;
        b=RZYQU0TyBQLzIQVpL7MWdq/uIrpNzgGYgZpsW45EMYB+vv33X+hIu4biRwXJo1tvMf9xiO
        XHeWzbuXnTCYTZytmLNGrBLO5r04fapC8NyW2ZAsVTcXEYMpz1tSkXBGIZO4G6G3aKE05W
        lNvpPAWJrARgiIPuhDzrFshaiPhrjj4=
From:   Henrik Grimler <henrik@grimler.se>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Cc:     Henrik Grimler <henrik@grimler.se>
Subject: [PATCH 0/6] ARM: dts: add mmc aliases for Exynos devices
Date:   Thu, 26 Jan 2023 11:38:22 +0100
Message-Id: <20230126103828.481441-1-henrik@grimler.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is convenient to have fixed mmcblk numbering of the eMMC and
sdcard, and with these aliases all Exynos 4 and 5 devices (and
probably Exynos 3, but I do not have one of those boards so cannot
verify) will have the eMMC as mmc0 and sdcard as mmc2.

I also removed sdhc aliases, as they should not be needed after [1] as
I understand it.

[1] https://lkml.kernel.org/lkml/20211124184603.3897245-1-john@metanate.com/

Henrik Grimler (6):
  ARM: dts: exynos: add mmc aliases for Exynos3250
  ARM: dts: exynos: add mmc aliases for Exynos4210
  ARM: dts: exynos: add mmc aliases for Exynos4412
  ARM: dts: exynos: add mmc aliases for Exynos5250
  ARM: dts: exynos: add mmc aliases for Exynos5410
  ARM: dts: exynos: add mmc aliases for Exynos5420

 arch/arm/boot/dts/exynos3250.dtsi | 6 +++---
 arch/arm/boot/dts/exynos4210.dtsi | 4 ++++
 arch/arm/boot/dts/exynos4412.dtsi | 5 ++++-
 arch/arm/boot/dts/exynos5250.dtsi | 8 ++++----
 arch/arm/boot/dts/exynos5410.dtsi | 3 +++
 arch/arm/boot/dts/exynos5420.dtsi | 6 +++---
 6 files changed, 21 insertions(+), 11 deletions(-)


base-commit: 9ca5a7ce492d182c25ea2e785eeb72cee1d5056b
-- 
2.39.1

