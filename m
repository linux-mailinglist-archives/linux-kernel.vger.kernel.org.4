Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02256786BF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjAWTsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjAWTs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:48:29 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D54222C3;
        Mon, 23 Jan 2023 11:48:27 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30NJmLVE069757;
        Mon, 23 Jan 2023 13:48:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674503301;
        bh=2deVQnpXjv2jkusjw58aOvaf5EeVgagttXtCwMY42tI=;
        h=From:To:CC:Subject:Date;
        b=LZfQoqi8fncgBDoAMBF3N7EjGljyuOZ0XcvyQMLjKTnF73kapHq9zMwK6P0RFtVqi
         i/86k0+qgCYmGoKhSG6Dbx47IaLKtv9JWG1ZpNZmRVY1Z4wgl0GoHNWp76XgzUrifw
         Vcuf27OCt/Pn8Mj5bASc97JMz7dlEyLM+yWBUocU=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30NJmL8j077799
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Jan 2023 13:48:21 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 23
 Jan 2023 13:48:20 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 23 Jan 2023 13:48:20 -0600
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30NJmJ0q031936;
        Mon, 23 Jan 2023 13:48:19 -0600
From:   Andrew Davis <afd@ti.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH v3 0/3] AM57x EVM Device Tree Overlays
Date:   Mon, 23 Jan 2023 13:48:15 -0600
Message-ID: <20230123194818.21448-1-afd@ti.com>
X-Mailer: git-send-email 2.38.1
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

These is an uncontroversial (hopefully) DT Overlay to support the
TI AM57x EVM. More complex cases are staged and ready to follow but
wanted to test the water with this one.

For some reason dtbs_check does not get run on overlays, this
will need further investigation to fix in kbuild. For now I ran
it through manually but am not 100% sure it actually checked it,
so double checks here very welcome.

Thanks,
Andrew

Changes from v2:
 - Rebased on v6.2-rc5

Changes from v1:
 - Made touchscreen node name generic
 - Used proper interrupt flags

Andrew Davis (3):
  ARM: dts: ti: Add AM57xx GP EVM board support
  ARM: dts: ti: Add AM57xx GP EVM Rev A3 board support
  ARM: dts: am57xx-idk: Add IDK displays and touchscreens

 arch/arm/boot/dts/Makefile                    |   8 ++
 arch/arm/boot/dts/am571x-idk-touchscreen.dtso |  32 +++++
 arch/arm/boot/dts/am572x-idk-touchscreen.dtso |  32 +++++
 arch/arm/boot/dts/am57xx-evm.dtso             | 127 ++++++++++++++++++
 .../boot/dts/am57xx-idk-lcd-osd101t2045.dtso  |  63 +++++++++
 .../boot/dts/am57xx-idk-lcd-osd101t2587.dtso  |  66 +++++++++
 6 files changed, 328 insertions(+)
 create mode 100644 arch/arm/boot/dts/am571x-idk-touchscreen.dtso
 create mode 100644 arch/arm/boot/dts/am572x-idk-touchscreen.dtso
 create mode 100644 arch/arm/boot/dts/am57xx-evm.dtso
 create mode 100644 arch/arm/boot/dts/am57xx-idk-lcd-osd101t2045.dtso
 create mode 100644 arch/arm/boot/dts/am57xx-idk-lcd-osd101t2587.dtso

-- 
2.38.1

