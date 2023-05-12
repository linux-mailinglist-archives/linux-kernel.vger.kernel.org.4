Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BB7700126
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 09:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240288AbjELHMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 03:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240259AbjELHLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 03:11:55 -0400
X-Greylist: delayed 601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 12 May 2023 00:09:33 PDT
Received: from first.geanix.com (first.geanix.com [116.203.34.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5030F11D87;
        Fri, 12 May 2023 00:09:33 -0700 (PDT)
Received: from xps.skovby (85.184.138.13.dynamic.dhcp.aura-net.dk [85.184.138.13])
        by first.geanix.com (Postfix) with ESMTPSA id EA71C4E50D4;
        Fri, 12 May 2023 06:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1683874179; bh=ftg3uIR+C7op/jYgo/Ad5XVflC5LGRCa0S30bZueYD8=;
        h=From:To:Cc:Subject:Date;
        b=CkHB8fFwaUPSp3vdx/UHgxaMip2Lp7BU1d/yW23VIBKOMM/EonZBRCy4EjZNVyDG0
         jQeBANogMnw6wYt7a9jjf+1BDWOlqOCtAy4PaGdb2vmpE3xxShwW570J9xMfbltmz6
         hgyU8J3C6Q4zM7ybUR+G1AxgNIplLB2cnxPEWUZIQX2zB2HeYPG3Y3vl2PBKHc46RD
         r/yvMLCpfwXx36UcmpryPAFiQKJWgHc9Ar8NVnbnOv1f/4yPqE9b46w01XKoYWN3dX
         VjQPEevgaRzaUeFVSV8NGVrf99b4sbnpGeaOpSoRduAOJqvCL6xYQOKNGUxpprbi05
         6GkaQ8hXlbFZw==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        stable@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] pinctrl: meson-axg: add missing GPIOA_18 gpio group
Date:   Fri, 12 May 2023 08:49:25 +0200
Message-Id: <20230512064925.133516-1-martin@geanix.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this, the gpio cannot be explicitly mux'ed to its gpio function.

Fixes: 83c566806a68a ("pinctrl: meson-axg: Add new pinctrl driver for Meson AXG SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Martin Hundebøll <martin@geanix.com>
---
Changes since first mail:
 * Added Cc: stable to commit message
 * Expanded To: and Cc: with full list from get_maintainers.pl

 drivers/pinctrl/meson/pinctrl-meson-axg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg.c b/drivers/pinctrl/meson/pinctrl-meson-axg.c
index 7bfecdfba177..d249a035c2b9 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-axg.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-axg.c
@@ -400,6 +400,7 @@ static struct meson_pmx_group meson_axg_periphs_groups[] = {
 	GPIO_GROUP(GPIOA_15),
 	GPIO_GROUP(GPIOA_16),
 	GPIO_GROUP(GPIOA_17),
+	GPIO_GROUP(GPIOA_18),
 	GPIO_GROUP(GPIOA_19),
 	GPIO_GROUP(GPIOA_20),
 
-- 
2.34.1

