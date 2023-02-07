Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43A668CC9C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 03:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjBGCf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 21:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBGCfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 21:35:19 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65D4311E89;
        Mon,  6 Feb 2023 18:35:18 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 07 Feb 2023 11:35:17 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id CA0ED2020780;
        Tue,  7 Feb 2023 11:35:17 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 7 Feb 2023 11:35:11 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 864D2A8556;
        Tue,  7 Feb 2023 11:35:17 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 0/8] Update UniPhier devicetree for 6.3
Date:   Tue,  7 Feb 2023 11:35:06 +0900
Message-Id: <20230207023514.29783-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update devicetree sources for UniPhier SoCs to align node names
to generic, add missing properties and compatible strings,
and add SD UHS property.

The SD UHS mode patches are related to the series:
https://lore.kernel.org/lkml/20230125010201.28246-4-hayashi.kunihiko@socionext.com/

Kunihiko Hayashi (8):
  ARM: dts: uniphier: Align node names for SoC-dependent controller and
    PHYs with bindings
  ARM: dts: uniphier: Add missing reg properties for glue layer
  ARM: dts: uniphier: Add syscon compatible string to soc-glue-debug
  ARM: dts: uniphier: Add syscon-uhs-mode to SD node
  arm64: dts: uniphier: Align node names for SoC-dependent controller
    and PHYs with bindings
  arm64: dts: uniphier: Add missing reg properties for glue layer nodes
  arm64: dts: uniphier: Add syscon compatible string to soc-glue-debug
  arm64: dts: uniphier: Add syscon-uhs-mode to SD node

 arch/arm/boot/dts/uniphier-ld4.dtsi           | 25 +++++-----
 arch/arm/boot/dts/uniphier-pro4.dtsi          | 44 ++++++++++-------
 arch/arm/boot/dts/uniphier-pro5.dtsi          | 42 +++++++++-------
 arch/arm/boot/dts/uniphier-pxs2.dtsi          | 49 ++++++++++---------
 arch/arm/boot/dts/uniphier-sld8.dtsi          | 26 +++++-----
 .../boot/dts/socionext/uniphier-ld11.dtsi     | 35 ++++++-------
 .../boot/dts/socionext/uniphier-ld20.dtsi     | 45 +++++++++--------
 .../boot/dts/socionext/uniphier-pxs3.dtsi     | 48 ++++++++++--------
 8 files changed, 171 insertions(+), 143 deletions(-)

-- 
2.25.1

