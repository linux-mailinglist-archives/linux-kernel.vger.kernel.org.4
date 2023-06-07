Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF16726446
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241407AbjFGPXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240847AbjFGPWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:22:38 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846D12722
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:21:54 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 633573F7EE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 15:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686151310;
        bh=sitF6aKufbc7DklTCjus/+uMnJoHcKEt7G8gHEJda3g=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=P/D8AjrULi8QbykhmIESppG2V5dwmDG65C6+Y/Lc/lyH0PwChBwUDbTr4nb5QiRH+
         AzfvzI0UoVv8ng85DoP90cKJBO2bjPXewzWA8ALtYxm/8PlLklLwE0jdOaCQZRWs1b
         voEY8gDTEW/lXDAzoQMTYuYsO1Nq1NDNjWc/dlOyK/cYL6kP9JDh7hQZlhBE2s4LfW
         v5ohY6pCKOwCOBE7UQSt7KP7AJOj99GbY6qmgTm8ycB7YPptofCEfY9ayYiaIlAJE8
         n+ZNuWnmJ13K7qVI4ZkQiHdCNt8yNqauTdfZgImKHCYHUaILMLtKTB+Mkt4eABVPse
         y5o/M7Ol6uz8Q==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-50daa85e940so1121289a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 08:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686151308; x=1688743308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sitF6aKufbc7DklTCjus/+uMnJoHcKEt7G8gHEJda3g=;
        b=Gyq2IfLXdMtAGjoHBhqQD6c+IY5kXOVfVVBK0armGTGo5CG2Tr2AD/MF7QYG9bV6se
         OAd1p4OaGyEFOL6495KxxsfqBDDVdnoidyaV4A+/q8Rq1G9lArf6tcOtX0XonIcL3LKO
         Wl7cOKlqtfGQ1mMDu9J+jzv/jP6XHJSyRsyPs5Cqf726R884SuRGhdakhdvo8zwyynAI
         oZ5QcCWpyPYNguYY9H3JmaoRZfZpnXbEWEBeXF6PotqesLk2Gr7bLPhwXcmE5xzkFBqb
         dAlp+OeJ6LohAumVoBu6HjLSaT/+XGAdTUxSvdaJCjeNq8mG032aX/eatgLFfGrNAuoM
         RYoQ==
X-Gm-Message-State: AC+VfDwaf6iYkEQQkuHZU+0aQSGq4Bjx7xRfAdBk2nrSP7OP7Gp7ZnyH
        pqPveUOBk3PKPiOJj852BBUYMML3hgnFQUaodjMYf4r2PKBdZ2YPRB97l02ZcISCSSEL7C4/Qev
        afwqJCYzeyUA/7gLBAlk4hAu6l4NbMbkpaP6ErXQ75w==
X-Received: by 2002:a05:6402:31e5:b0:514:9422:37dc with SMTP id dy5-20020a05640231e500b00514942237dcmr4479653edb.6.1686151308084;
        Wed, 07 Jun 2023 08:21:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6RVi6/fukZeNZcvZRzUwSUGXDPAwHYX90ZNHPzdh9z1jOlvF2lCQ3DOS9NFUQhNAtgVCXjxQ==
X-Received: by 2002:a05:6402:31e5:b0:514:9422:37dc with SMTP id dy5-20020a05640231e500b00514942237dcmr4479639edb.6.1686151307933;
        Wed, 07 Jun 2023 08:21:47 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id w17-20020a056402129100b005147503a238sm6263441edv.17.2023.06.07.08.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:21:47 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/14] ceph: allow idmapped mounts
Date:   Wed,  7 Jun 2023 17:20:38 +0200
Message-Id: <20230607152038.469739-15-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607152038.469739-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230607152038.469739-1-aleksandr.mikhalitsyn@canonical.com>
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

From: Christian Brauner <christian.brauner@ubuntu.com>

Now that we converted cephfs internally to account for idmapped mounts
allow the creation of idmapped mounts on by setting the FS_ALLOW_IDMAP
flag.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 3fc48b43cab0..4f6e6d57f3f1 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1389,7 +1389,7 @@ static struct file_system_type ceph_fs_type = {
 	.name		= "ceph",
 	.init_fs_context = ceph_init_fs_context,
 	.kill_sb	= ceph_kill_sb,
-	.fs_flags	= FS_RENAME_DOES_D_MOVE,
+	.fs_flags	= FS_RENAME_DOES_D_MOVE | FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("ceph");
 
-- 
2.34.1

