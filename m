Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90C772F87E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239976AbjFNI73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243628AbjFNI71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:59:27 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD38A1BF3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 01:59:22 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4Qgzr82nB1zBQgnx
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 16:59:20 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686733160; x=1689325161; bh=+Pgk5Qdr4y1+ylFUEtfOc7XJIpZ
        2V9Df0ycnSUjUwNA=; b=nJgilORUt76zkSkEJsQgKdizJ2rGsIZWtYoxDKoL4Gf
        cLeYyL1WPols9HWOiq6LP5LMxOBWQk+EGMnZsnfQHD9pZ6bsIBK1YVVtDjQ/p89q
        lPsYZ5KGzVXEt/I3e3IHLEYe0rggSBG5tPRsI1AB1HxWSe6CUpBOryekPRDcSK5H
        ATi3qGsmsxiKxK53qhMas3R7ER0Dexy/yzuW+I2WuDwNDEuSRTD+gXzvfzfPMWDM
        w0JKATqTu2ZKLvM8XB6r7aIWg2CzLrKsb6lCz6UsxFJU/8rZi9GSJc2UKeBr3iUX
        ct0suUWmbOKEydzXjA1nZrk5Z/DlHCHaLQZI5ySRnQg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CiHBiuR-CCql for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jun 2023 16:59:20 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4Qgzr75SzzzBJJD0;
        Wed, 14 Jun 2023 16:59:19 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 16:59:19 +0800
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
Message-ID: <f372ecd6bb8459641dfe89e3c7867237@208suo.com>
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

fix the following coccicheck warning:

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
