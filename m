Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63D9724881
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238295AbjFFQHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237956AbjFFQG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:06:57 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94D610DB;
        Tue,  6 Jun 2023 09:06:56 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 356G6jBd016148;
        Tue, 6 Jun 2023 11:06:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686067605;
        bh=whwfbFwwRorwVWsr9vpBR5ox/1Rjt5+auclY1HZ3W10=;
        h=From:To:CC:Subject:Date;
        b=HRDZnONpF2fuRWbSlJPtqkuGM4vr4AoZMZHxOXIUBd96y91kHhK1mK5a3exhQzY7y
         uat9Nno46M8SnnryPc/PpG5EhhsrzXDptiahbcX6ILqcp5i7nl0CpIJxP3rkbDivBj
         nY2fxi+z4uyWpHxv/MujFU961AcppJZGMMAORmkk=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 356G6jts062106
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Jun 2023 11:06:45 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Jun 2023 11:06:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Jun 2023 11:06:44 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 356G6idY002944;
        Tue, 6 Jun 2023 11:06:44 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jan Kiszka <jan.kiszka@siemens.com>, Andrew Davis <afd@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 0/4] arm64: dts: ti: k3-am65: dtbs_check warnings fixups
Date:   Tue, 6 Jun 2023 11:06:39 -0500
Message-ID: <20230606160643.3618390-1-nm@ti.com>
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

Series of minor fixups for AM65x device tree to cleanup some of the
dtbs_check warnings.

Changes Since V1:
* Dropped syscon conversion and FSS node rename changes.

V1: https://lore.kernel.org/all/20230424144949.244135-1-nm@ti.com/

Nishanth Menon (4):
  arm64: dts: ti: k3-am65-main: Fix mux controller node name
  arm64: dts: ti: k3-am65-main: Fix mcan node name
  arm64: dts: ti: k3-am65-main: Drop deprecated ti,otap-del-sel property
  arm64: dts: ti: k3-am65-iot2050-common: Rename rtc8564 nodename

 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 2 +-
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi           | 3 +--
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            | 4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.40.0

