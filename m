Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E251F6E6A32
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbjDRQws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjDRQwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:52:35 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3477493C8;
        Tue, 18 Apr 2023 09:52:30 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33IGqEpN076778;
        Tue, 18 Apr 2023 11:52:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681836734;
        bh=W75yG1FbhHDO6azc5l11+tUUPGbR5d0f1ih4ZwyOmN8=;
        h=From:To:CC:Subject:Date;
        b=AtrJ7iGbs7lvaFxdajlDXqL+3HvqxLpUlGgrvpGsZeI/b/W+6sas5ibleZggVtwOp
         IRa1BkrQJ7ZYLtizektQxQh22VmxpJoaizlw9z9JV/UYT5Fys6kCXu8PMbRzTTFIE1
         6cr7gXO+sQcjnN/uGryYVUyUbcpe3GWE77FnQHk0=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33IGqELQ012864
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Apr 2023 11:52:14 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 18
 Apr 2023 11:52:14 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 18 Apr 2023 11:52:14 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33IGqELQ011969;
        Tue, 18 Apr 2023 11:52:14 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/5] arm64: dts: ti: Drop bootargs
Date:   Tue, 18 Apr 2023 11:52:07 -0500
Message-ID: <20230418165212.1456415-1-nm@ti.com>
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

This has come up multiple times, so cleaning it all up.
See [1] for context. AM64 is covered in [2].

Nishanth Menon (5):
  arm64: dts: ti: k3-am62x-sk-common: Drop bootargs
  arm64: dts: ti: k3-am65*: Drop bootargs
  arm64: dts: ti: k3-j721e-*: Drop bootargs
  arm64: dts: ti: k3-j7200-common-proc-board: Drop bootargs
  arm64: dts: ti: k3-j721s2-common-proc-board: Drop bootargs

 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi         | 1 -
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi     | 1 -
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts         | 1 -
 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts  | 1 -
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts  | 1 -
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts                 | 1 -
 arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts | 1 -
 7 files changed, 7 deletions(-)

[1] https://lore.kernel.org/linux-arm-kernel/81134eb9-2b7d-05bc-3035-a47f020861a8@linaro.org/
[2] https://lore.kernel.org/all/20230414073328.381336-1-nm@ti.com/
-- 
2.40.0

