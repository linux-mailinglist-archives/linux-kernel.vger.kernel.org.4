Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BAB5B4FF6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 18:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiIKQUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 12:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiIKQUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 12:20:11 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8239014029
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 09:20:06 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id y17so9916752ejo.6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 09:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=xUphcrXxQc1ipnQhfpFIDYBTmrSlFRYJTDjjM/qgN3o=;
        b=hWI2lxW+3yst5tOygYtWH3uD42UCnBngUblM6Yl6sFe60p/mlNy5ItkZPgWyg8IM+B
         Bq0M5BY04O4kcIXAe7u5nH0pN5BZcToXyQ3y6ARmtW6yJJlXDV11wEB8cznjrroOK3nP
         Fvo6LvlKsX4nLh35c89hqbVR1mImbSBqJ6ftnvOyLLR098QvjSy8w7ZVhZ1yYmMvC7hr
         fG8kYJ7T93BZIdO8A8zaJtfs8CgGxTnIjBEsBwGPC2ZpwFzOX/FKf4UWbvM+GT7csOjl
         +Su4Ew6tjRJOx32gnbe7auOvnBjzXnz/dupbXyuy7oAXkrOovF9b48dugLe/qwTg5sdu
         Gm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xUphcrXxQc1ipnQhfpFIDYBTmrSlFRYJTDjjM/qgN3o=;
        b=ZgQuDTxDKUQTZWgKs5k659IDXBJTCbcM2BVETa9FwUwsj9RJxHw82b+331QfZYCfKm
         E9QE1QP1p8ozNywqeR2vAbJved8gwODiSiRfXC8QL1y7SqYxlbZuLRmCT7Pvb2TAoRnv
         3tkDKGqLLzlYsubGbnLficDktAHrKzpqDG/oQNrAeS4puGYnOXNmyWcxTowOi45BCpHz
         lMD04+VBJIrOsK6tf+Z08SLC9+jKeu1QxF8voQ1XOweoYiVjYo92j1CnozeMU/zBS2Et
         T75qnrNHHYWF3GkUB/r6DRvMHR+rDNvio/cbP2EtRnKIhHYwOXbqOjAO20sWOe7NuL7Y
         5zMw==
X-Gm-Message-State: ACgBeo01vJlDehP29L3WHkVOQaSsOFm6qHH0RWLF7Q5ZHROjHG04nbZD
        UoF4c13YTfwgRU90Lqfm5Fs=
X-Google-Smtp-Source: AA6agR7kp7AB1fLPUmeg1WKG0Ar+XXUfe3/HxCUunyPfSboqDsOv1dfV8VH86SApTcJKR2uFcJo7gg==
X-Received: by 2002:a17:907:31ce:b0:742:1206:529e with SMTP id xf14-20020a17090731ce00b007421206529emr16006575ejb.643.1662913205042;
        Sun, 11 Sep 2022 09:20:05 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id bt6-20020a170906b14600b00779dc23be62sm3055346ejb.120.2022.09.11.09.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 09:20:04 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/6] staging: r8188eu: replace tabs with space in odm_query_rxpwrpercentage()
Date:   Sun, 11 Sep 2022 18:19:49 +0200
Message-Id: <20220911161949.11293-7-straube.linux@gmail.com>
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

In statements spaces should be used not tabs. Replace tabs withs spaces
in two return statements in odm_query_rxpwrpercentage().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_HWConfig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index a870973395f6..38f357e8aeda 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -6,9 +6,9 @@
 static u8 odm_query_rxpwrpercentage(s8 antpower)
 {
 	if ((antpower <= -100) || (antpower >= 20))
-		return	0;
+		return 0;
 	else if (antpower >= 0)
-		return	100;
+		return 100;
 	else
 		return 100 + antpower;
 }
-- 
2.37.3

