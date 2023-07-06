Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1362749E0B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjGFNnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjGFNnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:43:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D968F1FC6;
        Thu,  6 Jul 2023 06:43:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EF1761956;
        Thu,  6 Jul 2023 13:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C683DC433C7;
        Thu,  6 Jul 2023 13:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688650992;
        bh=FUjvj+1KggTKf3IJ7E9yOc6WsvJXizVjHxqnoZ8GHtU=;
        h=From:Date:Subject:To:Cc:Reply-To:From;
        b=HcLTEbcH6/iC3K0d3H89WJpztQgQD/sCOz5U04lYXNdkEa0OB03R7CCOSGHKKAdfK
         9BK0o8aYaN1Pwp+gXqZBUnK1Tj3brEXIiKwj/qybu61bjoV56WCkcmmVHfC5flq1jy
         ixNEmpPItlRnFiOv/mxS/sySQ74E5qW6ZFRDZVsTCsf2UntXYir9yxTo4zCBY/QMCx
         tpyh7nvIX0GYRlZmF1LJZrvT8I4l3TcNLLHtr5fnfXuKMjSACKGvgCdGcI+tDni6c3
         1dvNckWuZEDXHaTk0XicV5XqAZWzYHvcwRd9sepBXzgK0il9ixCkXMH0uV4AOMGfs1
         HXNOZIXTD/gSA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id A5B22EB64D9;
        Thu,  6 Jul 2023 13:43:12 +0000 (UTC)
From:   =?utf-8?q?T=C3=B3th_J=C3=A1nos?= via B4 Relay 
        <devnull+gomba007.gmail.com@kernel.org>
Date:   Thu, 06 Jul 2023 15:42:47 +0200
Subject: [PATCH] security: smack: smackfs: fix typo (lables->labels)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230706-smackfs-lables-fix-v1-1-228c8da5a526@gmail.com>
X-B4-Tracking: v=1; b=H4sIANbEpmQC/x2MSQqAMAwAvyI5G6g7+hXxUGOqwZUGRJD+3eJxB
 mZeUPbCCl3ygudbVM4jQpYmQIs9ZkaZIkNu8sI0pkbdLa1OcbPjxopOHrTU1hWVVDatgxhenqP
 +p/0QwgfggIfrZAAAAA==
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?T=C3=B3th_J=C3=A1nos?= <gomba007@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688650991; l=959;
 i=gomba007@gmail.com; s=20230706; h=from:subject:message-id;
 bh=S9HyRNyzLwD2W29A0DsX2ZZZiM4IO3L3DpcXXpfmTVs=;
 b=+l3RH2YK8ag+dH4tuUELH+9cCBBPq/Q/0jA3y2RaAMzIg/aM05m2xuKO2LqP1+WPWo8bU9u9R
 eJrj3WH5m+wCBZgCrQW0f5XpFTJJfh+0d8KcynKf72E51KCl0BZbNoI
X-Developer-Key: i=gomba007@gmail.com; a=ed25519;
 pk=iY9MjPCbud82ULS2PQJIq3QwjKyP/Sg730I6T2M8Y5U=
X-Endpoint-Received: by B4 Relay for gomba007@gmail.com/20230706 with auth_id=60
X-Original-From: =?utf-8?q?T=C3=B3th_J=C3=A1nos?= <gomba007@gmail.com>
Reply-To: <gomba007@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tóth János <gomba007@gmail.com>

Fix a spelling error in smakcfs.

Signed-off-by: Tóth János <gomba007@gmail.com>
---
 security/smack/smackfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 5590eaad241b..2b79c30d4bb6 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -114,7 +114,7 @@ struct smack_known *smack_syslog_label;
  * SMACK_PTRACE_DEFAULT    regular smack ptrace rules (/proc based)
  * SMACK_PTRACE_EXACT      labels must match, but can be overriden with
  *			   CAP_SYS_PTRACE
- * SMACK_PTRACE_DRACONIAN  lables must match, CAP_SYS_PTRACE has no effect
+ * SMACK_PTRACE_DRACONIAN  labels must match, CAP_SYS_PTRACE has no effect
  */
 int smack_ptrace_rule = SMACK_PTRACE_DEFAULT;
 

---
base-commit: 6995e2de6891c724bfeb2db33d7b87775f913ad1
change-id: 20230706-smackfs-lables-fix-ac965c4c479f

Best regards,
-- 
Tóth János <gomba007@gmail.com>

