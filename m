Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FBA70946E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjESKGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjESKGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:06:21 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5780E9C
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:06:19 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2536e522e47so1187189a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684490779; x=1687082779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bzq3Pqk8pZIS4OBKRNMcHxRAHqoQcIGGMgWTxxeCr8o=;
        b=OfozACIZTPXj9YjAsiMEiLO3Q/qKKBGE8rtNvdksLde+azMBz5+doNg2LZOfAHVxtH
         MRlnTiIdVH153ZXN5nvS41Gvl39HVN61+bScsf+5e60vWyq7Zvi6wIHDudFLTbw1TUll
         TNDXB3MoUE0cfRb/EP9Zvh7hjeea144WRARZ6HhbnyIGM6zTwlcTfHC7ZQhDhvnsZzF7
         h6tJNQwfdPQdg31Zg586DGhLLvUB49P76VeLxNG65bqIF/aj5UMD7715dHk9Rl01gNGE
         VnjbwG+fyfTE5ybWcOAR5BGSL313lZ4TMInh0e4ug1+B9vxo/AX/ktvrlXVUb0ol4z+d
         +9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684490779; x=1687082779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bzq3Pqk8pZIS4OBKRNMcHxRAHqoQcIGGMgWTxxeCr8o=;
        b=eLhzACqSZQcZDamfu0DJ9nXVj+3UCOHyk7VflD/kG/s7YR69NFFmECUs7fUwpwGbl7
         +H1E1VWLXoMNFI6fXW1/MlSOQnRwY0cgtjqVfvZeDCcj192O0rpCTqTWr6Kcmbe7/qOO
         PTYy1AfohfdnJZ4u32fhte5IKO1yJyzDfbVbWJhGTTPq6J6Lh4caSxlfUAtFNClwzlQE
         /SJxfFGbYK9wCxkmFh9eZ0wM4zt+ts3+1zPplAGSjJQbSdw3Rk1Wa8wKBg67p2IjhZ6N
         Cz7ToCwcJqiRnmDZQUWSEYwbTPtOSYdXiMQFrJcD2LZonkrIS1UjB0hegq0KbZm4ZaK1
         Llhg==
X-Gm-Message-State: AC+VfDyYRK92SIHh0b956ugwncsNxPgOhj/rNLUtn/fyVta3ITJ7kuSX
        yX4o4Z2SD1Abm3aZNg5XzxY=
X-Google-Smtp-Source: ACHHUZ5OgbbTMM3fdz1ZNdvURBWY3YC++eRXCDeFU27+aPQjNh27NYoQ9MAxOBOE4im3k7Z4lnMWCQ==
X-Received: by 2002:a17:90a:a602:b0:250:bc78:9828 with SMTP id c2-20020a17090aa60200b00250bc789828mr1621173pjq.4.1684490778763;
        Fri, 19 May 2023 03:06:18 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:682f:3808:92bc:26c4:ce02:816b])
        by smtp.gmail.com with ESMTPSA id ev23-20020a17090aead700b0023cfdbb6496sm1163733pjb.1.2023.05.19.03.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 03:06:18 -0700 (PDT)
From:   Deepanshu Kartikey <kartikey406@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Deepanshu Kartikey <kartikey406@gmail.com>
Subject: [PATCH v2] [PATCH v2] Staging: rts5208: rtsx: Moved else statement to same line with else if
Date:   Fri, 19 May 2023 15:35:59 +0530
Message-Id: <20230519100559.26173-2-kartikey406@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519100559.26173-1-kartikey406@gmail.com>
References: <20230519100559.26173-1-kartikey406@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moved else statement to same line with else if,
this warning was given by checkpatch.pl

Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

...
Changes in V2:
    - Moved else to the same line with else if
    - Moved comment on else statement to inside of it
---
 drivers/staging/rts5208/rtsx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
index 2284a96abcff..47dacef0aaf8 100644
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
+			/* we've got a command, let's do it! */
 			scsi_show_command(chip);
 			rtsx_invoke_transport(chip->srb, chip);
 		}
-- 
2.25.1

