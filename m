Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6261873662C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 10:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjFTI2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 04:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjFTI2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 04:28:30 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA4619B;
        Tue, 20 Jun 2023 01:28:26 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35K8SHrn078194;
        Tue, 20 Jun 2023 03:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1687249697;
        bh=1TtkVf2Tto/at6H2rAWfzX+S3Mo+7puUHIeHSEn+4H4=;
        h=From:Subject:Date:To:CC;
        b=j734Dq1ofAbK3MH/BTM8Je4qqJPzI+CFojroH4Shxyp7jMrKgyTUzU9TEwtVbNpcI
         Xkcd1mn7UvUSQAvBPcOisjmUnGqGIWEvvac7wMKXzFYJRL331qNhG/fuqRXCHtJQRs
         iXMjzgOUhNqkBODCpYFbpFC8/SeyXXigRNG+C3zU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35K8SHgG022379
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Jun 2023 03:28:17 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Jun 2023 03:28:16 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Jun 2023 03:28:16 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35K8SGlj094303;
        Tue, 20 Jun 2023 03:28:16 -0500
From:   Kamlesh Gurudasani <kamlesh@ti.com>
Subject: [PATCH v4 0/2] Remove power-domains property for devices with
 compatible ti,am62-sa3ul
Date:   Tue, 20 Jun 2023 13:56:58 +0530
Message-ID: <20230614-sa3ul-v4-0-7c969f626796@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANJikWQC/22NQQ7CIBBFr9KwdgwwRNGV9zAuGDpaEtsaqETT9
 O5CFy6My/fnv/mzSBwDJ3FsZhE5hxTGoYDZNMJ3brgxhLaw0FKj3CkDyeHzDp4MtYrItNKK0iW
 XGCi6wXe13bs0cayHR+RreK0D50vhLqRpjO91L+ua/r7OGhSgs6jJasSDP01h68deVD3jXwVBg
 mYmqyTqvVNfZVmWDy7m3cnjAAAA
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jayesh Choudhary <j-choudhary@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kamlesh Gurudasani <kamlesh@ti.com>,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687249695; l=1328;
 i=kamlesh@ti.com; s=20230614; h=from:subject:message-id;
 bh=ST262oFisiDch2+16ED+cqDo/T9OI2VS2nMCHWhazhQ=;
 b=bvHAdJliZCMkZWv/NeVdt/8gtovLbM+iTnBJTd1PB5tpt9OclS/szWE8Lwvd+tu2sJt219bXG
 apLBya26aj0BNv6KkMvhnKJr6eRGz/G5qb6dxSFkoRaKCpX+TadeRwv
X-Developer-Key: i=kamlesh@ti.com; a=ed25519;
 pk=db9XKPVWDGJVqj2jDqgnPQd6uQf3GZ3oaQa4bq1odGo=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,TVD_SUBJ_WIPE_DEBT,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SYSFW don't allow access to power of devices with compatible ti,am62-sa3ul
from main domain.

Power-domains property, if present will try to access the power of the
device, which will result into failure in probing of driver for that
device.

Make power-domains property as false for devices with compatible
ti,am62-sa3ul.

Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
---
Changes in v4:
- s/items/contains/ for dt-binding patch
- Added "fixes commit" for dt-binding patch
- Link to v3: https://lore.kernel.org/r/20230614-sa3ul-v3-0-2eeb810327a1@ti.com

Changes in v3:
- Add patch dt-bindings: crypto: ti,sa2ul: make power-domains conditional
- Link to v2: https://lore.kernel.org/r/20230614-sa3ul-v2-1-3a832b82339c@ti.com

Changes in v2:
- Make commit message clearer

---
Kamlesh Gurudasani (2):
      dt-bindings: crypto: ti,sa2ul: make power-domains conditional
      arm64: dts: ti: k3-am62-main: Remove power-domains from crypto node

 Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml | 14 +++++++++++++-
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi               |  1 -
 2 files changed, 13 insertions(+), 2 deletions(-)
---
base-commit: 53ab6975c12d1ad86c599a8927e8c698b144d669
change-id: 20230614-sa3ul-cb4bd1bb4d08

Best regards,
-- 
Kamlesh Gurudasani <kamlesh@ti.com>

