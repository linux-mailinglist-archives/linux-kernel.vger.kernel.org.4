Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2976ED0B1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 16:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjDXOux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 10:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjDXOuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 10:50:35 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E619003;
        Mon, 24 Apr 2023 07:50:21 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33OEnqhQ130483;
        Mon, 24 Apr 2023 09:49:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682347792;
        bh=37co4mMWzWHR0FGQIBgLoWPWkErT33NhdlV4SL6RYY0=;
        h=From:To:CC:Subject:Date;
        b=y32ZjrPcZZbbYQ79Vrm94Mmv2j4SO3EVeJSN/kUA7GyPIYW2MYTCex6Une4PGuCxH
         WaEP7IEfrdqx4QHyn1GCE8io+6AIWfphE4j8tCfO1STDBKb4+AHuItCMgQrdjMZSEf
         vwJktlG7Lw0hERp3vIi5JxuxUwCZy2vXis1Y5TTU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33OEnqle064867
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Apr 2023 09:49:52 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 24
 Apr 2023 09:49:51 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 24 Apr 2023 09:49:51 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33OEnpPY077023;
        Mon, 24 Apr 2023 09:49:51 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 0/7] arm64: dts: ti: k3-am65: dtbs_check warnings fixups
Date:   Mon, 24 Apr 2023 09:49:42 -0500
Message-ID: <20230424144949.244135-1-nm@ti.com>
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

One round of long pending dtbs_checks warnings fixups for am65.

Bootlog: https://gist.github.com/nmenon/605142cb4a4ffb2b9d05bea944f8fd32#file-am654-evm-patchset2-txt

Pending warnings: https://gist.github.com/nmenon/605142cb4a4ffb2b9d05bea944f8fd32#file-pending-dtbs_check_warnings

Nishanth Menon (7):
  arm64: dts: ti: k3-am65-main: Remove "syscon" nodes added for
    pcieX_ctrl
  arm64: dts: ti: k3-am65-main: Fix mux controller node name
  arm64: dts: ti: k3-am65: Switch to "ti,j721e-system-controller"
    compatible
  arm64: dts: ti: k3-am65-main: Fix mcan node name
  arm64: dts: ti: k3-am65-main: Drop deprecated ti,otap-del-sel property
  arm64: dts: ti: k3-am65-mcu: Fix fss node
  arm64: dts: ti: k3-am65-iot2050-common: Rename rtc8564 nodename

 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   |  2 +-
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      | 32 +++++--------------
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       |  9 +++---
 3 files changed, 14 insertions(+), 29 deletions(-)

-- 
2.40.0

