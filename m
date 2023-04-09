Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0D86DBEA1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 06:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjDIEsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 00:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjDIEsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 00:48:41 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7FD5BAE
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 21:48:40 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id g12so1922667qtj.12
        for <linux-kernel@vger.kernel.org>; Sat, 08 Apr 2023 21:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1681015719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V3qp54zofXL6HqwANXHbIqSJAW5oTYcp+phuNdRg/30=;
        b=bZk6ef5UuG6O3E/Y8htUsoTwirOIIPyvE7GJK7dBhiVc2Wxdz9zT60P4FDnGVygzX9
         6W9X3MRxRnIx8wMNXcclZFzD9tH7eV6WGw/iVl70zu1nw+Mhiq90AjhykyoltjOopMEG
         7xEjbLbJlBN/UfGF0BxxORT3GeioWuyuEnp2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681015719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V3qp54zofXL6HqwANXHbIqSJAW5oTYcp+phuNdRg/30=;
        b=kvCedI+AvOL7VMQL35c1/v1r1Bk65E1N++OkNwkMbavreFvckb2QVRSIzI17Q4PeqS
         TfbzX1G8C94LhcU9wmJcuRYUl2Bmv3sdL4o6tP1d38QVVRxzUVYWzdCEeNUg388BJTCj
         l0lhU1AOt+/LmGY+QLFCMh7pSNwa26XLmjrXucYe+cWHFVcG9IPPUKfEWex15OxxUzCY
         52xky2U1M6D7XlFP3wwFyhS25i/x9wlGqDMvaPdNBNrdfrph0JcFhav5b1KoK6NYhEsA
         XQfLnJrj3OZDTZ9gbyzRzsxqFMLI/hADEykNtbhZcpCFuq5fLelzXUEltS5PAKbElm9p
         kkbQ==
X-Gm-Message-State: AAQBX9eC8rSdbgDNLn4yMQX7dWKf2OZJ8+lMbbyiES4txwG8zz/VAsRS
        E6FsQj0Q/QREMsSQM2rb3LpZ6oQ9RGHLP7tUlu8=
X-Google-Smtp-Source: AKy350ZKwQ2XEp/crMH+ihARzNWWaNa99vwdIYw+uuZwiSY9SYfDcvIJ1Kn10flzhIvD4yJPPCW+Bw==
X-Received: by 2002:ac8:5f8b:0:b0:3d9:307e:8b with SMTP id j11-20020ac85f8b000000b003d9307e008bmr5937947qta.35.1681015719372;
        Sat, 08 Apr 2023 21:48:39 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id z63-20020a376542000000b007417e60f621sm2421270qkb.126.2023.04.08.21.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 21:48:38 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-arch@vger.kernel.org
Subject: [PATCH] tools: memory-model: Rename litmus test to avoid confusion with similar-named test
Date:   Sun,  9 Apr 2023 04:48:22 +0000
Message-Id: <20230409044823.775760-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
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

In order to differentiate the test
Z6.0+pooncelock+poonceLock+pombonce.litmus from another test that only
differs by a capital L, the following file has been renamed:

renamed: litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus ->
litmus-tests/Z6.0+pooncelock+pooncelockmb+pombonce.litmus

This change should help avoid confusion between the two tests.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 ...mbonce.litmus => Z6.0+pooncelock+pooncelockmb+pombonce.litmus} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename tools/memory-model/litmus-tests/{Z6.0+pooncelock+poonceLock+pombonce.litmus => Z6.0+pooncelock+pooncelockmb+pombonce.litmus} (100%)

diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelockmb+pombonce.litmus
similarity index 100%
rename from tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
rename to tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelockmb+pombonce.litmus
-- 
2.40.0.577.gac1e443424-goog

