Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD61F5B4FF7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 18:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiIKQUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 12:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiIKQUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 12:20:05 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C434D13DF7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 09:20:03 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id e17so9537075edc.5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 09:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=mslrvAnEr3TpSO5X38U+iS/S6NUXdhZVFElJnWUwu3s=;
        b=GD3M6ZeYw41YJxJi7HhErMRuFz+d5shSG79sMa/sNp7AOJBdOFt3pHVyTrMIB+ckvD
         ueHwsKZ6/A3gNHX9f5S9CywFaseSlRQsaIX1M837b8IsWgdB5KlMBqAG5J5AYs0PDapi
         N8jfeKJS3hdsd5doN2zbEb2qwxUUzXwVK56eGGtqquBfAdz+3YCrUrt3o2NejE8qkz6v
         nuQ5QQaHh5ND6TXbabOrE8GCx3QMQb0gT4eVrmeNdsnPN+k65x6pFkDrD6WutUWGdqjb
         acznzub9cg8fMmrkfxMnuUDfIv1wGPjPXZ1zjrLNmTIUxSqlVs4Tm4Y+2KDgZFrwmUvn
         MEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mslrvAnEr3TpSO5X38U+iS/S6NUXdhZVFElJnWUwu3s=;
        b=Rdc/xpKA5LRg6bRj+i0t7rdVQmixC7kQQc25CSH+6p34tRxvne+M/bj7081fFh8p5n
         zD/7iCUT4v7eZxBPQWkos79tRaxmBoN1V+C7SEqXttDV2D5AhCwdPPTROkipXcvpCpNe
         rCpVCmpJ7+MwUy1JePwa2F7sSAuNecKJYAuyTlUueG0525vUTTF0wPoHLROcHIyMQtzj
         NBtVl6hOrNGzJOJVp5BXORqe21ISbk6S7+kFk03IjdsBDTOXQkKE7a8kb/BQI6t6Xx5+
         AczHuRBvxkd1rxiUvvGSScaVDr9DPBoShdsYU4JXy6iqnjDTZ6I1vw62XGdFMH/AVMqb
         yYMQ==
X-Gm-Message-State: ACgBeo1fHM0Yz6mjiq2Vc6vV1yo7IEWcAQ2FOqYpJ+tF5mstdqVhq7tk
        dIdkC3r0MI9eJ3HirkFyrVY=
X-Google-Smtp-Source: AA6agR6tKfXAXP4ZvieTYvpgPNZkdMlKGl526lwtq9Jt3HoZKR16Wluu3yKdKmixn+UXnjxGsaHQ7w==
X-Received: by 2002:aa7:c1ce:0:b0:44d:d5b4:adf5 with SMTP id d14-20020aa7c1ce000000b0044dd5b4adf5mr19845305edp.182.1662913202426;
        Sun, 11 Sep 2022 09:20:02 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id bt6-20020a170906b14600b00779dc23be62sm3055346ejb.120.2022.09.11.09.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 09:20:01 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/6] staging: r8188eu: remove unnecessary initialization
Date:   Sun, 11 Sep 2022 18:19:46 +0200
Message-Id: <20220911161949.11293-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220911161949.11293-1-straube.linux@gmail.com>
References: <20220911161949.11293-1-straube.linux@gmail.com>
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

The variable 'retsig' in odm_signal_scale_mapping() is set in the
function before it returns, so it is not needed to initialize it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_HWConfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index 5fd53c60f762..a557c5d1542e 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -15,7 +15,7 @@ static u8 odm_QueryRxPwrPercentage(s8 AntPower)
 
 static s32 odm_signal_scale_mapping(struct odm_dm_struct *dm_odm, s32 currsig)
 {
-	s32 retsig = 0;
+	s32 retsig;
 
 	if (currsig >= 51 && currsig <= 100)
 		retsig = 100;
-- 
2.37.3

