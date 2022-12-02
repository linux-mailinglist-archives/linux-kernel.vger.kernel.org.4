Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200BF640FEC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 22:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbiLBVWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 16:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLBVWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 16:22:45 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DA723160;
        Fri,  2 Dec 2022 13:22:43 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id o12so6056780pjo.4;
        Fri, 02 Dec 2022 13:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5nNMX1EahXRoqcP+r5gLnG0D7xor4fKiUSWKgh5Q/4=;
        b=iF6aQCrc27Tg12HtqUiR1ke6C24qgHRrOpSxTml+BlnWk/RPCOeiPl+y0Xl0hXWseR
         gt9uX0ElepD+ehy2efag1UlINkEnUEf7loh/3eoX5DMWE4Tkczjvh4Uv2FS0AIuoQkvA
         G4J7mu2VZ6va38Dy4PfNUtRfOYoNhI20+iSRA76vgVf+coD5J33U/wOXQi0h6M6IbfBU
         fIsCbWZObsNYxFQIGrccDztO/Xn8ZaHl289Uwvxa1emcI7k61K+riaoBYtjy7M9SBX2C
         3DeFYEiYmZfZgNEbzX4k290tl13wpText2g5lEawkBbaOT6j47fN2HSxvT3rqq+wkC/S
         sWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5nNMX1EahXRoqcP+r5gLnG0D7xor4fKiUSWKgh5Q/4=;
        b=GyHW/5X63Ku/dLZt+r+GLUevPYg4tDUwa1AP6QLyi2mm2XoW3AxZfKX1XBFCvt8a6w
         hpPUJXHPbRH+vcp35dY2W/7pmexOIt2Er6LLBohsjcg1IKE+SIv0cjUFTO/loHpgcAMp
         IUCRE/nUgE7yOCR3COcvHu/vBwC9K9rgo4d6weiu/KlwyyRfVz+m4XdcLtamvV4g4dXm
         uICgsvHawitt8a9nNGihHixE1MELvdfaZigO7b4wd/AagL8fN3bG/iETrQ7oSOHDbyWh
         bKeFbeBwBHk0pteemFpdJQL4cYw1mJ8i7RHhAVNlI0jHZ54C7+sQHtGl2YHVg9BLkwSm
         kp3g==
X-Gm-Message-State: ANoB5pnZWs1YjknMq3bSzWoucBvwXeLc/v1a7zygvISUQKdwRTdpKxvN
        io/3nmHcxn7CHhScbhyaMtk=
X-Google-Smtp-Source: AA0mqf4FDRZuxra7lB45oD3I+9L9Kg8sy7m0uGhT6+vY4pHnr6PBBshURE48ehMWbiyvnO3YMokcnw==
X-Received: by 2002:a17:902:cf02:b0:186:c372:72d6 with SMTP id i2-20020a170902cf0200b00186c37272d6mr67178115plg.25.1670016162652;
        Fri, 02 Dec 2022 13:22:42 -0800 (PST)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id x9-20020aa79a49000000b0056e0ff577edsm5514703pfj.43.2022.12.02.13.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 13:22:42 -0800 (PST)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     ulf.hansson@linaro.org, linux-kernel@vger.kernel.org,
        alcooperx@gmail.com, linux-arm-kernel@lists.infradead.org,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH] MAINTAINERS: Update maintainer for SDHCI Broadcom BRCMSTB driver
Date:   Fri,  2 Dec 2022 16:21:19 -0500
Message-Id: <20221202212119.43214-1-kdasu.kdev@gmail.com>
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

Taking over as upstream maintainer for Broadcom SDHCI
driver from Al Cooper.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1daadaa4d48b..90beddcf84b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18497,6 +18497,7 @@ K:	\bsecure_computing
 K:	\bTIF_SECCOMP\b
 
 SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) Broadcom BRCMSTB DRIVER
+M:	Kamal Dasu <kdasu.kdev@gmail.com>
 M:	Al Cooper <alcooperx@gmail.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-mmc@vger.kernel.org
-- 
2.17.1

