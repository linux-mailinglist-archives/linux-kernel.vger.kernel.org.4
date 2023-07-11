Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DE274E52F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 05:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjGKDRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 23:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjGKDRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 23:17:13 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8802811D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 20:17:11 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R0Qyr4R2GzBHXhh
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 11:17:08 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689045428; x=1691637429; bh=eCpHUBZ535nAx5ld0aM21nbCV5s
        N/mFLdl27W+J/3KY=; b=Fv7HuvZBz0D1ivxg7Uis1CBsi+Ipl5jZWqi0PIKXDZ2
        IjyIQ9tWF58cCHMpPKw4wDyYFf3E8XxkVazkuvr9HVZheRnOigIg6P/Nmhhjb92c
        M0Dqtb2JGan2wAP23irlN8+Ir5nAkHQioFlvxBa8jQUm2ECAOZMELjS+G0OQiWx+
        Igt12EEE2oitmEPpL+Zc8rD5N73QE0KiB6yoelA2pJ4ODt+JaIcbuxHMzENwNB1Q
        F/Jyfz6M+NYvYoGdo/e0hvX/Jn20kzJ/q/7CL8RGknWg+IVAHDhjnnGdH1COawMW
        ebfgTZ/4eQxhnOYmaAR+y3Y4mi0CNr7LKwcjvRCHN4g==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QmrIFzmv-wlA for <linux-kernel@vger.kernel.org>;
        Tue, 11 Jul 2023 11:17:08 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R0Qyr2703zBHXhc;
        Tue, 11 Jul 2023 11:17:08 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 11 Jul 2023 11:17:08 +0800
From:   sunran001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/clk: add missing spaces after ',' and '{'
In-Reply-To: <20230711031602.78854-1-xujianghui@cdjrlc.com>
References: <20230711031602.78854-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <20c47d68e1ff2da06e66cac9c935afc9@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing spaces to clear checkpatch errors.

ERROR: space required before the open brace '{'
ERROR: space required before the open parenthesis '('

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/nouveau/nvkm/subdev/clk/mcp77.c | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/mcp77.c 
b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/mcp77.c
index 81f103f88dc8..f85d6a08c61a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/mcp77.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/mcp77.c
@@ -56,7 +56,7 @@ read_pll(struct mcp77_clk *clk, u32 base)
      u32 clock = 0;
      int N1, M1;

-    switch (base){
+    switch (base) {
      case 0x4020:
          post_div = 1 << ((nvkm_rd32(device, 0x4070) & 0x000f0000) >> 
16);
          break;
@@ -222,7 +222,7 @@ mcp77_clk_calc(struct nvkm_clk *base, struct 
nvkm_cstate *cstate)
          /* NVCTRL is actually used _after_ NVPOST, and after what we
           * call NVPLL. To make matters worse, NVPOST is an integer
           * divider instead of a right-shift number. */
-        if(P1 > 2) {
+        if (P1 > 2) {
              P2 = P1 - 2;
              P1 = 2;
          }
@@ -258,7 +258,7 @@ mcp77_clk_calc(struct nvkm_clk *base, struct 
nvkm_cstate *cstate)
      /* vclk */
      out = calc_P(core, vdec, &divs);
      clock = calc_P(500000, vdec, &P1);
-    if(abs(vdec - out) <= abs(vdec - clock)) {
+    if (abs(vdec - out) <= abs(vdec - clock)) {
          clk->vsrc = nv_clk_src_cclk;
          clk->vdiv = divs << 16;
      } else {
