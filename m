Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF6F5E60FF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiIVL3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiIVL2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:28:52 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE26DED6F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 04:28:50 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id w20so8484248ply.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 04:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=nCK5BNpGpE1s8cljBVp+LVXtq7b3ijRTCH/bNupgy+o=;
        b=EmE6k4IfbUWPUsYrJSnoxltDDw54Atjw4180/xLkc/JO3v+vivH/O1mwwzkAANF1+k
         CI5I2HrBpG95LF9DNTRHYEOsdxfGSM+/d+LEUo8j23SHX3jb/i863/DoS46BXjrnMRGP
         asHDZ8452xDrAhI7nShmhDEPKQB2vyHgX4p4jHnCHN8xY0/cdimLYq1JQoaDFyM/8WGS
         wP4KXp55v+kLPbLPlNSoRxx/9ziUvojHvmHIBIp2mKNn9Jsymc+Sd/awLIojjzGahIJF
         d539NWXVDWc5XySf17J/aSjl4qiY7dsB0mnCsysj+Bru32MCjKT9Jr+p1JmGC69/o506
         q8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=nCK5BNpGpE1s8cljBVp+LVXtq7b3ijRTCH/bNupgy+o=;
        b=6NCtMkEwJKkrESSE07kgSe5Qsedh1aPCFmzw7YkiIR9Ak0PUnVSl+EbDS4z26FNJF0
         3AOE6+CjpILm6wWhAXdSAgwKCESLrqPb/eVg+3KGJnVLxPuGdST9Zn7U3i+hAdrROoh+
         yvTvaTryKxbkPd8aVVHxa99RAq2jEaJFf9AEeG9SBhDHs1VtsAssKEauTyynJXBnmS67
         uJgH7vGBswkBjoeDbdPNei7UFi6m/S4NJFTA5itAaq1dlKl6uruS307fvUI4qgDYsT+/
         bwqO0HZvuT7ug9iBfEj0Tq9HeCwf9infqeXKEsOwNLZbRCwGAQA6EgmQS/umZRhqzJ4D
         L6xA==
X-Gm-Message-State: ACrzQf21Zv3eS6PWe73FawlSz2fqZKBp4HiWT6S/2YDpbJrw0SOaKKSL
        W8WHSdBf1aXCTgiiMi9nNOI=
X-Google-Smtp-Source: AMsMyM4rI1ofld4QpP7RpzQzr2xzg5T3jWtDQIvS9nqUXQ0jCyA7dPOL0oD7qIkfIZ1akG3AQ7OtKA==
X-Received: by 2002:a17:90a:46c2:b0:203:a2c7:2362 with SMTP id x2-20020a17090a46c200b00203a2c72362mr3142196pjg.142.1663846130159;
        Thu, 22 Sep 2022 04:28:50 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w22-20020aa79556000000b0053e0d6f353esm4210176pfq.27.2022.09.22.04.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 04:28:49 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     tiwai@suse.com
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ALSA: hda/ca0132 - remove the unneeded result variable
Date:   Thu, 22 Sep 2022 11:28:46 +0000
Message-Id: <20220922112846.236987-1-ye.xingchen@zte.com.cn>
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

Return the value dsp_allocate_ports() directly instead of storing it in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 sound/pci/hda/patch_ca0132.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 208933792787..9580fe00cbd9 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -2962,7 +2962,6 @@ static int dsp_allocate_ports_format(struct hda_codec *codec,
 			const unsigned short fmt,
 			unsigned int *port_map)
 {
-	int status;
 	unsigned int num_chans;
 
 	unsigned int sample_rate_div = ((get_hdafmt_rate(fmt) >> 0) & 3) + 1;
@@ -2976,9 +2975,7 @@ static int dsp_allocate_ports_format(struct hda_codec *codec,
 
 	num_chans = get_hdafmt_chs(fmt) + 1;
 
-	status = dsp_allocate_ports(codec, num_chans, rate_multi, port_map);
-
-	return status;
+	return dsp_allocate_ports(codec, num_chans, rate_multi, port_map);
 }
 
 /*
-- 
2.25.1
