Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9376B37AD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 08:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjCJHq2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Mar 2023 02:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjCJHqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 02:46:03 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B4B2ED41;
        Thu,  9 Mar 2023 23:45:07 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 0F0B724E24E;
        Fri, 10 Mar 2023 15:45:05 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 10 Mar
 2023 15:45:05 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX068.cuchost.com (172.16.6.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Fri, 10 Mar 2023 15:45:03 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <devicetree@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        William Qiu <william.qiu@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>
Subject: [PATCH v2 0/2] StarFive's Pulse Width Modulation driver support
Date:   Fri, 10 Mar 2023 15:45:01 +0800
Message-ID: <20230310074503.155131-1-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset adds initial rudimentary support for the StarFive
Pulse Width Modulation controller driver. And this driver will
be used in StarFive's VisionFive 2 board.The first patch add
Documentations for the device and Patch 2 adds device probe for
the module.

Changes v1->v2:
- Renamed the dt-binding 'pwm-starfive.yaml' to 'starfive,jh7110-pwm.yaml'.
- Dropped the compatible's Items.
- Dropped the unuse defines.
- Modified the code to follow the Linux coding style.
- Changed return value to dev_err_probe.
- Dropped the unnecessary local variable.

The patch series is based on v6.2.

William Qiu (2):
  dt-bindings: PWM: Add StarFive PWM module
  pwm: starfive: Add PWM driver support

 .../bindings/pwm/starfive,jh7110-pwm.yaml     |  53 ++++
 MAINTAINERS                                   |   7 +
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-starfive-ptc.c                | 245 ++++++++++++++++++
 5 files changed, 316 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/starfive,jh7110-pwm.yaml
 create mode 100644 drivers/pwm/pwm-starfive-ptc.c

--
2.34.1

