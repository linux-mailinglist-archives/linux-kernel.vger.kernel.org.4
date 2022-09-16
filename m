Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4DC5BA6C9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 08:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiIPG0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 02:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiIPG0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 02:26:37 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D78796A1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:26:37 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id b75so15053433pfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=XCDwki2qZ4Nr/nkC+/OXLcZMdTv44msrWgOLDzkJxRY=;
        b=fv+3HMJf1UQzCUIvyoizWAgiHV2CIyM/xXZwucrTFjCDQxYW+QFM6ZeoxF26Xo35LY
         F1EXPI/bAUHuNyarmXJoickZkZb0UsgDRZlWZX2JWHAl1c79WJOdAmV8qrLZ4ZT8oMqD
         CbYJuNgJPtziiE6Q71ZUFWLtGCk+8yHst6ooc52nwM0+Ivn/DHzHREYkigzZKkUstln2
         tUK5lJ4oXvx0o8lLXc5yP8iiWmg2rZpH+aXqB+Qe1+7fdj9fxSO/PBKKg9mQneou5e5w
         UKCBIm4AWVmt/ZrouinRRgc8SLLgdXK2p0GvRB1MyTdOEBtcv4vxojhzNsl9cb7sIEc3
         klJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=XCDwki2qZ4Nr/nkC+/OXLcZMdTv44msrWgOLDzkJxRY=;
        b=CxEshUnmdylCPjIn3hOx6jy1T4lMEZ7znYKi2BcYi88yafBqkZlt4R/E6x5j2Rvzje
         8IsMtvChctmBVuAqmHbiAxlqefESx1MMT6JpdyO8CJad6AFT7YtilBO+CJin2Vt+OhTP
         t6+lalpyVx3yVlRis/pUec7iUH3JYZyuB0dkhuIAjXf6lrkkXwAnxHZ2xTIMQCLk8nsX
         cwfeenPUtvJ6ladX2uGwmoSiD6zCJ5wohSFfTv0/4xaDu4UtbqaUMjSA1aDOB/5m3x9u
         uZ7iZjThUCh7CWCNxEdzbLynqZwDZzawWmATFN0XewFsL6mbQ1eK/RNfYTLxkhks8ezr
         Se5Q==
X-Gm-Message-State: ACrzQf31un6iAPXi1FdSgsnLQXRiANrDF3/mrophZ0dlxW+qcSP6Mpq7
        JNtLRYON5HMhP50uGw+T77A=
X-Google-Smtp-Source: AMsMyM7htnW8o/km9HpQ/knPb5Q/9DNcisZhgjRQPh61cNMIrdUyyWfMSMlSyHeNkUnGBIDZaJ8QbQ==
X-Received: by 2002:a05:6a00:1691:b0:53b:3f2c:3257 with SMTP id k17-20020a056a00169100b0053b3f2c3257mr3734327pfc.21.1663309596584;
        Thu, 15 Sep 2022 23:26:36 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w70-20020a628249000000b005363bc65bafsm13565044pfd.57.2022.09.15.23.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 23:26:36 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     broonie@kernel.org
Cc:     cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, perex@perex.cz, tiwai@suse.com,
        brent.lu@intel.com, yong.zhi@intel.com, ajye.huang@gmail.com,
        mac.chiang@intel.com, vamshi.krishna.gopal@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ASoC: Intel: sof_rt5682: use devm_kcalloc() instead of devm_kzalloc()
Date:   Fri, 16 Sep 2022 06:26:30 +0000
Message-Id: <20220916062630.154277-1-ye.xingchen@zte.com.cn>
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
 sound/soc/intel/boards/sof_rt5682.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 045965312245..1bf9455eaf93 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -600,10 +600,10 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
 	struct snd_soc_dai_link *links;
 	int i, id = 0;
 
-	links = devm_kzalloc(dev, sizeof(struct snd_soc_dai_link) *
-			     sof_audio_card_rt5682.num_links, GFP_KERNEL);
-	cpus = devm_kzalloc(dev, sizeof(struct snd_soc_dai_link_component) *
-			     sof_audio_card_rt5682.num_links, GFP_KERNEL);
+	links = devm_kcalloc(dev, sof_audio_card_rt5682.num_links,
+			    sizeof(struct snd_soc_dai_link), GFP_KERNEL);
+	cpus = devm_kcalloc(dev, sof_audio_card_rt5682.num_links,
+			    sizeof(struct snd_soc_dai_link_component), GFP_KERNEL);
 	if (!links || !cpus)
 		goto devm_err;
 
@@ -687,9 +687,10 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
 
 	/* HDMI */
 	if (hdmi_num > 0) {
-		idisp_components = devm_kzalloc(dev,
-				   sizeof(struct snd_soc_dai_link_component) *
-				   hdmi_num, GFP_KERNEL);
+		idisp_components = devm_kcalloc(dev,
+				   hdmi_num,
+				   sizeof(struct snd_soc_dai_link_component),
+				   GFP_KERNEL);
 		if (!idisp_components)
 			goto devm_err;
 	}
-- 
2.25.1
