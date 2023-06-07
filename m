Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03ABB72680D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbjFGSLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbjFGSLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:11:00 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BFE1FE2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 11:10:45 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D70283F160
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 18:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686161443;
        bh=NiXISWdTTKqrASGu11LnECL/5NzVPnT3d4irPieP8Oo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=fv+cASnkekyxpgPBOTe7kCkXdiSJM5qzQq3/utsFK2qHAAli72ySXOKNUvWBoDgc7
         WzCZcH4+WRjzsNH6YSmj2cJgKBbBl+pbKnyDNFPU3PGkqmAVKsoVZdbyHsw0G5JVR1
         ejA3TMVuf7fLLxAFsDS4R/qNVOnlytC02uyOA050GY2B/tD3+UqoniXmj+ECxtvdiH
         FmgF4csYCmqW2Df7TbtshQs0vAUfygjOCT40fQF3LZP6Q75vZ3j4GmU1ILttGFIUx2
         VLZf9FAwLXQAMTQ/5go8FujH7vpCjsilx8C2qYQhbq5FNxenRKeWrH6pOwCv8rBwyU
         8/cp0Q9k6usIQ==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-97455ea1c14so540464066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 11:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686161443; x=1688753443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NiXISWdTTKqrASGu11LnECL/5NzVPnT3d4irPieP8Oo=;
        b=bSRc33hnWmzfmMbZvIebC/vk1j6Mbx2kKzsyxTcgbW7YxKoco0QtYdGZwaIFIW4pFP
         TyZlhegU7osPvVPXurqXV7Uvzw3vjuqSuv1P4ry8qXUp+hz11Bfjo/4MpNvvA7v1DYtD
         9oHEO6nIDoYizeQ4YH7Lg8bzSTlumrjGh1kWzv40sU+A5gQCB/mChVC8aFez+BRXWN7A
         /8JZ5qHsXyRswIIXDrAC9nu3334ykON6cGVMnC+PIZZbvWfPN0WFUsfSuDkl9yLxSBUw
         uDVvwVsx2w/q+JGHfq4skVvfjv7ZEVh3rGEUExW0gJsqoW2kzhR8jFdW/xvvNqO9tOeg
         G1lQ==
X-Gm-Message-State: AC+VfDzXrxHt2jjuOKyAv4ZioohEnzs/hCkEzGx6NWqWpy0mM4VvOTGr
        F9aB+W3Itt+wmnA6kI1noCBwv7oBsUAa270yMfqabBS94OviVp1eaoCHVq9uzPjdVTZPWNfMDGs
        8ssjUb5pU+71iq7DNTnRyw7Th/bzePawCVeG/gfEa/w==
X-Received: by 2002:a17:907:7203:b0:971:9364:f8cd with SMTP id dr3-20020a170907720300b009719364f8cdmr7198750ejc.44.1686161443503;
        Wed, 07 Jun 2023 11:10:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6v6uUPJK8+xV3dSA9zftqoqH4Sl5IhvWY6O86BBmABFIFnOcXD46uWK9jOFmxZDQRLCE5RZg==
X-Received: by 2002:a17:907:7203:b0:971:9364:f8cd with SMTP id dr3-20020a170907720300b009719364f8cdmr7198723ejc.44.1686161443215;
        Wed, 07 Jun 2023 11:10:43 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id oz17-20020a170906cd1100b009745edfb7cbsm7170494ejb.45.2023.06.07.11.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 11:10:42 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/14] ceph: allow idmapped symlink inode op
Date:   Wed,  7 Jun 2023 20:09:48 +0200
Message-Id: <20230607180958.645115-6-aleksandr.mikhalitsyn@canonical.com>
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

Enable ceph_symlink() to handle idmapped mounts. This is just a matter
of passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v4:
	- call mnt_idmap_get
---
 fs/ceph/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index aaae586de4de..5025b570683d 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -956,6 +956,7 @@ static int ceph_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	req->r_num_caps = 2;
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_AUTH_EXCL;
 	req->r_dentry_unless = CEPH_CAP_FILE_EXCL;
+	req->r_mnt_idmap = mnt_idmap_get(idmap);
 	if (as_ctx.pagelist) {
 		req->r_pagelist = as_ctx.pagelist;
 		as_ctx.pagelist = NULL;
-- 
2.34.1

