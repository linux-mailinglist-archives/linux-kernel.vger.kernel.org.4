Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AC070FA5C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbjEXPfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236548AbjEXPfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:35:07 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C2A10C6
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:34:45 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4B0BC3F4A6
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684942449;
        bh=H9xVyVFm2J6DXYIa+xt6L2ldHLbh9SntsfJpFosG5pA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=S5F22vKuFFc/ja968PcyvVkGDGKhe4UDdSTVSh0hk+eqbeg6aXOS8gRodker4iG33
         6anRuTteIdc00/D6cuAVixT2p57EZiTwmcd/T5V+vFo7mJCPTyM0K7YLgM7veroOfg
         SYgqKcVeslJqDuYSAa1EGPIjiXe6u835kqFvitJHRqM+2AvfmXNhZBLUEaAxbgcgAo
         oRf649MgMWq/MncpFsjuoxsa8a9hDbzup4G1EPGvdWSLvnNpF6tdpcOBZ0ntnn0CXd
         WA+GtXNfwpAxToFr8FD6Q1tJdY1sYrsbsgOsv4vHG3Hw5HdjihJH1GigXaGTRlsv8O
         I/j8cDXagwlbA==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-506a7b4f141so1336971a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684942446; x=1687534446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H9xVyVFm2J6DXYIa+xt6L2ldHLbh9SntsfJpFosG5pA=;
        b=ljW61kFmyJY4WkdVwAoQfh1hn/ZBX9CKvaibww4IWWdV4nbRRDTk9aBYMzfjQl4jrY
         /ge+UpyMvDNoq8mztxEtUxLF38feWeVpfOPGtmI4XPJfAm6U4bewH9kVDYxXW5Hwl8xa
         SlzexBsw95ptxCAYefvMbFZ0kNo2nEDSInCsnN5aad6EHa950L7/y16hRLH/3wOnLeNb
         9V58ubD5+ufzd7GEaoaDoLGJu5R3iqQq9oc5uwyz9CahPG5CNPfAdzjE4RaQAvA5QHOa
         GfAaZQ/KGG5+GdRq3yV2kFkE7xXFgMJdZKH8OkB7fC8lsNZWwZP6CEII7O72NqmG4nFc
         Q7Ig==
X-Gm-Message-State: AC+VfDzCJh2SgdlUnThli3pW+TgA1GUEMZ7ikeeexcVs4oIZyL0o6wj9
        b/RM7SbcDeVy6rgQtoCTS5KZduZ0+DNzlC46CEPmsrDqzJ0GBladZggxaWnl4aDVV4gi6jv44Xf
        cGsGuwiMaDGvLZrTz24gRheS75B3IMFzAO+xv4k8R4Q==
X-Received: by 2002:a17:907:c07:b0:96a:c661:fa1 with SMTP id ga7-20020a1709070c0700b0096ac6610fa1mr20640395ejc.46.1684942446756;
        Wed, 24 May 2023 08:34:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4XpCjIcxhdoliupK6KKdEUY8jcq27fFWoCooizfqJ+xFZsiS/Txtj9EH8UgEqevhz9hzz8ew==
X-Received: by 2002:a17:907:c07:b0:96a:c661:fa1 with SMTP id ga7-20020a1709070c0700b0096ac6610fa1mr20640376ejc.46.1684942446551;
        Wed, 24 May 2023 08:34:06 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-074-206-207.088.074.pools.vodafone-ip.de. [88.74.206.207])
        by smtp.gmail.com with ESMTPSA id p26-20020a17090664da00b0096f7105b3a6sm5986979ejn.189.2023.05.24.08.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 08:34:06 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/13] ceph: allow idmapped mkdir inode op
Date:   Wed, 24 May 2023 17:33:08 +0200
Message-Id: <20230524153316.476973-7-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable ceph_mkdir() to handle idmapped mounts. This is just a matter of
passing down the mount's idmapping.

Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 3996572060da..a4b1ee5ce6b6 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1024,6 +1024,7 @@ static int ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	ihold(dir);
 	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
 	req->r_args.mkdir.mode = cpu_to_le32(mode);
+	req->r_mnt_idmap = idmap;
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_AUTH_EXCL;
 	req->r_dentry_unless = CEPH_CAP_FILE_EXCL;
 	if (as_ctx.pagelist) {
-- 
2.34.1

