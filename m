Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D9869D42A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 20:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbjBTTiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 14:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjBTTiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 14:38:17 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5D3A5EA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 11:38:16 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 494273F587
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676921894;
        bh=YuLEnjWYJ3ZScY+VoOmH9vHwx7aNhN3sNU3joAeNQOc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=wMZmLNQ+i63tlWK+Yf+7US/vF8Y81qMUjDREhPV6j4gj+2dx4RE2E6vjWj4cZvnBk
         lYPTANXyoAIbqdNmnq7v6IhXp1A4v1ruaLgueemeHeUFKSpHhfHSsEsPAbnKYHuhwO
         mtQ7UnyJ4Iai6JkpDIodXKaRNW6SPg4qFnZc8yi2pY8IGOVRZn7aNOSxUAqgzjoWX2
         c1NA/prH6Gz3q6FkS9vwgByQsLnkwWHeRuquZwNLjkUTlnDKOYFcwxJ9VJkU8Cyx3c
         F/oU2uCRTorFdNj0JgHcPJjTFD16pNj+ln5C83FYlXGa3vSxkbnzSayexYPjVgJmcH
         SAi2cMFKLqsxg==
Received: by mail-ed1-f72.google.com with SMTP id co14-20020a0564020c0e00b004aab4319cedso2319420edb.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 11:38:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YuLEnjWYJ3ZScY+VoOmH9vHwx7aNhN3sNU3joAeNQOc=;
        b=fANHiCgY7ry50toIAxCXDtegfhyRlhJpq7nmpZg/VJ1sJ3oQLYN2NFEy17VR0Poh44
         kUhhTcUP3r/GeqMmt4ZP2YxmRpFOh/Bi0k+VXo0csSo9WZucz9nUGkpoYn0S8eyWjHZT
         JdLvxSKtIXADtdgsuogdxnrk2eEUCC6J7oq5byCutwOTwuAeCjfqXKoFjNzwunYpSfd+
         ryJet3e4xUkOoACqCZD7OJqHdTE1lSf1EG9DTp3IRVKG49NoFpDgaiWdxlwXZldAvbH+
         w79xQDIL49ZAXY+OpxihZOb9GzOzHlOoB/FB0MwEADLCuNe4N/X4OdXl7NmirrGfyKmN
         LOig==
X-Gm-Message-State: AO0yUKVM5J87Xh9ejnkBHuP7BwNO/2a3a2PlYije6DU81JXq+k5Ln1TN
        Od9cQUwE2AOZI/PMkLxBpa1VSEFXN4weRaHD9fPmh172MaWISz8QMUtI8+39/tbHT3oEyaJ53EX
        7DtuT8ptPxMfgX9RZ7fmQidqBGuDwMoH8WBv1+5xkrA==
X-Received: by 2002:a17:906:264d:b0:8a9:e330:3a23 with SMTP id i13-20020a170906264d00b008a9e3303a23mr9886644ejc.26.1676921892767;
        Mon, 20 Feb 2023 11:38:12 -0800 (PST)
X-Google-Smtp-Source: AK7set+dotV8WedmVXCpUfp7Rt1J+dl2VV8JXLR/YqSls60Skj61wTIhQpTDznIUMAwG11YbDKBOeg==
X-Received: by 2002:a17:906:264d:b0:8a9:e330:3a23 with SMTP id i13-20020a170906264d00b008a9e3303a23mr9886624ejc.26.1676921892581;
        Mon, 20 Feb 2023 11:38:12 -0800 (PST)
Received: from amikhalitsyn.. ([2a02:8109:bd40:1414:bb20:aed2:bb7f:f0cf])
        by smtp.gmail.com with ESMTPSA id a19-20020a17090680d300b008d4df095034sm1526693ejx.195.2023.02.20.11.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 11:38:12 -0800 (PST)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     mszeredi@redhat.com
Cc:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        criu@openvz.org
Subject: [RFC PATCH 1/9] fuse: move FUSE_DEFAULT_* defines to fuse common header
Date:   Mon, 20 Feb 2023 20:37:46 +0100
Message-Id: <20230220193754.470330-2-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ASCII
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Stéphane Graber <stgraber@ubuntu.com>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: criu@openvz.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/fuse_i.h | 6 ++++++
 fs/fuse/inode.c  | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index e13a8eff2e3d..4be7c404da4b 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -47,6 +47,12 @@
 /** Number of dentries for each connection in the control filesystem */
 #define FUSE_CTL_NUM_DENTRIES 5
 
+/** Maximum number of outstanding background requests */
+#define FUSE_DEFAULT_MAX_BACKGROUND 12
+
+/** Congestion starts at 75% of maximum */
+#define FUSE_DEFAULT_CONGESTION_THRESHOLD (FUSE_DEFAULT_MAX_BACKGROUND * 3 / 4)
+
 /** List of active connections */
 extern struct list_head fuse_conn_list;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 114bdb3f7ccb..097b7049057e 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -53,12 +53,6 @@ MODULE_PARM_DESC(max_user_congthresh,
 
 #define FUSE_DEFAULT_BLKSIZE 512
 
-/** Maximum number of outstanding background requests */
-#define FUSE_DEFAULT_MAX_BACKGROUND 12
-
-/** Congestion starts at 75% of maximum */
-#define FUSE_DEFAULT_CONGESTION_THRESHOLD (FUSE_DEFAULT_MAX_BACKGROUND * 3 / 4)
-
 #ifdef CONFIG_BLOCK
 static struct file_system_type fuseblk_fs_type;
 #endif
-- 
2.34.1

