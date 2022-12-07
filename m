Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F18D645A91
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiLGNRj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Dec 2022 08:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiLGNRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:17:37 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5CA100F;
        Wed,  7 Dec 2022 05:17:35 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 11B4C24E046;
        Wed,  7 Dec 2022 21:17:33 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 7 Dec
 2022 21:17:33 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX068.cuchost.com (172.16.6.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Wed, 7 Dec 2022 21:17:32 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        William Qiu <william.qiu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/3] StarFive's SDIO/eMMC driver support
Date:   Wed, 7 Dec 2022 21:17:28 +0800
Message-ID: <20221207131731.1291517-1-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset adds initial rudimentary support for the StarFive
designware mobile storage host controller driver. And this driver will
be used in StarFive's visionfive-v2 board. The main purpose of adding
this driver is to accommodate the ultra-high speed mode of eMMC.

The patch series is based on v6.1-rc5.

-- William

William Qiu (3):
  dt-bindings: mmc: Add bindings for StarFive
  mmc: starfive: Add sdio/emmc driver support
  riscv: dts: starfive: Add mmc node

 .../bindings/mmc/starfive,jh7110-sdio.yaml    |  71 +++++++
 MAINTAINERS                                   |   6 +
 .../jh7110-starfive-visionfive-v2.dts         |  25 +++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  38 ++++
 drivers/mmc/host/Kconfig                      |  10 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/dw_mmc-starfive.c            | 197 ++++++++++++++++++
 7 files changed, 348 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/starfive,jh7110-sdio.yaml
 create mode 100644 drivers/mmc/host/dw_mmc-starfive.c

--
2.34.1

