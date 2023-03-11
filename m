Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D706B5AC3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjCKLKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCKLKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:10:39 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6224C2749F;
        Sat, 11 Mar 2023 03:10:38 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32BBANKk049370;
        Sat, 11 Mar 2023 05:10:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678533023;
        bh=ilPGfLPlAmZ74uLHxrHzuH55hDbvAigU+Dx7r7Mbotc=;
        h=From:To:CC:Subject:Date;
        b=CU7rKWVxzVI8Yb63BRrmrXpZ3GlCNs9ZmfKDxhxnzYbc7kFUI9XRMCENEDu9wV6hM
         5Yfv43/BDCcOVX4f8lojQZ/7L1rJYnLwkrGgWjk/RvjXUhLRGSwc6IhxoSSchUbziG
         ycu8Ch+W1YCYkGmiqZQgG4evV8Kpm7W/RYZaG2xM=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32BBAN6Z111593
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 11 Mar 2023 05:10:23 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Sat, 11
 Mar 2023 05:10:23 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Sat, 11 Mar 2023 05:10:23 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32BBANEf064041;
        Sat, 11 Mar 2023 05:10:23 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Julien Panis <jpanis@baylibre.com>,
        Bryan Brattlof <bb@ti.com>, Jason Kridner <jkridner@gmail.com>,
        Robert Nelson <robertcnelson@gmail.com>
Subject: [PATCH 0/3] arm64: dts/defconfig/binding: Add support for BeaglePlay
Date:   Sat, 11 Mar 2023 05:10:19 -0600
Message-ID: <20230311111022.23717-1-nm@ti.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

BeagleBoard.org BeaglePlay[1][2] is an easy to use, affordable open source
hardware single board computer based on the Texas Instruments AM625
SoC. Add the base support for the same.

Bootlog: https://gist.github.com/nmenon/f5be177bdbe7537fbfc7b42cd36d430a

Nishanth Menon (1):
  arm64: defconfig: Enable drivers for BeaglePlay

Robert Nelson (2):
  dt-bindings: arm: ti: Add bindings for BeaglePlay
  arm64: dts: ti: Add k3-am625-beagleplay

 .../devicetree/bindings/arm/ti/k3.yaml        |   1 +
 arch/arm64/boot/dts/ti/Makefile               |   1 +
 .../arm64/boot/dts/ti/k3-am625-beagleplay.dts | 753 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |   7 +
 4 files changed, 762 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts

[1] https://beagleplay.org/
[2] https://git.beagleboard.org/beagleplay/beagleplay
-- 
2.37.2

