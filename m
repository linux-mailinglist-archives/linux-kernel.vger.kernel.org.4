Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CCB6C8FC9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 18:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjCYReG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 13:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjCYReB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 13:34:01 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8CEB779
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 10:33:53 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id bz27so4514650qtb.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 10:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679765632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGRr1ILwfN2cOAAXlHu3J2/PGFc4d+v/t0gK/PtSh/k=;
        b=WatzM4DuWOJx4M4gULzYWvg6Ga2sfw1KF2JFslVS7krm98DuqIWIE6ircHntnso5H1
         3UZgA5Ms0OUui4t/aHQFizRVnCsnEgiV8KjUOTNFBi16FD1cmCrvf26RRnioQUr0sURE
         LqGpU4P/snzVoGwiU+SupVRJmuzG0EYDaGz1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679765632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGRr1ILwfN2cOAAXlHu3J2/PGFc4d+v/t0gK/PtSh/k=;
        b=D5HlUzO/P+VZp0kqzz1MoSmBWd0/HB7sS/w5cQKjKIe7j+mfzNpKLAFNag4p6xdD9J
         dXOfIooN9qgayzQYpnz4LCOWQtK+4Iu27qWbaIZTOpB4BN8GBtsQNxXGG9wGdvhhyzXH
         7Jzylt4MiaT/KTliA9kH42p5kDAKMij+r/GWDZthEHjlHnc5owNZra3cQ3lXPWL8Bxx7
         WSGBELK0d6D9QmNYeETYS9FRs9Wyllo61BKFVznGZZ9RQAsA/0bXfTxJDVkfMaWIPtri
         2+8G9qPLGmOul7ECDp9P7vobbiaRErv76nUdFCqEAiMVW2Wun1B+IYAZd8dQ5abvGu28
         Js8Q==
X-Gm-Message-State: AO0yUKVDO2UVXxef7pj71Q8qU4+hmd7uw3aeZswxFTtkHrpo4UKsj6iy
        1jeebNArqFpeQxrSHFwh80MMjYDwujgqRcRkzGQ=
X-Google-Smtp-Source: AKy350ZQb8NjnaheRmr0a0yUUSmOBnTfw+5+ORNnlNxBGifSZcPI5cuHF9VGV1N28HXDzuZ7cScG3g==
X-Received: by 2002:ac8:5f8b:0:b0:3e3:8427:fb51 with SMTP id j11-20020ac85f8b000000b003e38427fb51mr12302234qta.23.1679765632737;
        Sat, 25 Mar 2023 10:33:52 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id m4-20020ac84444000000b003e37ee54b5dsm6762764qtn.90.2023.03.25.10.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 10:33:52 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v2 01/13] MAINTAINERS: Change Joel Fernandes from R: to M:
Date:   Sat, 25 Mar 2023 17:33:04 +0000
Message-Id: <20230325173316.3118674-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230325173316.3118674-1-joel@joelfernandes.org>
References: <20230325173316.3118674-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have spent years learning / contributing to RCU with several features,
talks and presentations, with my most recent work being on Lazy-RCU.

Please consider me for M, so I can tell my wife why I spend a lot of my
weekends and evenings on this complicated and mysterious thing -- which is
mostly in the hopes of preventing the world from burning down because
everything runs on this one way or another. ;-)

Acked-by: Paul E. McKenney <paulmck@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f305..698c330d37cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17637,11 +17637,11 @@ READ-COPY UPDATE (RCU)
 M:	"Paul E. McKenney" <paulmck@kernel.org>
 M:	Frederic Weisbecker <frederic@kernel.org> (kernel/rcu/tree_nocb.h)
 M:	Neeraj Upadhyay <quic_neeraju@quicinc.com> (kernel/rcu/tasks.h)
+M:	Joel Fernandes <joel@joelfernandes.org>
 M:	Josh Triplett <josh@joshtriplett.org>
 R:	Steven Rostedt <rostedt@goodmis.org>
 R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 R:	Lai Jiangshan <jiangshanlai@gmail.com>
-R:	Joel Fernandes <joel@joelfernandes.org>
 L:	rcu@vger.kernel.org
 S:	Supported
 W:	http://www.rdrop.com/users/paulmck/RCU/
-- 
2.40.0.348.gf938b09366-goog

