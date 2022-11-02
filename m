Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7927615F21
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiKBJMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiKBJLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:11:53 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7287B28709;
        Wed,  2 Nov 2022 02:11:07 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id f27so43550966eje.1;
        Wed, 02 Nov 2022 02:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAlb1kax7HoNKVQNf77d4ZzCjwa1EAZi7nCZnHO7gmQ=;
        b=kW7Gstv8G1/BMZNg//WXpApV3OoQDMXLECH/Np0uSFWFEIR+Hx5AQdjUGBY5xCyjQS
         UzB4TfT+lCA4pyxk0YwVFGBgCszHttKC3zL0jT+Veh5QcTaDLSPIopqCF/ccoWNvpyDo
         IFVZY6+T5hq5DYp4Pf54JjqZuGn/jJGpB9OzwdXan3bWVJbFnvzRGi98V7vyJ+ox/k/H
         92JlpJSDjV7qoPbT33Lj8DfCaVtDLUHUXioKMz6riDWRoi2cN7ZkzYxqRQfvkhASCSMs
         g6vyEDVXx9JEO9ely4EiFecYNoQy6O/P7JGiHxNKYQkedOD6aFJWvZyOVI6S3zKvT+dX
         EKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAlb1kax7HoNKVQNf77d4ZzCjwa1EAZi7nCZnHO7gmQ=;
        b=lEC7KAOaMCECkhCx3/qyVYuRsuoIaMuaiwR0hfT/NFfCDMJV0PPyR4DR/4q2UFi+Nk
         +nLusmRYwMsa4JX4mZUhQbjfWB8Wl93D8oNu/15B2xtA3A4JxPMDaV3bG/jgJCSIye7s
         hNwl4jhaRLS409EEMWXh/c2srlCeTx/8f6rjnT95JSE/WxaoOSWmh0VHRx9KuZ83PvJg
         gJHI0mhrAwh1ey9BXHp+w1s93dple+CfsUcym8ISqbzuyFIWS+OeLIOeC49TTLx8z6a2
         jouING974ahhazxYAXpTA1Ztz7a7C36QVGEwd11nMaX8XyLfJthFyLlxrIQOAupZDYYD
         oXPg==
X-Gm-Message-State: ACrzQf1dducJHvZ64KD6rWqFY7MOmF/FyUk95p822biq1O7hsQxF5j99
        rNPLmV0OQylimW8YiFu/eeh1IK+euMk=
X-Google-Smtp-Source: AMsMyM5WPTsGoNprGbFwhLCPYvhspYFy6eGwpy3YhnGj8i1h1uGL7+nA0L/FuDrxByuh0ay8j2udAg==
X-Received: by 2002:a17:907:86a0:b0:78d:df8b:4d17 with SMTP id qa32-20020a17090786a000b0078ddf8b4d17mr22146988ejc.254.1667380265806;
        Wed, 02 Nov 2022 02:11:05 -0700 (PDT)
Received: from felia.fritz.box (200116b826ffdf0094d0303451b23214.dip.versatel-1u1.de. [2001:16b8:26ff:df00:94d0:3034:51b2:3214])
        by smtp.gmail.com with ESMTPSA id bx18-20020a0564020b5200b00459012e5145sm5556331edb.70.2022.11.02.02.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 02:11:05 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] clockevents: repair kernel-doc for clockevent_delta2ns()
Date:   Wed,  2 Nov 2022 10:10:48 +0100
Message-Id: <20221102091048.15068-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the introduction of clockevents, i.e., commit d316c57ff6bf
("clockevents: add core functionality"), there has been a mismatch between
the function and the kernel-doc comment for clockevent_delta2ns().

Hence, ./scripts/kernel-doc -none kernel/time/clockevents.c warns about it.

Adjust the kernel-doc comment for clockevent_delta2ns() for make W=1
happiness.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 kernel/time/clockevents.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 5d85014d59b5..960143b183cd 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -76,7 +76,7 @@ static u64 cev_delta2ns(unsigned long latch, struct clock_event_device *evt,
 }
 
 /**
- * clockevents_delta2ns - Convert a latch value (device ticks) to nanoseconds
+ * clockevent_delta2ns - Convert a latch value (device ticks) to nanoseconds
  * @latch:	value to convert
  * @evt:	pointer to clock event device descriptor
  *
-- 
2.17.1

