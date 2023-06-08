Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5B67283F1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbjFHPoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237162AbjFHPnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:43:49 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0326830DF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 08:43:37 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 81FAB3F36B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 15:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686239015;
        bh=U9FNme5iBEpufhowdmn6D6u4P9E81AUlwyvYSH4GMyo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=nXEpBLY25uGlswDTSF7+yXtJxiY9OwrEtmJLmgwjg/Oo59EbJaUOK2vhQSm74loZa
         FCODoM1TQBmmbteEHWTQe9Uz1dPt/LrlOGThyjSmuUnXmmasEHCRSbUzriLZOHg80t
         onJim6o8miaXTgd7HqKRWVDJZgDD0nRQbxCS2kJYcJiBadzy8FVYH9cQRe/eG6Ni1I
         XPricqkktgfX0Wf3Xb44Oj5oNdWXWn2D3j1mjIlh1k8l8sZM3O7iCmgudltqPmC08J
         hF21HTH3zFO7TeKhLgLrH+xkni+D13q9/ayUglCR1i7j8oqoAYCeV8kUHVo67F4kyD
         3TBtVQcuReAtA==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-51495d51e0fso754587a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 08:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686239013; x=1688831013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9FNme5iBEpufhowdmn6D6u4P9E81AUlwyvYSH4GMyo=;
        b=bhPHP8ltFo6rXAv/OqGmlrOuoSIuhZiJDImcWJGFa6vz4nrCB2vRP/oDDGFeVITWuL
         /OjwbJBk8yKrxIiS+7fEPbxefh/zz12B6UhM757CHpdwUecIfVIrTzYllhbVyllejpiM
         hRMFYFN//TOMhKgjLCeb2XS5NDwxEDQes/OMB8nBHCsmP52vI1Z11D4Njuhq9uKj5XOs
         kojGhVp3Yt4TQmZsAZmC3DIMH3UjEocWGAlFROZWWF4SZjYau8tFtxBWGEzwE8c6b9ME
         5z2MYnijJml/h/j5an3xo788endVN3tVHu+sHSZ5VlJMShThqQe1Dag0GfGsE9/bJvhN
         H6cg==
X-Gm-Message-State: AC+VfDw99TCbwqfUZCVRG0UR/l3Sj/mW9U3qu3aKQrmC/H4Mm4LJwJbd
        u07NvRFiPwggEH5vW8zXUyzBKhGiIiIqBZMKbCo9iPY39ZQDX31Cs2UGm7EntK9m46dYpyAPBUy
        ujrWhTYrwTpP9nUrohndwrNjy6O/yYIIOmq24z6B6SQ==
X-Received: by 2002:a05:6402:147:b0:514:9c05:819e with SMTP id s7-20020a056402014700b005149c05819emr7681644edu.0.1686239013828;
        Thu, 08 Jun 2023 08:43:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ735DyjETywLYDs+jXXCutddOvsHT2twFvkzH160wtul6aVFuOgt/4u3yyoBsAtPQpaf211Jg==
X-Received: by 2002:a05:6402:147:b0:514:9c05:819e with SMTP id s7-20020a056402014700b005149c05819emr7681635edu.0.1686239013667;
        Thu, 08 Jun 2023 08:43:33 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id y8-20020aa7c248000000b005164ae1c482sm678387edo.11.2023.06.08.08.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 08:43:33 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 05/14] ceph: allow idmapped getattr inode op
Date:   Thu,  8 Jun 2023 17:42:46 +0200
Message-Id: <20230608154256.562906-6-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable ceph_getattr() to handle idmapped mounts. This is just a matter
of passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 8e5f41d45283..2e988612ed6c 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2465,7 +2465,7 @@ int ceph_getattr(struct mnt_idmap *idmap, const struct path *path,
 			return err;
 	}
 
-	generic_fillattr(&nop_mnt_idmap, inode, stat);
+	generic_fillattr(idmap, inode, stat);
 	stat->ino = ceph_present_inode(inode);
 
 	/*
-- 
2.34.1

