Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471AD73588C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjFSN3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjFSN3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:29:20 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C91123;
        Mon, 19 Jun 2023 06:29:19 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35JDTDbG062977;
        Mon, 19 Jun 2023 08:29:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1687181353;
        bh=0IhZwEKQQOcpbqrlvSqmdxEryZDlXmPaSobN0FNJ3GQ=;
        h=From:Subject:Date:To:CC;
        b=YEyHNej95cBpYWt5dn8bAb9zg3m3ZRLOBTTcUSX40YKeWEfPQ8VVmZv/ABjDSNAdX
         74M4mseb5G/vpnAWVzB/cNTLeD9OISSSP1AKscFWl6cAS3VKvUAXFgby/H/kwQTlbZ
         4AtUC6QfcHCqbo1DkwnvaNdypZLpSN5WGqEQy3ow=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35JDTDQN003887
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Jun 2023 08:29:13 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 19
 Jun 2023 08:29:13 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 19 Jun 2023 08:29:12 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35JDTCoc008663;
        Mon, 19 Jun 2023 08:29:12 -0500
From:   Kamlesh Gurudasani <kamlesh@ti.com>
Subject: [PATCH v3 0/2] Remove power-domains property for devices with
 compatible ti,am62-sa3ul
Date:   Mon, 19 Jun 2023 18:58:46 +0530
Message-ID: <20230614-sa3ul-v3-0-2eeb810327a1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA5YkGQC/12NwQ6CMBBEf4Xs2RroNgY9+R+GQ7ddZRMB061EQ
 /h3C0ePb+ZlZgHlJKxwqRZIPIvKNBbAQwWh9+ODjcTCYGuL9alxRj2+nyaQo9gQuVi3UFzyyoa
 SH0O/2YPXzGkrXonv8tkPbl3hXjRP6bv/zXZL/6dnaxqDvkVLrUU8h2uWY5gG6NZ1/QH8M47Es
 AAAAA==
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jayesh Choudhary <j-choudhary@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kamlesh Gurudasani <kamlesh@ti.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687181351; l=1143;
 i=kamlesh@ti.com; s=20230614; h=from:subject:message-id;
 bh=8QyvRD8xZGPk0AYXE76qhzGByJhvCtRdRURpCf2p8DY=;
 b=f7Pu23xcXtY9sXiEhDtNtMYFY+SBJe8DyR+PSWeZxtIi9ELWOTtzppM9ZVUqvPPo364gL2Ll4
 aeaE/h3xqg9DkRZnMjesfur/64/Xe5+m/qFOnz5EuNPfolph7GtDMz1
X-Developer-Key: i=kamlesh@ti.com; a=ed25519;
 pk=db9XKPVWDGJVqj2jDqgnPQd6uQf3GZ3oaQa4bq1odGo=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,TVD_SUBJ_WIPE_DEBT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Changes in v2:
-make commit message clearer

Changes in v3:
- Add patch dt-bindings: crypto: ti,sa2ul: make power-domains conditional
- Link to v2: https://lore.kernel.org/r/20230614-sa3ul-v2-1-3a832b82339c@ti.com

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

