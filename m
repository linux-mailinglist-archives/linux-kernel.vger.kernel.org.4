Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5CB7295EB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240117AbjFIJxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241420AbjFIJwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:52:34 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5F03C39
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:44:59 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3BB3F3F36D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686303160;
        bh=+ZXNJzxGWGsPdae4AE9sODEjkcVKgoTQCtJS4YUBoj8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=t0R85owjgKAifVfpub0FOmpRsFLc+pzJcBAOuwYi2Zd444pzIMFAbkt3DiVRA3C6T
         q4ThxuvoX+bnRvvSwH+FxEgFzDAak2VoDxEj31Z6s3xDo/KN2ZriMIS/4wyeogaBu+
         sARb2LyjLJho5QBu8Tt4Nrqq7ne93iF/Vh+jwBBSGcUPAKYAPh8hC/1cXgC22gB1yE
         o7ftZJpZo6FQTh2oT2LaC/7UaLhV0kEkG59HxGMNJmslHa+Y/NZ8Fs/Vs356eNXxfo
         Rm/anDwogNTggn4rOvBpEYTSc7HS179xxCoJOmaqzLHH+bYV3NdyzcTnmizQeGImSF
         2ADYQqHg2H0rQ==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5149ab05081so1265256a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 02:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686303160; x=1688895160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZXNJzxGWGsPdae4AE9sODEjkcVKgoTQCtJS4YUBoj8=;
        b=NvNiuW7FM65/RO2AScP8nODlTYRiHVh1VTS/3ivaUljo8nvBYGcmV7kdpEmNpddbSO
         8XrP1VDmSkByzbKHw+Oq7No7FSv3MHGXPBJCAi8+CtSD4JdNSi7FLyZXWW7Wucr9IvWM
         TpG26EJSPqOBCQZHVXNsYFWEJvF4o52PZF28blHDPbe49PXi5+QH9H+B4T2wo+X7mpgE
         tOJ8giGl0eM3xz4bcV8IivLcgIrsNIVKWRbvlpDexui11RA0VQJfkAUUFmz3/oawS30J
         Fl6JAxbHdTFA9roDBa2ajJaE0Dhpbie8TRe6PwVbMyUVFEkYhSJSyZXNZc/YDt61UxOp
         gKhQ==
X-Gm-Message-State: AC+VfDxrb5O+H/SFmMJ7gyVdYh75L7wEHhgYF/9IOTqw3Q/brxoFcRlr
        X+LWcomBEQuSUZT6Z9u65aabRbWltLQWPq0OJY4Yftwu8Z16x6LuEQGVxbPnxDmjRdO9mIpOmnI
        HaIdd98mtNs5dRcG54q5VqmURLF4S695VsRTccm5R8g==
X-Received: by 2002:a17:907:a49:b0:961:272d:bdb9 with SMTP id be9-20020a1709070a4900b00961272dbdb9mr890201ejc.43.1686303159769;
        Fri, 09 Jun 2023 02:32:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7VqlSsk8gsTl2VwGNKDG9KIKCrS8w8mAhrmZPyw2RDEHCUca7gFHg2dmkq6oitdS04CtjiJQ==
X-Received: by 2002:a17:907:a49:b0:961:272d:bdb9 with SMTP id be9-20020a1709070a4900b00961272dbdb9mr890180ejc.43.1686303159346;
        Fri, 09 Jun 2023 02:32:39 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id e25-20020a170906081900b0094ee3e4c934sm1031248ejd.221.2023.06.09.02.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 02:32:38 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 03/15] ceph: handle idmapped mounts in create_request_message()
Date:   Fri,  9 Jun 2023 11:31:14 +0200
Message-Id: <20230609093125.252186-4-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609093125.252186-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230609093125.252186-1-aleksandr.mikhalitsyn@canonical.com>
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

Inode operations that create a new filesystem object such as ->mknod,
->create, ->mkdir() and others don't take a {g,u}id argument explicitly.
Instead the caller's fs{g,u}id is used for the {g,u}id of the new
filesystem object.

Cephfs mds creation request argument structures mirror this filesystem
behavior. They don't encode a {g,u}id explicitly. Instead the caller's
fs{g,u}id that is always sent as part of any mds request is used by the
servers to set the {g,u}id of the new filesystem object.

In order to ensure that the correct {g,u}id is used map the caller's
fs{g,u}id for creation requests. This doesn't require complex changes.
It suffices to pass in the relevant idmapping recorded in the request
message. If this request message was triggered from an inode operation
that creates filesystem objects it will have passed down the relevant
idmaping. If this is a request message that was triggered from an inode
operation that doens't need to take idmappings into account the initial
idmapping is passed down which is an identity mapping and thus is
guaranteed to leave the caller's fs{g,u}id unchanged.,u}id is sent.

The last few weeks before Christmas 2021 I have spent time not just
reading and poking the cephfs kernel code but also took a look at the
ceph mds server userspace to ensure I didn't miss some subtlety.

