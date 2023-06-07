Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B216A726808
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjFGSKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbjFGSKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:10:40 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928E51FC3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 11:10:37 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9BE3D3F120
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 18:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686161435;
        bh=PnimYtsU8L1wziru+PbLo9AAv92Qytxkfm0LOSGrer8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=f4Ow0cXfcxrvXjQnNGNTOTZRSK/XsAzJhks8oXLB+U9OuUfR4QKNyLwbMJ1KmxlXl
         iaZseCKueNgg+z35HSj4LU3YJY0XmDbBCEsAYdm60DCtOAL2LLg8+eHsHNUoyMR5Zn
         b6d/v833RzZ7NKwWciYktQyjO+dDq5NqMw2G2vFeSYk0eGIxalqnnlWz2UnezDv9RF
         U5CcFdr5lq7vc1mNUplizMBIEYwZZ34V0u/2GuaYnaZcs74utGo4dGjI+t6TFDn5V8
         OolW5AUY3g2eLgHnoIzxsF8Iyh1UAn7JISUejVHogMj10cgWhUrpMVemZmrWFslo9w
         RJGPV3Pbgskyg==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-977c516686aso503019766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 11:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686161435; x=1688753435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnimYtsU8L1wziru+PbLo9AAv92Qytxkfm0LOSGrer8=;
        b=JbfpTrHTln4/4pKGwrO/sYPfDGQvJIEa8Hyi83VCt4bJWi+mOP3y8ySkanavwxJHfZ
         1AMDKwGS+XW/RdpG8XgdqG+3mYqZGFwTGjWmtGzzY47UiZpOW7LIb14QX/1r5qv/nda3
         nhSfyBy6Rhjgv2kaltqUhbML7dAdoT3FkSY1PBBUGTq8ybG/fXVPC/cILdJceI+MpIkm
         87+eP73AyriRWTrwDx5g+3pbA5YxoM2Y//1V7zYijuYwhq+YRG5P+29J3djkvP6tq1Yc
         xPtONfsvl0LXjhsvDGzxmFgnJSEOP6g6Ijwc31Yfn/DB335H8QvpUkGp1y4FTMivFbpl
         0hFw==
X-Gm-Message-State: AC+VfDwhtYvZDzBpxW9AQy6CY+jb12leuFtImqDb6zZ/Pf2j9xaDwElD
        enC7ir4YAXd2a+rLxQMn9/Jb+6l3y/STR5X7EEI4hv0Byu/iCXhS4kPI8n0JraWe4fcx4eaY3GF
        /hBMFrxDFh6JkChxmMbRLUiblTWyVP429x3mNHt7+9g==
X-Received: by 2002:a17:907:8a08:b0:973:d1cd:933d with SMTP id sc8-20020a1709078a0800b00973d1cd933dmr7874765ejc.47.1686161435286;
        Wed, 07 Jun 2023 11:10:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6noxHTypAyjkYYgzACU+3pomO8jr2HnNRQ/wBTwDkTdyTqSLpcYw7tUbeaV5I0WXpNEgp9uA==
X-Received: by 2002:a17:907:8a08:b0:973:d1cd:933d with SMTP id sc8-20020a1709078a0800b00973d1cd933dmr7874752ejc.47.1686161435119;
        Wed, 07 Jun 2023 11:10:35 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id oz17-20020a170906cd1100b009745edfb7cbsm7170494ejb.45.2023.06.07.11.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 11:10:34 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/14] ceph: stash idmapping in mdsc request
Date:   Wed,  7 Jun 2023 20:09:45 +0200
Message-Id: <20230607180958.645115-3-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607180958.645115-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230607180958.645115-1-aleksandr.mikhalitsyn@canonical.com>
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

When sending a mds request cephfs will send relevant data for the
requested operation. For creation requests the caller's fs{g,u}id is
used to set the ownership of the newly created filesystem object. For
setattr requests the caller can pass in arbitrary {g,u}id values to
which the relevant filesystem object is supposed to be changed.

If the caller is performing the relevant operation via an idmapped mount
cephfs simply needs to take the idmapping into account when it sends the
relevant mds request.

In order to support idmapped mounts for cephfs we stash the idmapping
whenever they are relevant for the operation for the duration of the
request. Since mds requests can be queued and performed asynchronously
we make sure to keep the idmapping around and release it once the
request has finished.

In follow-up patches we will use this to send correct ownership
information over the wire. This patch just adds the basic infrastructure
to keep the idmapping around. The actual conversion patches are all
fairly minimal.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v4:
	- don't call mnt_idmap_get(..) in __register_request
---
 fs/ceph/mds_client.c | 5 +++++
 fs/ceph/mds_client.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 4c0f22acf53d..05a99a8eb292 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -12,6 +12,7 @@
 #include <linux/bits.h>
 #include <linux/ktime.h>
 #include <linux/bitmap.h>
+#include <linux/mnt_idmapping.h>
 
 #include "super.h"
 #include "mds_client.h"
@@ -962,6 +963,8 @@ void ceph_mdsc_release_request(struct kref *kref)
 	kfree(req->r_path1);
 	kfree(req->r_path2);
 	put_cred(req->r_cred);
+	if (req->r_mnt_idmap)
+		mnt_idmap_put(req->r_mnt_idmap);
 	if (req->r_pagelist)
 		ceph_pagelist_release(req->r_pagelist);
 	put_request_session(req);
@@ -1018,6 +1021,8 @@ static void __register_request(struct ceph_mds_client *mdsc,
 	insert_request(&mdsc->request_tree, req);
 
 	req->r_cred = get_current_cred();
+	if (!req->r_mnt_idmap)
+		req->r_mnt_idmap = &nop_mnt_idmap;
 
 	if (mdsc->oldest_tid == 0 && req->r_op != CEPH_MDS_OP_SETFILELOCK)
 		mdsc->oldest_tid = req->r_tid;
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 724307ff89cd..32001ade1ea7 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -280,6 +280,7 @@ struct ceph_mds_request {
 	int r_fmode;        /* file mode, if expecting cap */
 	int r_request_release_offset;
 	const struct cred *r_cred;
+	struct mnt_idmap *r_mnt_idmap;
 	struct timespec64 r_stamp;
 
 	/* for choosing which mds to send this request to */
-- 
2.34.1

