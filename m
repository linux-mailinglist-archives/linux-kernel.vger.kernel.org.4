Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40826D07BF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjC3OLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC3OLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:11:35 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0786B3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:11:33 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id o32so11008717wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680185492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/11lbx2+OLsP5+4dMf0d4+77ejtkZtCxn73BU3ygIA=;
        b=hHjrk15GcvrQeufjkpCutHUhQG02cItQfcmF1eCByAc5XP/3GRJ3l+/Z5DqtxBEpzo
         vSjKRI4KxOkNLJfwrBRBPCM3jJqrNGioGh2W6VOtTnAKcjyIaPGCsb8y9oxGycPYHD9d
         R0mHuIILIRhID4cmurz77CsOeN95ATFZet0cca6to3YDoqyHE5E0PWOt1uz//rDLNQPw
         f8SS9FRgCMPUBCYipLifK2+sXSCA/XNIjVdTLMTQP3CGbSoTtf5xp475GCWFDsO5Phgg
         7h6onpoZfL8r9xvMceXS4dGp0LssRSROyideVcC79VX2uppc/ts7Wul6RcYBxAlzUdJd
         Nmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680185492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/11lbx2+OLsP5+4dMf0d4+77ejtkZtCxn73BU3ygIA=;
        b=7fAtKeUDsW5kpZgV5Lna+wy5fGPrSMLBvKDk/xpRD6V+6HNof9NkTvQQTapH7uX4+s
         l3Md4DKozcVs1M6TLdANeviKWSctq0UtG+ncXDQe4ZNQCF+NL9Ox0FRuiplilmL+ftcI
         kylsvQDY2QenlXFJ6F/H9CPzh5Iw4NoX+PULDtMO2RtUeeBpBRkflqeorq+HVGBsL/zz
         K+vJ9Wy4YfzThemH38uP3Ci7eYdpl8votIgJ5r/jZ/lr7CXHh4sbHXfDFgHeYb4D69rB
         IUNVyqGyKHCuG8NxNRWjxTUPBwp5QwEG+nV4lauyF2AqPRdE/ag2dcVMJUXsjPZ8DpKB
         EuEA==
X-Gm-Message-State: AO0yUKWa86kJaZvGMniFZikvN64o2Vnt7PZcaut5ksmn4WVCF5FsCQev
        W+z4jeT+YwOPGr68e5wF1fA=
X-Google-Smtp-Source: AK7set+0v3qdSi/olNwk5smzxmld9SdjfWJXtXnVbwWl/UlS7cLg4FLwT34Cf0kqEwRjVI7Gm/yaYA==
X-Received: by 2002:a05:600c:2049:b0:3df:e6bb:768 with SMTP id p9-20020a05600c204900b003dfe6bb0768mr17449957wmg.24.1680185492312;
        Thu, 30 Mar 2023 07:11:32 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id b5-20020adfee85000000b002c573778432sm32761705wro.102.2023.03.30.07.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 07:11:31 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     hvaibhav.linux@gmail.com, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH 1/2] staging: greybus: add a single exit path to arche_platform_wd_irq()
Date:   Thu, 30 Mar 2023 19:11:24 +0500
Message-Id: <e670baa9bde47a3bdb02e59ec37a438a62c52dd1.1680185025.git.kamrankhadijadj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1680185025.git.kamrankhadijadj@gmail.com>
References: <cover.1680185025.git.kamrankhadijadj@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arche_platform_wd_irq() function has two exit paths. To make the code
more readable, use only one exit path.

Suggested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/greybus/arche-platform.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
index fcbd5f71eff2..a64c1af091b0 100644
--- a/drivers/staging/greybus/arche-platform.c
+++ b/drivers/staging/greybus/arche-platform.c
@@ -153,6 +153,7 @@ static irqreturn_t arche_platform_wd_irq_thread(int irq, void *devid)
 static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
 {
 	struct arche_platform_drvdata *arche_pdata = devid;
+	irqreturn_t rc = IRQ_HANDLED;
 	unsigned long flags;
 
 	spin_lock_irqsave(&arche_pdata->wake_lock, flags);
@@ -180,9 +181,7 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
 						WD_STATE_COLDBOOT_START) {
 					arche_platform_set_wake_detect_state(arche_pdata,
 									     WD_STATE_COLDBOOT_TRIG);
-					spin_unlock_irqrestore(&arche_pdata->wake_lock,
-							       flags);
-					return IRQ_WAKE_THREAD;
+					rc = IRQ_WAKE_THREAD;
 				}
 			}
 		}
@@ -204,7 +203,7 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
 
 	spin_unlock_irqrestore(&arche_pdata->wake_lock, flags);
 
-	return IRQ_HANDLED;
+	return rc;
 }
 
 /*
-- 
2.34.1

