Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB4170FA66
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbjEXPgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236670AbjEXPfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:35:11 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59C818C
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:34:48 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9D09C41FC2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684942455;
        bh=Md8TLnFONebgQ4vC2/VtTKzXRXy8hQu8U3It9LdXrRE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=bhC4YNeX35pSUHBPzJjqkYN07y71/FMuAMbEZfHv/nPaZqFTyAJm99sS2ujhe4vqo
         izO895S+AMYV8mlb5BQCYvN24FlHMIc4ChdUBPuxYIy6WC5O0MyjhUyNChh8UK88BL
         4DtYmjQmpUyJ1II2mbLgAwd2gpm4V/3xKVlQGtSZKiQpykWLdyQRKgxt1d5gJGTPDo
         ev7ObDM/R9sRgwLz+G/d+hd8GvDQAhAT1eI4oMgIjjIGDI1C0Sxj3RUQGw/E2ck9YE
         rpqHY9iCystR7jUm9xjCfl30DJ5YNKMh3npXB69yeaSMPAvBPK5VIE37Q6gQuMr2vG
         HE74JZEpPQneQ==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-96fb396ee3dso106879866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684942455; x=1687534455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Md8TLnFONebgQ4vC2/VtTKzXRXy8hQu8U3It9LdXrRE=;
        b=Tf957n7vCf4qQHJsxSrcaynNF4ET4JvdND3h3KO37wQyKKkWNCR2wCEjXzvaYhiS8p
         leWwgSd89dcJrVCoZvbA48zlQdDTRsQpV2W/s17g6PR4wThSBOrOtUjQpwi4gEed0CWg
         mSJs+pBCppjVABvFkPRoi5IcKLP6GI9OMoArMG8iku0FncKwKs6n5cEcmi7rrBYuiV8k
         xG7FOPk91WliZmpobFrJ1WKMckI0kGBkAYO1P7z7AP9Mu8Nc8JMUxH+1EByQ+w6F6PRe
         xjtv2aK5CpxvSeYHjB6zHY81NvvncQ2VDDR2Lel+ZKllfZiray3TEFanVljRCEgbWAOF
         lW2Q==
X-Gm-Message-State: AC+VfDx2096GcglzM5XJkm4F3A9qs+0mEMck1evwHY6H40ZZi1RbGbxq
        spbq8nzZoOsxm9ZPPuA/bYVuOvRm1aoW+3ESV9hce6Uh6O1PANJV89VtZcYEUJKEa7n62wGz8dw
        +9B4r3qtMqoDriD8nSf3UjEtU+vJ1TDae6sE/WuQo8Q==
X-Received: by 2002:a17:907:a42b:b0:96f:9cea:a346 with SMTP id sg43-20020a170907a42b00b0096f9ceaa346mr12483837ejc.1.1684942455182;
        Wed, 24 May 2023 08:34:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4wBfGopEZ/PbcB7gaSEiXxq8R0KVY7IbTh7GgeLo03JonIsvQba/f+t+zD7HunE0mybct/6w==
X-Received: by 2002:a17:907:a42b:b0:96f:9cea:a346 with SMTP id sg43-20020a170907a42b00b0096f9ceaa346mr12483820ejc.1.1684942454952;
        Wed, 24 May 2023 08:34:14 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-074-206-207.088.074.pools.vodafone-ip.de. [88.74.206.207])
        by smtp.gmail.com with ESMTPSA id p26-20020a17090664da00b0096f7105b3a6sm5986979ejn.189.2023.05.24.08.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 08:34:14 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/13] ceph: allow idmapped setattr inode op
Date:   Wed, 24 May 2023 17:33:12 +0200
Message-Id: <20230524153316.476973-11-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
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

Enable __ceph_setattr() to handle idmapped mounts. This is just a matter
of passing down the mount's idmapping.

Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/inode.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 37e1cbfc7c89..f1f934439be0 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2050,6 +2050,13 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 
 	dout("setattr %p issued %s\n", inode, ceph_cap_string(issued));
 
+	/*
+	 * The attr->ia_{g,u}id members contain the target {g,u}id we're
+	 * sending over the wire. The mount idmapping only matters when we
+	 * create new filesystem objects based on the caller's mapped
+	 * fs{g,u}id.
+	 */
+	req->r_mnt_idmap = &nop_mnt_idmap;
 	if (ia_valid & ATTR_UID) {
 		dout("setattr %p uid %d -> %d\n", inode,
 		     from_kuid(&init_user_ns, inode->i_uid),
@@ -2240,7 +2247,7 @@ int ceph_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (ceph_inode_is_shutdown(inode))
 		return -ESTALE;
 
-	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
+	err = setattr_prepare(idmap, dentry, attr);
 	if (err != 0)
 		return err;
 
@@ -2255,7 +2262,7 @@ int ceph_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	err = __ceph_setattr(inode, attr);
 
 	if (err >= 0 && (attr->ia_valid & ATTR_MODE))
-		err = posix_acl_chmod(&nop_mnt_idmap, dentry, attr->ia_mode);
+		err = posix_acl_chmod(idmap, dentry, attr->ia_mode);
 
 	return err;
 }
-- 
2.34.1

