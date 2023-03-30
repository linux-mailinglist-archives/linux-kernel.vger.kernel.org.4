Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57F76D0290
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjC3LHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjC3LHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:07:42 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C99F1724;
        Thu, 30 Mar 2023 04:07:15 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w9so74923799edc.3;
        Thu, 30 Mar 2023 04:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680174434; x=1682766434;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUvcUSL2maFaaBSn3S3B+N1vQ+lGiww/3E9Sh3I4LiE=;
        b=XR/L6KMuvqdfzfj0ZcbQF32l647H15jTcIvHBfz6xDhjvH9cz0C1inzkUPU5qo639x
         0gS+ChicsdETx7X2CO7onh4gOi+TWdkTTuQ47AypX/ELCze5wH1r/SDwIKvVQYWANczB
         M5FTrODSZmBDyFCORFHIpAFy/Zts1Sl3aIWUYza28uyyT1Yj5fpeK3vNNgnnzeZB84uz
         fglfdSFvzqyFlGiZlQlvqxMu+3mcpgpwvIlhtLP7SdplgNyg54u/GVkRHjOSNDPZDUKS
         NqpNgDv38CpQ+7s2WktokGeoEj0xVZYedD3JLI7twEKFXQuWkd/O7+zRnqj6Tp1xnuEU
         uB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680174434; x=1682766434;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUvcUSL2maFaaBSn3S3B+N1vQ+lGiww/3E9Sh3I4LiE=;
        b=IfHPp0GaqV/ottVhQ19VbvWXDo03qyo70umwhWwxa0Q61BwEbY4PaGAaRLmyC+wCRb
         jHMVAvidwmsjBdjxOlEyPy7Tsl46b/R4ib2TIe2mC4h3oZkMyELD4vM7NPtDRS2N3scR
         OJZBGsQVoco0PSGLpEuHYViQOl+G0TFO24ZeGDdNKlOWLBAPRcwcB3ZtYGPYSZiEYGiw
         dWpawdeSTPy1MhtwsBn2FfmG3oEUhJIXdQ8LF0k22V8N79KuMqtkBLx4F2cPv9vjecXk
         BcJ4Clyi4EaUF7BZGN6+W33mH8d4vE8Dns1R9j8656mkAdgzZtWR2693obSQIPE0GwPY
         cu1Q==
X-Gm-Message-State: AAQBX9fE2n3q+7u11mVKT+6FOTK7Pd2o0H/FOBNw/Ppcn1MBS07O1hHk
        SuGmaMCV4r45OI8GVNyrRfI=
X-Google-Smtp-Source: AKy350aXGZutV/g0VUXfpOrcNRiyvK90sm+wrKTZUO1EigfOVDmTjPzUsnKDigkSQHZuFNu6sbssaA==
X-Received: by 2002:a17:907:1612:b0:931:88e8:d470 with SMTP id hb18-20020a170907161200b0093188e8d470mr28703491ejc.23.1680174433886;
        Thu, 30 Mar 2023 04:07:13 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:b46b:e78:a1d5:4082])
        by smtp.gmail.com with ESMTPSA id v2-20020a1709064e8200b008d9ddd2da88sm17525697eju.6.2023.03.30.04.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 04:07:13 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] csky: remove obsolete config CPU_TLB_SIZE
Date:   Thu, 30 Mar 2023 13:07:10 +0200
Message-Id: <20230330110710.20784-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9d35dc3006a9 ("csky: Revert mmu ASID mechanism") removes the only
use of CONFIG_CPU_TLB_SIZE. Since then, this config has no effect and can
be deleted.

Remove the obsolete config CPU_TLB_SIZE.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/csky/Kconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index dba02da6fa34..1fb5f066a885 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -166,11 +166,6 @@ config STACKTRACE_SUPPORT
 config TIME_LOW_RES
 	def_bool y
 
-config CPU_TLB_SIZE
-	int
-	default "128"	if (CPU_CK610 || CPU_CK807 || CPU_CK810)
-	default "1024"	if (CPU_CK860)
-
 config CPU_ASID_BITS
 	int
 	default "8"	if (CPU_CK610 || CPU_CK807 || CPU_CK810)
-- 
2.17.1

