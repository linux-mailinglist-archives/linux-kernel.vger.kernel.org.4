Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8486DC8BF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 17:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjDJPub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 11:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjDJPu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 11:50:29 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3991702
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 08:50:28 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ga37so13777862ejc.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 08:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681141827;
        h=content-transfer-encoding:commit:signed-off-by:mime-version
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLYER13K+NrI6zCmIwDtQmW2Dz0up0GnJYK0qZbJDm4=;
        b=RvfvpaR8UJE/2K5y4uouPge/ZZnR6QmPwIP2g7jrsugShEiOOhPuqdOU78fTEN2GhC
         I9UB3ilxKMbWdFnCylvt1HFIa0FmaFUG7ByP7C0TwLWnWDhPx/5JHIV+o8BndHt6dCOZ
         jtM16XzzE/4GeoGnFvCc7aAhl/Qp1IfMgY8sNzLyyiga792JC2lSoR/i9vV6fquKtJ/8
         dB1MNFfHqTMP/fFhXokNgyBalGA1Y1vAjOji193CjFbWrv0lw8/8ax1mRq5O7jpQSWhj
         sD0rMUXl7NVBR8E9RztTQVhX2JlArWHRF3j40U00dpELq4qOGEpoDyEXHjECXDp8ddN5
         MGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681141827;
        h=content-transfer-encoding:commit:signed-off-by:mime-version
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLYER13K+NrI6zCmIwDtQmW2Dz0up0GnJYK0qZbJDm4=;
        b=49mI+sP9ZplMhKziyfGw64Ch+Y2LzG+hCYg8qmHyileniyi2sqQs7y6EPjfzxcBYX+
         gZP96lYCCMb2B9zSY/LESqnB2ehtoAsOwT2TW1tFfccNFsXnpgbTiuoQ8jKOvkT13Dvz
         VHEMpQkUMyJ2p63StO/hMukh1+o27rSy97WPCvSKpg8P8Z12r9IaLQgdfLUAxe7+JsOT
         nv+vkU2EFNVVoZ86xVhDHZqTdD8igoeTI/pFAGiOpO5I5vlDrO/YC5loh4Pv9jgE08gh
         h2J9PyKPl4bkyAJtwIPs+m2EPGQyTqVVsCtfkUxdCpnLMBKXhNRCJmWAFMQyLEflXnEM
         iEzw==
X-Gm-Message-State: AAQBX9ft6R8AdDv5msfaRdiztQ6QUNYkeMwZ+t/2PnnD+4BGYSTKgrrA
        6zUgqgM6Pm5PHVkYAPheRqgu+heHuMWfVmWHP7Ldlg==
X-Google-Smtp-Source: AKy350ah7wbvYwPmQzATzu4hxFlZa1kWlhyJJjYoEB7zGFAeyxIFE2NxSBlN6dagvKRVznnURUhHJw==
X-Received: by 2002:a17:906:b118:b0:935:20d8:c3c with SMTP id u24-20020a170906b11800b0093520d80c3cmr8412872ejy.61.1681141826814;
        Mon, 10 Apr 2023 08:50:26 -0700 (PDT)
Received: from localhost.localdomain ([79.142.69.160])
        by smtp.gmail.com with ESMTPSA id tg12-20020a1709078dcc00b0094a473988b9sm2387908ejc.27.2023.04.10.08.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 08:50:26 -0700 (PDT)
From:   Cem Kaya <cemkaya.boun@gmail.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     mario.limonciello@amd.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Cem Kaya <cemkaya.boun@gmail.com>
Subject: [PATCH] Add Dell G15 5525 Ryzen Edition to quirks list for acp6x so that internal DMIC works.
Date:   Mon, 10 Apr 2023 17:49:28 +0200
Message-Id: <20230410154928.171975-1-cemkaya.boun@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Signed-off-by: Cem Kaya <cemkaya.boun@gmail.com>
Commit: Add Dell G15 5525 Ryzen Edition to quirks list for acp6x so that internal DMIC works.
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index a428e17f0325..e044d811496e 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -45,6 +45,13 @@ static struct snd_soc_card acp6x_card = {
 };
 
 static const struct dmi_system_id yc_acp_quirk_table[] = {
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell G15 5525"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.40.0

