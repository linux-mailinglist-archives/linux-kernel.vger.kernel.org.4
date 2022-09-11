Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7405B4FF1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 18:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiIKQUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 12:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiIKQUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 12:20:05 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0768913CDA
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 09:20:03 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id t5so9495315edc.11
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 09:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=NYhdzoo6tM23KOShyzRyKjHKkaVDcrKz7iHGaueE0HU=;
        b=SRCxa55iJ/03fwJDnBkzsV38RX0UDP8cPGHBKrsU/GK9UhHXwyZSQhN9SUIbmpOYYR
         RjafR0Ewp7chC1atKddyjizH9+rUUmTAUhxRlOF7YvY0gJ/iTMqIxitPtMrkcf0aXCVI
         HhZ0SupndPObbaUQdS+OPeH8JyMcrGscxrBAlTvJRzMHdLcityxbNrCHpuh0AqA9dUGB
         Mh/62tdJWzqcRAUyTxke4BChSdXaYhgJGiChkN612stqoHlAGmAl2AFMNkNwvBe2KUU+
         KQrzDGg6CbQlnH0qP9sz1OEsmYz7BTmQRwzOl9bEn/I5/C0mNI1pfwiJbgvquRkbMS9T
         whBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NYhdzoo6tM23KOShyzRyKjHKkaVDcrKz7iHGaueE0HU=;
        b=qOQNH2I4BFUHddyibWX+hTlccN0E7CLBbwThyC73hQjNVIP2Ly8jK0BIeOR5X2nBI5
         /e5hOm8AuXS9W1TVT5etg3LCZlTsufzmumkvcs8+7wFjU3LSxjNe8p01onRq6AKI4/HL
         4A5nI7gh07jHIxUfSokSdwPilnb+ItMpiB2hTfyX9b9nU5l2iWibedRZSBrltq5hWd1e
         AEmyLldVAFSEIIxAB9wOIZVZJXSUh1v8DZNWTnKTCKL0H6+9VJ2bLsGvjO8ycNg2bxZm
         HGxdhvQhF6CUXHWRhS2GsukAqjpZg3F12MR6GIiuCC06sMxSrFuFzYryIzhix9mC8yoQ
         /Axw==
X-Gm-Message-State: ACgBeo0wivCJErUmvC6rVg1drD6D2mP0fV/P5CjB/3LMuqdgYRRUhUwW
        xjnPOqluVFRcXqgnIVaSamCEcHC9FGc=
X-Google-Smtp-Source: AA6agR7WzDP20gXCr9U5do86/epHo+otMYu6GuGXJyy7XrB9saBTiDGJ0oPBer8TRe/RiyuaHi7u5g==
X-Received: by 2002:a05:6402:2694:b0:450:d537:f6d6 with SMTP id w20-20020a056402269400b00450d537f6d6mr13804306edd.344.1662913201636;
        Sun, 11 Sep 2022 09:20:01 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id bt6-20020a170906b14600b00779dc23be62sm3055346ejb.120.2022.09.11.09.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 09:20:01 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/6] staging: r8188eu: clean up camel case in odm_signal_scale_mapping()
Date:   Sun, 11 Sep 2022 18:19:45 +0200
Message-Id: <20220911161949.11293-3-straube.linux@gmail.com>
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

Rename variables in odm_signal_scale_mapping() to avoid camel case.

CurrSig -> currsig
RetSig -> retsig

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_HWConfig.c | 38 +++++++++++-----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index cd6af491d5a8..5fd53c60f762 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -13,28 +13,28 @@ static u8 odm_QueryRxPwrPercentage(s8 AntPower)
 		return 100 + AntPower;
 }
 
-static s32 odm_signal_scale_mapping(struct odm_dm_struct *dm_odm, s32 CurrSig)
+static s32 odm_signal_scale_mapping(struct odm_dm_struct *dm_odm, s32 currsig)
 {
-	s32 RetSig = 0;
-
-	if (CurrSig >= 51 && CurrSig <= 100)
-		RetSig = 100;
-	else if (CurrSig >= 41 && CurrSig <= 50)
-		RetSig = 80 + ((CurrSig - 40) * 2);
-	else if (CurrSig >= 31 && CurrSig <= 40)
-		RetSig = 66 + (CurrSig - 30);
-	else if (CurrSig >= 21 && CurrSig <= 30)
-		RetSig = 54 + (CurrSig - 20);
-	else if (CurrSig >= 10 && CurrSig <= 20)
-		RetSig = 42 + (((CurrSig - 10) * 2) / 3);
-	else if (CurrSig >= 5 && CurrSig <= 9)
-		RetSig = 22 + (((CurrSig - 5) * 3) / 2);
-	else if (CurrSig >= 1 && CurrSig <= 4)
-		RetSig = 6 + (((CurrSig - 1) * 3) / 2);
+	s32 retsig = 0;
+
+	if (currsig >= 51 && currsig <= 100)
+		retsig = 100;
+	else if (currsig >= 41 && currsig <= 50)
+		retsig = 80 + ((currsig - 40) * 2);
+	else if (currsig >= 31 && currsig <= 40)
+		retsig = 66 + (currsig - 30);
+	else if (currsig >= 21 && currsig <= 30)
+		retsig = 54 + (currsig - 20);
+	else if (currsig >= 10 && currsig <= 20)
+		retsig = 42 + (((currsig - 10) * 2) / 3);
+	else if (currsig >= 5 && currsig <= 9)
+		retsig = 22 + (((currsig - 5) * 3) / 2);
+	else if (currsig >= 1 && currsig <= 4)
+		retsig = 6 + (((currsig - 1) * 3) / 2);
 	else
-		RetSig = CurrSig;
+		retsig = currsig;
 
-	return RetSig;
+	return retsig;
 }
 
 static u8 odm_evm_db_to_percentage(s8 value)
-- 
2.37.3

