Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3816E863C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 02:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjDTANn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 20:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjDTANm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 20:13:42 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC2819B5;
        Wed, 19 Apr 2023 17:13:40 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33JMxEJf082932;
        Wed, 19 Apr 2023 17:59:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681945154;
        bh=+p5fGOXutjKfdf4dNqahY+t7OALSJWd+VPBgBQJpsCo=;
        h=From:To:CC:Subject:Date;
        b=ZCREi33FySg9cKOEhr+cCsBKJrSXspQiMIq3LeyVmEAMWbiexMOGywOvpgAWdxMD7
         j6mCnNlN02Jp5cAl+I88BAgjXf4pFhsU2RXnOaR58kRleCz9I/TePXXQWSxrsOVAhO
         cecGIScWzLkjmjpfm4MS3D4odo9pYdQkktMXadBg=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33JMxErp077397
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Apr 2023 17:59:14 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 19
 Apr 2023 17:59:14 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 19 Apr 2023 17:59:14 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33JMxESx015534;
        Wed, 19 Apr 2023 17:59:14 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 0/7] arm64: dts: ti: k3-am65: Cleanups and minor additions
Date:   Wed, 19 Apr 2023 17:59:06 -0500
Message-ID: <20230419225913.663448-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a result of looking to cleanup u-boot and realizing there are
pieces missing in kernel that need to be pushed out.

So, minor cleanups and adding a few missing pieces.

Bootlog: https://gist.github.com/nmenon/f4dc43aef616dfcb3d38701cc074ff6d

Nishanth Menon (7):
  arm64: dts: ti: k3-am654-base-board: Add missing pinmux wkup_uart,
    mcu_uart and mcu_i2c
  arm64: dts: ti: k3-am654-base-board: Rename regulator node name
  arm64: dts: ti: k3-am654-base-board: Add VTT GPIO regulator for DDR
  arm64: dts: ti: k3-am654-base-board: Add missing PMIC
  arm64: dts: ti: k3-am654-base-board: Add board detect eeprom
  arm64: dts: ti: k3-am654-base-board: Add aliases
  arm64: dts: ti: k3-am65: Drop aliases

 arch/arm64/boot/dts/ti/k3-am65.dtsi           | 17 ----
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 93 ++++++++++++++++++-
 2 files changed, 88 insertions(+), 22 deletions(-)

-- 
2.40.0

