Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D24729664
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240620AbjFIKLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241379AbjFIKKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:10:19 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F049E8698
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:59:17 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 159663F18A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686303170;
        bh=/ZEyoJlFLaVuWVBzkT1cBDONkmXP3qyfK5/dTNb2H5c=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=cvK+95elo2k3/jMqYxyonrhw0wwys5ZUxNM3rjPC98l3y4IZy7TRombROSqa/FWs5
         tLhldCVPYTrK5o9lpuOqZvdxti+Whh7ueQnqUClwX8A6Ws5pJBDY4YwikJSmifqxBh
         Ao6MF5fZKP9kcqwZTe9tY86C2TX0TnvEtpRrT8KRVaBZzgeabrlaRg8wGInbAeryyp
         +AzhvQujwDPp5BRF0XdAVHAIOrYuP44HjYPmUbLB3Je0I8hVmsroYNUU6Bi0MhCvYP
         4qX39swt+bfa7qEGP6eiu7PFnecUACgG006PO+nNXg2KEdEFIQwD7aaAs7gLyIqrhA
         whEu5fLO+2D3w==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9775f04de56so181934766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 02:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686303167; x=1688895167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZEyoJlFLaVuWVBzkT1cBDONkmXP3qyfK5/dTNb2H5c=;
        b=ecsIaN7siGBZ3M9swFfm43eQBIoWCetbSLOfgjhCiOMq1767ZQyojuzzpyCymp0CO7
         9nKekk4qZ4+Uh777+9SyJtFk6BgUiXr0HGAd33QbMIoeJlwUk1oZ9xOsYhGa/a/L/pjR
         Qwye8k+fSig8UAXfavXG3FmhtTpeuPv6ONOgde7+Vaq8ObDM6ifeM5nOHiT2DT0aae9P
         UKG/G4+2WGI5S8nUTqn3MxjNtJkyfqBk8BVG9WXGYUesej2F8k6kdIQ5Y62Q2v+yOu/3
         t3eusmY8KcdlzmQ6XbxjCfEcnUw1rLwAuWgAvb6mNEP05kd+sRe0Vak5VQDrNaz7ufNw
         pW1Q==
X-Gm-Message-State: AC+VfDzxQAV1u5wfk28m1lJhzM6KtmWO2WYh/tgI+yjtzqiA0gMJ4PNM
        3ktasB8P+2Vqjj6K1q5qIx5LrXd6AtCUbft15lBDNeOU7gvZtLtx5yzxP/T9ahqHbM44IVR6hpg
        BLucWmN9gs+SCEXUgJu6ed+2R2yytDzPr/TdAN/hCTQ==
X-Received: by 2002:a17:906:4792:b0:96f:608c:5bdf with SMTP id cw18-20020a170906479200b0096f608c5bdfmr1229551ejc.64.1686303166889;
        Fri, 09 Jun 2023 02:32:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ40M5L5XkhSQA/QnoBcPEpFPgOUlmKAwDqyV+kolDwTxZ11t7xizkzr5a/UJGRyxfZTZYD9xg==
X-Received: by 2002:a17:906:4792:b0:96f:608c:5bdf with SMTP id cw18-20020a170906479200b0096f608c5bdfmr1229533ejc.64.1686303166625;
        Fri, 09 Jun 2023 02:32:46 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id e25-20020a170906081900b0094ee3e4c934sm1031248ejd.221.2023.06.09.02.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 02:32:46 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 06/15] ceph: allow idmapped permission inode op
Date:   Fri,  9 Jun 2023 11:31:17 +0200
Message-Id: <20230609093125.252186-7-aleksandr.mikhalitsyn@canonical.com>
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

Enable ceph_permission() to handle idmapped mounts. This is just a
matter of passing down the mount's idmapping.

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
index 533349fe542f..f45d9c066523 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2922,7 +2922,7 @@ int ceph_permission(struct mnt_idmap *idmap, struct inode *inode,
 	err = ceph_do_getattr(inode, CEPH_CAP_AUTH_SHARED, false);
 
 	if (!err)
-		err = generic_permission(&nop_mnt_idmap, inode, mask);
+		err = generic_permission(idmap, inode, mask);
 	return err;
 }
 
-- 
2.34.1

