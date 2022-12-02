Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99EA640799
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 14:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbiLBNSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 08:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbiLBNSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 08:18:46 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6102EA1C1C;
        Fri,  2 Dec 2022 05:18:41 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id b2so11487105eja.7;
        Fri, 02 Dec 2022 05:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Ca6QPpKTJOWP49HF+iF94/pyngRqhYtlzDQu2E2Km0=;
        b=Z7HcHw8RkcKlHeBQl1aaAPXZP1bfk+tKpSphCq5YjLX2nfaYrF6775w8wv+218FTuq
         Tx9wjQON91rEhZf87KfCyeN7GVE6V+JozIxJdYjRfcfqkUt/C01GxSBRbgDDN8Gdefi7
         NGxz5Jt7xIon0I9pz72f6/ZLLdWbs8Z6UdjIjJskx1QxiIrUThMk5ailM6gPQwXH/pDw
         QwqgO8uFITcBgPwKaRY6Tm3w34lm5ARN+t9r09daZf8KtSaeav0h1aeLYfLYFyGoKgwI
         rt3uoORjBPD9EuNjGG7fX6iiovn0TiLqhb6hkjIRapqLZxKE3ooLi9mpVeTuMNhtyzIH
         sitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Ca6QPpKTJOWP49HF+iF94/pyngRqhYtlzDQu2E2Km0=;
        b=r4fL8v82dn3bWe9mljsz3lU0S0/OtwM2tYHOVjqe4msPftrK/4zy9i57agG0tWff9c
         QIICOLvRX6g9c+Srxy/4lBbe9TXyEfeDVeNMJk98HsEGR7lauwC2Ty2V7DCqh3IGL4Wo
         YEldtlmFTjvJPciZzOxqCy4MaqWHGO2sMEoraADa5Nkt3Au3IY/wL35HWomAtOzj2xjM
         c23T7APxGVLrpQhiiY+CiqHujzyfl7NukYwJJbDwbXW0rCNGdZCVkKg5cMmgsyqmifvs
         8BZnEmfujkMiSZW3vK49/TT+bMsFPOKjp6GGo1cWE8YlDTeNcoiEn/v3Wm2gNlaR+RF9
         qSWg==
X-Gm-Message-State: ANoB5plZjk1WHJZqSWVEF9vtghwvGM4KX6TINq5peGHpoPssuRInw/Do
        J5ITMA8ssGWwhWYyLQ5OEV8h+WtBIAA=
X-Google-Smtp-Source: AA0mqf7ULWzC5JKX52czQP93Fd7QkmK0RbAObRCCjzci++TGCUeb9XRDe6+4VRUSt3LW3L5fgDeWmQ==
X-Received: by 2002:a17:906:a20f:b0:7bf:f0e9:1cde with SMTP id r15-20020a170906a20f00b007bff0e91cdemr20338412ejy.512.1669987119944;
        Fri, 02 Dec 2022 05:18:39 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id c10-20020a17090618aa00b007ad9c826d75sm2980336ejf.61.2022.12.02.05.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 05:18:39 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 1/1] rcu/kvfree: Use READ_ONCE() when access to krcp->head
Date:   Fri,  2 Dec 2022 14:18:37 +0100
Message-Id: <20221202131837.375341-1-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A need_offload_krc() function is now lock-free. A compiler
can optimize readers in way that they see an old value even
though writers already updated the krcp->head from another
path.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index efc79f942b30..d155f2594317 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3029,7 +3029,7 @@ need_offload_krc(struct kfree_rcu_cpu *krcp)
 		if (!list_empty(&krcp->bulk_head[i]))
 			return true;
 
-	return !!krcp->head;
+	return !!READ_ONCE(krcp->head);
 }
 
 static void
@@ -3070,7 +3070,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
 		// in that case the monitor work is rearmed.
 		if ((!list_empty(&krcp->bulk_head[0]) && list_empty(&krwp->bulk_head_free[0])) ||
 			(!list_empty(&krcp->bulk_head[1]) && list_empty(&krwp->bulk_head_free[1])) ||
-				(krcp->head && !krwp->head_free)) {
+				(READ_ONCE(krcp->head) && !krwp->head_free)) {
 
 			// Channel 1 corresponds to the SLAB-pointer bulk path.
 			// Channel 2 corresponds to vmalloc-pointer bulk path.
-- 
2.30.2

