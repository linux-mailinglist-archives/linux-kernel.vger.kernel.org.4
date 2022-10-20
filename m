Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20EF605F76
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJTLzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJTLza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:55:30 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397EA133323
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:55:29 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id r14so33130095lfm.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LsYCCTAqbxl1nYegcA6XVTC9x8A8DOyUVzkeALJAq+8=;
        b=NBtRzRBtf3CHp+ZqCc1ugzJAxtf+FQVKg2znqKAHKcyqQD28FLc1pZigowJDa5b4cx
         T14yJBOg6h/DCw82V1QIGM5NujztBo7z5POKBdEh5+GvZIpQO2i62wrTbaUya4zjj0Jw
         nGJDa6LGC2eIuoWcU+F57K/9Qxd4SMDa/bgId48bb9tHTIDzwE95NvzZQyMscY4iPcD6
         UZwmxGMzeB2fHWb5jDfOtSSwUjZ3KGnLsHuHwaicwmoEa7hdVRhuEFI3rTONtWv3Ijlv
         OvKXGcaJibok55AsceVFipb8FoGx2bs8Kyk/0c5y0e2+o4xRRqSkc+sJnYg66ADBpmj8
         VOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LsYCCTAqbxl1nYegcA6XVTC9x8A8DOyUVzkeALJAq+8=;
        b=xeQoBKM0j7hZjCKUy17HAwfcIwMZyY9UeilZYY/NXWdhc9L5iKHxoxu3P8TQF8fu+h
         V2B9xHorqwNNF3ipdPjJbc6tQn+u8bJ1KojHnCtOwopfckgzkqWxavUEDwIHc/cpDqyP
         5JmMzkTgfOMpg6ZXloNzfWltsACNxl+i086yuuszS3p+I6tGVejsbso2EcqKxR8A7sje
         fbVpyFYUq2RhGCSxEzZljYKk0ncvEUDFmrl/g23v/J5VZpFhMhWw7d+zxicr36vCdAF1
         j0NDru5iSRVuL9DkHkrBqmBeIfYEMgym4EbTgkEY7bt1rVL7WMuCIqd8mk6Gt17i64i2
         4ehQ==
X-Gm-Message-State: ACrzQf0z2VeTIsA00GiyYuObysDmY/C95qZgVYZ6KwlDgvMG4Y8MGIT0
        fKKxhLlWrl/s1Toht9SDgX9dFw==
X-Google-Smtp-Source: AMsMyM5ipN3ArP3zHYOiQQl4eLE64TxXPn3wOxrn/2+hiWFMuiv5mEYk8Kq5Z/mO5CmICg29fehyZw==
X-Received: by 2002:a05:6512:40d:b0:4a2:d61d:6c82 with SMTP id u13-20020a056512040d00b004a2d61d6c82mr4378263lfk.381.1666266927538;
        Thu, 20 Oct 2022 04:55:27 -0700 (PDT)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id s16-20020a056512215000b0049adf925d00sm2701626lfr.1.2022.10.20.04.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 04:55:26 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpuidle: psci: Extend information in log about OSI/PC mode
Date:   Thu, 20 Oct 2022 13:55:13 +0200
Message-Id: <20221020115513.93809-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
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

It's useful to understand whether we are using OS-initiated (OSI) mode or
Platform Coordinated (PC) mode, when initializing the CPU PM domains.
Therefore, let's extend the print in the log after a successful probe with
this information.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-psci-domain.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index 821984947ed9..c80cf9ddabd8 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -181,7 +181,8 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 	if (ret)
 		goto remove_pd;
 
-	pr_info("Initialized CPU PM domain topology\n");
+	pr_info("Initialized CPU PM domain topology using %s mode\n",
+		use_osi ? "OSI" : "PC");
 	return 0;
 
 put_node:
-- 
2.34.1

