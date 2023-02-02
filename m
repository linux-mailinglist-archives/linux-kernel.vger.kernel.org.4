Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0831A6889D2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 23:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjBBWeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 17:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBBWeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 17:34:15 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5EA68AD2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 14:34:14 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id bn10-20020a056a02030a00b004da3651ff4cso1635240pgb.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 14:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dHYTUHZ8SljeUpfYx0Af13LEtqVRaVyIcAWcaM3M5WQ=;
        b=I/Jz7ePL18BdC75UYYW8y+xqrtgsO4ZgRjhlqBdH9sYeHDOxQsgeRUHzNF6LNs/F7v
         4OipkPn3QzZTtSmns1wX7NmgOzGouFkfRS4KF5WnM789ageXhDWCobNeCgwd+VhHM3ir
         PvJFC/Wtx9kHkGtI1dwtA1SikbHe0rXNuzI3aN4LmDn/mIZIx5I5HW0u5mployOx4lcM
         Ri6QruxqZ1lCjXC8dHbH7ww1jiBWxgPIfWYMtr8sfrWahfFugXtAUnP8i4nkGB+//YmQ
         mRNhlORIzSR9YtZIw57shpojkEO3V9zUZp2s868j0vK7Fs4TgycHIygcJRAahwTXlXX4
         g4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dHYTUHZ8SljeUpfYx0Af13LEtqVRaVyIcAWcaM3M5WQ=;
        b=RGYEcAdeY+1rWSN6eoQlIMFnSOkPnM6pesWDr6qAfNaduBcPT/uUQZIHrv5dWvZgme
         V425jkMC7FgbRXdINY54ibScbqQUMPi06Jjb32wA12PgDGzLocYdzcKa1w0puz41CdW2
         VEEYPsiNHLGo948MgGw/Et8K68Tbtwizw4/zoyg1PlIEV74WnzuphsVQfB1fk/UEKWYP
         ItUph9Ji8YTIISlNHxoS+PwL5REg0/BjEvdpR98wsVqbfNfpPwOEpk4cL1o2y9ib1mBL
         osnKYCYBcVGCXycq0TdqrMGNilNiSECrzd2eQZjWhB/isxk/D4t/Dqa1pJMr3GcJUNJi
         r3Lw==
X-Gm-Message-State: AO0yUKVIHDhWiFMiYOJ9lyDRvC8E7n/QB2QT3yKfJPGYVOcchhirbY2x
        Quzn1leWVo/jVl7bzQB4yr/z3KAIWQF2AEZa5qgw9SrQV7y8FQ3ppZDPK+A9zT71oUnvHhNFGvU
        5mWzvZ8VusYf9FsgxgR7G3LKlPQ8yL9bNLjNEC8YNQOudvxw3lS37857ew3CY/WFmK1m0fHU=
X-Google-Smtp-Source: AK7set9RMYaUbHwlcJotHFm562Hka36j1aOlTfNX+L6qiNuNh3oEhZbpCEonOXVo3+OaM0As3ne4X8vnr0Mt
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:902:d349:b0:198:debf:d114 with SMTP id
 l9-20020a170902d34900b00198debfd114mr6721plk.29.1675377253704; Thu, 02 Feb
 2023 14:34:13 -0800 (PST)
Date:   Thu,  2 Feb 2023 22:34:07 +0000
In-Reply-To: <20230202223409.2812443-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230202223409.2812443-1-jstultz@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230202223409.2812443-2-jstultz@google.com>
Subject: [RFC][PATCH 2/4] locktorture: Add nested locking to mutex torture tests
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds randomized nested locking to the mutex torture
tests.

This was inspired by locktorture extensions originally implemented
by Connor O'Brien, for stress testing the proxy-execution series:
  https://lore.kernel.org/lkml/20221003214501.2050087-12-connoro@google.com/

Comments or feedback would be greatly appreciated!

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/locking/locktorture.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index f4fbd3194654..27d92ce36836 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -332,6 +332,28 @@ static struct lock_torture_ops rw_lock_irq_ops = {
 };
 
 static DEFINE_MUTEX(torture_mutex);
+static struct mutex torture_nested_mutexes[MAX_LOCKS];
+static struct lock_class_key nested_mutex_keys[MAX_LOCKS];
+
+static void torture_mutex_init(void)
+{
+	int i;
+
+	for (i = 0; i < MAX_LOCKS; i++)
+		__mutex_init(&torture_nested_mutexes[i], __func__,
+			     &nested_mutex_keys[i]);
+}
+
+static int torture_mutex_nested_lock(int tid __maybe_unused,
+				     u32 lockset)
+{
+	int i;
+
+	for (i = 0; i < nlocks; i++)
+		if (lockset & (1 << i))
+			mutex_lock(&torture_nested_mutexes[i]);
+	return 0;
+}
 
 static int torture_mutex_lock(int tid __maybe_unused)
 __acquires(torture_mutex)
@@ -360,11 +382,24 @@ __releases(torture_mutex)
 	mutex_unlock(&torture_mutex);
 }
 
+static void torture_mutex_nested_unlock(int tid __maybe_unused,
+					u32 lockset)
+{
+	int i;
+
+	for (i = nlocks - 1; i >= 0; i--)
+		if (lockset & (1 << i))
+			mutex_unlock(&torture_nested_mutexes[i]);
+}
+
 static struct lock_torture_ops mutex_lock_ops = {
+	.init		= torture_mutex_init,
+	.nested_lock	= torture_mutex_nested_lock,
 	.writelock	= torture_mutex_lock,
 	.write_delay	= torture_mutex_delay,
 	.task_boost     = torture_boost_dummy,
 	.writeunlock	= torture_mutex_unlock,
+	.nested_unlock	= torture_mutex_nested_unlock,
 	.readlock       = NULL,
 	.read_delay     = NULL,
 	.readunlock     = NULL,
-- 
2.39.1.519.gcb327c4b5f-goog

