Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBCD645B2D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiLGNmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiLGNmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:42:20 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1516C59FCB;
        Wed,  7 Dec 2022 05:42:20 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id f13-20020a1cc90d000000b003d08c4cf679so1078596wmb.5;
        Wed, 07 Dec 2022 05:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TMF2QTzrIEhAvcCRAKAyrDjyFw5YI3dtgKin010Drxo=;
        b=Nsh4hYm51nfI+1na0IvpRbqgwiNwOvz4fAxaQwLeZ95GKOCHayKqMTikL/f9snt+oC
         /jcD6T1WMloKlEF6hJAZetIXhp40cHFYS10PCx9rru0I3gaZKG01LOBqS22GQYi8q05O
         2m9c750Py1YavUiyPHAn43ykX6B2Y3YKkXZnfncWAoPrSMqjSSQlevISHXHSih8aHjhp
         kM0BhLS0xIsI3fEy0hsOMLZNwjtMQqbLe0r2gkRJv7Nzq2cUi8mo63lcFRtlaaxNcl2F
         PtBCe27d6EavPdmShqny6TwH4G46ifmbeF30VWCn7qbF3Lmwxs0Ij1a0lKC8YkwquwyN
         YHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TMF2QTzrIEhAvcCRAKAyrDjyFw5YI3dtgKin010Drxo=;
        b=By2nY40z73C9HkauB2pmfAUTFyi8e0lK+8Er202ZBmlFxwz7V6tciNBVbse9T1msGd
         6xPorfzndOa/TgShukwO82MnTolq6Az8SONkESPnlEYJbRCmg1vwk5ZPlvugiSmxinDk
         h06b/Q3joaYLtuegrbISgDmZLHJHGJtt2RBkRuVhu/DFgw6H+s9x4PBzQoQ44j1xqh34
         EEl07PP+jcYCNL+sHGUvFxTQIygdw9DKvpw8RnLwzzEyZN5Bo8BdcjDbtqkB14daM7gE
         7242SpnfNnGupgyjOAdG6J2Xrl79bjwEdNQEZdQWL+OXCnQuOygPq2pn/9k2XPDQpZOT
         THlg==
X-Gm-Message-State: ANoB5pnkM3UhjM+MbG9PgFNY67D/jRq5Wtd9gdtV4gVrA/8gO9WD2zlc
        UYQrqoj7wEkQR5w2yZfRGVbFPzKhdAcOQMvS
X-Google-Smtp-Source: AA0mqf4v7NhxFM6ADBnyGnt437t6imDkbPXjJcoZTc+HXGyF5bCElcmBD8N2fTCKcX6IrxbPqGMliA==
X-Received: by 2002:a05:600c:1c04:b0:3cf:ecdb:bcb7 with SMTP id j4-20020a05600c1c0400b003cfecdbbcb7mr63835767wms.180.1670420538472;
        Wed, 07 Dec 2022 05:42:18 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id m31-20020a05600c3b1f00b003d1e3b1624dsm2075515wms.2.2022.12.07.05.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 05:42:18 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: Fix spelling mistake in label: free_bio_enrty_cache -> free_bio_entry_cache
Date:   Wed,  7 Dec 2022 13:42:17 +0000
Message-Id: <20221207134217.2325189-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a label name. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/f2fs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 79bf1faf4161..7a9fa1a5baa2 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4709,7 +4709,7 @@ static int __init init_f2fs_fs(void)
 		goto free_iostat;
 	err = f2fs_init_bioset();
 	if (err)
-		goto free_bio_enrty_cache;
+		goto free_bio_entry_cache;
 	err = f2fs_init_compress_mempool();
 	if (err)
 		goto free_bioset;
@@ -4726,7 +4726,7 @@ static int __init init_f2fs_fs(void)
 	f2fs_destroy_compress_mempool();
 free_bioset:
 	f2fs_destroy_bioset();
-free_bio_enrty_cache:
+free_bio_entry_cache:
 	f2fs_destroy_bio_entry_cache();
 free_iostat:
 	f2fs_destroy_iostat_processing();
-- 
2.38.1

