Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FB45BA6BF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 08:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiIPGYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 02:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiIPGY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 02:24:29 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7010A2223
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:24:21 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id e68so20308680pfe.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=n4S92ltdclB9gEaEbidGcfEJc4hoERFLtmLJlSQbuQo=;
        b=KDBVkZqEu+wmjHfMe6cFICUhPZbfK2OfZqL4HN2oITBvNKQWfAc6A4p4OYCo7LCInU
         Pqy2UX2U/O3NSzrRQJr4X3JVpE0+SuvngoL9dZAxf6SkBeYpLhubw/jx7tHMfuzDmAxr
         4dlZD340iwkCMUlxCemdzGM7VCnrIs7/eVF83Q90o+DjfG4w5vq02EdjhaXOWWZogyhc
         sPWIezVefsnrvonXdkBZJ7hmylxuwvzZVu2kPtyfkNerVV7Eu7dZ5Kxr96OmL+pOdRJM
         HL/AdBwhwUVApWf3gt1yOg+HQgcJ0YSlt0VkPQfyHXzS3lgES4329a7zDteliIeDR4it
         0Rjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=n4S92ltdclB9gEaEbidGcfEJc4hoERFLtmLJlSQbuQo=;
        b=qMXVDqrFiEAGw8VFvGE62ic9OTOq27G/qkgJZqmCvVq0joU7l8A8zmcZ1fryRtR4G4
         wwnUjk+deKmTkTrWABIeRtGzMvyp8uGFhbgxUROYV2DBO/JwwIiwHmN524xqHPV9taoP
         JJhyXDWrUd80rl3eWelZX34cY2CVeJmgXJUZ5X1YUgVzKFADQj2opYJu17qrejKDfg3b
         drfSS8MPSnSexpXxc9juKfkiveicW4QadpPryhh8OOt/b87IZuP8saFNRoYjLeDsoCn7
         Xg7eRm7dR0NNFWzj/kgUACO9GT9cNlxMziv0BjVldF/TNsyWWMG7tE+SIPczqylDuDoS
         YxpA==
X-Gm-Message-State: ACrzQf3NvpbryZaf4ckLTCf8EOlKCq2WMiYBKy2qXS3RM4udbJur8tuq
        K2Ex7dvMlQUE/onmxP7CKS8=
X-Google-Smtp-Source: AMsMyM6Xeip4PMKJuOyP0VyLECoI9jr5AlNeekFVQUtmid6WX66FRGnMKmOjJNGNlbaEp4NNGRahvA==
X-Received: by 2002:a05:6a00:23cd:b0:544:cbec:6d60 with SMTP id g13-20020a056a0023cd00b00544cbec6d60mr3894104pfc.16.1663309460689;
        Thu, 15 Sep 2022 23:24:20 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b00176cdd80148sm13982414plg.305.2022.09.15.23.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 23:24:20 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     broonie@kernel.org
Cc:     cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, perex@perex.cz, tiwai@suse.com,
        mchehab@kernel.org, andrey.turkin@gmail.com,
        muralidhar.reddy@intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ASoC: Intel: sof_es8336: use function devm_kcalloc() instead of devm_kzalloc()
Date:   Fri, 16 Sep 2022 06:24:15 +0000
Message-Id: <20220916062415.153659-1-ye.xingchen@zte.com.cn>
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
 sound/soc/intel/boards/sof_es8336.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/sof_es8336.c b/sound/soc/intel/boards/sof_es8336.c
index 606cc3242a60..fbb42e54947a 100644
--- a/sound/soc/intel/boards/sof_es8336.c
+++ b/sound/soc/intel/boards/sof_es8336.c
@@ -481,9 +481,10 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
 
 	/* HDMI */
 	if (hdmi_num > 0) {
-		idisp_components = devm_kzalloc(dev,
-						sizeof(struct snd_soc_dai_link_component) *
-						hdmi_num, GFP_KERNEL);
+		idisp_components = devm_kcalloc(dev,
+						hdmi_num,
+						sizeof(struct snd_soc_dai_link_component),
+						GFP_KERNEL);
 		if (!idisp_components)
 			goto devm_err;
 	}
-- 
2.25.1
