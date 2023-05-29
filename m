Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E6A714F2F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 20:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjE2SPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 14:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2SPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 14:15:10 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA259B0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 11:15:09 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6af78ce91b1so2680889a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 11:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685384109; x=1687976109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Fz2odnwoQoSb/f4/uwxLcGBzSZobAqAudC69cDyIVg=;
        b=AcSDTu0N7NdMN4gpxfkOdVF3BF5ZTv4A7Sb9Smnwr40A8Q4z9ZFuICQfKl8wLphA+p
         2mp9VhPL45dPc6B0JW04e6NCVauWBel32Xt7U13N7tEdjdrbQU2b9z2ta5iXsfsPzHMP
         b4ViOhhj3iaIULCK+2QtZWWY6KNc08nYSTzmPLpkJpL7N6TBDSLe84MClPmkJU6kLN7u
         jV959AruFreHoyHZ0evAZP59HB7+33Is9BZv89YJXxiQLNCCGBoqn1gZ4nOcKvE23Mu7
         kHlMWMVeE16v4juKqZpT2JxvDj1KswDqIDNquDGy5eQNNEy0ZGCU+aIWcmn4BNnn1WKw
         gaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685384109; x=1687976109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Fz2odnwoQoSb/f4/uwxLcGBzSZobAqAudC69cDyIVg=;
        b=VbfPJLjdn4Zn2W5Y8plH1u3wRx1z+FmMD2LqZYMJmEy3Hcr97N0XjsIP7ogXjk/zjV
         5DE6RPGqXCKuc8bT36uTLrG/nI8k0zfQT9SfQSuyiJppEHw0ycrY6YvKpaKQc1fKN7t7
         jIaSPLpeLs6xbh4CiRBGVVXerJ62zp8LVAnnRTqRFznXrbvqv8tos/81BgzaeHmR3wJK
         EJv6mn4D7O5F+HjSjYW/H4HDDjFsEtTPprkYNrl4Rzq6oen7AyubXbDyiZ3QWK4qa/4j
         UkusbWbgWA2w9fkcZrZaOVoWLlw8mCuGuPbiPokUbe054OXPcn+JWmp82U31gjyF9FCu
         krMQ==
X-Gm-Message-State: AC+VfDzbQI8SGTHsnxRbJibv1AWoj9KWAvX7+fanPXJZdD4mGLq/Xka9
        Ra4qlLj7UibMjrjguA/wFuhCutAGpsLk8A==
X-Google-Smtp-Source: ACHHUZ55Ew1xe12k0UOq1uaBO7QWrNF4wlScCTdgihgsD8vO20OZhCNgsIZc91qonI17sMXnhrJZFQ==
X-Received: by 2002:a9d:7e8c:0:b0:6ab:ce:6eac with SMTP id m12-20020a9d7e8c000000b006ab00ce6eacmr6211715otp.20.1685384109228;
        Mon, 29 May 2023 11:15:09 -0700 (PDT)
Received: from policorp.cardume.local ([177.91.232.53])
        by smtp.gmail.com with ESMTPSA id t4-20020a9d7484000000b006af8bc70e26sm4754451otk.7.2023.05.29.11.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 11:15:08 -0700 (PDT)
From:   drosdeck <edson.drosdeck@gmail.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, savagecin@gmail.com,
        SJLIN0@nuvoton.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, edson.drosdeck@gmail.com
Subject: [PATCH] ASoC: nau8824: Add quirk to active-high jack-detect
Date:   Mon, 29 May 2023 15:19:11 -0300
Message-Id: <20230529181911.632851-1-edson.drosdeck@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add  entries for Positivo laptops: CW14Q01P, K1424G, N14ZP74G to the
DMI table, so that  active-high jack-detect will work properly on
these laptops.

Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
---
 sound/soc/codecs/nau8824.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index 4f19fd9b65d1..5a4db8944d06 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -1903,6 +1903,30 @@ static const struct dmi_system_id nau8824_quirk_table[] = {
 		},
 		.driver_data = (void *)(NAU8824_MONO_SPEAKER),
 	},
+	{
+		/* Positivo CW14Q01P */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Positivo Tecnologia SA"),
+			DMI_MATCH(DMI_BOARD_NAME, "CW14Q01P"),
+		},
+		.driver_data = (void *)(NAU8824_JD_ACTIVE_HIGH),
+	},
+	{
+		/* Positivo K1424G */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Positivo Tecnologia SA"),
+			DMI_MATCH(DMI_BOARD_NAME, "K1424G"),
+		},
+		.driver_data = (void *)(NAU8824_JD_ACTIVE_HIGH),
+	},
+	{
+		/* Positivo N14ZP74G */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Positivo Tecnologia SA"),
+			DMI_MATCH(DMI_BOARD_NAME, "N14ZP74G"),
+		},
+		.driver_data = (void *)(NAU8824_JD_ACTIVE_HIGH),
+	},
 	{}
 };
 
-- 
2.39.2

