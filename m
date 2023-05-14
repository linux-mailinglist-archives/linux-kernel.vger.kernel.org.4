Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B015701B53
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 05:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjENDJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 23:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjENDJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 23:09:53 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8DB2683
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 20:09:52 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1aaff9c93a5so78087485ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 20:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684033792; x=1686625792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i/y2Q9D0CfiPbFjFqVeY6UhKR07Cv8DHbxpO7JqJ2YI=;
        b=NY3eZzfl62OfyDFlsWmAkeZIOqL8aEQS0lt11umcLuzSUSIOZUtGPpbqwxo1mTLmX2
         AjhBR7CdzjzqqOxACqzuyoF31PL8ljXafbKf4Ra0Zu36F6qPpGjl3+cnt+e4S77tI0Nb
         yuSQFU9+lGLaPxaHLi55jemfG5vvAo254w973pURlMoNMzm5M8Lz0ytpq5PxpJJg5DD4
         iNbX+NtvYPqQrKHkjFVXgCl3OBV3Dvu+0MbnU93qYH6uKBEDhut8InyAzeKAycH6ukPK
         euY+Kv/Y8rY7//drIuXZjNPY5TaHfL8fUrjMJNvNHf3SYvmNeVqeiAilHPZb+HH/rpck
         Qthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684033792; x=1686625792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/y2Q9D0CfiPbFjFqVeY6UhKR07Cv8DHbxpO7JqJ2YI=;
        b=PXZPf6j+3yS7sxiFJ3jZZVLKYdCGHDqFQoYEVOtaW2miWwECJ7kKnavyBCbolHefDl
         48Pzdp7S5io68fmjzROHnFjHMn2S9+TaIcEwCAIP2BlXJ0oZVMIc0IFnj91fM584vEIN
         rtG62do3Jlfm+qeCffYCQ9P9WlydjmmY3EiblbnnIEhuAMzHdDfUoTJyTX9OMP/SH9bD
         m+FENh++04K2Q3KeKSbcWjRYrkTNOyIumUzHwD/aWgmXCgx4wylHZh0XtZ5jXSrlPOub
         bU+OvKLclcjtIsQmsyfOPmWoDzIOBpYDBHNKl3iGgMjLEVC0YWlAWdeOIvAM1i/Ca0Zc
         /p9w==
X-Gm-Message-State: AC+VfDxy5OZKCp7nuAaVYxRUz1mMbQBPxNvk4Rj6I9uF07ghIyhZDyt7
        6/UJhqT6AgYCCd52UFIzZIw=
X-Google-Smtp-Source: ACHHUZ4yzDyb3+1MJW6BO1BvzSA+zsUs6/q4VKM8nhZmLQgEwJoUXDmy5/k027R+RymdbL6dhFb3jA==
X-Received: by 2002:a17:902:d486:b0:1ad:d2b1:3faf with SMTP id c6-20020a170902d48600b001add2b13fafmr11320550plg.21.1684033792230;
        Sat, 13 May 2023 20:09:52 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:682f:3808:354c:21fc:fb33:cae9])
        by smtp.gmail.com with ESMTPSA id p15-20020a170902b08f00b001add653dba2sm5095575plr.108.2023.05.13.20.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 20:09:51 -0700 (PDT)
From:   Deepanshu Kartikey <kartikey406@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Deepanshu Kartikey <kartikey406@gmail.com>
Subject: [PATCH] Staging: rts5208 :rtsx : fixed  a brace coding style issue
Date:   Sun, 14 May 2023 08:39:40 +0530
Message-Id: <20230514030940.4820-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed  a coding style issue

Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 drivers/staging/rts5208/rtsx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
index 2284a96abcff..0ab9355873f7 100644
--- a/drivers/staging/rts5208/rtsx.c
+++ b/drivers/staging/rts5208/rtsx.c
@@ -399,10 +399,8 @@ static int rtsx_control_thread(void *__dev)
 				chip->srb->device->id,
 				(u8)chip->srb->device->lun);
 			chip->srb->result = DID_BAD_TARGET << 16;
-		}
-
-		/* we've got a command, let's do it! */
-		else {
+		} else {
+			//we've got a command, let's do it!
 			scsi_show_command(chip);
 			rtsx_invoke_transport(chip->srb, chip);
 		}
-- 
2.25.1

