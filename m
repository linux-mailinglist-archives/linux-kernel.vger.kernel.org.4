Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A6C6B5AB6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 11:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjCKK7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 05:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjCKK7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 05:59:16 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2116244BE;
        Sat, 11 Mar 2023 02:59:15 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32BAwwF2047377;
        Sat, 11 Mar 2023 04:58:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678532338;
        bh=xfnqiXq23uEQEEOQFVlKoE7b83OBZowlCY6VYWzEIHY=;
        h=From:To:CC:Subject:Date;
        b=Tq+2duvOVTCFILQyknybuU1D6Ms6YEpHZ8drmp5li5C+BFzWaOmkbxD/pSSnseGNN
         9JmdxXl/U4xOxTG4RUYYZCmRel9fLSzQg2B8jqSLyR9csZhInkMaM1xfD5TlPdJ22g
         oSnJs+NHcDWHcj03SDUNjrxc5JUw0Dyvf31Net3I=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32BAwwmN105299
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 11 Mar 2023 04:58:58 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Sat, 11
 Mar 2023 04:58:58 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Sat, 11 Mar 2023 04:58:58 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32BAwviC038728;
        Sat, 11 Mar 2023 04:58:57 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Julien Panis <jpanis@baylibre.com>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH 0/2] arm64: dts: ti: k3-am62: Add watchdog and rtc nodes
Date:   Sat, 11 Mar 2023 04:58:48 -0600
Message-ID: <20230311105850.21811-1-nm@ti.com>
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

Couple of misc patches.

AM62x WDT was posted here[1] - So, this would be a resend, dropping the
board level reservation.

Julien Panis (1):
  arm64: dts: ti: k3-am62: Add watchdog nodes

Nishanth Menon (1):
  arm64: dts: ti: k3-am62-wakeup: Introduce RTC node

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi   | 45 ++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi    |  9 +++++
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi | 21 ++++++++++
 3 files changed, 75 insertions(+)

[1] https://lore.kernel.org/all/20221109093026.103790-2-jpanis@baylibre.com/
-- 
2.37.2

