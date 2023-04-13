Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9C16E0EEC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjDMNhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjDMNhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:37:19 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C252C153
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:35:06 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0D9C23F4A5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 13:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681392882;
        bh=tINNpmFGgSXRr6eO7vUL42OoLzt52EnFT+KFr84tTSM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=IWDXicU2IQ9anwvlt41gLsLZbPZ1unCTVWeeM7Up+nwwE+5OIiswt8+tchFOFGrpi
         pveAeyfsJTBEivTaXTd85UCCbRhLx1gMYxi4aBH3GStjvwl5Cg1CmahWFbZGkGNJoH
         1xuIhnVWOQgNylub289HfbcFlGKHZgiJQygBmYIzLZSUw3tv34JYlekk71isGeEm4o
         Ht1z/+wpVNypgc/A5ELZB1zmKY6MMLztwD0YuIavb21KxOWGZfHgPGZ/RQLMO1sohs
         BHgp1O+dRWB/X8eVoJtejN3GE9sM83UNe0c7WhpgCd6aiPwmfpgD1vGBYpd87MyaP9
         CRCYbVg30oVDA==
Received: by mail-ed1-f69.google.com with SMTP id x5-20020a50d605000000b005066c2aa22aso1456211edi.17
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681392879; x=1683984879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tINNpmFGgSXRr6eO7vUL42OoLzt52EnFT+KFr84tTSM=;
        b=P8wOmmtMh6Koh5Y1jw7ZqkLJJx/0iMLT6xJepAQ2Cu3t/2zeAzIPMVW9/QY4YldW2u
         W+fMGOmk/4pj0xer9ASq9Jxo4m+uz3Oz4QyeLVhPKgo3Mfr6QCnCHy04lrS8BfVu8tZd
         RwjNhgRRyZxTsE4v+wa8btNk4csAYwpEIu3Q4vFX6vFHOkqfTUIsZH0w8UUMDyhgjV46
         uZaq0qN3f9oDgK1J4NmIrBZxMWFKNNZ5Kgdny5rLqfFf8t1KUPaXiNEiuqiTPKAz8GbQ
         rn5gtjouuGGsh1Oy0ww14ZVTmY+tDukz1aeEBqEWe2+hJyMstZdzihHUqXPyUkwCctEH
         gi7A==
X-Gm-Message-State: AAQBX9chijo4Yq+61s3QMxJxqL8rc8vNvD1iR8Q3/BiN7AcwBlW3hIXV
        CL3+m3+Q4vKpDtSF9U7cyJtCXOA7LleB+OOkhEx8zkL50XfQEH0ihEiQgHRnLEkqQEnwK3ASZzG
        O6+q3gNg8W8SqCXtXKudmgh06DlLmW1YDmKrMGY2LVQ==
X-Received: by 2002:a17:906:57d0:b0:94a:62e7:70e1 with SMTP id u16-20020a17090657d000b0094a62e770e1mr2718806ejr.68.1681392879595;
        Thu, 13 Apr 2023 06:34:39 -0700 (PDT)
X-Google-Smtp-Source: AKy350bWyh1fpNfKciV+c7c09q66s0vrF8zu0AQeMYpVtpd/3rM0AMu+N1JJw82j5x6TBlII2M7uJA==
X-Received: by 2002:a17:906:57d0:b0:94a:62e7:70e1 with SMTP id u16-20020a17090657d000b0094a62e770e1mr2718777ejr.68.1681392879298;
        Thu, 13 Apr 2023 06:34:39 -0700 (PDT)
Received: from amikhalitsyn.. ([95.91.208.118])
        by smtp.gmail.com with ESMTPSA id et22-20020a170907295600b0094a966330fdsm976806ejc.211.2023.04.13.06.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 06:34:38 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        daniel@iogearbox.net,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Luca Boccassi <bluca@debian.org>, linux-arch@vger.kernel.org
Subject: [PATCH net-next v4 3/4] net: core: add getsockopt SO_PEERPIDFD
Date:   Thu, 13 Apr 2023 15:33:54 +0200
Message-Id: <20230413133355.350571-4-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230413133355.350571-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230413133355.350571-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SO_PEERPIDFD which allows to get pidfd of peer socket holder pidfd.
This thing is direct analog of SO_PEERCRED which allows to get plain PID.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: David Ahern <dsahern@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Tested-by: Luca Boccassi <bluca@debian.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v4:
	- return -ESRCH if sk->sk_peer_pid is NULL from getsockopt() syscall
	- return errors from pidfd_prepare() as it is from getsockopt() syscall
