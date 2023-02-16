Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9062469995B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjBPQAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBPQAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:00:09 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AD04BE82
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 08:00:08 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id l4so1498598qvh.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 08:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=090PiZboWm4xKAxokbVWDfrV3xrsWJlZwqvYSImMRoI=;
        b=q33rqeXeRbuTnWBfq4xJA2U7uspFazDKHLWhY0GzG3ZmPtIg3WeMYI4dlKoqsdiZj3
         8kaik4slpbHdZuOq2mSHpOfQTymngQ4mVUjUY9RL3PqxnD1ogdo3usfZJZpiTYwPA41d
         Ck/kfiFydd8s7snRnU75zXZEYAotd+49s0fYHeXY1/WlxU5VwytBnNHiSFQcEenBRo0K
         hAHawc3uCmfdRb2ISlprcAfMEA9Y7kXDjZhvXtCieqs/1VKW/qzgPi+T1Y5pYwQZeX7m
         yBpuFo4oqvmcYVaRt0v+KyNLFXTfWGEH5wsMj93s9Kh6zgeK0wqCTO/ypeFd6CPhreed
         aHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=090PiZboWm4xKAxokbVWDfrV3xrsWJlZwqvYSImMRoI=;
        b=EitsFHRQryYTNeS29TJfe3XGzGCYJkna1RL5j46irRnokTiNbOzbbmEfOw3e9dAlJG
         VtBm6ijM9+mRBm6vIu6h7txdlbFDTizxINvOOCNiJZxFIcdBO7YmPep3/6S6dWAx1/Hl
         80IRAZvt10P1qoP01rDKSoUsCmFAKhnysbfsB2OnOK4HWzL7Oymr+DhC1cgdOL8AewF6
         7Ojk1e/Nckks8K0CIzJovIV3HOiDl1Dm1Fv26y+YoxZI9qWU0pgu2mtuI3UMIGnsSIDz
         S2s9wx21AZGhX/IIU/ce2k+GnazxjHAkubFm0T5r72OXDRt2jd4l8WJgiFUEYiWPLTCh
         WRfg==
X-Gm-Message-State: AO0yUKW5eUCHcpdpJynONI1nln88SiZSpwozmkv9Nen2jVNI3m5uOXos
        57gadoE1n2LJzjJSXtSbjM8IMsEdIEV6O6CT
X-Google-Smtp-Source: AK7set/slyxS0VTiycNJWvqfexed9tSt/x1r2N1T0sTVLe20qQdkH0hCX0ZHeg4i255H71bxBQyJBg==
X-Received: by 2002:ad4:4ea8:0:b0:56e:a331:cf14 with SMTP id ed8-20020ad44ea8000000b0056ea331cf14mr12985012qvb.51.1676563207358;
        Thu, 16 Feb 2023 08:00:07 -0800 (PST)
Received: from localhost.localdomain ([2601:14d:4e80:336e:6940:faac:fba5:1dee])
        by smtp.gmail.com with ESMTPSA id t80-20020a374653000000b007203bbbbb31sm1430439qka.47.2023.02.16.08.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 08:00:06 -0800 (PST)
From:   Joseph Hunkeler <jhunkeler@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Joseph Hunkeler <jhunkeler@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] soc:amd:yp:Add OMEN by HP Gaming Laptop 16z-n000 to quirks
Date:   Thu, 16 Feb 2023 10:50:07 -0500
Message-Id: <20230216155007.26143-1-jhunkeler@gmail.com>
X-Mailer: git-send-email 2.39.1
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

Enables display microphone on the HP OMEN 16z-n000 (8A42) laptop

Signed-off-by: Joseph Hunkeler <jhunkeler@gmail.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 363147539..4e681e9c0 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -255,6 +255,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "15NBC1011"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "OMEN by HP Gaming Laptop 16z-n000"),
+		}
+	},
 	{}
 };
 

base-commit: e1c04510f521e853019afeca2a5991a5ef8d6a5b
-- 
2.39.1

