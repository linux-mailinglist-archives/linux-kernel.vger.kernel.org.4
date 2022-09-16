Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809545BA6B5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 08:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiIPGWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 02:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiIPGWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 02:22:41 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E5174371
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:22:41 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ge9so8536718pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=+MmMIqtR6gK+uJ43QZQbXrlj8rVSJr7UP9ANkMT6yW8=;
        b=MmkbqEj1j3pilvmcCNQ430oGSQeS6MVM8z0JwyNS7e7ToGLvwRs0hEUVFw//m6ma32
         cRAlF9AA44nGuo0dNy87oRm8qDbG1uJn80407u+obsJgk4RrAwGivr3HkVxp/j7HhgWJ
         Grw9rMYEVi4Th1WfN1ww3kMyhxPmKJOIyrJGQAOL6z3BTLkipYH8llbheFfLYQUw6DEG
         f7cdqsBkX5zaE27EVNTP6Bbo6dwH1q3dEAjHlJNmFZAA/W7wfBVh1avQhdegXWYXmt2a
         KmM/I4KdNsm1moENErWAEEvenua7dtyt1K89RwamP/CwrUYoVs+HLcxlA1hFEVlzIa9V
         36Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=+MmMIqtR6gK+uJ43QZQbXrlj8rVSJr7UP9ANkMT6yW8=;
        b=Ih3ASC/MsLc6728gRXcfw2MewM/30SKF9+gc7n0k8XzbC1K3MtE9CtHg/EXK5UKR2d
         Sw+3JgQsILHMUgdE4LIRHJOmcXBKKFCo9RPNDrYbVIiH0MR6R5BxHePhJC27r6/dUrrA
         qUD5tD4DTCLbx5toc1pAwx47iEYokDr1i9ocYlJP8qu+M7L8NcIVCGe9PMTwIN9nDJeI
         72VbII/uxs/vwJup4jph0xtITZ+kX2CSbT0G2nyRqSVxvpbFLxULozgfhWHoLYl1FHMp
         QDr5pNJ+1bcwDcLJZGwVgR2aDTkgNj1LBr9CFLOAllqJ6gUeE5CPxechS2B6fPVzQOkK
         lngg==
X-Gm-Message-State: ACrzQf3S8l2zaW6oWoxmsoCHi4i4Y24Q3+IXB2eWQAXEap9P9xOdV0E1
        BOx8xiVHkZaLxUlz4agZgWM=
X-Google-Smtp-Source: AMsMyM5rpm6UR6GaMvlD2WAfq3EyoiU9M/YbbBf9csTDqNrvJV2F1/Aj8zF35sjsbttJgqfS7eIOYQ==
X-Received: by 2002:a17:902:e212:b0:178:5c:8248 with SMTP id u18-20020a170902e21200b00178005c8248mr3359695plb.102.1663309360532;
        Thu, 15 Sep 2022 23:22:40 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id c206-20020a621cd7000000b00536431c6ae0sm13538652pfc.101.2022.09.15.23.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 23:22:40 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     broonie@kernel.org
Cc:     cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, perex@perex.cz, tiwai@suse.com,
        brent.lu@intel.com, akihiko.odaki@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ASoC: Intel: sof_cs42l42: use function devm_kcalloc() instead of devm_kzalloc()
Date:   Fri, 16 Sep 2022 06:22:34 +0000
Message-Id: <20220916062234.153275-1-ye.xingchen@zte.com.cn>
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
 sound/soc/intel/boards/sof_cs42l42.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/boards/sof_cs42l42.c b/sound/soc/intel/boards/sof_cs42l42.c
index 85ffd065895d..e38bd2831e6a 100644
--- a/sound/soc/intel/boards/sof_cs42l42.c
+++ b/sound/soc/intel/boards/sof_cs42l42.c
@@ -445,9 +445,9 @@ static int create_hdmi_dai_links(struct device *dev,
 	if (hdmi_num <= 0)
 		return 0;
 
-	idisp_components = devm_kzalloc(dev,
-					sizeof(struct snd_soc_dai_link_component) *
-					hdmi_num, GFP_KERNEL);
+	idisp_components = devm_kcalloc(dev,
+					hdmi_num,
+					sizeof(struct snd_soc_dai_link_component), GFP_KERNEL);
 	if (!idisp_components)
 		goto devm_err;
 
@@ -543,10 +543,10 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
 	struct snd_soc_dai_link *links;
 	int ret, id = 0, link_seq;
 
-	links = devm_kzalloc(dev, sizeof(struct snd_soc_dai_link) *
-			     sof_audio_card_cs42l42.num_links, GFP_KERNEL);
-	cpus = devm_kzalloc(dev, sizeof(struct snd_soc_dai_link_component) *
-			     sof_audio_card_cs42l42.num_links, GFP_KERNEL);
+	links = devm_kcalloc(dev, sof_audio_card_cs42l42.num_links,
+			    sizeof(struct snd_soc_dai_link), GFP_KERNEL);
+	cpus = devm_kcalloc(dev, sof_audio_card_cs42l42.num_links,
+			    sizeof(struct snd_soc_dai_link_component), GFP_KERNEL);
 	if (!links || !cpus)
 		goto devm_err;
 
-- 
2.25.1
