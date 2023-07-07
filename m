Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC6874A82E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 02:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjGGAiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 20:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjGGAh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 20:37:59 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC41619A7;
        Thu,  6 Jul 2023 17:37:14 -0700 (PDT)
Received: from droid01-cd.amlogic.com (10.98.11.200) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Fri, 7 Jul 2023
 08:37:04 +0800
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
To:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: [PATCH V2 0/4] Power: C3: add  power domain driver
Date:   Fri, 7 Jul 2023 08:37:06 +0800
Message-ID: <20230707003710.2667989-1-xianwei.zhao@amlogic.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.98.11.200]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First patch is that Use 'name' instead of 'index' as criterion.
The  variate 'index' could be equal to zero in some SoCs. Such as C3 SoC,
PWRC_C3_NNA_ID be defined zero.

Other patchs adds power controller driver support for Amlogic C3 SoC.
The power domains registers can be accessed in the secure world only.

Changes Since v1:
 -Add a new patch for change that use 'name' instead of 'index'.
 -Mofiy filename  matching compatibles
 -Delete unnecessary blank line.
 -Fixed some formatting.
 -Delete status,use "okay" status by default.

Xianwei Zhao (4):
  soc: amlogic: use name instead of index as criterion
  dt-bindings: power: add Amlogic C3 power domains
  soc: c3: Add support for power domains controller
  arm64: dts: add support for C3 power domain controller

 .../power/amlogic,meson-sec-pwrc.yaml         |  3 +-
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi   |  9 ++++++
 drivers/soc/amlogic/meson-secure-pwrc.c       | 28 ++++++++++++++++++-
 include/dt-bindings/power/amlogic,c3-pwrc.h   | 25 +++++++++++++++++
 4 files changed, 63 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/power/amlogic,c3-pwrc.h


base-commit: 057889cb4244096ea5abcbe76ffd4d311c3078fe
-- 
2.37.1

