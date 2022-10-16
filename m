Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB7D5FFD48
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 06:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJPEqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 00:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiJPEqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 00:46:20 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36BE13CC0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 21:46:19 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id b2so8137776plc.7
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 21:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOPGjdkUUwBD33Ljs14iPONiNzANh82bKNKcOAVpv2U=;
        b=ig6Dy5kUHX/xCi/qhfXtOSmXyx21TOvJnI+Qe0WYy+CrzaePjxltimPIbm/E/bz4b0
         Thq1g4ovro3P/B4Pwzu2sbOQuw9JJ4CvxNedhA80rlTJcVgvMeUPAxVGRH2KYByPLfe/
         1RtuE2vyn1ARWx3ulPnABCPzy/EN3bXPyTcUYUcsq8oAvuIogH6oszJV8ymX2h/Y14Wo
         /PJNTVd/8mzaKDQyvwYbQQuMOjN7S48l3S8H603mRUAwkTWiSdR4gZuhD+KEJDUXHVrg
         fQdjrKnaCKiIqEtn9b8tpLq/Fe2+Zf0lP0aeI6z1eYMqy6d8ldiYOn7B5fyVGwY1HsUv
         BKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOPGjdkUUwBD33Ljs14iPONiNzANh82bKNKcOAVpv2U=;
        b=Uae09J4M6eynvPdPAuUocvRw6lIIoxADZZijFLbs3drRp9S69ZWiCpobSYAHZhxaa4
         LJwEAaBX0v/D98lRLXkqfcyxP2J2Is6nFxFRAGbgDZ+/jDbkMtusg8QZjrMT8m8HYS3i
         QrtFLT/+JAPIg2VDYCMMjksoYXzffKXj+QfArqZkFQDhVyaweWsC5mD4VkehWnY2C3ue
         QgDRRzlSZ442jaH+OYOHHRp5kPt3lptiP4XB6svQacuj/ziFexs4A3yRfggNU1sm4Ju4
         wzFa7LOvnJbXT7h2Ap92PCwe50WmomRm4Fd0M7TRkPWBktZKHBDyrPWLX+OalYKWpwCl
         QvVw==
X-Gm-Message-State: ACrzQf3fy8490CW507jkk88NA8GFV1RIUU8p1gW4e25z7zS9YkeHvrBv
        h941QiDu/GBhtBRUtKkC7w==
X-Google-Smtp-Source: AMsMyM63j0z/1xvhysZgEbmP6pbY1z3+XW9PpVel3uuw8eOMbfB7ujM/Qo5QvMY8PkoBbfj2qSylXw==
X-Received: by 2002:a17:902:c7c3:b0:182:7a62:4fa with SMTP id r3-20020a170902c7c300b001827a6204famr5855511pla.122.1665895579262;
        Sat, 15 Oct 2022 21:46:19 -0700 (PDT)
Received: from localhost.localdomain ([113.110.232.129])
        by smtp.gmail.com with ESMTPSA id z14-20020aa79e4e000000b005631a40a00bsm4308555pfq.139.2022.10.15.21.46.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Oct 2022 21:46:18 -0700 (PDT)
From:   Ban Tao <fengzheng923@gmail.com>
To:     fengzheng923@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: sun50i-dmic: avoid unused variable warning for sun50i_dmic_of_match
Date:   Sat, 15 Oct 2022 21:45:24 -0700
Message-Id: <1665895524-122458-1-git-send-email-fengzheng923@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In configurations with CONFIG_OF=n, we get a harmless build warning:

sound/soc/sunxi/sun50i-dmic.c:268:34: warning: unused variable
'sun50i_dmic_of_match' [-Wunused-const-variable]

Signed-off-by: Ban Tao <fengzheng923@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 sound/soc/sunxi/sun50i-dmic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun50i-dmic.c b/sound/soc/sunxi/sun50i-dmic.c
index 86cff5a..62509cb 100644
--- a/sound/soc/sunxi/sun50i-dmic.c
+++ b/sound/soc/sunxi/sun50i-dmic.c
@@ -391,7 +391,7 @@ static const struct dev_pm_ops sun50i_dmic_pm = {
 static struct platform_driver sun50i_dmic_driver = {
 	.driver         = {
 		.name   = "sun50i-dmic",
-		.of_match_table = of_match_ptr(sun50i_dmic_of_match),
+		.of_match_table = sun50i_dmic_of_match,
 		.pm     = &sun50i_dmic_pm,
 	},
 	.probe          = sun50i_dmic_probe,
-- 
2.7.4

