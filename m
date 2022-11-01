Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBE16154C4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiKAWLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiKAWLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:11:16 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13E913D6E;
        Tue,  1 Nov 2022 15:11:15 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A1MBBmB130734;
        Tue, 1 Nov 2022 17:11:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667340671;
        bh=7xqD9SBOlPYAy27JENl91PXYlRlOW3BCnKdV2+8MgKY=;
        h=From:To:CC:Subject:Date;
        b=h8Qa7jgo/7HCnwn0LtL3yQwqMwhGvuw1lqac1dnaGcyE1AkcJurn4IAP0U1d1E29G
         r8UIXI9P1PX+r78KSPxVINsv7KyMJuuGn69WzOUPNmZq2LOdXU8pEOE6Zcph4gn6BU
         o/OCNCDYvCC15suDoN/gSn2WjsTdrQqvOcS6tGRI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A1MBBsH116123
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Nov 2022 17:11:11 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 1 Nov
 2022 17:11:11 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 1 Nov 2022 17:11:11 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A1MBAl4016232;
        Tue, 1 Nov 2022 17:11:10 -0500
From:   Andrew Davis <afd@ti.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH v2 0/2] AM57x EVM Device Tree Overlays
Date:   Tue, 1 Nov 2022 17:11:08 -0500
Message-ID: <20221101221110.17885-1-afd@ti.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Series depends on https://www.spinics.net/lists/kernel/msg4548509.html

Thanks,
Andrew

Changes from v1:
 - Made touchscreen node name generic
 - Used proper interrupt flags

Andrew Davis (2):
  ARM: dts: ti: Add AM57xx GP EVM board support
  ARM: dts: ti: Add AM57xx GP EVM Rev A3 board support

 arch/arm/boot/dts/Makefile        |   4 +
 arch/arm/boot/dts/am57xx-evm.dtso | 127 ++++++++++++++++++++++++++++++
 2 files changed, 131 insertions(+)
 create mode 100644 arch/arm/boot/dts/am57xx-evm.dtso

-- 
2.37.3

