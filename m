Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232BC70946D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjESKGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjESKGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:06:20 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08D0114
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:06:16 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-51f1b6e8179so2122763a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684490776; x=1687082776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bzq3Pqk8pZIS4OBKRNMcHxRAHqoQcIGGMgWTxxeCr8o=;
        b=QheMzGRBNCM1TmgnZZMsfP41tBTiLKXVvJPnLmJPpegqx4NsudjPei3sxTIdOSBAtT
         8AzaTLQKGJ7HBwQfL8z5gRT6ekx9bGu18fjcUJ5zEO1U3k6+IDEeZIbPlKOAGoQniPdp
         WOudB7omPlsQC0V2h1ae1caVeHGxQGeBkNefDvRjtc2Ualb11wUu0p8qtXGDCDcUGaAn
         1OrT/5ul3/laL2UNP+WyGKa65Shoc3MBAfChe98dq4S3XjCFaHXB62mlghDu208q8e9B
         CSwc50Mdm9ZkR58dK31Dr4mutXq1ldwSCoKILoMPcaNFr9Yt+BA2TBGJYw3DJ0ogajqY
         8fmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684490776; x=1687082776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bzq3Pqk8pZIS4OBKRNMcHxRAHqoQcIGGMgWTxxeCr8o=;
        b=DfRe7O/j266ZduS2JD8XAESC4Q5+aHs4a64KMf0BXdosc/3sl+ZhO/9k/Lic805nQW
         oTJqHoIkaKxRHK2/PoRUla88IxMr0c6P64w0UwVD4p4wQGvnAaemoNTqV9r9DDYMV65M
         sytDqp8OmL2Kh10SK03UT1U215f+9RXHZBekMK5mZo6BUl9rwWKo3cReprU3J2ezYkEX
         Y95bYKt7kz2j4duR7iyXP0eFiyjxaw281VNJz004hRyHn6/OHT6hNKynx18J/kJk/8Cl
         GWJkJO8tbNue93THRjE7lQ88IWKdVnEdMmrLNkW80d96tDPcXKR0q+T6TgX6cgPaG9iv
         LxIw==
X-Gm-Message-State: AC+VfDwWabor4VYZ8SvcmvIxvV3cRyLDCsmPrIOn4IESL0U43v2r5Rgi
        E+3PpohGqDT3WfYcEMoxxjWC5D75780=
X-Google-Smtp-Source: ACHHUZ7Rxa7TBsEKIb7oCDpopFvMxtvzIC3bSiVEQjPTgEZP2AoYJKbEQyPphXQiCul2S79KyXIo5Q==
X-Received: by 2002:a17:90a:d188:b0:253:4212:9157 with SMTP id fu8-20020a17090ad18800b0025342129157mr1764152pjb.28.1684490776157;
        Fri, 19 May 2023 03:06:16 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:682f:3808:92bc:26c4:ce02:816b])
        by smtp.gmail.com with ESMTPSA id ev23-20020a17090aead700b0023cfdbb6496sm1163733pjb.1.2023.05.19.03.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 03:06:15 -0700 (PDT)
From:   Deepanshu Kartikey <kartikey406@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Deepanshu Kartikey <kartikey406@gmail.com>
Subject: [PATCH] [PATCH v2] Staging: rts5208: rtsx: Moved else statement to same line with else if
Date:   Fri, 19 May 2023 15:35:58 +0530
Message-Id: <20230519100559.26173-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.25.1
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

