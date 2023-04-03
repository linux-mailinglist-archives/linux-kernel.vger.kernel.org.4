Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AD26D4A7B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbjDCOrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbjDCOrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:47:21 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECED29BE0
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 07:46:42 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C43D43F4A5
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 14:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1680533150;
        bh=EXiQokygEgtdFby6V0DaIlICChGvv1djpoKsAB/p2vA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=AB7oqhJJEk/EGurhNt2yIxzjHn5eyb7aPxGFZLyNh/JJ5TIJ/o4Mpn+GYyFayH+Is
         2MQvo/CTcf8628ZHsqquNTtIKyIVfLb7oOKL+e38ZY5/6QHfLQKJVFfoijidG+DJoU
         TFt6JwHlUlUBgU71s4lkJm8IqcmjQ6oiVtk81r1EQ9TIa9c+Ap11O/cVvSUSxuvTB4
         45jn7CaCNzsH/m7uiKDgQKkQEsXAAsavselvXNs+Ld8YTdnybHcd/E/gADXam4xus/
         yasVU2oqKseuwYqN8ZRdtuDP7JN9steHnWLS5OmrjOSnFSqu7UYq3Nwcw0LOzlTPJR
         GWa/1DZaIW4Xw==
Received: by mail-ed1-f71.google.com with SMTP id r19-20020a50aad3000000b005002e950cd3so42069816edc.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 07:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680533150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXiQokygEgtdFby6V0DaIlICChGvv1djpoKsAB/p2vA=;
        b=qhCXbWTAR0OU5yRf1MmlKfRu9q7oazZcdv5LnaDsp9weUHlKjiHfFmJuF1o067FnX/
         JDeGvVEcz461/d8yCGz5kIeUAFQYGll+aBCLAlsdVVhz+JIAxHG/5Ya9Ppe1lY5W6H6p
         oJWfYx9ot6p/hom+DwQbFKMkQoFl4vmCT5ovGM4ubwvOHFMhUNaQOnmWBxqgprPyqCJp
         awJ9xZkOsungOgnBHn6fezKrLJ9TK4ETCCf9wR+vgqASHFC6QCSiRp9QmUeSXp2oX8dg
         29jap1C/y6tQfMFtkh4v/AsRCoMa/0maINliKLOvFf96JL63p3Qg/3XoG/M6IjOPdi4x
         1YWA==
X-Gm-Message-State: AAQBX9cfQiKfXFWEm2TcNORFUYjnpP+7BiaWkSas6iX+bDghTA9ds0/c
        xkR1F97jBwyCZn5Yo8fQ9WMOkEHYUUMJDnusfz0C8XRdVBCsAn+I4Qir+xtB/nfp8ez/6kwSST6
        g0CoQE7f/0l9JpjRd+sCjedW4OyKh9qGny8wfrnFaBQ==
X-Received: by 2002:a05:6402:12cc:b0:4f9:f07d:a978 with SMTP id k12-20020a05640212cc00b004f9f07da978mr32552813edx.5.1680533150585;
        Mon, 03 Apr 2023 07:45:50 -0700 (PDT)
X-Google-Smtp-Source: AKy350YEqQM+ipb2my4c7+y9TG7BmdCKAdA3pSBQm+DjrFOBW2UBW64exk69S7plf9fVjKzWjMbAAg==
X-Received: by 2002:a05:6402:12cc:b0:4f9:f07d:a978 with SMTP id k12-20020a05640212cc00b004f9f07da978mr32552802edx.5.1680533150434;
        Mon, 03 Apr 2023 07:45:50 -0700 (PDT)
Received: from amikhalitsyn.. (ip5f5bd076.dynamic.kabel-deutschland.de. [95.91.208.118])
        by smtp.gmail.com with ESMTPSA id i5-20020a50d745000000b004fa19f5ba99sm4735804edj.79.2023.04.03.07.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 07:45:50 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     mszeredi@redhat.com
Cc:     flyingpeng@tencent.com,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Bernd Schubert <bschubert@ddn.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        criu@openvz.org
Subject: [RFC PATCH v2 9/9] fuse: add fuse device ioctl(FUSE_DEV_IOC_BM_REVAL)
Date:   Mon,  3 Apr 2023 16:45:17 +0200
Message-Id: <20230403144517.347517-10-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230403144517.347517-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230403144517.347517-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This ioctl allows to revalidate all the existing fuse bindmounts
by performing relookup of all root dentries and resetting them.

Useful if it's needed to make fuse bindmounts work without
remounting them after fuse connection reinitialization.

Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Stéphane Graber <stgraber@ubuntu.com>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: criu@openvz.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/dev.c             | 29 ++++++++++++++++++++++++++++-
 include/uapi/linux/fuse.h |  1 +
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 93a457c90b49..dae4d718b03a 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -13,6 +13,7 @@
 #include <linux/poll.h>
 #include <linux/sched/signal.h>
 #include <linux/uio.h>
+#include <linux/mnt_namespace.h>
 #include <linux/miscdevice.h>
 #include <linux/pagemap.h>
 #include <linux/file.h>
@@ -2313,6 +2314,27 @@ static int fuse_reinit_conn(struct fuse_conn *fc)
 	return 0;
 }
 
+static ssize_t fuse_revalidate_bindmounts(struct fuse_conn *fc)
+{
+	int ret = 0;
+
+	down_read(&fc->killsb);
+	if (!list_empty(&fc->mounts)) {
+		struct fuse_mount *fm;
+
+		fm = list_first_entry(&fc->mounts, struct fuse_mount, fc_entry);
+		if (!fm->sb) {
+			up_read(&fc->killsb);
+			return -EINVAL;
+		}
+
+		ret = sb_revalidate_bindmounts(fm->sb);
+	}
+	up_read(&fc->killsb);
+
+	return ret;
+}
+
 void fuse_wait_aborted(struct fuse_conn *fc)
 {
 	/* matches implicit memory barrier in fuse_drop_waiting() */
@@ -2409,6 +2431,7 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 		}
 		break;
 	case FUSE_DEV_IOC_REINIT:
+	case FUSE_DEV_IOC_BM_REVAL:
 		struct fuse_conn *fc;
 
 		if (!checkpoint_restore_ns_capable(file->f_cred->user_ns))
@@ -2429,7 +2452,11 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 			mutex_unlock(&fuse_mutex);
 
 			if (fc) {
-				res = fuse_reinit_conn(fc);
+				if (cmd == FUSE_DEV_IOC_REINIT)
+					res = fuse_reinit_conn(fc);
+				else if (cmd == FUSE_DEV_IOC_BM_REVAL)
+					res = fuse_revalidate_bindmounts(fc);
+
 				fuse_conn_put(fc);
 			}
 		}
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 325da23431ef..d8d1997876d8 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -993,6 +993,7 @@ struct fuse_notify_retrieve_in {
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
 #define FUSE_DEV_IOC_REINIT		_IO(FUSE_DEV_IOC_MAGIC, 0)
+#define FUSE_DEV_IOC_BM_REVAL		_IO(FUSE_DEV_IOC_MAGIC, 1)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
-- 
2.34.1

