Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883C85FF148
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 17:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiJNP0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 11:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiJNP0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 11:26:50 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F264CA17;
        Fri, 14 Oct 2022 08:26:49 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29EFQj4x047297;
        Fri, 14 Oct 2022 10:26:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1665761205;
        bh=cr+gOCZHdw+5ge9BgUDYqRul2Hv7vIzX24DwiHzRaxA=;
        h=From:To:CC:Subject:Date;
        b=sdgSgr9WcohTrO2iISuD6dKKtYbMyW9e1RzSpKWgEDPi8Iip2OQTzBuu4M9vXZAqh
         s1Ih7zZR6bO3UyXao8GcFWJmvdpk2HksgadbB0tYr1WYR9TYAdKfIFkEB8NzeT/W7j
         UDE836fx0heLA8c3FQziwaC6SNpXhCFFP0+fhxR4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29EFQjrT002902
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Oct 2022 10:26:45 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 14
 Oct 2022 10:26:44 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 14 Oct 2022 10:26:44 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29EFQhPA102295;
        Fri, 14 Oct 2022 10:26:44 -0500
From:   Andrew Davis <afd@ti.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 0/2] AM57x EVM Device Tree Overlays
Date:   Fri, 14 Oct 2022 10:26:41 -0500
Message-ID: <20221014152643.28745-1-afd@ti.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Andrew Davis (2):
  ARM: dts: ti: Add AM57xx GP EVM board support
  ARM: dts: ti: Add AM57xx GP EVM Rev A3 board support

 arch/arm/boot/dts/Makefile        |   4 +
 arch/arm/boot/dts/am57xx-evm.dtso | 127 ++++++++++++++++++++++++++++++
 2 files changed, 131 insertions(+)
 create mode 100644 arch/arm/boot/dts/am57xx-evm.dtso

-- 
2.37.3

