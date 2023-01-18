Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B91672036
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjAROyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjAROxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:53:54 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1CAEE5DC15;
        Wed, 18 Jan 2023 06:47:58 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.97,226,1669042800"; 
   d="scan'208";a="149830460"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 18 Jan 2023 23:47:58 +0900
Received: from mulinux.example.org (unknown [10.226.93.55])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id C45AE4007209;
        Wed, 18 Jan 2023 23:47:54 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH 0/3] Add PWC, uSD and eMMC support to RZ/V2M EVK
Date:   Wed, 18 Jan 2023 14:47:44 +0000
Message-Id: <20230118144747.24968-1-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        LOTS_OF_MONEY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

this series aims at adding uSD and eMMC support to the RZ/V2M EVK.
The uSD card bus voltage is controlled via one of GPIOs from the
PWC, therefore this series takes care of adding SoC specific
and board specific PWC support, too.

Thanks,
Fab

Fabrizio Castro (3):
  arm64: dts: renesas: r9a09g011: Add PWC support
  arm64: dts: renesas: v2mevk2: Add PWC support
  arm64: dts: renesas: v2mevk2: Add uSD card and eMMC support

 .../boot/dts/renesas/r9a09g011-v2mevk2.dts    | 127 ++++++++++++++++++
 arch/arm64/boot/dts/renesas/r9a09g011.dtsi    |   8 ++
 2 files changed, 135 insertions(+)

-- 
2.34.1

