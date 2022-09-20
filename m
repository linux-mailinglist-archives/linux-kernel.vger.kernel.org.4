Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CDA5BDD8F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiITGqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiITGqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:46:12 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA0F58B6C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:46:11 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d24so1447573pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=NwDmfKE5iNHscSlvrWqERxCyMK8HOjlUkCCMjtuH/fY=;
        b=D7QDCFzbh+lreP/zatxT+fSjUWhVTWbIOl1ZvaPj5TvctZTcZLvKGdJKE9tYfwv7O5
         X/EeYFFzMavjzbiRmgLAZDFgcM+Rx3P2kHFDenxt35e7LJ8qT0Mo0g2SL/0n5p/bV8Nr
         2Sx8cmG00Fr8ExBRPcU7xH+1f/PLndikfFUi+z42+oafEmCYK1T4D4gGs+IyYOP148q+
         ps9V2woPavD0dJga8mlOcqjht+ds0kQMmUbnNA9HKJJooYUaypM1j8CbvbqWFmwfK1+z
         7ytAEiPHR8x/4g6VWcPWYPun7i3oBCpq+AKRn8FTNMPAIZEH+bZndq3REg3pTy4fapcd
         wjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=NwDmfKE5iNHscSlvrWqERxCyMK8HOjlUkCCMjtuH/fY=;
        b=GydFB1DWrklCihUJD2TX/dP/xC1cvnlshvIb9T4GjKkJfEO76NebkLwWoY19JqApks
         ksRvxN0JiUcCKx2XlX90BBFZatH4KldbNiNzcijOrJZuBmGoe31X56KlSrd7mpj1ykIc
         mJKh0ZtxCUQ61CHnN/ouKaSYchoLKHt9RLjB/7PA7zRsskeZkB8CRTzNrQqQSmmrPaG4
         3xYlirg6PnUFAGbd2fnFyt1bOmauTwFkWKNh0Rjpu3WTwlhOgJ3IVTVnAkRHjhErOgmB
         OgZO5e9/j5uK+zTOK7zFhRAKmA+saEbrG+438j4rMF4qKbwwSklzL3WB38FlMsVgmhxl
         hJVQ==
X-Gm-Message-State: ACrzQf2hqXOKsxH21sq96I20agOkBAYKBykC5Grx68rzQjl2jSFTxUI8
        rVxoTKwBK7NytR4Qsxnqf7k=
X-Google-Smtp-Source: AMsMyM6UWf5IEM8Hs2pSoqZVB3IHIpTqtrOgOaGGe/Dr2xi+fKjh+FABf9k3jO6qxaQzPBoLy5zbGQ==
X-Received: by 2002:a17:902:ef93:b0:178:93cf:d267 with SMTP id iz19-20020a170902ef9300b0017893cfd267mr3382135plb.123.1663656371390;
        Mon, 19 Sep 2022 23:46:11 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d2-20020a655ac2000000b0043a09d5c32bsm636240pgt.74.2022.09.19.23.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 23:46:10 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     tiwai@suse.com
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ALSA: es18xx: Remove the unneeded result variable
Date:   Tue, 20 Sep 2022 06:46:05 +0000
Message-Id: <20220920064605.215318-1-ye.xingchen@zte.com.cn>
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

Return the value inb() directly instead of storing it in another redundant
 variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 sound/isa/es18xx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/isa/es18xx.c b/sound/isa/es18xx.c
index 3fcd168480b6..0a32845b1017 100644
--- a/sound/isa/es18xx.c
+++ b/sound/isa/es18xx.c
@@ -1344,11 +1344,8 @@ ES18XX_SINGLE("GPO1 Switch", 0, ES18XX_PM, 1, 1, ES18XX_FL_PMPORT),
 
 static int snd_es18xx_config_read(struct snd_es18xx *chip, unsigned char reg)
 {
-	int data;
-
 	outb(reg, chip->ctrl_port);
-	data = inb(chip->ctrl_port + 1);
-	return data;
+	return inb(chip->ctrl_port + 1);
 }
 
 static void snd_es18xx_config_write(struct snd_es18xx *chip,
-- 
2.25.1
