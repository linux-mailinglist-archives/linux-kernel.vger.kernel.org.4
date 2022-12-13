Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF3E64BD91
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 20:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236439AbiLMTuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 14:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbiLMTuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 14:50:02 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9C926557;
        Tue, 13 Dec 2022 11:50:01 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id y4so4467088ljc.9;
        Tue, 13 Dec 2022 11:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J4x77W/sibnroDB0Sxn4QouDqI5azeko85Ug18unf/Y=;
        b=hj5SHgfTSCgDGTpEkply32REHP3MOD4YDUtKSsYto5FQk8zCsnLNxEaweJ5lLzg076
         MzKwNKYvv7cNSRy9oVkJVnNougFsA20uGDfCCggW2EaEP8i43TQnuy+oDEMv29DTnvUR
         DP4g7QYVUaRm2TRhILfFNuy22PFmXbfIY7pOFHNkon6/ULhq5xpjCFD/Hn4bGXGYdDvw
         +dTG10czOBXBzXweOQb8YOgBZgsoc1eo27P38WJKRQSZU0qiRShczu6DSwRAUEQPYFLV
         ZZxTrkAIRcFX6v/JNXqrh+Y4lisDvImaLASq7Ctj81FbNTGNTMySDB4JcE9XH20TUbUQ
         jPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4x77W/sibnroDB0Sxn4QouDqI5azeko85Ug18unf/Y=;
        b=dNI6qCgdy3wl6aljlhUG8weA7a+9D18UXlogLb2GDzQiDTn6Er8R2pBEy+SDoaqiwM
         lN/QLPacOYFjhH5gsn1jx9iiRSLTMVttByUyKa7hMOQlU8n01+XCag8XuJmeXfDPiEks
         WORAR4eo15aNdDVN93e6e4Kzlx98wxBKrD+CI17j/kUl5PDC5+yvCy372xGE3iqKzHPD
         YzLhA/DDLXvfqo/H5SRiar/DN+7jr74lEEEVFLBGlbjtJgj7GcH9L3ma0vGeksVACU1c
         FHtSZurhhCI80b93lFhEdg2A0VX364m/pSfZ6Oo3hbonag54RQIOcuGXBrLI+OP8P2Cp
         yFCA==
X-Gm-Message-State: ANoB5pngj4lVAbvsZ/h/mVqHdmnBHc8d1sb7gkmsxB5CyeStsdOzxZZ2
        Ecq2zse/BkC6RfmLKeURa6c=
X-Google-Smtp-Source: AA0mqf5TVlZlFb09EBcxPBNEwwdMCpQN6zeWfsNeGPBQozy02qmMZsROmJfCqjvOPtKHb8WzP6J6MA==
X-Received: by 2002:a05:651c:883:b0:26f:db34:a157 with SMTP id d3-20020a05651c088300b0026fdb34a157mr5246440ljq.26.1670961000081;
        Tue, 13 Dec 2022 11:50:00 -0800 (PST)
Received: from DESKTOP-5EKDQDN.localdomain (78-63-10-115.static.zebra.lt. [78.63.10.115])
        by smtp.gmail.com with ESMTPSA id a8-20020a05651c030800b0027a081bfee9sm383099ljp.43.2022.12.13.11.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 11:49:59 -0800 (PST)
From:   =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>
To:     eajames@linux.ibm.com, dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>
Subject: [PATCH] Input: ibm-panel - fix typo in comment
Date:   Tue, 13 Dec 2022 21:48:55 +0200
Message-Id: <20221213194855.260-1-aldas60@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"set the index to it's largest possible value" -> "set the index to its
largest possible value"

Signed-off-by: Aldas Taraškevičius <aldas60@gmail.com>
---
 drivers/input/misc/ibm-panel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/ibm-panel.c b/drivers/input/misc/ibm-panel.c
index a8fba0054..6be60bc8d 100644
--- a/drivers/input/misc/ibm-panel.c
+++ b/drivers/input/misc/ibm-panel.c
@@ -101,7 +101,7 @@ static int ibm_panel_i2c_slave_cb(struct i2c_client *client,
 		else
 			/*
 			 * The command is too long and therefore invalid, so set the index
-			 * to it's largest possible value. When a STOP is finally received,
+			 * to its largest possible value. When a STOP is finally received,
 			 * the command will be rejected upon processing.
 			 */
 			panel->idx = U8_MAX;
-- 
2.37.2

