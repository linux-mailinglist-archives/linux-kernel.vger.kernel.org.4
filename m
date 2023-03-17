Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E2A6BF1DE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 20:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCQTo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 15:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjCQToX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 15:44:23 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D188531BEB
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:44:17 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id r16so6856782qtx.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679082256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=341yOCJQSt3i3F13IHsmlZ0mEcYrW2rEkyPXLsqSxhw=;
        b=Le7Jg+shSRNiwD6FiSczFsxExYNPVqS08zfPewPnT+ZQXuSPT36dB9lln1docPcEc/
         /FeIOtFnbloRYz1jlFWQP90P1OwlVfyiryf2rpniGyNZmhudZeEnJBQuNZEGljflRGlq
         FkSBEp7W1zkXW8jfTYYja9a2DDfIYTSXRQ7Bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679082256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=341yOCJQSt3i3F13IHsmlZ0mEcYrW2rEkyPXLsqSxhw=;
        b=pynINGkuivn7JSi2eMWxZVdYzngESlnA2bUeAi7W3u9dZqUZ2VJSYDJO/bv8t2YVn3
         Vsu90lSncVCW+ZCGaWk0suIgYkhN4tSWccCJ7aA3W840ZKkBmcihgdjhUwYrENw+T4TI
         uQnLbeef4axgiuby448ag/hzW53SJdZaNwyhCGYyYAj/QsYSdVnczGx0Ix8t0NFMRUZq
         oKGX77QoOAgDuuXWciFY0LamUW39ucXUbl5nmPWg1K6wanpoWUFyNk83s2iBEuT2yaXM
         W3t/hhWMr74scG4vpcEq/ennMeH7Ak2ilm30lRnSlIqvy2QGNjY+0/B1T3P+JEMKnJFp
         6a3w==
X-Gm-Message-State: AO0yUKUW4gOJ6iky2HBzPe9EBLxEJ8Eq/GOY/2qPqPhII4W5LsG3ogiV
        Nn8znitmf38gZ7u56MQ4kpY9Ng85ejmsI1usj7Y=
X-Google-Smtp-Source: AK7set/60T9owq2KRRh95IJ85Hkd46seE3FORmqTjanaEzIjg/6lxRl8b9VWpfTnLoyX6ugzI9kk5A==
X-Received: by 2002:a05:622a:104d:b0:3ae:189c:7455 with SMTP id f13-20020a05622a104d00b003ae189c7455mr15537285qte.47.1679082256678;
        Fri, 17 Mar 2023 12:44:16 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id c72-20020ae9ed4b000000b007461fe6d6e3sm2251085qkg.49.2023.03.17.12.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 12:44:16 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH] MAINTAINERS: Change Joel Fernandes from R: to M:
Date:   Fri, 17 Mar 2023 19:44:04 +0000
Message-Id: <20230317194404.923623-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ec57c42ed544..2e70394ac64a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17638,11 +17638,11 @@ READ-COPY UPDATE (RCU)
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
2.40.0.rc1.284.g88254d51c5-goog

