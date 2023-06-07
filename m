Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1A9726432
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241381AbjFGPWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240802AbjFGPV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:21:56 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE2B9E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:21:34 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0CF9F3F0F8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 15:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686151293;
        bh=U9FNme5iBEpufhowdmn6D6u4P9E81AUlwyvYSH4GMyo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=FMcSDOJzjt6uHmZB4Cql5z3tk9az0bFqpTfPixCEjjLWATzpfHqKfdKuOQVXLc/Fv
         ZaOLf0l/do2Ps36pZES5dt8ZT1tQCP+6PO0j6YYnaZlLepl5K6vTsX1yGEh5ss2dOn
         IuMA/ijbbsfgQf7yEkhL8Exuzr9WnlrY/69RKwJ2+xJ3HPrmEwO33Z3oD0RL+wWcJO
         1M0BAl9pzVLOdUD2jQnkh9aIe5YOfzzYdKWXW9eWoO7CHgrCmP+BEkrJWsqEFgj7JI
         YaePgFiCBUkNvx9knET1fBlHqvKtelxbmVZhOHMavUyRMdXNy4SYd+8rW/mJnAb+Ca
         NyEFwEIDqrYEQ==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5149e1bd242so911457a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 08:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686151292; x=1688743292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9FNme5iBEpufhowdmn6D6u4P9E81AUlwyvYSH4GMyo=;
        b=OgPCeHUMphtHHHRrL5H3yg2heexpS9PyTZD6mVbrZhFVxgoq4L+Nl+RjR/cdc8T8Lp
         sn7lGKhcUQJMWjQJZ1MaC3KNCE8JLimZ79HJ+X9ULq/2LlCitEHyhVLVoe1iXUUw0Udf
         0jqDsxEu6+JTPC0Cz0myLsdQc7w6UBEhPME3zTlY51JRGv8SemSPPoSMCj4aiUl5Wwv4
         PmBMf9dP1EuKE0nUIeywZJpVCro+EoRJ2uUggMUWu1wSsgHbIXb7NaKJ1viRox+5NhdU
         wZbwJHMfvy2CRrS7hvwS8hksUb30phT20FzkD72JnAvVknB0jn1mUOuBgFd6tQQX1ieg
         UBHw==
X-Gm-Message-State: AC+VfDzY6UJe/6BjDbnGHmPRXbwLgBNMVrciue7CZ2icFQRev9DOfaqm
        td7vHBjBQhVJvfv/IHLo/ZPB0BtmB4EEAfqMSvHfdxYPQPDqkfagf1hti0FtLkNA0PrswJv2ItL
        jzqYY6JkNEm10UuKfuf9cFNqyXWeuw/S4aqTpVcdXug==
X-Received: by 2002:a05:6402:405:b0:50b:d34c:4710 with SMTP id q5-20020a056402040500b0050bd34c4710mr5279760edv.5.1686151292771;
        Wed, 07 Jun 2023 08:21:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ukjxBPm2/4MAaMIFZIp/LfzmkwbPJlVYLJ2Ii9P7Wv40lR8G8Bfa9qw0g+oYTEKKG+D6Ssg==
X-Received: by 2002:a05:6402:405:b0:50b:d34c:4710 with SMTP id q5-20020a056402040500b0050bd34c4710mr5279746edv.5.1686151292630;
        Wed, 07 Jun 2023 08:21:32 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id w17-20020a056402129100b005147503a238sm6263441edv.17.2023.06.07.08.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:21:32 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/14] ceph: allow idmapped getattr inode op
Date:   Wed,  7 Jun 2023 17:20:32 +0200
Message-Id: <20230607152038.469739-9-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607152038.469739-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230607152038.469739-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

