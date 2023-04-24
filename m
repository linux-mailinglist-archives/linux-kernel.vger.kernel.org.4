Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF896ECB2F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjDXLT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjDXLT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:19:57 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0580526A3;
        Mon, 24 Apr 2023 04:19:56 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33OBJnMX082585;
        Mon, 24 Apr 2023 06:19:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682335189;
        bh=hruX9XcQXV26OqZbHYGiqc1ofW49Lz0oe/NSRRKPtWQ=;
        h=From:To:CC:Subject:Date;
        b=qVPDOcmTXYRehGkxstCfGWvft0Onsul2bilsta06E/hvFH5pVQEXhODJs/2Qu9vX+
         8GsBv30DBctjNAtaGpV/9fM+bB7eUh8sV6llppMwWzuFGEUf4PaX4tv6TOf75Qbna9
         f2CAmioY/WmMsBeVxMiDg3FWlcUE6Iyf/SM2d4G0=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33OBJnr5019169
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Apr 2023 06:19:49 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 24
 Apr 2023 06:19:49 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 24 Apr 2023 06:19:49 -0500
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33OBJjiW100294;
        Mon, 24 Apr 2023 06:19:46 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <afd@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [RFC PATCH 0/2] Add support for CPSW3G port 2 on AM62A7-SK
Date:   Mon, 24 Apr 2023 16:49:43 +0530
Message-ID: <20230424111945.3865240-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
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

Hello,

This series adds support for CPSW3G MAC port 2 with the SK-Ethernet-DC01
Add-On daughtercard. Also, the missing alias for CPSW3G MAC Port 1 is
added to the am62a7-sk board file in order to allow kernel to fetch MAC
address populated by U-Boot for CPSW3G MAC Port 1.

This series has been developed and tested on linux-next tagged
next-20230421.

Regards,
Siddharth.

Siddharth Vadapalli (2):
  arm64: dts: ti: k3-am62a7-sk: Add alias for CPSW3G MAC port 1
  arm64: dts: ti: k3-am62a7: Add overlay for second CPSW3G Port

 arch/arm64/boot/dts/ti/Makefile               |  2 +
 .../dts/ti/k3-am62a7-sk-ethernet-dc01.dtso    | 61 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts       |  1 +
 3 files changed, 64 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a7-sk-ethernet-dc01.dtso

-- 
2.25.1

