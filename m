Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E187283E6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237143AbjFHPnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237131AbjFHPn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:43:28 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335F62D72
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 08:43:25 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6B8763F466
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 15:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686239002;
        bh=GFNwWvhavDkNrI4eqwez7OWrv+w+Iw1WNhnwQW/Fw7E=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=UzQqOx/afwCY8VI7jYOfHqsG3g9AVlJgJZrZiw8W31u1LIaM5ZO3c3sIih6wUZdvL
         aUJOtvvV/BzsqfdtD8fMYU7OydbrFS3KVcFTISZxG1fhBHiH1sqPutGP639xOflx6s
         7bMnbHeeZgRHPzp3QhecTonM6svuXatBNkkZuwh0C4derx9yZrHVjoZui/LhGzRpdZ
         e2FkLjc69ONX6Ua/7QWEjoC8MVWlD1JZJZLkGMskZdhdHUp4WwoRaKEPLTEJikKYLV
         oiR9HKK/zNktk7/jkFK565WV4zqyqw2/8QGZHoTa69OOclTFoHl+zejc7P/6fgA/A8
         M0YvudZojkP5w==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-514b8a3c0d3so767790a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 08:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686239001; x=1688831001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFNwWvhavDkNrI4eqwez7OWrv+w+Iw1WNhnwQW/Fw7E=;
        b=kbR1odEdZ5W8opHfAYmh9El5I5ZNB1WOk7M/mUFVYQyMvJG/VJAzwWWm18BeEj5LOG
         naM0Zv8okRChEF+oMoCKmPwE+SLNbMp4ehGoi5DDF+vo+17F6LnVnAivCqMW2F99tvzv
         GTEo1C8rMQIGc3CnQZHSxgkupdDVV6q2bLxBeRcGW9jtYYuZCVZrLS3kI8PXW0IgP3Vy
         Grsa/7fc/VeFKSWW17osWQSLFECL8k+reyopPHb+5KANgRzlEpmOt+SIOp+eRTNDgBrF
         Knh2xcWjSY2a2lAluAdyo00ZjA/R6B9nBjpFlvBQCjQuvO/k76izvH6RZqidBZocSmjW
         Fwlg==
X-Gm-Message-State: AC+VfDwfCcOMKxgmd0ir5F5iyIDcvU+MbJ/yAYnfyOjDsy6xh84L28rq
        m7HGx9ag5iEgiQdz0/mxN1xCzGJnMc5SXwtpYnUhLoONDM6C6H1aUVS0oTezbu6oQiqPLd6CEDW
        oV+WUvpVopxxI/cwPdGelZ19XFcq1WCU1jeOvV3s4Ag==
X-Received: by 2002:aa7:c48f:0:b0:514:a4b9:d76b with SMTP id m15-20020aa7c48f000000b00514a4b9d76bmr7147039edq.25.1686239001447;
        Thu, 08 Jun 2023 08:43:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6D65qutYZn/dsggFwwsDjY8pGikammSJwWJPaGnVmVUjtpy9lSBHuLU5+l7FJU+gbu4LrgNA==
X-Received: by 2002:aa7:c48f:0:b0:514:a4b9:d76b with SMTP id m15-20020aa7c48f000000b00514a4b9d76bmr7147022edq.25.1686239001194;
        Thu, 08 Jun 2023 08:43:21 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id y8-20020aa7c248000000b005164ae1c482sm678387edo.11.2023.06.08.08.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 08:43:20 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/14] fs: export mnt_idmap_get/mnt_idmap_put
Date:   Thu,  8 Jun 2023 17:42:42 +0200
Message-Id: <20230608154256.562906-2-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These helpers are required to support idmapped mounts in the Cephfs.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
v3:
	- EXPORT_SYMBOL -> EXPORT_SYMBOL_GPL as Christoph Hellwig suggested
---
 fs/mnt_idmapping.c            | 2 ++
 include/linux/mnt_idmapping.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
index 4905665c47d0..57d1dedf3f8f 100644
--- a/fs/mnt_idmapping.c
+++ b/fs/mnt_idmapping.c
@@ -256,6 +256,7 @@ struct mnt_idmap *mnt_idmap_get(struct mnt_idmap *idmap)
 
 	return idmap;
 }
+EXPORT_SYMBOL_GPL(mnt_idmap_get);
 
 /**
  * mnt_idmap_put - put a reference to an idmapping
@@ -271,3 +272,4 @@ void mnt_idmap_put(struct mnt_idmap *idmap)
 		kfree(idmap);
 	}
 }
+EXPORT_SYMBOL_GPL(mnt_idmap_put);
diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
index 057c89867aa2..b8da2db4ecd2 100644
--- a/include/linux/mnt_idmapping.h
+++ b/include/linux/mnt_idmapping.h
@@ -115,6 +115,9 @@ static inline bool vfsgid_eq_kgid(vfsgid_t vfsgid, kgid_t kgid)
 
 int vfsgid_in_group_p(vfsgid_t vfsgid);
 
+struct mnt_idmap *mnt_idmap_get(struct mnt_idmap *idmap);
+void mnt_idmap_put(struct mnt_idmap *idmap);
+
 vfsuid_t make_vfsuid(struct mnt_idmap *idmap,
 		     struct user_namespace *fs_userns, kuid_t kuid);
 
-- 
2.34.1