v3:
	- fixed possible fd leak (thanks to Christian Brauner)
v2:
	According to review comments from Kuniyuki Iwashima and Christian Brauner:
	- use pidfd_create(..) retval as a result
	- whitespace change
---
 arch/alpha/include/uapi/asm/socket.h    |  1 +
 arch/mips/include/uapi/asm/socket.h     |  1 +
 arch/parisc/include/uapi/asm/socket.h   |  1 +
 arch/sparc/include/uapi/asm/socket.h    |  1 +
 include/uapi/asm-generic/socket.h       |  1 +
 net/core/sock.c                         | 33 +++++++++++++++++++++++++
 net/socket.c                            |  7 ++++++
 tools/include/uapi/asm-generic/socket.h |  1 +
 8 files changed, 46 insertions(+)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index ff310613ae64..e94f621903fe 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -138,6 +138,7 @@
 #define SO_RCVMARK		75
 
 #define SO_PASSPIDFD		76
+#define SO_PEERPIDFD		77
 
 #if !defined(__KERNEL__)
 
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 762dcb80e4ec..60ebaed28a4c 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -149,6 +149,7 @@
 #define SO_RCVMARK		75
 
 #define SO_PASSPIDFD		76
+#define SO_PEERPIDFD		77
 
 #if !defined(__KERNEL__)
 
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index df16a3e16d64..be264c2b1a11 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -130,6 +130,7 @@
 #define SO_RCVMARK		0x4049
 
 #define SO_PASSPIDFD		0x404A
+#define SO_PEERPIDFD		0x404B
 
 #if !defined(__KERNEL__)
 
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index 6e2847804fea..682da3714686 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -131,6 +131,7 @@
 #define SO_RCVMARK               0x0054
 
 #define SO_PASSPIDFD             0x0055
+#define SO_PEERPIDFD             0x0056
 
 #if !defined(__KERNEL__)
 
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index b76169fdb80b..8ce8a39a1e5f 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -133,6 +133,7 @@
 #define SO_RCVMARK		75
 
 #define SO_PASSPIDFD		76
+#define SO_PEERPIDFD		77
 
 #if !defined(__KERNEL__)
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 3f974246ba3e..49531c0dc57f 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1763,6 +1763,39 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		goto lenout;
 	}
 
+	case SO_PEERPIDFD:
+	{
+		struct pid *peer_pid;
+		struct file *pidfd_file = NULL;
+		int pidfd;
+
+		if (len > sizeof(pidfd))
+			len = sizeof(pidfd);
+
+		spin_lock(&sk->sk_peer_lock);
+		peer_pid = get_pid(sk->sk_peer_pid);
+		spin_unlock(&sk->sk_peer_lock);
+
+		if (!peer_pid)
+			return -ESRCH;
+
+		pidfd = pidfd_prepare(peer_pid, 0, &pidfd_file);
+		put_pid(peer_pid);
+		if (pidfd < 0)
+			return pidfd;
+
+		if (copy_to_sockptr(optval, &pidfd, len) ||
+		    copy_to_sockptr(optlen, &len, sizeof(int))) {
+			put_unused_fd(pidfd);
+			fput(pidfd_file);
+
+			return -EFAULT;
+		}
+
+		fd_install(pidfd, pidfd_file);
+		return 0;
+	}
+
 	case SO_PEERGROUPS:
 	{
 		const struct cred *cred;
diff --git a/net/socket.c b/net/socket.c
index 9c1ef11de23f..505b85489354 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2248,6 +2248,13 @@ static bool sockopt_installs_fd(int level, int optname)
 		default:
 			return false;
 		}
+	} else if (level == SOL_SOCKET) {
+		switch (optname) {
+		case SO_PEERPIDFD:
+			return true;
+		default:
+			return false;
+		}
 	}
 
 	return false;
diff --git a/tools/include/uapi/asm-generic/socket.h b/tools/include/uapi/asm-generic/socket.h
index fbbc4bf53ee3..54d9c8bf7c55 100644
--- a/tools/include/uapi/asm-generic/socket.h
+++ b/tools/include/uapi/asm-generic/socket.h
@@ -122,6 +122,7 @@
 #define SO_RCVMARK		75
 
 #define SO_PASSPIDFD		76
+#define SO_PEERPIDFD		77
 
 #if !defined(__KERNEL__)
 
-- 
2.34.1

