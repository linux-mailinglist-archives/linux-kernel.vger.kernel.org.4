Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E1E6F9E9F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 06:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjEHENs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 00:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjEHENp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 00:13:45 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E3C4488;
        Sun,  7 May 2023 21:13:43 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50bc1612940so7743794a12.2;
        Sun, 07 May 2023 21:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683519222; x=1686111222;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kC/utfZ9fQhbpGbbmjC75yjL4GQLhxn8VaJ5T9oPJN4=;
        b=X+bSHPjbHLPk1qA8Aao6jbLomI98279x8hPmZFq7jfOjREhlmBwkiJKeb9HJyPtNu7
         TM50+f5UDWF51BRscQpo4jfNa4S1BYW1SgiBW99OfJzS8y8HkqMlYXe3ppAoNW5BAGoA
         PtUezP9Knqz8sTlJ+W0+6fS3FQtlVeae+EpUD69go9KI3hP/RwS/3uUS47pa3l4we2RQ
         Fwa1Leg7yjpj+CjFaKttckbxSC0uoAMBwam48T4Ww6E5PQY4YDeQicJLc5RSMsto3xnh
         qE0aeD38QIbmAjbpA7MuRa/USVfklyGyp/ldYhXT+4coW9ifggLtLHj74qId7Uiyf4t5
         Y4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683519222; x=1686111222;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kC/utfZ9fQhbpGbbmjC75yjL4GQLhxn8VaJ5T9oPJN4=;
        b=aeK9YeUaz2B9aR/RBKSmiZ+MmkI/Wa/G9/IIWy/sEIIeEx1RNFD8bLsAf1XKCzbE5r
         osNmo0PHFKIHZ63XelehF/kA4OlBeMsdU4UjLrVemZTT8W8o+sz+KebnNrHnCxxMKCeU
         9lXcxAXmbYIdZxdwKABYEjZhDv4PXhQyBJwPl+V75/xJY9tPlFJaHhwbcOTzRAB9XJtJ
         pa02PS7WSK9vrNSV2nxGeLfrtMcbMu9d/WZ9aTMi+Gx5gbPTxoHGY1cEwiXqfPwikZ8v
         vcoMZGNOOj2/qcbjb9Hy2KRgNQC27kQPGF2j4+u9fkpDY6D7iX+1aqzw8tBbQk8hxEbQ
         yl7A==
X-Gm-Message-State: AC+VfDzkdQ9BTONkk1ZuhqOLUMtDfYHY8obwwbgJbj6gqhF5tfzoNyPZ
        2dSKMG54ak0R3YiSHbsiyJo=
X-Google-Smtp-Source: ACHHUZ5B2XVJMuK0mzQwjZNfFsjp4f/1CnkLkrvqQbu+FtRNNBkxDLHdC0EWGLGqzdgE1wB69nQatQ==
X-Received: by 2002:a17:907:2d0b:b0:94a:6953:602d with SMTP id gs11-20020a1709072d0b00b0094a6953602dmr9559962ejc.37.1683519222168;
        Sun, 07 May 2023 21:13:42 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:8906:f99a:ce33:2033])
        by smtp.gmail.com with ESMTPSA id w20-20020a170907271400b00965b0eb7b0csm4392834ejk.103.2023.05.07.21.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 21:13:41 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marcel Hasler <mahasler@gmail.com>, linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] media: stk1160: Simplify the build config definition
Date:   Mon,  8 May 2023 06:13:39 +0200
Message-Id: <20230508041339.19571-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit dfb9f94e8e5e ("[media] stk1160: Build as a module if SND is m and
audio support is selected") had to introduce some complex config dependency
handling to compile for all combinations of configs VIDEO_STK1160 and
VIDEO_STK1160_AC97.

Later, commit e36e6b5f26c1 ("[media] stk1160: Remove stk1160-mixer and
setup internal AC97 codec automatically") removes the config
VIDEO_STK1160_AC97, which renders the previous dependency handling
unnecessary. The commit already simplified the dependency of the remaining
config VIDEO_STK1160, but it misses the opportunity to merge VIDEO_STK1160
and VIDEO_STK1160_COMMON.

So, do that now and simplify the build config definition of the STK1160 USB
video capture support.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/media/usb/stk1160/Kconfig | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/media/usb/stk1160/Kconfig b/drivers/media/usb/stk1160/Kconfig
index 4f50fb7db7b9..bf7c16baa9f8 100644
--- a/drivers/media/usb/stk1160/Kconfig
+++ b/drivers/media/usb/stk1160/Kconfig
@@ -1,8 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0-only
-config VIDEO_STK1160_COMMON
+config VIDEO_STK1160
 	tristate "STK1160 USB video capture support"
 	depends on VIDEO_DEV && I2C
-
+	select VIDEOBUF2_VMALLOC
+	select VIDEO_SAA711X
 	help
 	  This is a video4linux driver for STK1160 based video capture devices.
 
@@ -12,10 +13,3 @@ config VIDEO_STK1160_COMMON
 	  This driver only provides support for video capture. For audio
 	  capture, you need to select the snd-usb-audio driver (i.e.
 	  CONFIG_SND_USB_AUDIO).
-
-config VIDEO_STK1160
-	tristate
-	depends on VIDEO_STK1160_COMMON
-	default y
-	select VIDEOBUF2_VMALLOC
-	select VIDEO_SAA711X
-- 
2.17.1

