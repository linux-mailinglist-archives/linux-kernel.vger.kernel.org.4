Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A766DB995
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 10:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjDHISv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 04:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDHISi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 04:18:38 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B89C143;
        Sat,  8 Apr 2023 01:18:37 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id p8so751169plk.9;
        Sat, 08 Apr 2023 01:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680941917; x=1683533917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bVLjHTnOtdfrJmTguxNf65pHe59NsHzZRHirsqU2kkI=;
        b=LAkalLbOacgneAq/9b8eeeOoWRMpWZze5EjlrBhbPhcJu8WyMkwdeaBsZfHX+WNzMD
         dz60VvUvcmOQoLrqDopgqWu+mtWYcqPHmaKFZh6gIgVIS5mgiZIfczY1SRXgPV2SobAa
         3eYpJfNCkhxRQoZ62c71hVvEcmZSMdFk98VqqTPaKPSMsfjLmoxHX6E2V0O/Gzmso0W5
         Pxd3kwS0pi5f2esDq+fSIGIpLqW939GitYraC8A85/XLgRLnURCPhE5QV6/Qxqz+a01y
         onWw2G55D96NGWu98LyYc93v37bITK4fBllZRVitQlyvdYTzWjCrQTShJrlQrldetbC4
         w2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680941917; x=1683533917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bVLjHTnOtdfrJmTguxNf65pHe59NsHzZRHirsqU2kkI=;
        b=ylF+b3IvMn3t4u6ky4AA4f9inZ2KKS/YEL23SqH7ySOKLym8yrGJrkq9Xr+jNseP3a
         VoOczmAKLubszM/2wvKLu+N68SeTsTCft4GIv0wGhLi1i/+Yz0juZ40gY/YztWeTowG4
         nUCHk7quIkj5yd/iPFty+9ujlpZxNPHLYb5AXdZWGYREBX2IVClTat/Fd3NlHYsjcAWd
         ni2myG6J2LxrTETnF/EP9pEmPzsBoobUkfhCXziuYMSwOrU3ObK0c9wq9r1XQQTCwnP9
         75YkyJLcXO3bar2c5OHcIz3EukoQepDuq2M/usv3TBU3j0C/46QuUVaNUGJo5Vk6l4+s
         XW0Q==
X-Gm-Message-State: AAQBX9dESUNiZPbvp2qm6EFERi/gBLyF/2NMjWuLoRTRux5wsQU8RQ3j
        NB0LnHhX8cn9n5umnjwEA5A=
X-Google-Smtp-Source: AKy350bL0LN8dYz+jJU6fEe9hPwD6r8Q52aLOrCDPnHNJ9uC8agiAAXug61dMxZjdY0aZTUZ5aK/dw==
X-Received: by 2002:a17:90b:3b42:b0:240:1e0b:a7b7 with SMTP id ot2-20020a17090b3b4200b002401e0ba7b7mr1780396pjb.39.1680941917202;
        Sat, 08 Apr 2023 01:18:37 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:682f:3808:8475:d375:707b:4600])
        by smtp.gmail.com with ESMTPSA id 14-20020a17090a08ce00b0023f21584dc7sm3796658pjn.55.2023.04.08.01.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 01:18:36 -0700 (PDT)
From:   Deepanshu Kartikey <kartikey406@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Deepanshu Kartikey <kartikey406@gmail.com>
Subject: [PATCH] staging: fbtft: fbtft-bus.c added params
Date:   Sat,  8 Apr 2023 13:48:17 +0530
Message-Id: <20230408081817.81562-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added cpu_to_be16 param in define_fbtft_write_reg

Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 3d422bc11641..228a5430c1d5 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -62,9 +62,9 @@ out:									      \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
-define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, cpu_to_be16);
+define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16);
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, cpu_to_be16);
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.25.1

