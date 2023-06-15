Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60049730DDA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 06:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242833AbjFOECe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 00:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242836AbjFOECU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 00:02:20 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1517B1BF8;
        Wed, 14 Jun 2023 21:02:07 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b4f9583404so13269985ad.2;
        Wed, 14 Jun 2023 21:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686801726; x=1689393726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3izBoZnsarVRGSGlTREJHeUFL5Dz9xWyg9wHmnWHSUU=;
        b=R+hJAms9B5cyUKbbm45fYbRJynKJWUr25Plghjxw4l+ngGJltxbSaOSGsCFAWFjM4K
         cDlvQsg9kRgKYBFHZL5EqVpyWLD6MyijZtTuLZa3ivcAv7ZaLWavknsLYivwdJF22a7g
         bF3JCJ22ql8OdswGSUY8O3lHFp4twV8Cd0b0m/ZXVZz1zVCatxFva7tsO5OhNDoqA7Z+
         x0Q7wrX/N6YsZn7Cpvb8X044E1VU214NLGj5Bm4SXTtbCwKHAOL1jg0Jw8arBG9Y4UlN
         Xw8dLOYIMjh8NTWlBEt2U6LNopSI+gh2/yUiw1mby7qxJqmUg9QA+CLwGqFbKkVpOKyF
         UcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686801726; x=1689393726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3izBoZnsarVRGSGlTREJHeUFL5Dz9xWyg9wHmnWHSUU=;
        b=M9aukiHYt1jZWu8WOLOHiRI1EYok1QF0bf/yWPF93K4LIZjF/WbrcIM8Uj+Pf3m/Yh
         dV9nkbdakU15xBlWhVHSOj0+wwRAhHcW6cg5B77g6hOYj6bPkmCu7wVOh2CqKCKkpIH3
         eG9P+1sx7eLV8NZh3Hd9bWlIFbgUMR34MCgqkwPEAXKZ4fEaB9ASd0d3gHD3zSJ7gaVJ
         Y2psvb/cUwaKGCTBLiVEc6qNLblcsTEFTKyKtEuRiCEB9XNo5IUsMDRKSNF+IHxNb48q
         OovcH0/yV/WENBdOUhGowXr72uRpLfn5Bg2ok1ZNsjTICipcD3Q0XI4+bZ1RahVDkWQl
         P9lA==
X-Gm-Message-State: AC+VfDziHJxGNgTlezdVIqJ65DhW7NxTGtdM01SUh3JjHx5opdFCpQl2
        82Kp854RH5dHUZg6nt8MvgI=
X-Google-Smtp-Source: ACHHUZ7pnWLwNT6A86yp7S8yhkm3zQVdAsYM08XNE5O+52gvCTnV5yQxxPuu2HGobQ4ewoFmhUizvg==
X-Received: by 2002:a17:902:e80b:b0:1ab:11c8:777a with SMTP id u11-20020a170902e80b00b001ab11c8777amr17231180plg.13.1686801726375;
        Wed, 14 Jun 2023 21:02:06 -0700 (PDT)
Received: from oslab-pc.tsinghua.edu.cn ([166.111.139.122])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902d90200b001b0499bee05sm105064plz.191.2023.06.14.21.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 21:02:05 -0700 (PDT)
From:   Tuo Li <islituo@gmail.com>
To:     sfrench@samba.org, pc@manguebit.com, lsahlber@redhat.com,
        sprasad@microsoft.com, tom@talpey.com
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, baijiaju1990@outlook.com,
        Tuo Li <islituo@gmail.com>, BassCheck <bass@buaa.edu.cn>
Subject: [PATCH] smb: fix a possible data race in cifs_can_echo()
Date:   Thu, 15 Jun 2023 12:01:31 +0800
Message-Id: <20230615040131.13444-1-islituo@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct field TCP_Server_Info.tcpStatus is often protected by the lock 
srv_lock when is accessed. Here is an example in __cifs_reconnect():

  spin_lock(&server->srv_lock);
  if (server->tcpStatus != CifsExiting)
    server->tcpStatus = CifsNeedNegotiate;
  spin_unlock(&server->srv_lock);

However, the variable server->tcpStatus is accessed without holding the 
lock server->srv_lock in cifs_can_echo():

  if (server->tcpStatus == CifsGood)
    return true;

To fix this possible data race, a lock and unlock pair is added when
accessing the variable server->tcpStatus.

Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Tuo Li <islituo@gmail.com>
---
 fs/smb/client/smb1ops.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index 7d1b3fc014d9..b258af1a75fe 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -1049,8 +1049,11 @@ cifs_dir_needs_close(struct cifsFileInfo *cfile)
 static bool
 cifs_can_echo(struct TCP_Server_Info *server)
 {
-	if (server->tcpStatus == CifsGood)
+	spin_lock(&server->srv_lock);
+	if (server->tcpStatus == CifsGood) {
+		spin_unlock(&server->srv_lock);
 		return true;
+	}
 
 	return false;
 }
-- 
2.34.1

