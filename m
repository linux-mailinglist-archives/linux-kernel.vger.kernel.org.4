Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4576DD821
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 12:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjDKKnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 06:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjDKKnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 06:43:45 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4CF3C1F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 03:43:32 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CBCBF3F237
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 10:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681209810;
        bh=pU+XkxxaqxIltFz6HAiJgXotXtTecmR/abIbMqTWsWw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Z06CA+JcDdJSFA9PnH61/Q3e0p+z11skMn3k+JedjsCMAnWO3NCgcJES26N4PNFfs
         3S5I/ZLknwsf3zB991NJIy0DPB9P7ps9Qyfr/N5hpVr4WAdf+aRhvQFcus2d2rChn/
         lk446tSYDUX6ooVqg9Nf0fW6Ec8X42j0wTauiriComSpNn4RRjoNZw0D5ISr2oED/9
         fUQgYjYw+YE77RvMSw+SpBnfZ4224/8gyPDLdYI0sgusM3RQlhYPH2okArpyL1pLvu
         P4GRnceeOPPH7X/JtXEZIN13S7xdLyFEsu1RDb8WowET8yEARhQLp+BTQ0tB4D0r7m
         fdrp7mYQiI2zg==
Received: by mail-ej1-f72.google.com with SMTP id b3-20020a170906038300b009489cf242c8so4397490eja.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 03:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681209810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pU+XkxxaqxIltFz6HAiJgXotXtTecmR/abIbMqTWsWw=;
        b=Rs5cX7BjPuM4w9WZt3o3gIfbDFAzaCqpmAkjX9jDSOkAmhvS2g/QovSfZcUUEwYuRC
         Coe4siqVkDojdyO4W/Irt5soZdVlurXwTsX6ZZ8FJCbvdI3ymJNrRcYvkcIM8AVQJ13E
         3u8q/WSNwjWBnwKdrTeGk367Afv9q6TuDQUxwxIn3iQTvkSRUTOSvgVLjtM2zCqDNz52
         QEuPmjI1BF+6QYlkPHKvKXNzXkLsD6uNwff+mzOwTkv2lQPC6ncxTrtO+O7yBuaBN03l
         5gzw3f85VaWMHGXbSWu2QpNvDL38SoqRCQvUjMMykYEVIedgBzcNgEA4iYfPLp+1gEDj
         QReQ==
X-Gm-Message-State: AAQBX9cUKhdp5t5VK7q+CkvVNaP5PJV+98FQHwq4o+qCHVz8Bs4N3T5P
        hh9JrdefL55A00Ter9c6ckFvFVyMKyv7wXzLY4OcQcc2Gf9yTQ175ms48E0Guw4euMxvNeQAkRe
        B/QLK9XY6NbCl6t6HTW3hios/wl4tyo7W02JvPlPSbw==
X-Received: by 2002:a17:907:6a12:b0:94a:474a:4dd7 with SMTP id rf18-20020a1709076a1200b0094a474a4dd7mr7376313ejc.60.1681209810561;
        Tue, 11 Apr 2023 03:43:30 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZNewLrXNZ6daAOHQgJi0nkKHwQAVXgrGhHW2GSMumryIkh965UAbKXhAPWjtH8AEfHFA4Kaw==
X-Received: by 2002:a17:907:6a12:b0:94a:474a:4dd7 with SMTP id rf18-20020a1709076a1200b0094a474a4dd7mr7376308ejc.60.1681209810274;
        Tue, 11 Apr 2023 03:43:30 -0700 (PDT)
Received: from amikhalitsyn.. ([95.91.208.118])
        by smtp.gmail.com with ESMTPSA id ne7-20020a1709077b8700b00948c320fcfdsm5921805ejc.202.2023.04.11.03.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 03:43:29 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
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
        linux-arch@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH net-next v3 2/4] net: socket: add sockopts blacklist for BPF cgroup hook
Date:   Tue, 11 Apr 2023 12:42:29 +0200
Message-Id: <20230411104231.160837-3-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411104231.160837-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230411104231.160837-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
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

