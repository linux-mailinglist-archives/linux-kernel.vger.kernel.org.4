Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964585BA6B2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 08:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiIPGUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 02:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiIPGUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 02:20:34 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D444B726B0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:20:32 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id p18so20499120plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=B/KZqyCS3W8efvkmSNeLGFSECJIUK/0eUjH5dQQxYAE=;
        b=gBpgxF3wg+gZHtpenxDvB6qtS/e4OB0t84WEdbfd6echN2ZwI5vpbiHrlZ2T/faKq9
         ptI4EQZG9V97HluvJlf5R+ps8OBkE/Sj40mYUbFQ7BOkDAya68OjLQYRUi3nlpi3c8g2
         s8sq1JcXclfkqChL7MpKYfPie7upMzOBE1slSSj9dwQ+1bxEGdBecul8wk71JBC7//Rj
         xYZvZs8zo6PbTxtzYLXk0a1Tbibt7TNYezGwbSGVRT423qHpCMEZJRx/MgrPkKpK6C9I
         d9eLYy+H4c3iPX1/PtjGGY1F7WPV9oT53qBxw9nimr1r0zk070VG9iPngp2mwW7LEdGj
         mG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=B/KZqyCS3W8efvkmSNeLGFSECJIUK/0eUjH5dQQxYAE=;
        b=eiLkmVDFCZnLTRH8NjQrxVZXF6BK2hC51XBPLnM0YZIPrO8MBMMzgihjNn3WugKV+V
         wiKFA/nLl61gxpFVrVJ2nkcmpaMkhbujSs+6qSzYyUTYkPGKsGi18BgYR4KGTkTS06A1
         zRQXCjOHDAWL9D8CF50pjTNTNNUBjktaJeoiHQDxQTU/cGHtj3CkCASwbaF/NCr+IuQd
         I9smqEkPEvFHmulr2w5jy/Gksu4SXgyTOvnI1nhfypgu5bE3rWLIK/tdTYxKUKHJNeqY
         Dqw9o0HrVbi/eC9Es/Bzf7IM4DjondIiOhrrDz/ZrWMg0Vm5Zjuj7WQ/YMuRbIM6g9Rg
         Wojw==
X-Gm-Message-State: ACrzQf2NF94h8I6vpj8SJKrhskm77i7Hbh8I+SJYUKZLdOYvDE7/r07V
        X3VnekSPomIMvFOvkALULjU=
X-Google-Smtp-Source: AMsMyM7tULTs63HRISt+17Wr58NGvjlbAiBrcc6asNPP1uQnYW/K6JYPBmH1AGsYbwX+ygKY++oDGw==
X-Received: by 2002:a17:90b:3b90:b0:202:80ac:467c with SMTP id pc16-20020a17090b3b9000b0020280ac467cmr14130663pjb.17.1663309232370;
        Thu, 15 Sep 2022 23:20:32 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902f60300b00174c0dd29f0sm13934831plg.144.2022.09.15.23.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 23:20:32 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        AjitKumar.Pandey@amd.com, Vsujithkumar.Reddy@amd.com,
        akihiko.odaki@gmail.com, baijiaju1990@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ASoC: amd: acp: use function devm_kcalloc() instead of devm_kzalloc()
Date:   Fri, 16 Sep 2022 06:20:27 +0000
Message-Id: <20220916062027.152815-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Use 2-factor multiplication argument form devm_kcalloc() instead
of devm_kzalloc().

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 sound/soc/amd/acp/acp-mach-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index f0c49127aad1..4c69cb6e3400 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -584,7 +584,7 @@ int acp_sofdsp_dai_links_create(struct snd_soc_card *card)
 	if (drv_data->dmic_cpu_id)
 		num_links++;
 
-	links = devm_kzalloc(dev, sizeof(struct snd_soc_dai_link) * num_links, GFP_KERNEL);
+	links = devm_kcalloc(dev, num_links, sizeof(struct snd_soc_dai_link), GFP_KERNEL);
 	if (!links)
 		return -ENOMEM;
 
@@ -749,7 +749,7 @@ int acp_legacy_dai_links_create(struct snd_soc_card *card)
 	if (drv_data->dmic_cpu_id)
 		num_links++;
 
-	links = devm_kzalloc(dev, sizeof(struct snd_soc_dai_link) * num_links, GFP_KERNEL);
+	links = devm_kcalloc(dev, num_links, sizeof(struct snd_soc_dai_link), GFP_KERNEL);
 	if (!links)
 		return -ENOMEM;
 
-- 
2.25.1
