Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EE87381E0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjFUKBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjFUKAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:00:36 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31051107
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 03:00:32 -0700 (PDT)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0A335413A8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 10:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1687341631;
        bh=AWRzGH6ZSf0xboDPPn0o1FV8eJ+EiIwoZtGC1w36Sx4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=nqu1JkirYUkOEdGHVEhH/aR0NNjp1f1qbE/AEXuI2JVp0Kn0OU6gJQh2NjUNqVOwg
         wYKXfkFLrezQcc2P2DUQvghcBeZ6xutsm4ivyP/d5rdQDt/vhk+0SDU8fTvIFDiFai
         L7E5SptSUmUemuEwrZ7lOTgx00s0lLTmmo7ObKyaVcPGzN6EMwSVvXfdJaCYTzIbQZ
         c2LBrvKmrhWpxryAI+UelJhUPc0CKANWfQO3MPIU+PhB6OdwFsdZdxrt0pz7iBk3KJ
         Z/asdnlM08lbG7IoQR2aoqVY0lvJd6vGyApocjXOMMrMMO/lY4Ggb9ALv6wbkKmAuV
         x2Sltm+2heCDg==
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f8fa2ef407so22079995e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 03:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687341630; x=1689933630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AWRzGH6ZSf0xboDPPn0o1FV8eJ+EiIwoZtGC1w36Sx4=;
        b=ba2sIky0FKNWkn30+kg55PfcF3vwMUMaYo5eCsLNdCgyxSPIk6NElOTF5/yAxuf8IE
         YMC7LY9cpjDQ+8ovqRUqa57Wk48y4RLbPA+VsWY3QNXffgWPf0jv4UfdyfuCVBN7dhi1
         HOaDx1BMGoicO/+q435HqvUHiXuJpNQfCxKZmjsBLhgih6b4Qdl3OdSLSBkYa6JX+FIx
         9ONNdOz0T5hIJtxUmEe4xYH5LJJOkRN5A9qmEaOJ6UxSndFXuPqLdt0edz28Iu3KdlRd
         Fzuixt3tCU1AWTMEXCeqIroj8pkrgDeinvyMn+kMHNWRbwDV7OTknSPgybWvHA/Alk2I
         8OaQ==
X-Gm-Message-State: AC+VfDziAajYWLlLbWidX6WiPGAbyMAj7nhBsq/tbEdLQHKzAlsLF9Gu
        I37JVWveO5ReGz5GcVQgZllSkIS3KAYmBJxyEf1qp//rcw/Qws7r2vYc3i5RM2+Ik8dBZHlRW0s
        t/UiKKm/qXtj66kOBx2STX0wXEOtttiZLnaSbL+wGfA==
X-Received: by 2002:a5d:6ad1:0:b0:311:18ce:152b with SMTP id u17-20020a5d6ad1000000b0031118ce152bmr9508840wrw.61.1687341630630;
        Wed, 21 Jun 2023 03:00:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6oq+fIPGFA+sWLn7jvMuxe5Lvalcwkqv7UzsK6f+Iq0Y+CIzxjFvRPS+Xk+lXhEcKckC55vw==
X-Received: by 2002:a5d:6ad1:0:b0:311:18ce:152b with SMTP id u17-20020a5d6ad1000000b0031118ce152bmr9508830wrw.61.1687341630348;
        Wed, 21 Jun 2023 03:00:30 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d58ca000000b003111fd2e33dsm4024427wrf.30.2023.06.21.03.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 03:00:29 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: filesystems: idmappings: clarify from where idmappings are taken
Date:   Wed, 21 Jun 2023 11:59:05 +0200
Message-Id: <20230621095905.31346-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's clarify from where we take idmapping of each type:
- caller
- filesystem
- mount

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 Documentation/filesystems/idmappings.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/filesystems/idmappings.rst b/Documentation/filesystems/idmappings.rst
index ad6d21640576..c20382f8bbb0 100644
--- a/Documentation/filesystems/idmappings.rst
+++ b/Documentation/filesystems/idmappings.rst
@@ -373,6 +373,12 @@ kernel maps the caller's userspace id down into a kernel id according to the
 caller's idmapping and then maps that kernel id up according to the
 filesystem's idmapping.
 
+From the implementation point it's worth mentioning how idmappings are represented.
+All idmappings are taken from the corresponding user namespace.
+    - caller's idmapping (usually taken from ``current_user_ns()``)
+    - filesystem's idmapping (``sb->s_user_ns``)
+    - mount's idmapping (``mnt_idmap(vfsmnt)``)
+
 Let's see some examples with caller/filesystem idmapping but without mount
 idmappings. This will exhibit some problems we can hit. After that we will
 revisit/reconsider these examples, this time using mount idmappings, to see how
-- 
2.34.1

