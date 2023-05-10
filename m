Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F15D6FDE4C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbjEJNPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjEJNPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:15:49 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC09612A
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 06:15:46 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1CE2C3F4D6
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 13:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1683724545;
        bh=a4+m+7dc0UGwNdAzW/ds7TFtd8vcV7ga23RII0fZY0k=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=QnDwxcwbqo0qcvmbuAkflNeP4iBu/+uu14fg1m+OR/wxY7VXnStVXHlHnR5f+u7gS
         19TeDZuXTdBxaZWrQvvUcN8KNaj6cJ76l/aRFlncLW5sqI8Nl7qzd61XLhqHzMIfFX
         DPvnXQ21AJdTMwgyJxD5PNOtqa9VIo90yVsal+Gi8YboeSxJOo8SgFo5ZU+faE6jHW
         r8B1+LGY3HX5eBvDlbAqXVRX3hiQlgb0r+nWnTDbjo2jUfOHFzQA24SzMn+1dbSa3c
         AnFBtdrrs9OaSMH8A75J0PnzaRfLVv2eo0rHk1jSFg7p4/P5cpR+HLr7gEyVdNDoLJ
         fEQm44H3iMv9w==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-50a16ab50e6so6777348a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 06:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683724544; x=1686316544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4+m+7dc0UGwNdAzW/ds7TFtd8vcV7ga23RII0fZY0k=;
        b=RLewV8CyO/AxCtZSnWFQhjS630QJyUttB1ZpfOBxUtOdfcHlC50jFZXzR1h6QUMyhh
         bhX2G6Q/IZJYc0WkP8GRpJPzzloKnddo8ju2GcL9SXiAQQnicdTj+AzJTK8VfMeTVJUf
         JDbkwpCZB6tnKK/xUNey2QJtvQS3d6bWeDq+bWN3RaZtvPflFXfBXW+nHDh3rU8sVVnl
         z7hSgb228ueneJF/jXOsqkUk63Jr1ydrPin09cBnrUjT4OBJadH78NjMZLV2XigCkHeA
         503iuw1JUcFUy6oJz6c8te2KNXsJ6PIOJo1zZEaItqHJQxokfJRUPXlwYGHzIfOJGb6z
         ITdA==
X-Gm-Message-State: AC+VfDyu27OURfpnk4whVK1MjSPn48KeLlr67rQwYcRW9hInh5KSDSiY
        2n6xM9UEVYQvY8GE6m4lc4EZxPhbCL1r+6HpmoB/DJgZbkNSxPqLw/XH4sUtiPS5i08uK/RRk97
        UecSoqTEiIIo3utHkbr465yr04zTZRDxlCf2ViqSg4lTkBmWO0Q==
X-Received: by 2002:a05:6402:10cc:b0:502:2494:b8fc with SMTP id p12-20020a05640210cc00b005022494b8fcmr12892380edu.7.1683724544609;
        Wed, 10 May 2023 06:15:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4hrt4igaxYX0S+3W3IYOURDdu03frwLJLDVV2qaMORLrSqzNtHujKSnoTSphWi+E7qjc5YGQ==
X-Received: by 2002:a05:6402:10cc:b0:502:2494:b8fc with SMTP id p12-20020a05640210cc00b005022494b8fcmr12892359edu.7.1683724544287;
        Wed, 10 May 2023 06:15:44 -0700 (PDT)
Received: from amikhalitsyn.. (ip5f5bf3d5.dynamic.kabel-deutschland.de. [95.91.243.213])
        by smtp.gmail.com with ESMTPSA id e2-20020a50fb82000000b00509e3053b66sm1824750edq.90.2023.05.10.06.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 06:15:43 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     nhorman@tuxdriver.com
Cc:     davem@davemloft.net,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Christian Brauner <brauner@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>, linux-sctp@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net-next] sctp: add bpf_bypass_getsockopt proto callback
Date:   Wed, 10 May 2023 15:15:27 +0200
Message-Id: <20230510131527.1244929-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
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

Add bpf_bypass_getsockopt proto callback and filter out
SCTP_SOCKOPT_PEELOFF and SCTP_SOCKOPT_PEELOFF_FLAGS socket options
from running eBPF hook on them.

These options do fd_install(), and if BPF_CGROUP_RUN_PROG_GETSOCKOPT
hook returns an error after success of the original handler
sctp_getsockopt(...), userspace will receive an error from getsockopt
syscall and will be not aware that fd was successfully installed into fdtable.

This patch was born as a result of discussion around a new SCM_PIDFD interface:
https://lore.kernel.org/all/20230413133355.350571-3-aleksandr.mikhalitsyn@canonical.com/

Fixes: 0d01da6afc54 ("bpf: implement getsockopt and setsockopt hooks")
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Neil Horman <nhorman@tuxdriver.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Xin Long <lucien.xin@gmail.com>
Cc: linux-sctp@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 net/sctp/socket.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index cda8c2874691..a9a0ababea90 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -8281,6 +8281,29 @@ static int sctp_getsockopt(struct sock *sk, int level, int optname,
 	return retval;
 }
 
+bool sctp_bpf_bypass_getsockopt(int level, int optname)
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
+
 static int sctp_hash(struct sock *sk)
 {
 	/* STUB */
@@ -9650,6 +9673,7 @@ struct proto sctp_prot = {
 	.shutdown    =	sctp_shutdown,
 	.setsockopt  =	sctp_setsockopt,
 	.getsockopt  =	sctp_getsockopt,
+	.bpf_bypass_getsockopt	= sctp_bpf_bypass_getsockopt,
 	.sendmsg     =	sctp_sendmsg,
 	.recvmsg     =	sctp_recvmsg,
 	.bind        =	sctp_bind,
@@ -9705,6 +9729,7 @@ struct proto sctpv6_prot = {
 	.shutdown	= sctp_shutdown,
 	.setsockopt	= sctp_setsockopt,
 	.getsockopt	= sctp_getsockopt,
+	.bpf_bypass_getsockopt	= sctp_bpf_bypass_getsockopt,
 	.sendmsg	= sctp_sendmsg,
 	.recvmsg	= sctp_recvmsg,
 	.bind		= sctp_bind,
-- 
2.34.1

