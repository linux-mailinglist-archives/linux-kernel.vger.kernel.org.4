Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9D673EE4D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 00:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjFZWF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 18:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjFZWE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 18:04:58 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8903C03
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 15:01:16 -0700 (PDT)
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5FAF53F18A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 22:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1687816801;
        bh=WrPgRiS83Y2mIcWHryPXtoWboK6sANlwF7CN0nqeeXc=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=qQM9tTvvQdz58zqZnYVXLY6GLI53DKyGpp1cmabVV0YHUgPFsSGgWn8ds4RphxJfv
         bH1U9tqEWSzwYgpf3aE2X/Wm8U9uEG7PNjQ/5wS4X6XOLDwy9QVtPZB7ULdwXAbxOt
         I8HrZ8Bb45gBYSyrfX2xnvKhIc/IPglLNJojJaZ7EbRdESmZp3wa7GdUbN+xaoyAlO
         ZCzmYwN1N2HYuOtu0vZR7IxNFULCHEMAyP4UYvd/9tqgI7abTqzsxMrUxlDmYWM3CG
         xdoM1jEtPXUrxcr64bzKv8lwssKJfsP54g8IAYezRVCB7anJKzXtRrzXQcj8kQoP4S
         q6bh4J1FtK1pA==
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4fb76659cacso1399402e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 15:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687816801; x=1690408801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WrPgRiS83Y2mIcWHryPXtoWboK6sANlwF7CN0nqeeXc=;
        b=ipfWhNSmhx4hwV/TI768NOCY9M5htSnFnMYRfYF2/T614+fU3Ew0d9CFke3zHv+9h4
         Irh9eBfYrwGHaPM+xhhjU/VXKg6CuI6YQwAIbsRGFlUg5zRLmeOXOnOoBvQ17rzmpmKg
         9oLJiO5u3rCkca7hUY7Dgt2VIhIc9aKDf2zRjKhg9GRvYXtpbCZjIoPC7WtT8E8VbaBt
         X32t3mLOjRJjBo9kOKgIAjHKqcOJCHuq+DACKObHbB86ZT2wPoL1cMH8fuiS/pU6fZkS
         6+wjLGc8U3Xjssi3QMozxR1KG1jRY7ZAIBhAUueQw4N0xHWkJdRPbaXgK/3/cg1iq0BA
         BBGg==
X-Gm-Message-State: AC+VfDz++KzG6Ll9xk0RVzGu6haFTkXX/jrQ/SJCxn9Im6fEg4V04ey/
        7pLK0r1gM1QQ0Wmjyh67jieODhKDuxsBU/hJofBCtHAk6gHOXt9JXt8LW9yQ3RTjqeXKIES0RuJ
        HCADF1ntpe+BXK3r5M+zMZmqaRVEVX4QMWsBzffDatw==
X-Received: by 2002:a2e:8689:0:b0:2b4:6195:bb2f with SMTP id l9-20020a2e8689000000b002b46195bb2fmr17494473lji.25.1687816800744;
        Mon, 26 Jun 2023 15:00:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5kEAG7BKp281vQ4Tc4uIIwnYqIhjtiqYLG/VOPCVutTsyYJTaNlnV0Ghbwg0sP5GAXOWPw1Q==
X-Received: by 2002:a2e:8689:0:b0:2b4:6195:bb2f with SMTP id l9-20020a2e8689000000b002b46195bb2fmr17494457lji.25.1687816800440;
        Mon, 26 Jun 2023 15:00:00 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id y7-20020a1709060a8700b0098f99048053sm2097490ejf.148.2023.06.26.14.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 14:59:59 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH net-next] net: scm: introduce and use scm_recv_unix helper
Date:   Mon, 26 Jun 2023 23:59:51 +0200
Message-Id: <20230626215951.563715-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, our friends from bluetooth subsystem reported
[1] that after ("scm: add SO_PASSPIDFD and SCM_PIDFD")
scm_recv helper become unusable in kernel modules (because it
uses unexported pidfd_prepare() API).

