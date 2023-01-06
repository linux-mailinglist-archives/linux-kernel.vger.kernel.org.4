Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE466600CC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 13:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbjAFM6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 07:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbjAFM62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 07:58:28 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 820C86B59C;
        Fri,  6 Jan 2023 04:58:26 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,305,1665414000"; 
   d="scan'208";a="145413761"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Jan 2023 21:58:25 +0900
Received: from mulinux.example.org (unknown [10.226.92.206])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7A49B4254DA6;
        Fri,  6 Jan 2023 21:58:20 +0900 (JST)
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
Subject: [PATCH v5 0/2] Driver support for RZ/V2M PWC
Date:   Fri,  6 Jan 2023 12:58:14 +0000
Message-Id: <20230106125816.10600-1-fabrizio.castro.jz@renesas.com>
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

The PWC IP found in the RZ/V2M family of chips comes with the below
capabilities:
* external power supply on/off sequence generation
* on/off signal generation for the LPDDR4 core power supply (LPVDD)
* key input signals processing
* general-purpose output pins

Version 5 of this series fixes subject line and changelog of the
dt-bindings patch.

Thanks,
Fab

Fabrizio Castro (2):
  dt-bindings: soc: renesas: Add RZ/V2M PWC
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

