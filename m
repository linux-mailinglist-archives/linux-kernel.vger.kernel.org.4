Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A0E61FA81
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbiKGQvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbiKGQvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:51:06 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4405823E81;
        Mon,  7 Nov 2022 08:50:40 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,145,1665414000"; 
   d="scan'208";a="141793940"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 08 Nov 2022 01:50:40 +0900
Received: from mulinux.home (unknown [10.226.92.51])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2CAFB40078CD;
        Tue,  8 Nov 2022 01:50:35 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Wolfram Sang <wsa@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH v2 0/2] Fix r9a09g011 specific I2C compatible string
Date:   Mon,  7 Nov 2022 16:50:25 +0000
Message-Id: <20221107165027.54150-1-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

The preferred form for Renesas' compatible strings is:
"<vendor>,<family>-<module>"

Somehow the compatible string for the r9a09g011 I2C IP was upstreamed
as renesas,i2c-r9a09g011 instead of renesas,r9a09g011-i2c, which
is really confusing, especially considering the generic fallback
is renesas,rzv2m-i2c.

Since it's early days for r9a09g011.dtsi, and compatible
renesas,i2c-r9a09g011 isn't being actively used at the moment,
I think it's safe to change to make compatible strings less
confusing.

v2 - Improved changelogs

Thanks,
Fab
Fabrizio Castro (2):
  dt-bindings: i2c: renesas,rzv2m: Fix SoC specific string
  arm64: dts: renesas: r9a09g011: Fix I2C SoC specific strings

 Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml | 4 ++--
 arch/arm64/boot/dts/renesas/r9a09g011.dtsi               | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.34.1

