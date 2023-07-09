Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D512F74C477
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 15:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjGIN7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 09:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjGIN7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 09:59:50 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7771118
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 06:59:44 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QzTK94tylzBJBgF
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 21:59:41 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1688911181; x=1691503182; bh=XC2qRso5yr3ArD1O8ps0Wm+4qpk
        guIyDAXINZk+B5kI=; b=yczk9CDG35PSKq/mIbDf98zLT7sAgybx21LtojWHkvk
        PHN7C9FhjmX8kyNamBy3iQXyCoinm0atjqf1M5d7ChSh+Y5RETNR3cjilgMLHhou
        lijFjtau8frR4JVnIwBsPPa03dkm58y3or37EUJfzYdKd3Zj093nW5Q+aRUiMn8r
        b7KtMJENsLjH+ImBzl7D5LyCPeavW7278zXHdgRvmwhyqYzjn4q29XxPnAGc6Z6s
        cdzauZUxmZ1L7+Pb1bkuSSYBhNhHzyy+uOhPr+09/hVuy7I9KX0x0zGeHqMUHV16
        6UJA/BAlV6GyPME1MeLiyoAVlK+LweEiILuRP6CenGA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6guwKLcS819t for <linux-kernel@vger.kernel.org>;
        Sun,  9 Jul 2023 21:59:41 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QzTK92Nx0zBHXkb;
        Sun,  9 Jul 2023 21:59:41 +0800 (CST)
MIME-Version: 1.0
Date:   Sun, 09 Jul 2023 21:59:41 +0800
From:   xuanzhenggang001@208suo.com
To:     tony@atomide.com
Cc:     linux@armlinux.org.uk, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: OMAP2+: prefer 'unsigned int' to bare use of 'unsigned'
In-Reply-To: <20230709135705.59832-1-denghuilong@cdjrlc.com>
References: <20230709135705.59832-1-denghuilong@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <7efba6a4aae52649aa05756263c0a955@208suo.com>
X-Sender: xuanzhenggang001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/arm/mach-omap2/display.c:73: WARNING: Prefer 'unsigned int' to bare 
use of 'unsigned'
arch/arm/mach-omap2/display.c:111: WARNING: Prefer 'unsigned int' to 
bare use of 'unsigned'
arch/arm/mach-omap2/display.c:119: WARNING: Prefer 'unsigned int' to 
bare use of 'unsigned'

Signed-off-by: Zhenggang Xuan <xuanzhenggang001@208suo.com>
---
  arch/arm/mach-omap2/display.c | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c 
b/arch/arm/mach-omap2/display.c
index dbec3bb9fbf4..c7a39d497e47 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -70,7 +70,7 @@ static struct platform_device omap_display_device = {

  static struct regmap *omap4_dsi_mux_syscon;

-static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
+static int omap4_dsi_mux_pads(int dsi_id, unsigned int lanes)
  {
      u32 enable_mask, enable_shift;
      u32 pipd_mask, pipd_shift;
@@ -108,7 +108,7 @@ static int omap4_dsi_mux_pads(int dsi_id, unsigned 
lanes)
      return 0;
  }

-static int omap_dsi_enable_pads(int dsi_id, unsigned lane_mask)
+static int omap_dsi_enable_pads(int dsi_id, unsigned int lane_mask)
  {
      if (cpu_is_omap44xx())
          return omap4_dsi_mux_pads(dsi_id, lane_mask);
@@ -116,7 +116,7 @@ static int omap_dsi_enable_pads(int dsi_id, unsigned 
lane_mask)
      return 0;
  }

-static void omap_dsi_disable_pads(int dsi_id, unsigned lane_mask)
+static void omap_dsi_disable_pads(int dsi_id, unsigned int lane_mask)
  {
      if (cpu_is_omap44xx())
          omap4_dsi_mux_pads(dsi_id, 0);
