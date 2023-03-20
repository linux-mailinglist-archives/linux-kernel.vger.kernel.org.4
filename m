Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07D06C09E8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 06:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjCTFNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 01:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCTFNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 01:13:51 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6150A5F2;
        Sun, 19 Mar 2023 22:13:49 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32K5DhGS051530;
        Mon, 20 Mar 2023 00:13:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679289223;
        bh=xY7Wwotry2c+F1FLEag7n4c3s52fzsG2beRtr53R3qE=;
        h=From:To:CC:Subject:Date;
        b=JC+pHSUcUdpkqVhztkG3MArHS5a79IKgeVCf6K4mftp2gE80rdfRinTl0J8ukboq2
         hrRAiS80laEFn7OsbGL666u1I9C3Hhb8q5jk2eMykklP7P9VyKdTrLVIF6eF/Ohi/V
         AwqBuO7dJ0I6njyHkSSB0VXcEcghc4I7mymcONMY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32K5Dh7W000527
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Mar 2023 00:13:43 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 20
 Mar 2023 00:13:42 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 20 Mar 2023 00:13:42 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32K5Ddsp046592;
        Mon, 20 Mar 2023 00:13:40 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] arm64: dts: ti: Introduce AM62x LP SK board support
Date:   Mon, 20 Mar 2023 10:43:01 +0530
Message-ID: <20230320051304.2730692-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This add DT support for AM62x LP SK board which has Automotive package
variant of AM62x SoC with LPDDR4 and OSPI NAND

Product link: https://www.ti.com/tool/SK-AM62-LP
Logs: https://gist.github.com/r-vignesh/0ad701f3df614cc5f90b6de775f2584e

Anand Gadiyar (2):
  arm64: dts: ti: Refractor AM625 SK dts
  arm64: ti: dts: Add support for AM62x LP SK

Vignesh Raghavendra (1):
  dt-bindings: arm: ti: k3: Add compatible for AM62x LP SK

 .../devicetree/bindings/arm/ti/k3.yaml        |   1 +
 arch/arm64/boot/dts/ti/Makefile               |   1 +
 arch/arm64/boot/dts/ti/k3-am625-sk.dts        | 237 +--------------
 arch/arm64/boot/dts/ti/k3-am62x-lp-sk.dts     | 227 +++++++++++++++
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 274 ++++++++++++++++++
 5 files changed, 504 insertions(+), 236 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62x-lp-sk.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi

-- 
2.40.0