We were aware of this issue and workarounded it in a hard way
by ("af_unix: Kconfig: make CONFIG_UNIX bool").

But recently a new functionality was added in the scope of
817efd3cad74 ("Bluetooth: hci_sock: Forward credentials to monitor")
and after that bluetooth can't be compiled as a kernel module.

After some discussion in [1] we decided to split scm_recv into
two helpers, one won't support SCM_PIDFD (used for unix sockets),
and another one will be completely the same as it was before
("scm: add SO_PASSPIDFD and SCM_PIDFD").

[1] https://lore.kernel.org/lkml/CAJqdLrpFcga4n7wxBhsFqPQiN8PKFVr6U10fKcJ9W7AcZn+o6Q@mail.gmail.com/

Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 include/net/scm.h  | 35 +++++++++++++++++++++++++----------
 net/unix/af_unix.c |  4 ++--
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/include/net/scm.h b/include/net/scm.h
index c67f765a165b..409b8efda2c9 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -151,8 +151,8 @@ static __inline__ void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm
 		fd_install(pidfd, pidfd_file);
 }
 
-static __inline__ void scm_recv(struct socket *sock, struct msghdr *msg,
-				struct scm_cookie *scm, int flags)
+static inline bool __scm_recv_common(struct socket *sock, struct msghdr *msg,
+					 struct scm_cookie *scm, int flags)
 {
 	if (!msg->msg_control) {
 		if (test_bit(SOCK_PASSCRED, &sock->flags) ||
@@ -160,7 +160,7 @@ static __inline__ void scm_recv(struct socket *sock, struct msghdr *msg,
 		    scm->fp || scm_has_secdata(sock))
 			msg->msg_flags |= MSG_CTRUNC;
 		scm_destroy(scm);
-		return;
+		return false;
 	}
 
 	if (test_bit(SOCK_PASSCRED, &sock->flags)) {
@@ -173,19 +173,34 @@ static __inline__ void scm_recv(struct socket *sock, struct msghdr *msg,
 		put_cmsg(msg, SOL_SOCKET, SCM_CREDENTIALS, sizeof(ucreds), &ucreds);
 	}
 
-	if (test_bit(SOCK_PASSPIDFD, &sock->flags))
-		scm_pidfd_recv(msg, scm);
+	scm_passec(sock, msg, scm);
 
-	scm_destroy_cred(scm);
+	if (scm->fp)
+		scm_detach_fds(msg, scm);
 
-	scm_passec(sock, msg, scm);
+	return true;
+}
 
-	if (!scm->fp)
+static inline void scm_recv(struct socket *sock, struct msghdr *msg,
+				struct scm_cookie *scm, int flags)
+{
+	if (!__scm_recv_common(sock, msg, scm, flags))
 		return;
-	
-	scm_detach_fds(msg, scm);
+
+	scm_destroy_cred(scm);
 }
 
+static inline void scm_recv_unix(struct socket *sock, struct msghdr *msg,
+				     struct scm_cookie *scm, int flags)
+{
+	if (!__scm_recv_common(sock, msg, scm, flags))
+		return;
+
+	if (test_bit(SOCK_PASSPIDFD, &sock->flags))
+		scm_pidfd_recv(msg, scm);
+
+	scm_destroy_cred(scm);
+}
 
 #endif /* __LINUX_NET_SCM_H */
 
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index f2f234f0b92c..20ac83e012e4 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2427,7 +2427,7 @@ int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
 	}
 	err = (flags & MSG_TRUNC) ? skb->len - skip : size;
 
-	scm_recv(sock, msg, &scm, flags);
+	scm_recv_unix(sock, msg, &scm, flags);
 
 out_free:
 	skb_free_datagram(sk, skb);
@@ -2808,7 +2808,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 
 	mutex_unlock(&u->iolock);
 	if (state->msg && check_creds)
-		scm_recv(sock, state->msg, &scm, flags);
+		scm_recv_unix(sock, state->msg, &scm, flags);
 	else
 		scm_destroy(&scm);
 out:
-- 
2.34.1

