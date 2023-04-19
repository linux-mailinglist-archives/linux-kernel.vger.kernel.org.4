Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC7E6E7BFF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjDSONn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjDSON0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:13:26 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA3A183A2;
        Wed, 19 Apr 2023 07:12:37 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33JECPC7106816;
        Wed, 19 Apr 2023 09:12:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681913545;
        bh=cYC7D6llkars5hMbhgZ9+x6mWTSmTBTNPojEt81eB2A=;
        h=From:To:CC:Subject:Date;
        b=REXgPdFtMDcvFy7QwLGry9oxVp08/W/h6BCqja9P2aR8ttgDom7YgEI3aYXKhTdYS
         ZtW3CyMUIWpc+bNE+Nc0BNcoSmmAgO5jm1Fv1JQLRN3duyNPCkv0SuSK7Z9LKgROmM
         0pL2TOauOa1tQrrITx6n/5mZ7zxjPJ8b81OusVnM=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33JECPPP095438
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Apr 2023 09:12:25 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 19
 Apr 2023 09:12:24 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 19 Apr 2023 09:12:24 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33JECOZI030195;
        Wed, 19 Apr 2023 09:12:24 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 0/5] arm64: dts: ti: Drop bootargs
Date:   Wed, 19 Apr 2023 09:12:17 -0500
Message-ID: <20230419141222.383567-1-nm@ti.com>
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

The bootargs atm contains (generally) two information: console and
earlycon - console is already covered by stdout-path and earlycon is
really meant to be used when debug is needed and not something of a
default to spin out to all users.

This has come up multiple times, so cleaning it all up.
See [1] for context. AM64 is covered in [2]. There are quite a few other
instances of the same in mailing list[3].

Changes since V1:
* No functional changes
* Commit message update to be verbose as to the rationale.
* Picked up Roger's and Krzysztof's acks.

V1: https://lore.kernel.org/all/20230418165212.1456415-1-nm@ti.com/

[1] https://lore.kernel.org/linux-arm-kernel/81134eb9-2b7d-05bc-3035-a47f020861a8@linaro.org/
[2] https://lore.kernel.org/all/20230414073328.381336-1-nm@ti.com/
[3] https://lore.kernel.org/linux-devicetree/?q=Krzysztof+bootargs

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

-- 
2.40.0

