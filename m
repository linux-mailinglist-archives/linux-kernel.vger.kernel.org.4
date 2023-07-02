Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1631C744EB4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 19:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjGBRJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 13:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjGBRJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 13:09:08 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AA218B;
        Sun,  2 Jul 2023 10:09:07 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666e64e97e2so1941452b3a.1;
        Sun, 02 Jul 2023 10:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688317747; x=1690909747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+OWP9mTxDvq9/9bth4FmWGXzG9JshUYvadC+k3pbKI=;
        b=ZVyrOGeve1JC9HcQiHoQdbvXMQQTytqcF/KiU8fKLltcPhsse4n5HTwiyMvQhljliR
         s1IVCuu6koKhsEdyWBaUxXSCO8oTtb66/TwczesKLJuaSZJgN2lMsN88Q6Tc8H0fDUG6
         /9v43LvZtrsA4/OI+zFrNUc/vgFvwHoIoj6Pe8uYLgZiCm154zi97U1diiXMv2DSQBKJ
         vF8nlC95f4lTtbaaPoq6xUOz9dRuldyAm+FLxKKPhjcfW6XpJ5UhLkFnRrOBp7CMyQsR
         f/oSivF6WYQBkX6Ohfa5icWdiAv09HTNuLhgxTlH3zR/dbm3LN2+2FU+yR0JAVB7DX23
         NQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688317747; x=1690909747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+OWP9mTxDvq9/9bth4FmWGXzG9JshUYvadC+k3pbKI=;
        b=AnmfkGl/qVa3tpWW0PHYqyzydopeqaO2QHmp9kO3pI7hxMiDzfVNuf2w9jWBFxisLI
         7sKEwCL82HJ8bfHhqs7C6u6LVeBlTXdDHPMSG4x6eNk8coJwMB9vol5mokcIkbUSl7Gi
         2p0UYVPqjflw6qMWgwMT57fWwrGP946IW+vb206p+F/xkMP73Kxx6dQT/8fuuznpOnin
         +w7pVK2dW1caoSUFyrx0Kiud2M9A/7bO64PDGsFENgnumkhl5NhjrzT1RQZQ04r8bpiK
         t/HU1jvCXHmvvcVR/IATEkRLhg/YitMdF+hmnt99d6SOpHtPB/+Fry77FUuf3F1dXpkC
         gJSw==
X-Gm-Message-State: AC+VfDyk7nLSwL3u/40Kbek1TpHC6Ka8pAk2dWTeLD5G3n9UNsQS3p5j
        +7Z+v4uhxBWq/NiX+3LXSMDPzlRzG9MMY5Md
X-Google-Smtp-Source: ACHHUZ6zNpcL400rejZP8WVfHTOBPgX7UQQM75jRZ95xOEUskQQTr6+lWtrSDfrshGyjDYtB+4CTQw==
X-Received: by 2002:a05:6a20:970a:b0:12c:518:b8de with SMTP id hr10-20020a056a20970a00b0012c0518b8demr6434565pzc.17.1688317747087;
        Sun, 02 Jul 2023 10:09:07 -0700 (PDT)
Received: from fedora.. ([123.139.60.254])
        by smtp.gmail.com with ESMTPSA id z2-20020a656642000000b005302682a668sm11847188pgv.17.2023.07.02.10.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 10:09:06 -0700 (PDT)
From:   Pairman Guo <pairmanxlr@gmail.com>
To:     paul@paul-moore.com
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pairman Guo <pairmanxlr@gmail.com>
Subject: [PATCH] LSM: Fix typo in a comment
Date:   Mon,  3 Jul 2023 01:08:57 +0800
Message-ID: <20230702170857.15603-1-pairmanxlr@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Hi maintainers,

In the description of function definition security_file_lock(),
the line "@cmd: fnctl command" has a typo where "fnctl" should be
"fcntl". This patch fixes the typo.

Please merge if it is the case. Thanks in advance.

Signed-off-by: Pairman Guo <pairmanxlr@gmail.com>
---
 security/security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index b720424ca37d..adaa7043c172 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2717,7 +2717,7 @@ int security_file_lock(struct file *file, unsigned int cmd)
 /**
  * security_file_fcntl() - Check if fcntl() op is allowed
  * @file: file
- * @cmd: fnctl command
+ * @cmd: fcntl command
  * @arg: command argument
  *
  * Check permission before allowing the file operation specified by @cmd from
-- 
2.41.0

