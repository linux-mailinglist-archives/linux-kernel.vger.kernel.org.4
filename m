Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0532642524
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbiLEIzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbiLEIyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:54:43 -0500
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDC5E64C1;
        Mon,  5 Dec 2022 00:54:01 -0800 (PST)
Received: from NTHCCAS01.nuvoton.com (NTHCCAS01.nuvoton.com [10.1.8.28])
        by maillog.nuvoton.com (Postfix) with ESMTP id 454FC1C8128E;
        Mon,  5 Dec 2022 16:53:59 +0800 (CST)
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 5 Dec 2022
 16:53:59 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 5 Dec 2022
 16:53:58 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Mon, 5 Dec 2022 16:53:58 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id AAE45637C4; Mon,  5 Dec 2022 10:53:57 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <ulf.hansson@linaro.org>, <avifishman70@gmail.com>,
        <tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
        <yuenn@google.com>, <benjaminfair@google.com>,
        <adrian.hunter@intel.com>, <skhan@linuxfoundation.org>,
        <davidgow@google.com>, <pbrobinson@gmail.com>, <gsomlo@gmail.com>,
        <briannorris@chromium.org>, <arnd@arndb.de>,
        <krakoczy@antmicro.com>, <andy.shevchenko@gmail.com>
CC:     <openbmc@lists.ozlabs.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v2 0/2] MMC: add NPCM SDHCI driver support
Date:   Mon, 5 Dec 2022 10:53:49 +0200
Message-ID: <20221205085351.27566-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds SDHCI support for the Nuvoton NPCM Baseboard 
Management Controller (BMC).

The NPCM SDHCI driver tested on NPCM750 and NPCM845 EVB.

Addressed comments from:
 - Rob Herring : https://www.spinics.net/lists/devicetree/msg556099.html
 - Andy Shevchenko : https://www.spinics.net/lists/devicetree/msg555247.html
 - Adrian Hunter : https://www.spinics.net/lists/devicetree/msg555583.html

Changes since version 1:
 - Use correct spaces in the dt-bindings.
 - Drop unused labels from dt-bindings.
 - Order by module name in the make a configuration.
 - Remove unnecessary blank lines.
 - Using devm_clk_get_optional instead of devm_clk_get.

Tomer Maimon (2):
  dt-bindings: mmc: npcm,sdhci: Document NPCM SDHCI controller
  mmc: sdhci-npcm: Add NPCM SDHCI driver

 .../devicetree/bindings/mmc/npcm,sdhci.yaml   | 45 ++++++++++
 drivers/mmc/host/Kconfig                      |  8 ++
 drivers/mmc/host/Makefile                     |  1 +
 drivers/mmc/host/sdhci-npcm.c                 | 84 +++++++++++++++++++
 4 files changed, 138 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/npcm,sdhci.yaml
 create mode 100644 drivers/mmc/host/sdhci-npcm.c

-- 
2.33.0

