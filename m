Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD306DD751
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 12:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjDKKD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 06:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDKKD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 06:03:56 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53FAC19A8;
        Tue, 11 Apr 2023 03:03:54 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.98,336,1673881200"; 
   d="scan'208";a="155587889"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 11 Apr 2023 19:03:53 +0900
Received: from localhost.localdomain (unknown [10.226.93.123])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id EB88D400F2DA;
        Tue, 11 Apr 2023 19:03:48 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/8] Enable DSI and ADV7535 on RZ/G2{L, LC} and RZ/V2L platforms
Date:   Tue, 11 Apr 2023 11:03:38 +0100
Message-Id: <20230411100346.299768-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.0 required=5.0 tests=AC_FROM_MANY_DOTS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series aims to Enable DSI by linking with ADV7535 on SMARC EVK
based on RZ/G2{L, LC} and RZ/V2L platforms.

patch#1 and #2 depend upon the binding patch [1]
[1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20230406171324.837247-1-biju.das.jz@bp.renesas.com/

patch #4 depend upon the binding patch [2]
[2] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20230406171324.837247-2-biju.das.jz@bp.renesas.com/

Biju Das (8):
  arm64: dts: renesas: r9a07g044: Add fcpvd node
  arm64: dts: renesas: r9a07g054: Add fcpvd node
  arm64: dts: renesas: r9a07g044: Add vspd node
  arm64: dts: renesas: r9a07g054: Add vspd node
  arm64: dts: renesas: r9a07g044: Add DSI node
  arm64: dts: renesas: r9a07g054: Add DSI node
  arm64: dts: renesas: rzg2l-smarc: Link DSI with ADV7535
  arm64: dts: renesas: rzg2lc-smarc: Link DSI with ADV7535

 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    | 53 +++++++++++++
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    | 54 +++++++++++++
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  | 79 +++++++++++++++++++
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi | 79 +++++++++++++++++++
 4 files changed, 265 insertions(+)

-- 
2.25.1

