Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D86D6BBD6D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjCOTjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjCOTj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:39:26 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29CB64B3E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:39:17 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id g9so17363033qvt.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678909156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axV3b7MOxr7kX8qyghaLBRtLrKYOLo8UOyKWzHAv10o=;
        b=dr2eaYvkOgPd0aEVBn12iOIdTI+nYzWGoFDs+yIe7nf4LdBfmjyuUqyx6BARTlwxjL
         NjDOPUlwUYo5ofycWAMbOEXXiQYNiANpL8ohKlu1F2bwYXyd7rtEx2eMzpUz4iDhO306
         OarLgjafO56s3QGKCDqYYd+/feEM7oaN7Ti+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678909156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axV3b7MOxr7kX8qyghaLBRtLrKYOLo8UOyKWzHAv10o=;
        b=7h2LZjWAaBiRVEItuBCPsh74JzmbmOmpa3yxkFB3f45yoPpAdCXonBobGak6QhEp9S
         MuLupga9RUHBNtimhk+ANeBlHcHhjv6ZQ2wDgnswsme7dzahvHiLbqAE9D3IpEgXVVFU
         HaYM2emQAmRrceK6vaZOqyqc77Ka+/4ZhP+hzyBZMiIwndgXEHIQUYFIupkm7wxx10jv
         M37TZbz9kEJ+qZ3ZRV6DUX1ODueQKHHd/xOTex4eULRvcwIL+VRi5wFSa5zurYBM4vn8
         gL/BGBafrwreU/79FSgbqdpbkeYNl0ddziLAiF3QSvQzjHmNgNqo3dxS4xxABITfyjqo
         NHtA==
X-Gm-Message-State: AO0yUKXLcOTgoLH1TrCcu1GRvauASdpNLRJVuIvE8e5t80kGmoBfpiWm
        gPsagRaHP16xBKlKc6d01qTIkSVdGFri0+UDVek=
X-Google-Smtp-Source: AK7set+jtVfX9Tlj3CkDKphbC220Zm791x7Gq+bhmf4ftIqzp6M4xdC/sqOnxIO46wsS32cUnIjong==
X-Received: by 2002:a05:6214:23c9:b0:56f:c138:2844 with SMTP id hr9-20020a05621423c900b0056fc1382844mr26775671qvb.37.1678909156672;
        Wed, 15 Mar 2023 12:39:16 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a254a00b00745af48838bsm4347227qko.5.2023.03.15.12.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 12:39:16 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 5/6] doc: Update whatisRCU.rst
Date:   Wed, 15 Mar 2023 19:38:50 +0000
Message-Id: <20230315193851.8598-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315193851.8598-1-joel@joelfernandes.org>
References: <20230315193851.8598-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

The kfree_rcu() macro is deprecated.  Rename it to its new
kfree_rcu_mightsleep() name in this documentation.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 Documentation/RCU/whatisRCU.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index 2c5563a91998..8eddef28d3a1 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -597,10 +597,10 @@ to avoid having to write your own callback::
 If the occasional sleep is permitted, the single-argument form may
 be used, omitting the rcu_head structure from struct foo.
 
-	kfree_rcu(old_fp);
+	kfree_rcu_mightsleep(old_fp);
 
-This variant of kfree_rcu() almost never blocks, but might do so by
-invoking synchronize_rcu() in response to memory-allocation failure.
+This variant almost never blocks, but might do so by invoking
+synchronize_rcu() in response to memory-allocation failure.
 
 Again, see checklist.rst for additional rules governing the use of RCU.
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

