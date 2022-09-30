Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEAD5F0C6D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 15:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiI3N3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 09:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbiI3N3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 09:29:15 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465B818E69A;
        Fri, 30 Sep 2022 06:29:14 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28UDSu4V011928;
        Fri, 30 Sep 2022 08:28:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1664544536;
        bh=I1UC8gyIVfmg2sMFVE5Ztl0HTvXBIu19PRvLucy/UNw=;
        h=From:To:CC:Subject:Date;
        b=WJW/BTvY5clKtDMdQXJsv6V4e9HymESF4Hi7sLWIcYWG7JwrnXiP7QR8ebAqnTgam
         MR24Z68jZU9nUzfJ/O0yy4w6Q8sywk9Z6YM7UDCn4MO9dRI5hS2NTD7uNtHVeZfuBX
         X1EDUPdCotL1fuSuMKEs1I2WU0o7sMUo0DpmJRrc=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28UDSuh9074052
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Sep 2022 08:28:56 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 30
 Sep 2022 08:28:55 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 30 Sep 2022 08:28:55 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28UDSsOO011083;
        Fri, 30 Sep 2022 08:28:55 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <airlied@gmail.com>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <tomi.valkeinen@ideasonboard.com>,
        <dri-devel@lists.freedesktop.org>, <nm@ti.com>, <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rahul T R <r-ravikumar@ti.com>
Subject: [PATCH 0/2] Fix dp-pwr property in dp-connector binding
Date:   Fri, 30 Sep 2022 18:58:40 +0530
Message-ID: <20220930132842.23421-1-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the miss match in the binding and driver implementation for
dp power supply regulator property. Also fix it in the dp-connector
node instances in dt files

Rahul T R (2):
  dt-bindings: dp-connector: Fix the property name for dp pwr
  arm64: dts: ti: k3-j721e-*: Fix the property name for dp pwr

 .../devicetree/bindings/display/connector/dp-connector.yaml     | 2 +-
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts           | 2 +-
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts                          | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.37.3