This made me aware of one complication to solve. All requests send the
caller's fs{g,u}id over the wire. The caller's fs{g,u}id matters for the
server in exactly two cases:

1. to set the ownership for creation requests
2. to determine whether this client is allowed access on this server

Case 1. we already covered and explained. Case 2. is only relevant for
servers where an explicit uid access restriction has been set. That is
to say the mds server restricts access to requests coming from a
specific uid. Servers without uid restrictions will grant access to
requests from any uid by setting MDS_AUTH_UID_ANY.

Case 2. introduces the complication because the caller's fs{g,u}id is
not just used to record ownership but also serves as the {g,u}id used
when checking access to the server.

Consider a user mounting a cephfs client and creating an idmapped mount
from it that maps files owned by uid 1000 to be owned uid 0:

mount -t cephfs -o [...] /unmapped
mount-idmapped --map-mount 1000:0:1 /idmapped

That is to say if the mounted cephfs filesystem contains a file "file1"
which is owned by uid 1000:

- looking at it via /unmapped/file1 will report it as owned by uid 1000
  (One can think of this as the on-disk value.)
- looking at it via /idmapped/file1 will report it as owned by uid 0

Now, consider creating new files via the idmapped mount at /idmapped.
When a caller with fs{g,u}id 1000 creates a file "file2" by going
through the idmapped mount mounted at /idmapped it will create a file
that is owned by uid 1000 on-disk, i.e.:

- looking at it via /unmapped/file2 will report it as owned by uid 1000
- looking at it via /idmapped/file2 will report it as owned by uid 0

Now consider an mds server that has a uid access restriction set and
only grants access to requests from uid 0.

If the client sends a creation request for a file e.g. /idmapped/file2
it will send the caller's fs{g,u}id idmapped according to the idmapped
mount. So if the caller has fs{g,u}id 1000 it will be mapped to {g,u}id
0 in the idmapped mount and will be sent over the wire allowing the
caller access to the mds server.

However, if the caller is not issuing a creation request the caller's
fs{g,u}id will be send without the mount's idmapping applied. So if the
caller that just successfully created a new file on the restricted mds
server sends a request as fs{g,u}id 1000 access will be refused. This
however is inconsistent.

From my perspective the root of the problem lies in the fact that
creation requests implicitly infer the ownership from the {g,u}id that
gets sent along with every mds request.

I have thought of multiple ways of addressing this problem but the one I
prefer is to give all mds requests that create a filesystem object a
proper, separate {g,u}id field entry in the argument struct. This is,
for example how ->setattr mds requests work.

This way the caller's fs{g,u}id can be used consistenly for server
access checks and is separated from the ownership for new filesystem
objects.

Servers could then be updated to refuse creation requests whenever the
{g,u}id used for access checking doesn't match the {g,u}id used for
creating the filesystem object just as is done for setattr requests on a
uid restricted server. But I am, of course, open to other suggestions.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/mds_client.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 083d0329f62d..73fd5784daf8 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2887,6 +2887,8 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 	void *p, *end;
 	int ret;
 	bool legacy = !(session->s_con.peer_features & CEPH_FEATURE_FS_BTIME);
+	kuid_t caller_fsuid;
+	kgid_t caller_fsgid;
 
 	ret = set_request_path_attr(req->r_inode, req->r_dentry,
 			      req->r_parent, req->r_path1, req->r_ino1.ino,
@@ -2984,10 +2986,22 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 
 	head->mdsmap_epoch = cpu_to_le32(mdsc->mdsmap->m_epoch);
 	head->op = cpu_to_le32(req->r_op);
-	head->caller_uid = cpu_to_le32(from_kuid(&init_user_ns,
-						 req->r_cred->fsuid));
-	head->caller_gid = cpu_to_le32(from_kgid(&init_user_ns,
-						 req->r_cred->fsgid));
+	/*
+	 * Inode operations that create filesystem objects based on the
+	 * caller's fs{g,u}id like ->mknod(), ->create(), ->mkdir() etc. don't
+	 * have separate {g,u}id fields in their respective structs in the
+	 * ceph_mds_request_args union. Instead the caller_{g,u}id field is
+	 * used to set ownership of the newly created inode by the mds server.
+	 * For these inode operations we need to send the mapped fs{g,u}id over
+	 * the wire. For other cases we simple set req->r_mnt_idmap to the
+	 * initial idmapping meaning the unmapped fs{g,u}id is sent.
+	 */
+	caller_fsuid = from_vfsuid(req->r_mnt_idmap, &init_user_ns,
+					VFSUIDT_INIT(req->r_cred->fsuid));
+	caller_fsgid = from_vfsgid(req->r_mnt_idmap, &init_user_ns,
+					VFSGIDT_INIT(req->r_cred->fsgid));
+	head->caller_uid = cpu_to_le32(from_kuid(&init_user_ns, caller_fsuid));
+	head->caller_gid = cpu_to_le32(from_kgid(&init_user_ns, caller_fsgid));
 	head->ino = cpu_to_le64(req->r_deleg_ino);
 	head->args = req->r_args;
 
-- 
2.34.1

