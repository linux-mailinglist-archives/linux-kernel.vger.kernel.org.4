Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255D9726442
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241441AbjFGPXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241387AbjFGPWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:22:25 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171242716
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:21:52 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6B9323F7DF
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 15:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686151308;
        bh=/It8VSgZDTEKktJxHTMOOJHpvqL0RXNtakCJDr6cWYA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=vOo6cV8dNnd6NKyR/aNcD6ERtS/1kdqbKdndSIJYr0A0mlrGN6WO+HpIzR5mZV14N
         D+gGQfb47UW/hXOKpKzrHQpiya6ZtrBTUQifVmACFpUGXDw65NUeSN3tgbfP/nB7jp
         VQSrN+HxMbyOCAZwLBIuNnt/bYcfLz5ZhWxAj6iB/l37TnO8z3Rlog6v5QigPzkvmu
         pO63OWUsoKEiqnR52yzfBGWLT/sJRQ5T6yVB+4ulml2TvfR3G+oFF2V9/pcrzIh/2+
         jnQn771prM8rX37p5W7BkU2jmXNxAk9tYfn8dVX3I9uvP+4qXZR+KuX0UJ6sFpBzBA
         RJTRx6Memz/eg==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-50ddef368e4so848969a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 08:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686151303; x=1688743303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/It8VSgZDTEKktJxHTMOOJHpvqL0RXNtakCJDr6cWYA=;
        b=VPcQO3Vq4QiyFZAgF81Rc9dTlRLBeHRtrm+IV1Mftgd67hanDqx2HAoovmWCuUHKoU
         QM+GQr1QVk1T1JceD2QeDVTDaA184b2NGgOMPaUeRkdyyvtOIRAciWYMooJDdyNUKshR
         6SvAgUMcMYUzObWIA1aRi/R0WOH7JR0Iiq018j250tc69Y5YY1Dgmew/i8wWkeVYSUQE
         EfRiAa0GC+HTiCwtoJY0okM9AUh4Fi4u3l0WzkRKvMZv9Qkvs5G3ntxFzp+5l04MW5gj
         W4jWOyuoOA+WVe1xZqxDk+a97M8G4njjrKfblz0iIBO3GszkNqqTQd/0WVjnbc278bRD
         fhUg==
X-Gm-Message-State: AC+VfDzRhwx5zRteNNqMPvFUbSPe/JZ85PVny9yqC6wqqHzgkeY8Uc3Q
        QY7R+N3HNIEw82QvE8EoT9yFnOgBE8UUENC2lIBn7uKmNXcI9gj1R0CuT8GTyNqoKgdcZLjJj72
        x5dm1prRAyV8douXdIgwnpN9nnfpmUAo9qiUPE/blKoKaa1yP1A==
X-Received: by 2002:aa7:d6d1:0:b0:514:9b64:e16b with SMTP id x17-20020aa7d6d1000000b005149b64e16bmr4291082edr.35.1686151303273;
        Wed, 07 Jun 2023 08:21:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ549H6QwL6/dPEtGgtxmi5qPiQgs+YkY6irYHiRo8gsOZQw2QXXW6qBLDYK5KPmgsOY3/heBg==
X-Received: by 2002:aa7:d6d1:0:b0:514:9b64:e16b with SMTP id x17-20020aa7d6d1000000b005149b64e16bmr4291070edr.35.1686151303150;
        Wed, 07 Jun 2023 08:21:43 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id w17-20020a056402129100b005147503a238sm6263441edv.17.2023.06.07.08.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:21:42 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/14] ceph/acl: allow idmapped set_acl inode op
Date:   Wed,  7 Jun 2023 17:20:36 +0200
Message-Id: <20230607152038.469739-13-aleksandr.mikhalitsyn@canonical.com>
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

Enable ceph_set_acl() to handle idmapped mounts. This is just a matter
of passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/acl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index 51ffef848429..d0ca5a0060d8 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -105,7 +105,7 @@ int ceph_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	case ACL_TYPE_ACCESS:
 		name = XATTR_NAME_POSIX_ACL_ACCESS;
 		if (acl) {
-			ret = posix_acl_update_mode(&nop_mnt_idmap, inode,
+			ret = posix_acl_update_mode(idmap, inode,
 						    &new_mode, &acl);
 			if (ret)
 				goto out;
-- 
2.34.1

