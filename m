Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597386998F4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 16:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjBPPeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 10:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjBPPeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 10:34:14 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB2A23DA5;
        Thu, 16 Feb 2023 07:34:09 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 31GFXeAH113353;
        Thu, 16 Feb 2023 09:33:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1676561620;
        bh=gGClkZ7Y6W8QSzuKIqCvjRgFVLWWEXdv+MGh3f1pp30=;
        h=From:To:CC:Subject:Date;
        b=mnqc/etMZlfmCgxezuHGTaZGGz7tLjApE9yOXjvVBUfW5D4/yc4+z6OroVY6UUkqT
         BDc61hOmbpdyyyzufsCF/3cORSAhRuQ4OoZJ4lBM7+zwT/HqEWqbV92Zxu001WGaXN
         O5u1q8tAHJAJN9r71f9GFhPGh3krR3BV7rOGHuLw=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 31GFXe9e121204
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Feb 2023 09:33:40 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 16
 Feb 2023 09:33:40 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 16 Feb 2023 09:33:40 -0600
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 31GFXdcd018680;
        Thu, 16 Feb 2023 09:33:39 -0600
From:   Andrew Davis <afd@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Andrew Davis <afd@ti.com>
Subject: [RFC 0/2] Convert omap.txt to DT schema
Date:   Thu, 16 Feb 2023 09:33:37 -0600
Message-ID: <20230216153339.19987-1-afd@ti.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I saw there was some more talk on the lists about converting
the omap.txt over to DT schema. I remembered that I had made
an attempt at this and wanted to post it as a WIP example.
It is not perfect or even very good, but might serve as
a base for someone.

Thanks,
Andrew

Andrew Davis (2):
  ARM: dts: omap: Drop ti,omap36xx compatible
  WIP: dt-bindings: omap: Convert omap.txt to yaml

 .../devicetree/bindings/arm/omap/omap.yaml    | 174 ++++++++++++++++++
 arch/arm/boot/dts/omap3-beagle-xm.dts         |   2 +-
 arch/arm/boot/dts/omap3-cm-t3730.dts          |   2 +-
 arch/arm/boot/dts/omap3-igep0020-rev-f.dts    |   2 +-
 arch/arm/boot/dts/omap3-igep0020.dts          |   2 +-
 arch/arm/boot/dts/omap3-igep0030-rev-g.dts    |   2 +-
 arch/arm/boot/dts/omap3-igep0030.dts          |   2 +-
 arch/arm/boot/dts/omap3-lilly-dbb056.dts      |   2 +-
 arch/arm/boot/dts/omap3-n9.dts                |   2 +-
 arch/arm/boot/dts/omap3-n950.dts              |   2 +-
 .../arm/boot/dts/omap3-overo-storm-alto35.dts |   2 +-
 .../boot/dts/omap3-overo-storm-chestnut43.dts |   2 +-
 .../boot/dts/omap3-overo-storm-gallop43.dts   |   2 +-
 .../arm/boot/dts/omap3-overo-storm-palo35.dts |   2 +-
 .../arm/boot/dts/omap3-overo-storm-palo43.dts |   2 +-
 .../arm/boot/dts/omap3-overo-storm-summit.dts |   2 +-
 arch/arm/boot/dts/omap3-overo-storm-tobi.dts  |   2 +-
 .../boot/dts/omap3-overo-storm-tobiduo.dts    |   2 +-
 arch/arm/boot/dts/omap3-pandora-1ghz.dts      |   2 +-
 arch/arm/boot/dts/omap3-sbc-t3730.dts         |   2 +-
 arch/arm/boot/dts/omap3-sniper.dts            |   2 +-
 arch/arm/boot/dts/omap3-zoom3.dts             |   2 +-
 22 files changed, 195 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/omap.yaml

-- 
2.39.1

