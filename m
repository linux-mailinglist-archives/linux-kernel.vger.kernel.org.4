Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD8860FFFE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 20:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbiJ0SOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 14:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236365AbiJ0SOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 14:14:02 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6E640E1F;
        Thu, 27 Oct 2022 11:14:01 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29RIDc56021442;
        Thu, 27 Oct 2022 13:13:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666894418;
        bh=ZG1TkZXYNP0GzfQynOXjdK0sq9LGrguRlXd9nG4V27M=;
        h=From:To:CC:Subject:Date;
        b=I5E8GvTwStIW73V51qayo1UbjyXvfTbEeNPJoNV6YjGHib3HBH0A4vgoAHW+DOdzG
         r+xcmCNu4vR5xaumaMFPFVZOtri4MrY1pXKW+1ytc1vg9BdksI4qs2ghATPjKCwuCi
         JnzY0ZS55YH7jPatc805/z06f5jWokQWj9klEYeE=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29RIDcuR015531
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Oct 2022 13:13:38 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 27
 Oct 2022 13:13:38 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 27 Oct 2022 13:13:38 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29RIDbdu108447;
        Thu, 27 Oct 2022 13:13:37 -0500
From:   Andrew Davis <afd@ti.com>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>,
        Fabian Vogt <fabian@ritter-vogt.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v3 0/9] TI-Nspire cleanups
Date:   Thu, 27 Oct 2022 13:13:28 -0500
Message-ID: <20221027181337.8651-1-afd@ti.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

This series is an extended version of the series started here[0].

We break out what was the first patch into one for DTS change and
one for code changes as suggested by Krzysztof. Those are now patches
2 and 8 of this series (I kept the ACKs, hope that is okay).

As also pointed out by Krzysztof syscon nodes need a specific
compatible, add that as patch 1.

While I was adding that, I noticed some other dtbs_check issues,
so while here fixed some of those up too (patches 3-6).

Thanks,
Andrew

[0] https://lore.kernel.org/lkml/20221026161302.5319-1-afd@ti.com/

Andrew Davis (9):
  dt-bindings: mfd: syscon: Add TI-Nspire misc registers compatible
  ARM: dts: nspire: Use syscon-reboot to handle restart
  ARM: dts: nspire: Fix cpu node to conform with DT binding
  ARM: dts: nspire: Fix sram node to conform with DT binding
  ARM: dts: nspire: Fix vbus_reg node to conform with DT binding
  ARM: dts: nspire: Fix uart node to conform with DT binding
  ARM: dts: nspire: Use MATRIX_KEY macro for linux,keymap
  ARM: nspire: Use syscon-reboot to handle restart
  ARM: nspire: Remove unused header file mmio.h

 .../devicetree/bindings/mfd/syscon.yaml       |   1 +
 arch/arm/boot/dts/nspire-clp.dts              | 128 ++++++++++++------
 arch/arm/boot/dts/nspire-cx.dts               |  92 +++++++++----
 arch/arm/boot/dts/nspire-tp.dts               | 126 +++++++++++------
 arch/arm/boot/dts/nspire.dtsi                 |  24 +++-
 arch/arm/mach-nspire/Kconfig                  |   2 +
 arch/arm/mach-nspire/mmio.h                   |  16 ---
 arch/arm/mach-nspire/nspire.c                 |  60 +++-----
 8 files changed, 284 insertions(+), 165 deletions(-)
 rewrite arch/arm/boot/dts/nspire-clp.dts (72%)
 rewrite arch/arm/boot/dts/nspire-tp.dts (72%)
 delete mode 100644 arch/arm/mach-nspire/mmio.h
 rewrite arch/arm/mach-nspire/nspire.c (61%)

-- 
2.37.3

