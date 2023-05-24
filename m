Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB6570FA61
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbjEXPgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236653AbjEXPfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:35:10 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A8B10DB
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:34:48 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9EE4841FC0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684942454;
        bh=nUbgNVx3j+EjvX/3B5psKLPL9iW2vvt56NMjhT4BQS4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=GENC9nrZs514N7RENTdYuLTzPV0u0z/B+/1AX7oZ2XYOZ6ZYrV6EvPIxi7W3q8TwY
         lXtSHPVuOF+lrLfgLjuuCi/sXUA2D/1bzYmrBuyfzl3S4HH9TK63/QY5pUzzQQs3Wn
         OcyKnSgin4jiiTIglZ+1b5S5k5dZtyS6w7VUsnnAWkMQMc6PSu2dq0v9r5iE89uffu
         wzreTVSXmABNcKHVorXCCXsTdjoogCsdd0QI4CUImOTkdUkoTafF0RGFBre5U8GIXj
         7+PWYYVyumP9C1FmDgzwU68eNhyodDg0Vj48Q5Ac5ny5IsKR4gFb8P4s8LnBC5pvg3
         1TrBBfVLL+peA==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-96f9996fb3dso97888866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684942451; x=1687534451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUbgNVx3j+EjvX/3B5psKLPL9iW2vvt56NMjhT4BQS4=;
        b=RLANRxstChXURsYfuCG7TdO0czqFbg81XcUgjIhHLQp2FXizM6NH6XU1QNmpC1zlGg
         OSkHcIrIHH2Bd0JANe2WwGeOJbKd+j6EJNEkYNIEdxoZDLbqCc75sts9pKQOPGi3x0JI
         YR6z2y9bymdhpQc9kqF9WCV8ZKyg7ahfsXB4sqpqXYlPHrakWbXgbx3G5kLKFscxyGRY
         tK0DgUsmww0Ve0EwDh3vOYK06HUSsrpPqj9Oxj05id3DCFz9VTeh0rebQqwrb1o/8fJE
         ZeT5cNPntSvzdcFgwbkGT4RG6vJFAkORMU9JtiWcF5a4XSZJfEt+Sk/USAoRyFRM6dWF
         Xy1A==
X-Gm-Message-State: AC+VfDwB1g7yyH2oJDP7Om7iqXm5uo2gC4S2vRK/4BR7DovjGAZ1JDwr
        AYo2HGBT+yaUsfdTMpy7wN0u4C3w+wq+EIqwfMDfiS2iqwMgn8gHNeuGZE1N2VUd3iYmueP49bP
        gy3UhKrnR9Ncea48hvY2yS+JnhHW9aR5CVocyXE2mKg==
X-Received: by 2002:a17:907:2cc7:b0:959:18b2:454a with SMTP id hg7-20020a1709072cc700b0095918b2454amr16847493ejc.76.1684942451055;
        Wed, 24 May 2023 08:34:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4agyA0tH+R6Uc7Qz229nwHWOixIWfcCKeLBdwkSFRUhR2KeRm98taylnAcoCXZTrZXUluskw==
X-Received: by 2002:a17:907:2cc7:b0:959:18b2:454a with SMTP id hg7-20020a1709072cc700b0095918b2454amr16847484ejc.76.1684942450831;
        Wed, 24 May 2023 08:34:10 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-074-206-207.088.074.pools.vodafone-ip.de. [88.74.206.207])
        by smtp.gmail.com with ESMTPSA id p26-20020a17090664da00b0096f7105b3a6sm5986979ejn.189.2023.05.24.08.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 08:34:10 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/13] ceph: allow idmapped getattr inode op
Date:   Wed, 24 May 2023 17:33:10 +0200
Message-Id: <20230524153316.476973-9-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
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

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable ceph_getattr() to handle idmapped mounts. This is just a matter
of passing down the mount's idmapping.

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

