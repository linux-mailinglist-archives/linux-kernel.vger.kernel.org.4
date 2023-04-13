Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DDF6E0EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjDMNhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjDMNhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:37:18 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99916B779
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:35:05 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BC7793F43B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 13:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681392880;
        bh=pU+XkxxaqxIltFz6HAiJgXotXtTecmR/abIbMqTWsWw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=fSdLFv6+6AwtL1xo8lr+sbRcMDlnQOpxNFbKF1loIK3JtPIuU6Cd255RADbyUjM1e
         mApLFFd90uIHUgVuW0iLpUUg0YJEPEjXR6k8cjHWN4co1VfoY1Or5iMisiYttIBwTb
         A9KQuRa67zJnpLR+BvXFa3ATy0doBYvADt595MduF11TQAmkNZDRm9YGr11p0oENXX
         J8wyW0JjBZh0ZHpc+qqDyJRF2496so/351JVfa3VVrQetQRY/KQrOuGMCwtEESczD7
         KXpMmrZXfgsj7YWYlODOiv+8VH4XTKPC6cFmLhO8bF+KjH05nB+EfDcx4wVJIzOMny
         H/pLsAFXSbvCA==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-505149e1a4eso3102652a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681392877; x=1683984877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pU+XkxxaqxIltFz6HAiJgXotXtTecmR/abIbMqTWsWw=;
        b=WWs3p7TZSj6AZDvpabfZHP3K0OxgLmiy5K3FdG3Ljg52wtv2B6UTHE4rr5p7drPECg
         GoJpfA2CpIrwx7Q3a6K1IybkCyF2J5LaI0Huv1Xfr7fTtSWArJkornOV8r9KInA5U3k2
         RR0dLoKg80QnMbU23vGeq8sunqYzgbtNXr+NvCZJCwIq4QtuzBzyjvW7NgcOG0vci0MB
         AdB1KtJnQXTPugSzijxu0mBSO9MKbSzAhROZumC6WpdFbKEN/DNB6KKEpeVTg5ai0DSp
         PpwVd4GGf5uUHdEbbySAVyPHqpg/1vXce9sEKJikRjFvXTjLdeBazQpjXhLZaUWb4vgN
         mAzg==
X-Gm-Message-State: AAQBX9fmDXO40ciQz6U1PS71wnvBBfCRvP+0objQ1iuo1FhR0OwX1MhD
        nGVZ/jVdM/Y8cWqZeaSepBaKxefuhGobT9UvQ9SMOVpgSMzXMI07SLFP6ZMtcHXgXnoygXv+hMJ
        y00Ip0zKW783xrpbqMFQO8QxRY7k41IH0jAUvrbX0rjkY8tzzqQ==
X-Received: by 2002:a05:6402:49:b0:504:8a0f:13ca with SMTP id f9-20020a056402004900b005048a0f13camr1932415edu.10.1681392877052;
        Thu, 13 Apr 2023 06:34:37 -0700 (PDT)
X-Google-Smtp-Source: AKy350aV7p0sn03LCerGeF3KPK9DDJyh86PbUa/oXNvIx8Ve9zsyvkpvXJUqxRJSvXrr+2BQLm/qeg==
X-Received: by 2002:a05:6402:49:b0:504:8a0f:13ca with SMTP id f9-20020a056402004900b005048a0f13camr1932387edu.10.1681392876801;
        Thu, 13 Apr 2023 06:34:36 -0700 (PDT)
Received: from amikhalitsyn.. ([95.91.208.118])
        by smtp.gmail.com with ESMTPSA id et22-20020a170907295600b0094a966330fdsm976806ejc.211.2023.04.13.06.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 06:34:36 -0700 (PDT)
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
        linux-arch@vger.kernel.org
Subject: [PATCH net-next v4 2/4] net: socket: add sockopts blacklist for BPF cgroup hook
Date:   Thu, 13 Apr 2023 15:33:53 +0200
Message-Id: <20230413133355.350571-3-aleksandr.mikhalitsyn@canonical.com>
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

During work on SO_PEERPIDFD, it was discovered (thanks to Christian),
that bpf cgroup hook can cause FD leaks when used with sockopts which
install FDs into the process fdtable.

After some offlist discussion it was proposed to add a blacklist of
socket options those can cause troubles when BPF cgroup hook is enabled.

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
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 net/socket.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 73e493da4589..9c1ef11de23f 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -108,6 +108,8 @@
 #include <linux/ptp_clock_kernel.h>
 #include <trace/events/sock.h>
 
+#include <linux/sctp.h>
+
 #ifdef CONFIG_NET_RX_BUSY_POLL
 unsigned int sysctl_net_busy_read __read_mostly;
 unsigned int sysctl_net_busy_poll __read_mostly;
@@ -2227,6 +2229,36 @@ static bool sock_use_custom_sol_socket(const struct socket *sock)
 	return test_bit(SOCK_CUSTOM_SOCKOPT, &sock->flags);
 }
 
+#ifdef CONFIG_CGROUP_BPF
+static bool sockopt_installs_fd(int level, int optname)
+{
+	/*
+	 * These options do fd_install(), and if BPF_CGROUP_RUN_PROG_GETSOCKOPT
+	 * hook returns an error after success of the original handler
+	 * sctp_getsockopt(...), userspace will receive an error from getsockopt
+	 * syscall and will be not aware that fd was successfully installed into fdtable.
+	 *
+	 * Let's prevent bpf cgroup hook from running on them.
+	 */
+	if (level == SOL_SCTP) {
+		switch (optname) {
+		case SCTP_SOCKOPT_PEELOFF:
+		case SCTP_SOCKOPT_PEELOFF_FLAGS:
+			return true;
+		default:
+			return false;
+		}
+	}
+
+	return false;
+}
+#else /* CONFIG_CGROUP_BPF */
+static inline bool sockopt_installs_fd(int level, int optname)
+{
+	return false;
+}
+#endif /* CONFIG_CGROUP_BPF */
+
 /*
  *	Set a socket option. Because we don't know the option lengths we have
  *	to pass the user mode parameter for the protocols to sort out.
@@ -2250,7 +2282,7 @@ int __sys_setsockopt(int fd, int level, int optname, char __user *user_optval,
 	if (err)
 		goto out_put;
 
-	if (!in_compat_syscall())
+	if (!in_compat_syscall() && !sockopt_installs_fd(level, optname))
 		err = BPF_CGROUP_RUN_PROG_SETSOCKOPT(sock->sk, &level, &optname,
 						     user_optval, &optlen,
 						     &kernel_optval);
@@ -2304,7 +2336,7 @@ int __sys_getsockopt(int fd, int level, int optname, char __user *optval,
 	if (err)
 		goto out_put;
 
-	if (!in_compat_syscall())
+	if (!in_compat_syscall() && !sockopt_installs_fd(level, optname))
 		max_optlen = BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);
 
 	if (level == SOL_SOCKET)
@@ -2315,7 +2347,7 @@ int __sys_getsockopt(int fd, int level, int optname, char __user *optval,
 		err = sock->ops->getsockopt(sock, level, optname, optval,
 					    optlen);
 
-	if (!in_compat_syscall())
+	if (!in_compat_syscall() && !sockopt_installs_fd(level, optname))
 		err = BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock->sk, level, optname,
 						     optval, optlen, max_optlen,
 						     err);
-- 
2.34.1

