Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7031A730F8C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244178AbjFOGmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243884AbjFOGl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:41:26 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E049135B8;
        Wed, 14 Jun 2023 23:39:50 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-543c6a2aa07so4176777a12.0;
        Wed, 14 Jun 2023 23:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686811190; x=1689403190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5dr/pk1CTGpe8xWEsKJhTgU6K6RWawYjj0PJrmiMabI=;
        b=j71V8tIoMnAkqTnlnzzM7y3ne0LUJHKP+0iSmYWbpVYC7DqsKJ4c3P5rQ5sld5JkWw
         jEhSlL8jYe+SQ3gajlXkV5I3NNHWx5YwRtKxDcXTqiClFoiIZyUdcBVW5q+UdKqyT8x2
         bRagHypQea3dDcmb2kvDA+4hUBAsJZ7qgOiRA1IjLYmvACI1HZfMpc2kUPyDa59tw84P
         x4VWAGC0NXlo5MOsS+3s2bHy59bedoHboHeABypM4X84TNVATcDf8OmAi16wAt2GQfWL
         N6lVO8I41+mJmFFhHpYUA/wET/EvYAoD57UJuXtaXyb0c7AetMLYjzyaJ5+Bh35csPYH
         X4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686811190; x=1689403190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5dr/pk1CTGpe8xWEsKJhTgU6K6RWawYjj0PJrmiMabI=;
        b=a0GPE8zj2NoGY/FJ1QOYAaarHrcgtHIWm0ztrfDoJ4p0Gv1X29KVJ6alrXVHiBlJqW
         qEWpEoONQ16+MC3IJzVK8cnBeRzJs5qQ46dPNsPNHFGSAhPiyhb+234uFROgMqWsmc1A
         SLGrEIH+M73UP5SDHGmDatSDc6/yB+pwIE4NIRj2Ys7O/8pg5JePhPsdp/g/C3Kw+YlT
         cr461tCN0jk5epHaga3FjBH6O1e+zuO+Arb1MI8WwtA/W4bpqVSiXfeJeXTQGsARW4hT
         F993zTCjecWn68sywSyVXCERULk8kf4qpN7QFO7azCLg4pHXmuYsM3jx32fzpzN2j96l
         Qd/g==
X-Gm-Message-State: AC+VfDzxmkw7jTvY/YYftIwPSF2TGc5t6gARi9NnZ/yGsHWq9i+Org8T
        lPkRUk/FRwA1nVCbmQesfKbZCKQNYajQQg==
X-Google-Smtp-Source: ACHHUZ7AQ3aMqwhakcw9+joN1EIbvod52rI078ZoK54hJ3gyiguRsgy7n/aKSDeVFyDYp8yba+iyZA==
X-Received: by 2002:a17:90b:46c9:b0:25e:a1c0:af23 with SMTP id jx9-20020a17090b46c900b0025ea1c0af23mr59824pjb.38.1686811190294;
        Wed, 14 Jun 2023 23:39:50 -0700 (PDT)
Received: from oslab-pc.tsinghua.edu.cn ([166.111.139.122])
        by smtp.gmail.com with ESMTPSA id mm23-20020a17090b359700b0025c1d5e3042sm4018845pjb.40.2023.06.14.23.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 23:39:49 -0700 (PDT)
From:   Tuo Li <islituo@gmail.com>
To:     sfrench@samba.org, pc@manguebit.com, lsahlber@redhat.com,
        sprasad@microsoft.com, tom@talpey.com
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, baijiaju1990@outlook.com,
        Tuo Li <islituo@gmail.com>, BassCheck <bass@buaa.edu.cn>
Subject: [PATCH v2] smb: fix a possible data race in cifs_can_echo()
Date:   Thu, 15 Jun 2023 14:38:53 +0800
Message-Id: <20230615063853.15500-1-islituo@gmail.com>
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
v2:
* Release the lock server->srv_lock in the false branch.
---
 fs/smb/client/smb1ops.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index 7d1b3fc014d9..5120241d3c0e 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -1049,8 +1049,12 @@ cifs_dir_needs_close(struct cifsFileInfo *cfile)
 static bool
 cifs_can_echo(struct TCP_Server_Info *server)
 {
-	if (server->tcpStatus == CifsGood)
+	spin_lock(&server->srv_lock);
+	if (server->tcpStatus == CifsGood) {
+		spin_unlock(&server->srv_lock);
 		return true;
+	}
+	spin_unlock(&server->srv_lock);
 
 	return false;
 }
-- 
2.34.1

