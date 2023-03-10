Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE4B6B519A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjCJUQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjCJUQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:16:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B214212DC3E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 12:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678479332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ySNF9VklMnLNMFFSlXUm9DSmVb0PMck6UAVDHRxOWTI=;
        b=P1hLghfHsbIaPuvscqZ/FXZh5pqzAWAnm1FjyvKCDSPaT5VDfGS6FBa3Y1BCe4FcanXHce
        nCFTlWebXu81yue/BABIWl9I54WQdUd8YckHMIsAePoS7aTXgvAgzYb7L2OlMuVpnf8cJ2
        DF4njTNVn2m8CswWB5RQ5YdcB+CU0sU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-l6gRyfhQNuOgRsi4_uQD8A-1; Fri, 10 Mar 2023 15:15:28 -0500
X-MC-Unique: l6gRyfhQNuOgRsi4_uQD8A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3A5E858F09;
        Fri, 10 Mar 2023 20:15:27 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1EA8C4014CF3;
        Fri, 10 Mar 2023 20:15:27 +0000 (UTC)
From:   Eric Blake <eblake@redhat.com>
To:     josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] uapi nbd: improve doc links to userspace spec
Date:   Fri, 10 Mar 2023 14:15:23 -0600
Message-Id: <20230310201525.2615385-2-eblake@redhat.com>
In-Reply-To: <20230310201525.2615385-1-eblake@redhat.com>
References: <20230310201525.2615385-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uapi <linux/nbd.h> header intentionally documents only the NBD
server features that the kernel module will utilize as a client.  But
while it already had one mention of skipped bits due to userspace
extensions, it did not actually direct the reader to the canonical
source to learn about those extensions.

While touching comments, fix an outdated reference that listed only
READ and WRITE as commands.

The documentation file also had a stale link to sourceforge; nbd
ditched that several years ago in favor of github.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 Documentation/admin-guide/blockdev/nbd.rst |  2 +-
 include/uapi/linux/nbd.h                   | 15 ++++++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/nbd.rst b/Documentation/admin-guide/blockdev/nbd.rst
index d78dfe559dcf..faf2ac4b1509 100644
--- a/Documentation/admin-guide/blockdev/nbd.rst
+++ b/Documentation/admin-guide/blockdev/nbd.rst
@@ -14,7 +14,7 @@ to borrow disk space from another computer.
 Unlike NFS, it is possible to put any filesystem on it, etc.

 For more information, or to download the nbd-client and nbd-server
-tools, go to http://nbd.sf.net/.
+tools, go to https://github.com/NetworkBlockDevice/nbd.

 The nbd kernel module need only be installed on the client
 system, as the nbd-server is completely in userspace. In fact,
diff --git a/include/uapi/linux/nbd.h b/include/uapi/linux/nbd.h
index 20d6cc91435d..8797387caaf7 100644
--- a/include/uapi/linux/nbd.h
+++ b/include/uapi/linux/nbd.h
@@ -11,6 +11,8 @@
  *            Cleanup PARANOIA usage & code.
  * 2004/02/19 Paul Clements
  *            Removed PARANOIA, plus various cleanup and comments
+ * 2023 Copyright Red Hat
+ *            Link to userspace extensions.
  */

 #ifndef _UAPILINUX_NBD_H
@@ -30,12 +32,18 @@
 #define NBD_SET_TIMEOUT _IO( 0xab, 9 )
 #define NBD_SET_FLAGS   _IO( 0xab, 10)

+/*
+ * See also https://github.com/NetworkBlockDevice/nbd/blob/master/doc/proto.md
+ * for additional userspace extensions not yet utilized in the kernel module.
+ */
+
 enum {
 	NBD_CMD_READ = 0,
 	NBD_CMD_WRITE = 1,
 	NBD_CMD_DISC = 2,
 	NBD_CMD_FLUSH = 3,
 	NBD_CMD_TRIM = 4
+	/* userspace defines additional extension commands */
 };

 /* values for flags field, these are server interaction specific. */
@@ -64,14 +72,15 @@ enum {
 #define NBD_REQUEST_MAGIC 0x25609513
 #define NBD_REPLY_MAGIC 0x67446698
 /* Do *not* use magics: 0x12560953 0x96744668. */
+/* magic 0x668e33ef for structured reply not supported by kernel yet */

 /*
  * This is the packet used for communication between client and
  * server. All data are in network byte order.
  */
 struct nbd_request {
-	__be32 magic;
-	__be32 type;	/* == READ || == WRITE 	*/
+	__be32 magic;	/* NBD_REQUEST_MAGIC	*/
+	__be32 type;	/* See NBD_CMD_*	*/
 	char handle[8];
 	__be64 from;
 	__be32 len;
@@ -82,7 +91,7 @@ struct nbd_request {
  * it has completed an I/O request (or an error occurs).
  */
 struct nbd_reply {
-	__be32 magic;
+	__be32 magic;		/* NBD_REPLY_MAGIC	*/
 	__be32 error;		/* 0 = ok, else error	*/
 	char handle[8];		/* handle you got from request	*/
 };
-- 
2.39.2

