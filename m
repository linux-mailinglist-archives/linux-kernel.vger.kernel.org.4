Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C9965E88E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjAEKDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjAEKCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:02:33 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2754E437
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:00:34 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 7so24203651pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YSkbr2QOz/1oJHttLNYBqZ3OmunTHUcZcfMj9K1W678=;
        b=V5JCffKEkz2t4SAa3LJfpXLxRbVlBq3IEt/aKevZEyrOMV3gfLZ1XvIXZEGmFnIVXs
         f8Opde01oKw6uRCrmju2MpRqbmMvz5gmWTnBBEmZgK/fSPHhZDNbYo6OSmK53K/ay9HY
         6fdWEYQCJqN6Gam2+z1blEToT0j9afsbVpr2KW6b0nP9s1dXaGgz+nZPS/y5nBA3Oc/B
         IBvtJTZSZ0tdzyYwDLJuCGAXWc5IZGuLDI6XeMsCd6z2G4LwpBxseylipnXLKrxlOWoD
         xO7fAsXra6DUjUBgxbrxXOVQUqZYGlyAn68FdCHIsiD8dWXho0HUheANY03PZflTtTXr
         o2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YSkbr2QOz/1oJHttLNYBqZ3OmunTHUcZcfMj9K1W678=;
        b=i52yxd1YoX31PksKvZsPOZWc0L9ahlk4/OclTBDxQMo5FM8g/J7wYHuJbn9Z2at/hJ
         gV629pl6kQ19kgGz5CJlgXIgVchoO1xDy0JBHqo7romvnQJiY1kc6umr3zuQj08cw4kv
         J+rXa/fLsfxdwI2JcUBL7dcV1lBP8Viex+hxiBOjGs1rRYQfBIRgIBiuVBXIb7EsOI1y
         6nFkzBrMPbgy3xjC4qAJmg/kZ/jNl8dIiqDhcUQgKHj8Gmz8qgs47xEfsAZr8z8AD807
         KHmJWHpdEbNgxt13V1gaFnaWDWrYc6LEBY152NmoIpkAOuB1xtzf1MXddPbx1oSWmUEQ
         259Q==
X-Gm-Message-State: AFqh2kpvVTFvswBY+FjJ18b6f79jgXhwRezL9r0SLHzQJVp/XiOz6xkN
        zBQK6YQFIFvDE8ip82OuokIxaA==
X-Google-Smtp-Source: AMrXdXvH91C82IqMwVs/qS4LAWFx1oH5HzHg3m1UBV75Y7lqCINRh8bpMZLCvzPniFcj5BXZk4BkGw==
X-Received: by 2002:a62:198a:0:b0:577:d10d:6eab with SMTP id 132-20020a62198a000000b00577d10d6eabmr50836195pfz.21.1672912832659;
        Thu, 05 Jan 2023 02:00:32 -0800 (PST)
Received: from PF2E59YH-BKX.inc.bytedance.com ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id s19-20020aa78bd3000000b00581d62be96dsm13003146pfd.197.2023.01.05.02.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 02:00:32 -0800 (PST)
From:   Yunhui Cui <cuiyunhui@bytedance.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        cuiyunhui@bytedance.com, duanxiongchun@bytedance.com,
        kuniyu@amazon.com, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] sock: add tracepoint for send recv length
Date:   Thu,  5 Jan 2023 18:00:14 +0800
Message-Id: <20230105100014.1935-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.37.3.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 2 tracepoints to monitor the tcp/udp traffic
of per process and per cgroup.

Regarding monitoring the tcp/udp traffic of each process, the existing
implementation is https://www.atoptool.nl/netatop.php.
This solution is implemented by registering the hook function at the hook
point provided by the netfilter framework.

These hook functions may be in the soft interrupt context and cannot
directly obtain the pid. Some data structures are added to bind packets
and processes. For example, struct taskinfobucket, struct taskinfo ...

Every time the process sends and receives packets it needs multiple
hashmaps,resulting in low performance and it has the problem fo inaccurate
tcp/udp traffic statistics(for example: multiple threads share sockets).

Based on these 2 tracepoints, we have optimized and tested performance.
Time Per Request as an indicator, without monitoring: 50.95ms,
netatop: 63.27 ms, Hook on these tracepoints: 52.24ms.
The performance has been improved 10 times. The tcp/udp traffic of each
process has also been accurately counted.

We can obtain the information with kretprobe, but as we know, kprobe gets
the result by trappig in an exception, which loses performance compared
to tracepoint. We did a test for performance comparison. The results are
as follows. Time per request, sock_sendmsg(k,kr):  12.382ms,
tcp_send_length(tracepoint): 11.887ms，without hook：11.222ms

It can be seen that the performance loss of tracepoint is only half of
that of kprobe.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
Signed-off-by: Xiongchun Duan <duanxiongchun@bytedance.com>
---
 include/trace/events/sock.h | 50 +++++++++++++++++++++++++++++++++++++
 net/socket.c                | 23 +++++++++++++++--
 2 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/sock.h b/include/trace/events/sock.h
