Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716CF6F7A07
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 02:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjEEAUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 20:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEEAUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 20:20:49 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A11C12096
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 17:20:48 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-250252e4113so197655a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 17:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1683246048; x=1685838048;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=8TmpvJbU96K5mWAE+i9LXk7p3PZGa9UIfo8DUIyUZ0c=;
        b=LSbtL8+iwnX5GqWaGBkCj5rkG6Gk0y6hZi+1w189U0O1tCpGD2Jutew6l7t00+dHHM
         pmmTo2/kAT2zb4bZQ0AjNDI6QlsMybGTy8m+4VKZQG3FPpbhOR4GwsQYHTo1JSrYTtSq
         j1toePpqa6F4s3B12xkrFCc+UiRr62QzyiMy9O0juqjTlObi9W6dP4l8w6PcYjf+DcMI
         DDloLYjO69NWdgdFxg9r4fWhltlDq3NNHeRGUSiHau4SwNxHUXaUbQ/RXnd8RenvO0e4
         Hh5VRijo3++skLzX7LkAV7l2JC2q4j27oeaQzVzEl4iSKl9g7maZbyXCp/JzF7u1gxmZ
         9RwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683246048; x=1685838048;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TmpvJbU96K5mWAE+i9LXk7p3PZGa9UIfo8DUIyUZ0c=;
        b=X/09ruOUQ//i/FowNJzKWMksZdiRIrBVRzewXtVlB+BV19DvDTV5SULcvNygVCiAvQ
         KT9hiPkhkPdE+LTMpSqMRgOcUxVnEwI1zPryBeD0VsntBHcOqnlGBT13etOf9eKn+Bai
         3mVfNJUlqDFrH7vkZ/2w2qMUx1OZ33ohuRniXhyvTrZuGeRlEgXnend/MJNRlYuReIkO
         1tzvLYON5CqvqOnIiC0wvi1wh5MDRXDs7Aa5VXgEavw1eGUcSQjC+PhQpAHmBkCbhMZI
         0UrGcBVRnV69qslkdpDgYWNJSrRsgGMyUSXhR5V2xKiPbvCk6xtQFnko1ftO7gET+YFG
         e7cw==
X-Gm-Message-State: AC+VfDx/ZwGGPgoY5zp967iJYMCa7SGYsjO6m7mdVLWnnqGJC783Omg7
        tJ1FaMXtN6u2gSfEvjGQj4v5xw==
X-Google-Smtp-Source: ACHHUZ43/6VUqC/4H/Fyb8yXxZtcJhQwJ+Pf66SFGn86RioprdSlGVfrxR7XKatPpG2zpuh26E5OqA==
X-Received: by 2002:a17:90b:3e83:b0:24d:dc79:5901 with SMTP id rj3-20020a17090b3e8300b0024ddc795901mr3994645pjb.26.1683246047965;
        Thu, 04 May 2023 17:20:47 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id cq2-20020a17090af98200b002470b9503desm3659179pjb.55.2023.05.04.17.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 17:20:47 -0700 (PDT)
Subject: [PATCH] phy: mediatek: Remove unusued ret and check
Date:   Thu,  4 May 2023 17:19:46 -0700
Message-Id: <20230505001945.10179-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        chunfeng.yun@mediatek.com, kishon@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com, Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     vkoul@kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

This trips up a maybe-uninitialized warning, but it's actually just not
used.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
I just stumbled into this one when trying to test Linus' master.  I'm
not sure it's a sane fix, but I'm not using the driver.  No rush no my
end, I'll just keep the fix around in my local tree for now.
---
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
index abfc077fb0a8..3fc0913ec73b 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
+++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
@@ -213,7 +213,7 @@ static int mtk_hdmi_pll_calc(struct mtk_hdmi_phy *hdmi_phy, struct clk_hw *hw,
 	u64 tmds_clk, pixel_clk, da_hdmitx21_ref_ck, ns_hdmipll_ck, pcw;
 	u8 txpredivs[4] = { 2, 4, 6, 12 };
 	u32 fbkdiv_low;
-	int i, ret;
+	int i;
 
 	pixel_clk = rate;
 	tmds_clk = pixel_clk;
@@ -295,8 +295,6 @@ static int mtk_hdmi_pll_calc(struct mtk_hdmi_phy *hdmi_phy, struct clk_hw *hw,
 	mtk_hdmi_pll_set_hw(hw, PLL_PREDIV, fbkdiv_high, fbkdiv_low,
 			    PLL_FBKDIV_HS3, posdiv1, posdiv2, txprediv,
 			    txposdiv, digital_div);
-	if (ret)
-		return -EINVAL;
 
 	return 0;
 }
-- 
2.40.0

