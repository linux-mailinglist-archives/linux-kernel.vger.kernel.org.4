Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1C77094A7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjESKUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjESKUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:20:12 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AB5E6E
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:20:11 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5343c3daff0so2064527a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684491611; x=1687083611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wba1YArvykmSZksSn+PRwHxHWmhMmfjRVISgjVjCTk4=;
        b=r+7NWjZWVcWmma20ropjBAVlRiDX88ySFCqwHU/iGNGMjO4nwzeYgtuz2/2mYn7sbd
         2duhvUxTPNcRZfDYB8iNwLX9J3x0Cj/NiP7qlNjf1+kvk3EUbhLdayVpvye8f6LE/l0m
         tB2poaw72qFJmc3Dv/aMLEeN1QWbUlm08z+cq9hqyr9VG3Ujqavzh3+p6hqTbGlhbAa+
         9/CGpc/6uBRzuNwGghhybADvueP5g/TpMG4c0i50zQzhkavYr01AAwhDeyclrpnyfgCT
         afQEgmm5aCJjjW+ijynifNz9VJZ3ORZDq+3gRN8yEQId4l1CB1BAW0HV4tCIAj7mRrtW
         +E3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684491611; x=1687083611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wba1YArvykmSZksSn+PRwHxHWmhMmfjRVISgjVjCTk4=;
        b=ZcgZ90wOlRsLk7wzqMmW6x9HplxT1yeksUkHlZUfQCfczAINCv6TD6fxFxlM4Up4AA
         x4s0fhvQYoNTrY+T7qsA20QzJz+HCaY9FJH73lFl4tT81nqeRI1y9l66p/69KbEw/FuK
         jToksZEy/DrHBSUj7DBv1RtNzOonCYXkqgKC2hMmj7yRGaj7n3uBufPwdIjXh+SV7HJP
         2W0n9UP2F6wNlzrq3L4SjzKUdRu8nVKywJv5gtyF7RzTLyjd7Qrl3kRu2vr1GILJ2zG9
         TnMFkUoNJQUiy0Un6/UqUzUcCYC4YtIuAwMuOcUYqCelxounoskfe6iHjwZCPs0SPJAP
         LhAg==
X-Gm-Message-State: AC+VfDxgYmuog164hk++XQpBRGisU10sKmhEtCpykzXLDfe/MfHMLnac
        xjAMT2Kc+vUxD4rqW0RgmIDzOhzKIZo=
X-Google-Smtp-Source: ACHHUZ6SUGdXo0L79y50osdj51y3rTdr1BqzA3o2k+ZO/cPnnVD/3MDRCNTkiyZLCFaPTV/cEAt2Xg==
X-Received: by 2002:a17:90a:2e12:b0:253:3ce4:b421 with SMTP id q18-20020a17090a2e1200b002533ce4b421mr1721376pjd.1.1684491611042;
        Fri, 19 May 2023 03:20:11 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:682f:3808:92bc:26c4:ce02:816b])
        by smtp.gmail.com with ESMTPSA id t7-20020a17090a3b4700b0025374fedab4sm1239643pjf.22.2023.05.19.03.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 03:20:10 -0700 (PDT)
From:   Deepanshu Kartikey <kartikey406@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Deepanshu Kartikey <kartikey406@gmail.com>
Subject: [PATCH] Staging: rts5208: rtsx: Moved else statement to same line with else if
Date:   Fri, 19 May 2023 15:49:19 +0530
Message-Id: <20230519101920.27342-1-kartikey406@gmail.com>
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

---
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

