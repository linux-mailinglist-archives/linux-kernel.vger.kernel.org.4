Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7C76FC704
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbjEIMrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjEIMro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:47:44 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDEE4EDB;
        Tue,  9 May 2023 05:47:42 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 349ClUGJ072686;
        Tue, 9 May 2023 07:47:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683636451;
        bh=QpWO3rtAJjLjlYjBVx6o6tVU6JnMLfQiBZXs4f5ZKkI=;
        h=From:To:CC:Subject:Date;
        b=G6MqRbwWU1LHg9ZCE+DexFmxOV46I1w+1Krvrj4Ev22tBwq4yDY60I1VNd0VfdH3+
         WS2boPST/owvyGt2Hw7z+Peb4Lqq4eDMl1LRxzsJAQzndm/OONtam6X9WLIBH3Tltw
         os+l7hykD8KUL34Q3H5IyH4ATrP8Dufga1BQki6c=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 349ClUQY009299
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 May 2023 07:47:30 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 May 2023 07:47:30 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 May 2023 07:47:30 -0500
Received: from ul0491018.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 349ClRFD052292;
        Tue, 9 May 2023 07:47:28 -0500
From:   Thejasvi Konduru <t-konduru@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] Fix node has a unit name, but no reg/ranges property
Date:   Tue, 9 May 2023 18:17:24 +0530
Message-ID: <20230509124727.18375-1-t-konduru@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
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

This series of patches includes a DT compile time warning fix for
1. am65
2. j7200
3. j721e

Thejasvi Konduru (3):
  arm64: dts: ti: k3-am65-mcu: Fix node has a unit name, but no
    reg/ranges property
  arm64: dts: ti: k3-j721e-main: Fix node has a unit name, but no
    reg/ranges property
  arm64: dts: ti: k3-j7200-main: Fix node has a unit name, but no
    reg/ranges property

 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi   | 4 +++-
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 2 ++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.17.1

