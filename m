Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE0663BE06
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 11:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiK2KfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 05:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiK2KfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 05:35:16 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2965CB97;
        Tue, 29 Nov 2022 02:35:14 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 29 Nov 2022 19:35:13 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 03E5E2059054;
        Tue, 29 Nov 2022 19:35:13 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 29 Nov 2022 19:35:12 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 54998C1E22;
        Tue, 29 Nov 2022 19:35:12 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 0/8] dt-bidnings: soc: Introduce UniPhier miscelaneous register blocks
Date:   Tue, 29 Nov 2022 19:35:01 +0900
Message-Id: <20221129103509.9958-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces dt-bindings documents for miscellaneous register
blocks implemented in Socionext Uniphier SoCs.

These are previously defined in the devicetree and used in the examples of
subnodes' dt-bindings, however, not documented.

These include two types of the blocks

* independent block including miscellaneous registers and functions for
  the whole SoC (system controller and SoC-glue logic)

* sideband logic including control registers in the component (others)

This series is part of the previous series shown below:
https://lore.kernel.org/linux-arm-kernel/20221107103410.3443-2-hayashi.kunihiko@socionext.com

Kunihiko Hayashi (8):
  dt-bindings: soc: socionext: Add UniPhier system controller
  dt-bindings: soc: socionext: Add UniPhier SoC-glue logic
  dt-bindings: soc: socionext: Add UniPhier peripheral block
  dt-bindings: soc: socionext: Add UniPhier media I/O block
  dt-bindings: soc: socionext: Add UniPhier SD interface block
  dt-bindings: soc: socionext: Add UniPhier ADAMV block
  dt-bindings: soc: socionext: Add UniPhier DWC3 USB glue layer
  dt-bindings: soc: socionext: Add UniPhier AHCI glue layer

 .../socionext/socionext,uniphier-adamv.yaml   |  52 +++++++++
 .../socionext,uniphier-ahci-glue.yaml         |  78 +++++++++++++
 .../socionext,uniphier-dwc3-glue.yaml         | 106 ++++++++++++++++++
 .../socionext/socionext,uniphier-mioctrl.yaml |  67 +++++++++++
 .../socionext,uniphier-perictrl.yaml          |  67 +++++++++++
 .../socionext/socionext,uniphier-sdctrl.yaml  |  63 +++++++++++
 .../socionext,uniphier-soc-glue.yaml          |  94 ++++++++++++++++
 .../socionext/socionext,uniphier-sysctrl.yaml |  84 ++++++++++++++
 MAINTAINERS                                   |   1 +
 9 files changed, 612 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-adamv.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-ahci-glue.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-dwc3-glue.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-mioctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-perictrl.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sdctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sysctrl.yaml

-- 
2.25.1

