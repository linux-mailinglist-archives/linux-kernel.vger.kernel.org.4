Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF366C4ADC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 13:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjCVMkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 08:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjCVMkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:40:02 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82FA4DE15;
        Wed, 22 Mar 2023 05:39:59 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32MCdglT122562;
        Wed, 22 Mar 2023 07:39:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679488782;
        bh=N+WOksGlwcM4nkoCKu/DS0IXriJ6erCaExgqr/mPfQw=;
        h=From:Subject:Date:To:CC;
        b=KrI8WOaL9gr8C5obxzys18vjBmVHZYLuM6XZoSEGCvppnFmv/WgGB6ayzwG/4scgY
         OndaogTOdnsqWvTnTRrRooeeWPrJ8q3/gmI72/jRn7x0f3xYHEDJOZtCGnz4hmo/IA
         JuCzLDiYDoforlxw6mG0hE2VL7ppZtemJP/GEad4=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32MCdgv3006959
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Mar 2023 07:39:42 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 22
 Mar 2023 07:39:42 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 22 Mar 2023 07:39:41 -0500
Received: from [127.0.1.1] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32MCdcnX098356;
        Wed, 22 Mar 2023 07:39:39 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v2 0/3] arm64: dts: ti: Introduce AM62x LP SK board support
Date:   Wed, 22 Mar 2023 18:09:19 +0530
Message-ID: <20230321-am62-lp-sk-v2-0-0a56e1694804@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPf2GmQC/02Nyw6CMBBFf8V07ZA+sERX/odxMeBAJ0ghU0QTw
 r9bXLk8uffkrCqRMCV1OaxKaOHEY8xgjwfVBIwdAT8yK6ut084awMFbeE6QeqDKVx49Yl0alYU
 aE0EtGJuwK/sT4Y09vaZ9noRa/vxat3vmVsYB5iCE/wWtT8bpsrCV0/5swcDCXaQU5Dpz0YyD2
 rYvW9Kk+bYAAAA=
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        "Tero Kristo" <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lore.kernel.org/r/20230320051304.2730692-1-vigneshr@ti.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        Anand Gadiyar <gadiyar@ti.com>
X-Mailer: b4 0.12.2
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This add DT support for AM62x LP SK board which has Automotive package
variant of AM62x SoC with LPDDR4 and OSPI NAND

Product link: https://www.ti.com/tool/SK-AM62-LP
Logs: https://gist.github.com/r-vignesh/0ad701f3df614cc5f90b6de775f2584e

Since v1:
Drop wild card 'x' and rename compatible and dts file to am62-lp-sk.dts
as suggested by Krzysztof.

v1: lore.kernel.org/r/20230320051304.2730692-1-vigneshr@ti.com

--
2.40.0

---
Anand Gadiyar (2):
      arm64: dts: ti: Refractor AM625 SK dts
      arm64: ti: dts: Add support for AM62x LP SK

Vignesh Raghavendra (1):
      dt-bindings: arm: ti: k3: Add compatible for AM62x LP SK

 Documentation/devicetree/bindings/arm/ti/k3.yaml |   1 +
 arch/arm64/boot/dts/ti/Makefile                  |   1 +
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts         | 227 ++++++++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts           | 237 +-------
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi   | 274 ++++++++++
 5 files changed, 504 insertions(+), 236 deletions(-)
---
base-commit: f3594f0204b756638267242e26d9de611435c3ba
change-id: 20230321-am62-lp-sk-e7676a6aab41

Best regards,
-- 
Vignesh

