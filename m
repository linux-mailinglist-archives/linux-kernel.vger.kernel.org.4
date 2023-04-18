Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3588E6E6E67
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbjDRViG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbjDRVh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:37:57 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB82CCE;
        Tue, 18 Apr 2023 14:37:56 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33ILbjFl036038;
        Tue, 18 Apr 2023 16:37:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681853865;
        bh=+5T1cgVD+6vlVdPmFZXeko/SbvSRaJlD1F3nvltuPx8=;
        h=From:To:CC:Subject:Date;
        b=v4yTvmm+V89iXocAL3OKXrC0OKJIegEsWfWYBNtVcRFfrEX6RVmU4xLmQnRqaUM2t
         YXWr3UUxlcBNofTdL5xJMopms1fANCQcpbzPuEyLiVPUG/2MEaf2G02OdT0l+A+yYQ
         i1x2xCU0zAOD/c4LgfXRThAV+7yJRBqaQ8Mcv9fQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33ILbjCN019355
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Apr 2023 16:37:45 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 18
 Apr 2023 16:37:45 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 18 Apr 2023 16:37:45 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33ILbjec041274;
        Tue, 18 Apr 2023 16:37:45 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/4] arm64: dts: ti: k3-am62x-sk-common: Cleanups and minor additions
Date:   Tue, 18 Apr 2023 16:37:36 -0500
Message-ID: <20230418213740.153519-1-nm@ti.com>
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

This is a result of looking to cleanup u-boot and realizing there are
pieces missing in kernel that need to be pushed out.

So, minor cleanups and adding a few missing pieces.

Bootlog: https://gist.github.com/nmenon/5e18c8d02c13cf00db649b6f01971d99

Nishanth Menon (4):
  arm64: dts: ti: k3-am62x-sk-common: Drop extra EoL
  arm64: dts: ti: k3-am62x-sk-common: Describe main_uart1 and wkup_uart
  arm64: dts: ti: k3-am62x-sk-common: Add eeprom
  arm64: dts: ti: k3-am62x-sk-common: Improve documentation of
    mcasp1_pins

 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 39 ++++++++++++++++---
 1 file changed, 34 insertions(+), 5 deletions(-)

-- 
2.40.0

