Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4076FBC17
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 02:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjEIArt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 20:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjEIArr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 20:47:47 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201E14C02
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 17:47:47 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ab13da70a3so51363655ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 17:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683593266; x=1686185266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AnYQFHTbJTJdfXp3SX7x1y+1lmd38opYw54jgIKs6KI=;
        b=W1QuMKAEZGcKrSLuy8Txc0Co7I+Kq9ScVrBOaEOhSWvV9THByGfo6ry5QJgWFv9+Wl
         g0hI2GXixbyHWPmHhYnKUlZzSs5V2BL451rHu+3KNQkhyV2y9/AmQ/6maDKEWGQwaF22
         DVNtO8Y3BCqPJCWTGwBOp1pJSWViGD+OWKWXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683593266; x=1686185266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AnYQFHTbJTJdfXp3SX7x1y+1lmd38opYw54jgIKs6KI=;
        b=XGopD+U4WcRgyCep1NNyZTEC489CEZMgxs6erwfS09VQonFvpaH0OseQ9FESrNYwx9
         XRtsCX68Xq80SWqtwwCA0BoY9oLkiijrChBP5lTxWmgcsF67Jd2YGDYxhsg32VDglJ+s
         p+j8MAmS1+d+pP4Ywu5TKo+hIsj3oIFRti0OC1t2I6dS0xhiQyt4HNwYo7n4uTXbOfw0
         iYjIrC5fz/2RrOiSp2NevBAgoADZx5bj+apTJz/dNOUgBhG+toLTXkJA7YHz/VlLLNBO
         TdbnaDOwZuOySbandUqfFH/r65FWuyaAPOxTJyb/VmQlVeItepzzDQrmXK04mUix0Tuu
         V1Fw==
X-Gm-Message-State: AC+VfDygxRLmnNaEtLwx6rL6sxKWjHjVKqHRAGAo3i950jj7yKCg2v1t
        RavBN9GT4JGJFeTB0tFwXFvYCh/ebJJrplSdfiKom4Q+
X-Google-Smtp-Source: ACHHUZ7L8ye/QrZf6n3vtDIM48n0Atsn/bCJYMfp7B9vIKZzA92kc4DHxoVk6MwOBcG5BRaYadfZzg==
X-Received: by 2002:a17:902:b696:b0:1a9:bac2:21a2 with SMTP id c22-20020a170902b69600b001a9bac221a2mr11554059pls.21.1683593266467;
        Mon, 08 May 2023 17:47:46 -0700 (PDT)
Received: from datalore.c.googlers.com.com (148.175.199.104.bc.googleusercontent.com. [104.199.175.148])
        by smtp.gmail.com with ESMTPSA id r1-20020a170902be0100b001a24cded097sm81321pls.236.2023.05.08.17.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 17:47:46 -0700 (PDT)
From:   Brandon Pollack <brpol@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, masahiroy@kernel.org, ojeda@kernel.org,
        alex.gaynor@gmail.com, keescook@chromium.org, nathan@kernel.org,
        Brandon Pollack <brpol@chromium.org>
Subject: [PATCH v3] .gitignore: Ignore smatch generated files
Date:   Tue,  9 May 2023 00:47:30 +0000
Message-ID: <20230509004729.3941096-1-brpol@chromium.org>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Smatch static checker creates some data files in the kernel root
directory.  Add them to the .gitignore file so that no one accidentally
commits them.

Signed-off-by: Brandon Pollack <brpol@chromium.org>

---
v3: Rewrote a more descriptive commit message and removed "change-id" junk
v2: Removed trinity stuff

New to development and looking for tasks to work on to get familiar with
code, I noticed smatch generates some files at the root.  Since this
tool seems frequent for newbies like myself I thought it would be worth
getting rid of the chance of accidentally committing these files.
---
 .gitignore | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/.gitignore b/.gitignore
index 47229f98b327..fd8572cb7db7 100644
--- a/.gitignore
+++ b/.gitignore
@@ -171,3 +171,10 @@ sphinx_*/
 
 # Rust analyzer configuration
 /rust-project.json
+
+# Smatch tree outputs
+smatch_compile.warns
+smatch_db.sqlite
+smatch_warns.txt
+smatch_warns.txt.caller_info
+smatch_warns.txt.sql
-- 
2.40.1.521.gf1e218fcd8-goog

