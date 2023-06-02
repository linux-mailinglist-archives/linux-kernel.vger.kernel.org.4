Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E55A720659
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbjFBPgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbjFBPgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:36:12 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2929718C;
        Fri,  2 Jun 2023 08:36:11 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 352FZv4g118401;
        Fri, 2 Jun 2023 10:35:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685720157;
        bh=jrsQ9WAeCDOvVC/rm5oOatbwMTkG0ydf7UHQx9yxInA=;
        h=From:To:CC:Subject:Date;
        b=lDg0SELZsM+x4NF6Het121jMcJ4kcuSxZ3Xkaq01lv/EMZkRand6ovO7ly66qmOa3
         AB77mXN8MULe2smgF2mEdcxR0W/VAlMmP/eKx7gBgngo/mJT4daU04Lr++6gT/OL60
         0npgO0KRGcJUdOpMxhKalBTQ9NYmnRu//GvBhG2k=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 352FZvog019589
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Jun 2023 10:35:57 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 2
 Jun 2023 10:35:57 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 2 Jun 2023 10:35:57 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 352FZvp3010198;
        Fri, 2 Jun 2023 10:35:57 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>,
        Udit Kumar <u-kumar1@ti.com>, Nitin Yadav <n-yadav@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH 0/6] arm64: dts: ti: k3-j721s2: Mux fixups and eeprom misc
Date:   Fri, 2 Jun 2023 10:35:48 -0500
Message-ID: <20230602153554.1571128-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is an expansion of Sinthu's series[1] for J721s2, fixing a few aspects
of his patches and adding uart, eeprom detection etc.

This set of changes picksup fixes seen in u-boot and else where an
consolidates into kernel as the definitive device tree description

Testing logs: https://gist.github.com/nmenon/2acfc566d0b215fe941c42317d9ac955

Changes:
* Fixups to the wkup_pmx0 patch to limit stable tree to 6.3
* Fixups to Rpi header patch for mcu_i2c0 pinmux
* Additional patches for eeprom and wkup/mcu uarts.

-- Sinthu's series history:
Changes in V5[1]:
-Remove main padconfig split patch which is not required.

Changes in V4:
- Address review comments
  * Update main and wakeup domain IO padconfig
  * Correct the pinctrl node offsets as per the newly split wkup_pmx*
    and main_pmx* nodes.

Changes in V3:
- Add Fixes tag.

Changes in V2:
- Update commit description.
- Update the offset value to 0x194 as 0x190 is the last register of the
  IO PADCONFIG register set.

V1: https://lore.kernel.org/all/20230123135831.4184-1-sinthu.raja@ti.com/
V2: https://lore.kernel.org/lkml/20230124120311.7323-1-sinthu.raja@ti.com/T/
V3: https://lore.kernel.org/linux-arm-kernel/20230316114102.3602-2-sinthu.raja@ti.com/T/
V4: https://lore.kernel.org/lkml/20230424081536.12123-1-sinthu.raja@ti.com/
V5[1]: https://lore.kernel.org/linux-arm-kernel/20230504073432.6438-1-sinthu.raja@ti.com/

Nishanth Menon (4):
  arm64: dts: ti: k3-am68-sk-base-board: Add uart pinmux
  arm64: dts: ti: k3-am68-sk-som: Enable wakeup_i2c0 and eeprom
  arm64: dts: ti: k3-j721s2-common-proc-board: Add uart pinmux
  arm64: dts: ti: k3-j721s2-som-p0: Enable wakeup_i2c0 and eeprom

Sinthu Raja (2):
  arm64: dts: ti: k3-j721s2: Fix wkup pinmux range
  arm64: dts: ti: k3-am68-sk-base-board: Add pinmux for RPi Header

 .../boot/dts/ti/k3-am68-sk-base-board.dts     | 145 +++++++++++++++---
 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi    |  22 +++
 .../dts/ti/k3-j721s2-common-proc-board.dts    |  99 +++++++-----
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |  29 +++-
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  |  22 +++
 5 files changed, 255 insertions(+), 62 deletions(-)

-- 
2.40.0

