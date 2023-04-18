Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B476E566A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 03:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjDRB1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 21:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjDRB12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:27:28 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B1C2D79;
        Mon, 17 Apr 2023 18:27:27 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33I1RIg5007800;
        Mon, 17 Apr 2023 20:27:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681781238;
        bh=Of7HHWk/aqFbkXN6zZ3p7OKc+toNQyjl37HgSMUNRu4=;
        h=From:To:CC:Subject:Date;
        b=YW2g0ZwrHSncy8Um1PA0HQ8T1r0bsoPtvhO07AxAkEeA52WV+rUsT+a8Ya5ZkwOMk
         hKa3gl6sP+9Tl/27jS4eL/Og1aFAZSo1/BjthKL018lgg9KOEYl3cBVkFsjJMgNvJa
         ZZd41WsHiD+bcqDSLfNNMqq9wTOr7iox2bqnDL8U=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33I1RIuk115910
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Apr 2023 20:27:18 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 17
 Apr 2023 20:27:18 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 17 Apr 2023 20:27:18 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33I1RItK041844;
        Mon, 17 Apr 2023 20:27:18 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH 0/3] arm64: dts: ti: k3-am62a: Add timers, wdt and fixup
Date:   Mon, 17 Apr 2023 20:27:14 -0500
Message-ID: <20230418012717.1230882-1-nm@ti.com>
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

Hi,

This is a series that adds wdt, timers to am62ax support, and adds the
missing description for uart1 and wkup_uart that is used by firmware.

Nishanth Menon (3):
  arm64: dts: ti: k3-am62a: Add general purpose timers
  arm64: dts: ti: k3-am62a: Add watchdog nodes
  arm64: dts: ti: k3-am62a7-evm: Describe main_uart1 and wkup_uart

 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi   | 141 ++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi    |  56 ++++++++
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi |  11 ++
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts     |  36 +++++
 4 files changed, 244 insertions(+)

-- 
2.40.0