index 777ee6cbe933..9a85b455a877 100644
--- a/include/trace/events/sock.h
+++ b/include/trace/events/sock.h
@@ -263,6 +263,56 @@ TRACE_EVENT(inet_sk_error_report,
 		  __entry->error)
 );
 
+/*
+ * sock send/recv msg length
+ * * Note: this class requires positive integer
+ */
+DECLARE_EVENT_CLASS(sock_msg_length,
+
+	TP_PROTO(struct sock *sk, __u16 family, __u16 protocol, int length,
+		int error, int flags),
+
+	TP_ARGS(sk, family, protocol, length, error, flags),
+
+	TP_STRUCT__entry(
+		__field(void *, sk)
+		__field(__u16, family)
+		__field(__u16, protocol)
+		__field(int, length)
+		__field(int, error)
+		__field(int, flags)
+	),
+
+	TP_fast_assign(
+		__entry->sk = sk;
+		__entry->family = sk->sk_family;
+		__entry->protocol = sk->sk_protocol;
+		__entry->length = length;
+		__entry->error = error;
+		__entry->flags = flags;
+	),
+
+	TP_printk("sk address = %p, family = %s protocol = %s, length = %d, error = %d, flags = 0x%x",
+			__entry->sk,
+			show_family_name(__entry->family),
+			show_inet_protocol_name(__entry->protocol),
+			__entry->length,
+			__entry->error, __entry->flags)
+);
+
+DEFINE_EVENT(sock_msg_length, sock_sendmsg_length,
+	TP_PROTO(struct sock *sk, __u16 family, __u16 protocol, int length,
+		 int error, int flags),
+
+	TP_ARGS(sk, family, protocol, length, error, flags)
+);
+
+DEFINE_EVENT(sock_msg_length, sock_recvmsg_length,
+	TP_PROTO(struct sock *sk, __u16 family, __u16 protocol, int length,
+		 int error, int flags),
+
+	TP_ARGS(sk, family, protocol, length, error, flags)
+);
 #endif /* _TRACE_SOCK_H */
 
 /* This part must be outside protection */
diff --git a/net/socket.c b/net/socket.c
index 888cd618a968..cd3887e12b76 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -106,6 +106,7 @@
 #include <net/busy_poll.h>
 #include <linux/errqueue.h>
 #include <linux/ptp_clock_kernel.h>
+#include <trace/events/sock.h>
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
 unsigned int sysctl_net_busy_read __read_mostly;
@@ -715,6 +716,10 @@ static inline int sock_sendmsg_nosec(struct socket *sock, struct msghdr *msg)
 				     inet_sendmsg, sock, msg,
 				     msg_data_left(msg));
 	BUG_ON(ret == -EIOCBQUEUED);
+
+	trace_sock_sendmsg_length(sock->sk, sock->sk->sk_family,
+				  sock->sk->sk_protocol,
+				  ret > 0 ? ret : 0, ret > 0 ? 0 : ret, 0);
 	return ret;
 }
 
@@ -992,9 +997,17 @@ INDIRECT_CALLABLE_DECLARE(int inet6_recvmsg(struct socket *, struct msghdr *,
 static inline int sock_recvmsg_nosec(struct socket *sock, struct msghdr *msg,
 				     int flags)
 {
-	return INDIRECT_CALL_INET(sock->ops->recvmsg, inet6_recvmsg,
+	int ret = INDIRECT_CALL_INET(sock->ops->recvmsg, inet6_recvmsg,
 				  inet_recvmsg, sock, msg, msg_data_left(msg),
 				  flags);
+
+	trace_sock_recvmsg_length(sock->sk, sock->sk->sk_family,
+				  sock->sk->sk_protocol,
+				  (ret > 0 && !(flags & MSG_PEEK)) ?
+				  ret : 0,
+				  (ret > 0 && !(flags & MSG_PEEK)) ? 0 : ret,
+				  flags);
+	return ret;
 }
 
 /**
@@ -1044,6 +1057,7 @@ static ssize_t sock_sendpage(struct file *file, struct page *page,
 {
 	struct socket *sock;
 	int flags;
+	int ret;
 
 	sock = file->private_data;
 
@@ -1051,7 +1065,12 @@ static ssize_t sock_sendpage(struct file *file, struct page *page,
 	/* more is a combination of MSG_MORE and MSG_SENDPAGE_NOTLAST */
 	flags |= more;
 
-	return kernel_sendpage(sock, page, offset, size, flags);
+	ret = kernel_sendpage(sock, page, offset, size, flags);
+
+	trace_sock_sendmsg_length(sock->sk, sock->sk->sk_family,
+				  sock->sk->sk_protocol,
+				  ret > 0 ? ret : 0, ret > 0 ? 0 : ret, 0);
+	return ret;
 }
 
 static ssize_t sock_splice_read(struct file *file, loff_t *ppos,
-- 
2.20.1

