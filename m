Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C706ED3A9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 19:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjDXRhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 13:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbjDXRhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 13:37:13 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1F37D9C;
        Mon, 24 Apr 2023 10:36:54 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33OHaQDT038228;
        Mon, 24 Apr 2023 12:36:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682357786;
        bh=rfFFOqkmSIPS2WCM908AQzzsrM2Xtl3smutdb5+PDo4=;
        h=From:To:CC:Subject:Date;
        b=f4Xz0fzXJphTfXmN3TZB9f8vY9r4u6wKkn5nUNMhNCZWJdhXBt8Mqz8GE/gpdX6d8
         iWiWTIs7gJ7oYvtFqMXGszi2OqlKHxcU58O+jlwrX3cdNDxZyPZeJIcGbGKtit0c2h
         jxjgpd1HBSfPGeRmNqljZLSiJrLPNllmGw7vMfTI=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33OHaQO7085700
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Apr 2023 12:36:26 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 24
 Apr 2023 12:36:26 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 24 Apr 2023 12:36:26 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33OHaQs6027938;
        Mon, 24 Apr 2023 12:36:26 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        <vaishnav.a@ti.com>, <afd@ti.com>, <u-kumar1@ti.com>
Subject: [PATCH 0/3] arm64: dts: ti: k3-j7200: Fixes for various dtbs_checks warnings
Date:   Mon, 24 Apr 2023 12:36:20 -0500
Message-ID: <20230424173623.477577-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Few fixups for j7200 dtbs_check warnings.

Bootlog: https://gist.github.com/nmenon/6a37fca2f05633b7153e661d2516deab

NOTE: lets see the discussion summary of [1] to see where to take this
series, but, I will put it out here in the list for discussion anyways.

[1] https://lore.kernel.org/all/76da0b98-3274-b047-db11-ecabc117ae11@ti.com/

Nishanth Menon (3):
  arm64: dts: ti: k3-j7200-mcu-wakeup: Remove 0x unit address prefix
    from nodename
  arm64: dts: ti: k3-j7200-mcu-wakeup: Switch mcu_syscon to
    ti,j721e-system-controller
  arm64: dts: ti: k3-j7200-mcu-wakeup: Split fss node up

 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 29 ++++++++++++-------
 1 file changed, 19 insertions(+), 10 deletions(-)

-- 
2.40.0

