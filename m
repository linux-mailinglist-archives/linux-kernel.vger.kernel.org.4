Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFE465F505
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 21:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbjAEUM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 15:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbjAEUMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 15:12:53 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C691E19039;
        Thu,  5 Jan 2023 12:12:51 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,303,1665414000"; 
   d="scan'208";a="145308096"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 06 Jan 2023 05:12:50 +0900
Received: from mulinux.example.org (unknown [10.226.92.64])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id B0B16400515A;
        Fri,  6 Jan 2023 05:12:45 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH v4 0/2] Driver support for RZ/V2M PWC
Date:   Thu,  5 Jan 2023 20:12:40 +0000
Message-Id: <20230105201242.189195-1-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PWC IP found in the RZ/V2M family of chips fits the Multi-Function
Device (MFD) model quite well, and comes with the below capabilities:
* external power supply on/off sequence generation
* on/off signal generation for the LPDDR4 core power supply (LPVDD)
* key input signals processing
* general-purpose output pins

Version 4 of this series basically just moves the dt-bindings
file under Documentation/devicetree/bindings/soc/renesas.

Thanks,
Fab
Fabrizio Castro (2):
  dt-bindings: mfd: Add RZ/V2M PWC
  soc: renesas: Add PWC support for RZ/V2M

 .../soc/renesas/renesas,rzv2m-pwc.yaml        |  56 +++++++
 drivers/soc/renesas/Kconfig                   |   4 +
 drivers/soc/renesas/Makefile                  |   1 +
 drivers/soc/renesas/pwc-rzv2m.c               | 141 ++++++++++++++++++
 4 files changed, 202 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/renesas/renesas,rzv2m-pwc.yaml
 create mode 100644 drivers/soc/renesas/pwc-rzv2m.c

-- 
2.34.1

