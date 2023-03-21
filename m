Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5506B6C3968
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 19:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjCUSpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 14:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjCUSpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 14:45:38 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DA853739
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 11:45:36 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 47A5944519
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 18:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1679424333;
        bh=yvq6UMt9yN5iUlZuMyY0OG5lD/RxD6knn9gceCIGOkg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=HIPJQxMlM/Wv+lrL18I9c68nP4KtaXtCro/RU+uaaECc8R3DBz1wC8kLaGJqF/jXr
         tmVsFi4/6c4R7175sYqfYkla0ehDYwVFlj+V/I1tFYYzJIBfDVP+fHqkKNW9YPHYTA
         nfq1DpixlNc2rwdZgFQSbpddMkV6FSaBck7fsVQ1rqEdy+q5PCRNzzt2yns2ORMnQs
         RVQ14NiZk/L/iazpZu9HAVV+EVXIUJtsKue5MKkRBhtqn7j8IIdaWZo2D1ek4kTcrQ
         kFgszDVCK03s9zZVnkOIyJTjKtUFNg9AQH/MggKWDgiKFltebjk7VLJrfnXNQQ82UJ
         oFyWIQoIa1e/g==
Received: by mail-ed1-f72.google.com with SMTP id s30-20020a508d1e000000b005005cf48a93so12083121eds.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 11:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679424332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yvq6UMt9yN5iUlZuMyY0OG5lD/RxD6knn9gceCIGOkg=;
        b=qZDBxSEmvs+bbYhOIgQbnY3pO7DBDAYCMRnHiNfsTq59pMlHlHFF1K4MBgahOPZxXJ
         NxrVUfAxh/tPwI4OY4iO3/MoN5Y7MRoJwvgSslMguj4gulKlvBURy5LoVMMF/QZeO7M+
         Vmtyt/oY6o3EdrjgIjSyEe4n8TfDME2YiGdC42P++kJGsgOZmNmw90qfJ1z+FEPwBEG1
         m230JZ+9FK7Zy5UCISMHTiUx2KgkGAEXCaLVdN9aHofLM8pjOMsVErzDlM1Dvm8JViCW
         Hnvp+HECg8bUNc4MrM+GFiJcVaEANQPVNNyUEPg1K65pGUmt4dytVS7HbBG96c8bO6QI
         Kxqg==
X-Gm-Message-State: AO0yUKUvVDIIIRIaBFWMumie4UieZ2YPfR/dC3jlMKLPv9x5hr/e7vHB
        AXEvoO8mRwE09s0Bu0vnj1ZRppH+/LOj+tGz6iKrBbbSX3bvc6dY/XGznqMaTJ8V6VF41CgiLNB
        LgPKS9FKBQXjZ5M1ZCK6uJOkpPiYr+ILeGYpodXBcoObpUbFsjA==
X-Received: by 2002:a17:906:8476:b0:931:96c5:7646 with SMTP id hx22-20020a170906847600b0093196c57646mr3965063ejc.57.1679424332652;
        Tue, 21 Mar 2023 11:45:32 -0700 (PDT)
X-Google-Smtp-Source: AK7set+h4AxTZC2eEvXbNStSrd7vEgU483k1w+wvWlNjFWtlvw+Tar3b0aYg/x+Y147Rd5JSOKP06g==
X-Received: by 2002:a17:906:8476:b0:931:96c5:7646 with SMTP id hx22-20020a170906847600b0093196c57646mr3965041ejc.57.1679424332403;
        Tue, 21 Mar 2023 11:45:32 -0700 (PDT)
Received: from amikhalitsyn.. (ip5f5bd076.dynamic.kabel-deutschland.de. [95.91.208.118])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709060e8900b0093313f4fc3csm4928194ejf.70.2023.03.21.11.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 11:45:31 -0700 (PDT)
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
        Lennart Poettering <mzxreary@0pointer.de>
Subject: [PATCH net-next v2 0/3] Add SCM_PIDFD and SO_PEERPIDFD
Date:   Tue, 21 Mar 2023 19:33:39 +0100
Message-Id: <20230321183342.617114-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
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

1. Implement SCM_PIDFD, a new type of CMSG type analogical to SCM_CREDENTIALS,
but it contains pidfd instead of plain pid, which allows programmers not
to care about PID reuse problem.

2. Add SO_PEERPIDFD which allows to get pidfd of peer socket holder pidfd.
This thing is direct analog of SO_PEERCRED which allows to get plain PID.

3. Add SCM_PIDFD / SO_PEERPIDFD kselftest

Idea comes from UAPI kernel group:
https://uapi-group.org/kernel-features/

Big thanks to Christian Brauner and Lennart Poettering for productive
discussions about this.

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

Alexander Mikhalitsyn (3):
  scm: add SO_PASSPIDFD and SCM_PIDFD
  net: core: add getsockopt SO_PEERPIDFD
  selftests: net: add SCM_PIDFD / SO_PEERPIDFD test

 arch/alpha/include/uapi/asm/socket.h          |   3 +
 arch/mips/include/uapi/asm/socket.h           |   3 +
 arch/parisc/include/uapi/asm/socket.h         |   3 +
 arch/sparc/include/uapi/asm/socket.h          |   3 +
 include/linux/net.h                           |   1 +
 include/linux/socket.h                        |   1 +
 include/net/scm.h                             |  14 +-
 include/uapi/asm-generic/socket.h             |   3 +
 net/core/sock.c                               |  32 ++
 net/mptcp/sockopt.c                           |   1 +
 net/unix/af_unix.c                            |  18 +-
 tools/include/uapi/asm-generic/socket.h       |   3 +
 tools/testing/selftests/net/.gitignore        |   1 +
 tools/testing/selftests/net/af_unix/Makefile  |   3 +-
 .../testing/selftests/net/af_unix/scm_pidfd.c | 336 ++++++++++++++++++
 15 files changed, 417 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/net/af_unix/scm_pidfd.c

-- 
2.34.1

