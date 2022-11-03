Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEEF618A02
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiKCU4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiKCUzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:55:55 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCB720F61
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 13:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=JWjIjltlEQXtONld3iwSzFWfb1s
        APlyroiYNxkfAmBQ=; b=rxRDac/XSEVNcpceFHptYTNrmGWgOJ8+sjNdQZEZovo
        4ZA7x5wemWPUC3+Z3+xvfmD5eYPjErYGgvO2pan0sLrJTC7+nlXBp5yhP4O28/jH
        eFpd6BVCuAH+a3GJveUuEUZLMFaoDCFotGBiEa7AgsK5LCCVOUv0fzAj4Gp93CJI
        =
Received: (qmail 2787654 invoked from network); 3 Nov 2022 21:55:51 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Nov 2022 21:55:51 +0100
X-UD-Smtp-Session: l3s3148p1@8EKvLpfsuOUujns0
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] r8a779g0: add TMU support
Date:   Thu,  3 Nov 2022 21:55:41 +0100
Message-Id: <20221103205546.24836-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the clk and DTS changes to enable TMU timers on the R-Car V4H
based WhiteHawk board. Tested with the 'clocksource-switch' selftest.
Nothing special, very similar to S4-8. Happy hacking!

Wolfram Sang (4):
  clk: renesas: r8a779g0: Add TMU and SASYNCRT clocks
  arm64: dts: renesas: r8a779g0: Add TMU nodes
  arm64: dts: renesas: white-hawk-cpu: sort RWDT entry correctly
  TEST: arm64: dts: renesas: white-hawk-cpu: Enable TMU

 .../dts/renesas/r8a779g0-white-hawk-cpu.dtsi  | 24 ++++++-
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi     | 65 +++++++++++++++++++
 drivers/clk/renesas/r8a779g0-cpg-mssr.c       |  6 ++
 3 files changed, 93 insertions(+), 2 deletions(-)

-- 
2.35.1

