Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7956F0470
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 12:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243413AbjD0KsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 06:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243448AbjD0KsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 06:48:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F995256;
        Thu, 27 Apr 2023 03:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1682592483; x=1714128483;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DJAw9VNz1ZsUBRAPmSWDnMHm4RxRMWbc9EwxSgNFsyA=;
  b=2bt6Ah9diZX4DTTTzlc7YnQnFXGyt/6Kf4Na4tefrB6wRUrwmeS+lD22
   pUguPvIZfIUiOFwM2NQAIIJk+MvqcBCC8Qu6eNBmN8EZvYZKSzZ7p31e8
   4FYK12JKU4Nfb47LnsDmB3McGUWTVg3ttFZJ1bGpzZlPWAfO8nomqg6cv
   TXGj3UC83cdFkBVrwk2Dj2rg/viKMJVZCQqHwpHkYOn952D3fD9Ew7Rki
   jnt9mCAkNsHMB1BJsZ5l9wovueDNJ02mjIecseyEixLvGnRr46dHvZjaI
   AC41mIFb9Ra9lGPVHpEGfocHiIG/ld92wJw7ybsN+kwVyRoqPShfAwBo+
   A==;
X-IronPort-AV: E=Sophos;i="5.99,230,1677567600"; 
   d="scan'208";a="211435929"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Apr 2023 03:48:02 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 27 Apr 2023 03:48:01 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Thu, 27 Apr 2023 03:47:59 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <palmer@dabbelt.com>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] dt-bindings: riscv: explicitly mention assumption of Zicsr & Zifencei support
Date:   Thu, 27 Apr 2023 11:43:42 +0100
Message-ID: <20230427-fence-blurred-c92fb69d4137@wendy>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1731; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=DJAw9VNz1ZsUBRAPmSWDnMHm4RxRMWbc9EwxSgNFsyA=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDClegdfq/j3oPnKMb1NS3+TYBa7qN1tclAtfvXphfWnXyXx2 9/bsjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEykai4jw93ZultuPgqb/fbiv19RZ+ WthEL+JXDOi5AWWcEZrctuc5iR4c6uQ/7qxdpei0/3/YlSq1K7lPTYfsWKuy+bbCS5X3d/YgYA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dt-binding was defined before the extraction of csr access and
fence.i into their own extensions, and thus the presence of the I
base extension implies Zicsr and Zifencei.
There's no harm in adding them obviously, but for backwards
compatibility with DTs that existed prior to that extraction, software
is unable to differentiate between "i" and "i_zicsr_zifencei" without
any further information.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Conor Dooley <conor@kernel.org>
CC: Rob Herring <robh+dt@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: linux-riscv@lists.infradead.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 4c7ce4a37052..a93bc7eae928 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -85,6 +85,12 @@ properties:
       User-Level ISA document, available from
       https://riscv.org/specifications/
 
+      Due to revisions of the ISA specification, some deviations
+      have arisen over time.
+      Notably, riscv,isa was defined prior to the creation of the
+      Zicsr and Zifencei extensions and thus "i" implies
+      "zicsr_zifencei".
+
       While the isa strings in ISA specification are case
       insensitive, letters in the riscv,isa string must be all
       lowercase to simplify parsing.
-- 
2.39.2

