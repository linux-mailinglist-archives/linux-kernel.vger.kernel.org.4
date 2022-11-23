Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B866355EC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237650AbiKWJZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237603AbiKWJYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:24:45 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374ADC67D3;
        Wed, 23 Nov 2022 01:23:15 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 71-20020a17090a09cd00b00218adeb3549so1304170pjo.1;
        Wed, 23 Nov 2022 01:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1KGy9n58ZkZbS12xnuR7faOBWPURlhUbJkhTIBbBqs=;
        b=ke+Z+JBfOqu2kGtngliDyo225zh79bEMbrNGsp/Bz0wyGFLte/9kT35A0TsxWQyhAZ
         J4THCGI/d/e46n/S3dR3WSYx8n76+ZQzDgbPX2ssu5sMArgqmzdEuXaPHGe01hUfxY3v
         dQYnkM98QJqfMGEJZMNFpllDJV7goX8wuCAfpQ83QxFEKRq6/1n1tdjvxoVo1vXNwI9I
         1HPoc7xlPC4WrrjtsVUr1LtMPJThQIgBgRtYxx+Qv8goOmRgI8l9YsnBvnUQUqYbjeQY
         NzD7dVFxlFfJAT6Xw2hmc36i6qsnzdPZPCWTYWKrmIQ3aiBSiOmmGh0MMluKiJ0oXyKm
         fPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y1KGy9n58ZkZbS12xnuR7faOBWPURlhUbJkhTIBbBqs=;
        b=2JJdXDTPS1ykqDLGqT2JrV/H5adcNUEWie+CrA5jTcAieE4uZG2K1G67/WODwVmsol
         sA9r9rEf4KaDdh9nWlRe7kCiDXoUPRZYfOXp+0kYWycQ1f/bJxWLDAbvGzCMGdJWM/oX
         BrvCg9Pk6C02EJil8JNIgAAXnSsyawBgpZY5LgzNbFRPwHO5cRv5S75rOKaA8BqrqzHM
         0aFtExI5X9LGiC7y9BYAD0h2LJqJRJioLDaxLW7tOzzCH6bf+RFeh1q6HVQYqNa6yj2Q
         08muhfWstzkzTo6UcIaWSgDb8YZUK66ar4u+NZEHdoAYjYfX1bJS/ruAIy3wnxLYkACv
         YgUw==
X-Gm-Message-State: ANoB5pnyvnbwH9Z7r4XqZSO09jbDudB5LYcSmiovW4wz3aTQIZf7zOqk
        45L4psCzY/39PP/1pHXQI8FHyN0OsiU=
X-Google-Smtp-Source: AA0mqf50wYGXZE1SGuXOcnhys5cudkZ3dda8hH0o7UHEtYXHQ/PBWXsmbxy2cjyt11AmRJbOoktn6A==
X-Received: by 2002:a17:902:cf05:b0:188:53bd:878a with SMTP id i5-20020a170902cf0500b0018853bd878amr7856859plg.12.1669195394554;
        Wed, 23 Nov 2022 01:23:14 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id x10-20020a17090a294a00b00218b8f8af91sm946469pjf.48.2022.11.23.01.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 01:23:14 -0800 (PST)
Message-ID: <b74e2e19-0317-e717-cc15-a7854b04adf4@gmail.com>
Date:   Wed, 23 Nov 2022 18:23:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>, linux-doc@vger.kernel.org
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH 1/2] docs/RCU/rcubarrier: Adjust 'Answer' parts of QQs as
 definition-lists
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "Answer" parts of QQs divert from proper format of definition-lists
as described at [1] and are not rendered as such.

Adjust them.

Link: [1] https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#definition-lists
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 Documentation/RCU/rcubarrier.rst | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/rcubarrier.rst b/Documentation/RCU/rcubarrier.rst
index 5a643e5233d5..9fb9ed777355 100644
--- a/Documentation/RCU/rcubarrier.rst
+++ b/Documentation/RCU/rcubarrier.rst
@@ -296,7 +296,8 @@ Quick Quiz #1:
 	Is there any other situation where rcu_barrier() might
 	be required?
 
-Answer: Interestingly enough, rcu_barrier() was not originally
+Answer:
+	Interestingly enough, rcu_barrier() was not originally
 	implemented for module unloading. Nikita Danilov was using
 	RCU in a filesystem, which resulted in a similar situation at
 	filesystem-unmount time. Dipankar Sarma coded up rcu_barrier()
@@ -315,7 +316,8 @@ Quick Quiz #2:
 	Why doesn't line 8 initialize rcu_barrier_cpu_count to zero,
 	thereby avoiding the need for lines 9 and 10?
 
-Answer: Suppose that the on_each_cpu() function shown on line 8 was
+Answer:
+	Suppose that the on_each_cpu() function shown on line 8 was
 	delayed, so that CPU 0's rcu_barrier_func() executed and
 	the corresponding grace period elapsed, all before CPU 1's
 	rcu_barrier_func() started executing.  This would result in
@@ -351,7 +353,8 @@ Quick Quiz #3:
 	are delayed for a full grace period? Couldn't this result in
 	rcu_barrier() returning prematurely?
 
-Answer: This cannot happen. The reason is that on_each_cpu() has its last
+Answer:
+	This cannot happen. The reason is that on_each_cpu() has its last
 	argument, the wait flag, set to "1". This flag is passed through
 	to smp_call_function() and further to smp_call_function_on_cpu(),
 	causing this latter to spin until the cross-CPU invocation of

base-commit: 741cfda870057958c53f9cb0b21ac33f531baaf4
-- 
2.25.1

