Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFE370947B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjESKJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjESKJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:09:15 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6B0102
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:09:14 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d3578c25bso371082b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684490954; x=1687082954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bzq3Pqk8pZIS4OBKRNMcHxRAHqoQcIGGMgWTxxeCr8o=;
        b=OJam3IMO9AgyKpxdwOimHPpW0Y49CHC5KRE5ZlwDcE5T8WhEmlo3Ct54blrPovaupf
         CFaI9uTdtq2zP5gjlXUpJ4ZAB8bX3Ynhp6bKrBX44KCWK5iklRbJ4HBlNShGF8ZNf4ab
         Ykv2NM7I92qqDk46tPADtyPid0sNpk/+2xOkte1PtJIAe0Jb5Q8iWtsFt6OdZwV3q+lG
         s6Lx3Rtt/K9nDTpFbCRHgXWEC2iqoajdhG/4EXBxIc+PZGxouJqqXS0UgouUSdGoJJDQ
         V8wKLVAMJcelRB3+r4qOiFV4PX5GTtkhkGCPSvTbLyaEQbAzrei3xrn3PSx2ISmeoB+6
         +uKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684490954; x=1687082954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bzq3Pqk8pZIS4OBKRNMcHxRAHqoQcIGGMgWTxxeCr8o=;
        b=b0hTfb+7mzx3+IsxNWuypfa00KMpcDT7tIYxMrvtIZZ0zmgtXe9Im2OA+aFci5LSUj
         0Mbamja+Nidezc99Dgkh7W53STBvqQDsxdUf6/r/yNjLEcupNA2TIN6id1stVpZpuOqB
         lhLoXnUG2X/SZTSc9MzYrGFcYU9rlby7M0zdN77I0ctFumxwNfi+3AfO5ts4FyunthYt
         O7s0Y09VQ9tRUQT+XrB+9M/UeIG7wSeWXFFYwkw3Iz2tSbWZ+9xkVuxpe9yWcKzcVEjM
         tVBk+DHsYKcU1ygWjSTTbfkLIiEUWFwaWZcksxv4Jh5yXu+vLN3qNWUGCYDZP7NSaeFC
         YDzQ==
X-Gm-Message-State: AC+VfDwEQYSaJU7nPOFec0rWnKK/g97VWlFwMhCRd/ARYwOkv0hvQUSi
        i/tITaXgoKL2mgM//M0mLHk=
X-Google-Smtp-Source: ACHHUZ6tDkUURnf4GoTlMypuJO/5CCs2NmlipjXwYx9bn8Zn090gRWIw5rXermFNfH2KRWXGqbJ6YA==
X-Received: by 2002:a05:6a00:2490:b0:63d:3f74:9df7 with SMTP id c16-20020a056a00249000b0063d3f749df7mr2781219pfv.34.1684490953774;
        Fri, 19 May 2023 03:09:13 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:682f:3808:92bc:26c4:ce02:816b])
        by smtp.gmail.com with ESMTPSA id g10-20020aa7874a000000b006439ad979cbsm2687554pfo.152.2023.05.19.03.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 03:09:13 -0700 (PDT)
From:   Deepanshu Kartikey <kartikey406@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Deepanshu Kartikey <kartikey406@gmail.com>
Subject: [PATCH] Staging: rts5208: rtsx: Moved else statement to same line with else if
Date:   Fri, 19 May 2023 15:38:57 +0530
Message-Id: <20230519100858.26508-1-kartikey406@gmail.com>
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

