Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EED72611C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240689AbjFGNVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240684AbjFGNVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:21:01 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708FE173A;
        Wed,  7 Jun 2023 06:20:54 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 357DKjgZ039055;
        Wed, 7 Jun 2023 08:20:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686144045;
        bh=TPymGC19ambGuoE0EfKA2oryKlI/ij87CCYGI6kVI7Y=;
        h=From:To:CC:Subject:Date;
        b=bv34FS6DQq2Ljofs1XJdDp4RW1fg/xWl1aAYPmtS/3Sz0hYCyrnNKLL/J8km/9VPu
         zPBHbWd+kCNO8GWt2Tm6xzUJy8N8ZlC+IabIxPEm6in3pCZ1ierhQEM0ayfQ7NlgFj
         htcwhTw0EUSot00La1kpw/CXwihJ3iUvmtR/tgQU=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 357DKjLE098754
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Jun 2023 08:20:45 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Jun 2023 08:20:45 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Jun 2023 08:20:45 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 357DKite005196;
        Wed, 7 Jun 2023 08:20:45 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Andrew Davis <afd@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH V3 0/3] arm64: dts: ti: k3-am65: dtbs_check warnings fixups
Date:   Wed, 7 Jun 2023 08:20:40 -0500
Message-ID: <20230607132043.3932726-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Hopefully, third time is a charm ;)

Series of minor fixups for AM65x device tree to cleanup some of the
dtbs_check warnings.


Changes Since V2:
* Dropped mux-controller fixup (should have been dropped when
  dependencies changed)

V2: https://lore.kernel.org/all/20230606160643.3618390-1-nm@ti.com/
V1: https://lore.kernel.org/all/20230424144949.244135-1-nm@ti.com/


Nishanth Menon (3):
  arm64: dts: ti: k3-am65-main: Fix mcan node name
  arm64: dts: ti: k3-am65-main: Drop deprecated ti,otap-del-sel property
  arm64: dts: ti: k3-am65-iot2050-common: Rename rtc8564 nodename

 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 2 +-
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi           | 1 -
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            | 4 ++--
 3 files changed, 3 insertions(+), 4 deletions(-)

-- 
2.40.0

