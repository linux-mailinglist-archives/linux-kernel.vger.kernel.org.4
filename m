Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEFA661F24
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 08:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbjAIHWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 02:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbjAIHVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 02:21:55 -0500
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F917764D;
        Sun,  8 Jan 2023 23:21:50 -0800 (PST)
Received: from SHSend.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by SHSQR01.spreadtrum.com with ESMTP id 3097LDTM092591;
        Mon, 9 Jan 2023 15:21:13 +0800 (+08)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from ubt.spreadtrum.com (10.0.74.87) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Mon, 9 Jan 2023
 15:21:12 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH V3 0/3] Convert Unisoc GPIO bindings to yaml and add support for UMS512
Date:   Mon, 9 Jan 2023 15:21:03 +0800
Message-ID: <20230109072106.2176048-1-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.74.87]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 3097LDTM092591
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V3-resend:
- Added Reviewed-by from Rob Herring.

V3:
- Removed a example from sprd,gpio-eic.yaml;
- Added '|' at the beginning of description blocks;
- Added Reviewed-by tags from Krzysztof Kozlowski and Linus Walleij.

Changes on V2:
* Addressed review comments:
- Fixed typo;
- Added description for 'reg' property and modified its maxItems;
- Removed redundant examples;
- Rephrased commit message.

Chunyan Zhang (3):
  dt-bindings: gpio: Convert Unisoc GPIO controller binding to yaml
  dt-bindings: gpio: Convert Unisoc EIC controller binding to yaml
  dt-bindings: gpio: Add compatible string for Unisoc UMS512

 .../bindings/gpio/gpio-eic-sprd.txt           |  97 --------------
 .../devicetree/bindings/gpio/gpio-sprd.txt    |  28 ----
 .../bindings/gpio/sprd,gpio-eic.yaml          | 124 ++++++++++++++++++
 .../devicetree/bindings/gpio/sprd,gpio.yaml   |  75 +++++++++++
 4 files changed, 199 insertions(+), 125 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-sprd.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml
 create mode 100644 Documentation/devicetree/bindings/gpio/sprd,gpio.yaml

-- 
2.25.1

