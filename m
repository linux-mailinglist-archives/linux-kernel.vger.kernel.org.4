Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4785961D92B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 10:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiKEJjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 05:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKEJjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 05:39:41 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F0D65C0
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 02:39:39 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so4471232wmb.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 02:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g7pK56t2R6Ps3nWxcCA0h4Y93S07BBRs7F+fa1Fp9yo=;
        b=eZUXAjEgKFh1gKa76NKDihcp9jKqj+CroyCLGuKPjIH9/yonf3Ah69KSQJPXeY4oJF
         3NWqsjWItl5VSyLGnqJ87QregktPBqtfzFOTDgn/jWDTdpSP8nmYydVVCG7UkAiT4GOc
         oV+inyNe/Pz9tz5Ddsz3aHcxZEM+DPp8nuAFWco0MFdLT5pM9SWNiwHEOeWs598GZrBw
         NFAUXwoegA7jsBvTUinXSGxjHtA1EZvr8x7HVZnzGUI09X1YjTAtLKbeBfLxvh98WD1T
         /b1ukzw076V0J26RGr/kye4Uyr11f84PEpUlxh/WWNlgkVUolx9J3X0aHP4HyCO6Ks34
         LdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7pK56t2R6Ps3nWxcCA0h4Y93S07BBRs7F+fa1Fp9yo=;
        b=4tDbh30KerExDFAJVpTXfhcF85c/55EcMOPK1TG9z+c/F2yqZuuc1kCkhXbdc506cv
         MU4/ttGUu/QJ7G0ota86I9SXaRUWK3FNfgmw01uvPBazsMpkUq4yZsA2bv1El2HDoYYw
         rNoFw+Y3TspqKB5HN935fbskDuk/7drENnX8iu8gl0DY0YsNhUJPlRwSaUqBpb1xB1xt
         aM9yfwGK5MXba1XFMnp+M9QIVbXrmGWbK4yPU0C5LbxZDvBkINQCRLxH8zJwlJdrzm9z
         7gAf69hGu6lK/swORV2AgMZQhwQ/3EU82+xZUTCMKpAQ0OompmV6pvkuEVtC1bAK5Wbe
         ZyyQ==
X-Gm-Message-State: ACrzQf1wZtw4fw4e01V3+qEjFCBB74QI2ElBnL3mDhR3GSOCuqndU3l9
        a0mNKGhOjc2I0QWUw15FxW4=
X-Google-Smtp-Source: AMsMyM5PvPcwHf6V3i5PsjristDEGZsePtXLhYQmhw8olTLE3aZB+mn4rbBIJZcB50eBAaseYY23OQ==
X-Received: by 2002:a1c:27c6:0:b0:3c2:e6df:c79b with SMTP id n189-20020a1c27c6000000b003c2e6dfc79bmr35729022wmn.14.1667641177909;
        Sat, 05 Nov 2022 02:39:37 -0700 (PDT)
Received: from localhost.localdomain ([213.177.192.129])
        by smtp.googlemail.com with ESMTPSA id z11-20020a05600c0a0b00b003b4868eb71bsm6073622wmp.25.2022.11.05.02.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 02:39:37 -0700 (PDT)
From:   Juan Alfonso Reyes Ajenjo <juanalfonso.reyes@gmail.com>
Cc:     juanalfonso.reyes@gmail.com,
        Gustavo Plaza Roma <gplazar03@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Fabio Estevam <festevam@denx.de>, Stephen Kitt <steve@sk2.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Fix tas2562 volume table values
Date:   Sat,  5 Nov 2022 10:39:16 +0100
Message-Id: <20221105093918.12274-1-juanalfonso.reyes@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes -90dB value (0x84a3 instead of 0x695b)
This patch adds missing -20dB value (0x06666666)
float_vol_db_lookup must have 56 values as volume is from 0 to 55 (0-110dB)

Co-developed-by: Gustavo Plaza Roma <gplazar03@gmail.com>
Signed-off-by: Gustavo Plaza Roma <gplazar03@gmail.com>
Signed-off-by: Juan Alfonso Reyes Ajenjo <juanalfonso.reyes@gmail.com>
---
 sound/soc/codecs/tas2562.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index b486d0b..acbdf77 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -33,15 +33,16 @@
 static const unsigned int float_vol_db_lookup[] = {
 0x00000d43, 0x000010b2, 0x00001505, 0x00001a67, 0x00002151,
 0x000029f1, 0x000034cd, 0x00004279, 0x000053af, 0x0000695b,
-0x0000695b, 0x0000a6fa, 0x0000d236, 0x000108a4, 0x00014d2a,
+0x000084a3, 0x0000a6fa, 0x0000d236, 0x000108a4, 0x00014d2a,
 0x0001a36e, 0x00021008, 0x000298c0, 0x000344df, 0x00041d8f,
 0x00052e5a, 0x000685c8, 0x00083621, 0x000a566d, 0x000d03a7,
 0x0010624d, 0x0014a050, 0x0019f786, 0x0020b0bc, 0x0029279d,
 0x0033cf8d, 0x004139d3, 0x00521d50, 0x00676044, 0x0082248a,
 0x00a3d70a, 0x00ce4328, 0x0103ab3d, 0x0146e75d, 0x019b8c27,
 0x02061b89, 0x028c423f, 0x03352529, 0x0409c2b0, 0x05156d68,
-0x080e9f96, 0x0a24b062, 0x0cc509ab, 0x10137987, 0x143d1362,
-0x197a967f, 0x2013739e, 0x28619ae9, 0x32d64617, 0x40000000
+0x06666666, 0x080e9f96, 0x0a24b062, 0x0cc509ab, 0x10137987,
+0x143d1362, 0x197a967f, 0x2013739e, 0x28619ae9, 0x32d64617,
+0x40000000
 };
 
 struct tas2562_data {
-- 
2.7.4

