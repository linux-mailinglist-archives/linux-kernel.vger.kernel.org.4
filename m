Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7FC74E55D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 05:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjGKDea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 23:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjGKDe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 23:34:28 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122F9116
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 20:34:23 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R0RLh32gYzBJJjv
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 11:34:20 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689046460; x=1691638461; bh=6ZIvBKyTDToEuxpYq+WPdlVRvsd
        sgjAeBAYi1t201Go=; b=oM/9maOl0zk8HJwP0Qi3lax5f6SXFaQdwLBaxDEHGIa
        tjqujcmdSF7uDMW36JIm8MiqLwvpF7TRTstUCWi1aiLqkVZqxCYwcONmaKx7xO5b
        A9Wpu2T2FBDz/gcFpwHuN78uj18HpBzu5NgxNYn6A5atJUXYU0C/V21yMD5UnKGp
        hTtzfwuV1JhMSJlH9alM1bMJKsw4eTXBS1fqKpeGfikiZGiAuNUDPyF/mw8L67hD
        I7l7/wlHWjfvwAIdfNahDEiCbeTnf7hQBpaxCKQAHE5RnOuH1sz5oMMtcTQ/wulY
        eMtcHwYb/tHlFf7wqWcMBmeVVTxylWT2igc8Vx+wLuw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FQUWVQhYiFsa for <linux-kernel@vger.kernel.org>;
        Tue, 11 Jul 2023 11:34:20 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R0RLh0N2CzBJ8kq;
        Tue, 11 Jul 2023 11:34:20 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 11 Jul 2023 11:34:19 +0800
From:   sunran001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/clk: remove spaces before ','
In-Reply-To: <20230711033246.79078-1-xujianghui@cdjrlc.com>
References: <20230711033246.79078-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <757078717970984a2ba9642044e37259@208suo.com>
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

Remove spaces to clear checkpatch errors.

ERROR: space prohibited before that ',' (ctx:WxW)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  .../gpu/drm/nouveau/nvkm/subdev/clk/gf100.c   | 20 +++++++++----------
  1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gf100.c 
b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gf100.c
index 6eea11aefb70..09face813805 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gf100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gf100.c
@@ -453,16 +453,16 @@ gf100_clk = {
      .tidy = gf100_clk_tidy,
      .domains = {
          { nv_clk_src_crystal, 0xff },
-        { nv_clk_src_href   , 0xff },
-        { nv_clk_src_hubk06 , 0x00 },
-        { nv_clk_src_hubk01 , 0x01 },
-        { nv_clk_src_copy   , 0x02 },
-        { nv_clk_src_gpc    , 0x03, NVKM_CLK_DOM_FLAG_VPSTATE, "core", 
2000 },
-        { nv_clk_src_rop    , 0x04 },
-        { nv_clk_src_mem    , 0x05, 0, "memory", 1000 },
-        { nv_clk_src_vdec   , 0x06 },
-        { nv_clk_src_pmu    , 0x0a },
-        { nv_clk_src_hubk07 , 0x0b },
+        { nv_clk_src_href, 0xff },
+        { nv_clk_src_hubk06, 0x00 },
+        { nv_clk_src_hubk01, 0x01 },
+        { nv_clk_src_copy, 0x02 },
+        { nv_clk_src_gpc, 0x03, NVKM_CLK_DOM_FLAG_VPSTATE, "core", 2000 
},
+        { nv_clk_src_rop, 0x04 },
+        { nv_clk_src_mem, 0x05, 0, "memory", 1000 },
+        { nv_clk_src_vdec, 0x06 },
+        { nv_clk_src_pmu, 0x0a },
+        { nv_clk_src_hubk07, 0x0b },
          { nv_clk_src_max }
      }
  };
