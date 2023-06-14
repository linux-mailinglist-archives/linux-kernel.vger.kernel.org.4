Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2B572F841
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242995AbjFNItT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243742AbjFNItE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:49:04 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266C92108
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 01:48:44 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4Qgzbq5yh6zBQgny
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 16:48:39 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686732519; x=1689324520; bh=IcIsuVytmxRFZfeFBIevtPHxZBh
        medXjR88mecjn6oQ=; b=ctAN/eY+zIoxNpmJqewkCWxpJX7BuMux8JRlaVhuBYs
        CHICqhltwfE0lJCFdQaJxGXTR+8eNGXSQY4Mf/I5LvUcgE/0uWc/KTNBwdlyDhPp
        7uSwbIWu2YX6bWVrbykMK2vsaCB0Y63IMb9mcTEfPCqteQEeeuIDDY9BPO3gw59B
        z9YufWgR5qzuhyv/cB5wsXHpDzUvqYmWV94wIE/4cFHUYB++OVePSMTVdIm7LDHd
        jeJ+FHxWFW85rubWjrB7+M7s/on8UO6fgQ0eQ4k4YFzlRw+pueK09tvVzZicybLT
        4+XkPNFLcUcyWh2fAtna2s/FjZO8Vm1RaL6lHNsY5Aw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dSLHXVGLM1RX for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jun 2023 16:48:39 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4Qgzbq1RBhzBJJD0;
        Wed, 14 Jun 2023 16:48:39 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 16:48:39 +0800
From:   baomingtong001@208suo.com
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, bchihi@baylibre.com,
        heiko@sntech.de, wenst@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/thermal/mediatek/lvts_thermal: Remove unneeded
 semicolon
In-Reply-To: <20230614084536.6911-1-luojianhong@cdjrlc.com>
References: <20230614084536.6911-1-luojianhong@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <aac85dc1a7070a84697f7e38e5bb7217@208suo.com>
X-Sender: baomingtong001@208suo.com
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

./drivers/thermal/mediatek/lvts_thermal.c:522:2-3: Unneeded semicolon

Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
---
  drivers/thermal/mediatek/lvts_thermal.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c 
b/drivers/thermal/mediatek/lvts_thermal.c
index d0a3f95b7884..1a5ae51b2c51 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -519,7 +519,7 @@ static int lvts_sensor_init(struct device *dev, 
struct lvts_ctrl *lvts_ctrl,
           */
          lvts_sensor[i].msr = lvts_ctrl_data->mode == 
LVTS_MSR_IMMEDIATE_MODE ?
              imm_regs[i] : msr_regs[i];
-    };
+    }

      lvts_ctrl->num_lvts_sensor = lvts_ctrl_data->num_lvts_sensor;
