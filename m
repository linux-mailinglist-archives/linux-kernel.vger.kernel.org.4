Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C106C0A13
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 06:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjCTFam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 01:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjCTFag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 01:30:36 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A74712BCA;
        Sun, 19 Mar 2023 22:30:33 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32K5UO3B126884;
        Mon, 20 Mar 2023 00:30:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679290224;
        bh=hi725RaUpEzAAtbgKkyMHSTidzd3jUkD8rMC1cgdjuM=;
        h=From:To:CC:Subject:Date;
        b=EBghntVgVVmK87eLgOdEVq5G7pPRsl0tGIriY19JiQIMOOYJqOpbg8hIdugMIdp4v
         gGTHtgsVXd3kz1OSbeoFu0kOsxFqKIi1z28iwSye4faQp4kwM/CZGhsNy1nCB0GQtG
         y0H32oYj+LmUWFTGyyxoHMN3c8n0mBD3Yrjnr1uE=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32K5UORf124477
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Mar 2023 00:30:24 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 20
 Mar 2023 00:30:24 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 20 Mar 2023 00:30:24 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32K5UMWU086045;
        Mon, 20 Mar 2023 00:30:23 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-keerthy@ti.com>, <u-kumar1@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH 0/8] arm64: dts: ti: j7: Add device-tree nodes for MCSPI
Date:   Mon, 20 Mar 2023 11:00:14 +0530
Message-ID: <20230320053022.11093-1-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
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

This series adds device tree nodes for Multi Channel Serial Peripheral
Interface (MCSPI) on J721E, J7200, J721S2 and J784S4 platforms. All the
MCSPI instances are disabled by default and can be enabled through overlays
as required, the changes were tested using spidev loopback test for all
instances and the data verified only for main_spi4 which is connected
internally as slave to mcu_spi2 for all existing J7 devices.

Vaishnav Achath (8):
  arm64: dts: ti: k3-j721e-main: Add MCSPI nodes
  arm64: dts: ti: k3-j721e-mcu-wakeup: Add MCSPI nodes
  arm64: dts: ti: k3-j7200-main: Add MCSPI nodes
  arm64: dts: ti: k3-j7200-mcu-wakeup: Add MCSPI nodes
  arm64: dts: ti: k3-j721s2-main: Add MCSPI nodes
  arm64: dts: ti: k3-j721s2-mcu-wakeup: Add MCSPI nodes
  arm64: dts: ti: k3-j784s4-main: Add MCSPI nodes
  arm64: dts: ti: k3-j784s4-mcu-wakeup: Add MCSPI nodes

 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 88 +++++++++++++++++++
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 33 +++++++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 88 +++++++++++++++++++
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      | 33 +++++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 88 +++++++++++++++++++
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 33 +++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 88 +++++++++++++++++++
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     | 33 +++++++
 8 files changed, 484 insertions(+)

-- 
2.17.1

