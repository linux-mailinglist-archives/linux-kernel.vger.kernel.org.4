Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD016337B3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbiKVI6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbiKVI6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:58:05 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496CEA456;
        Tue, 22 Nov 2022 00:57:58 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id 4so13043496pli.0;
        Tue, 22 Nov 2022 00:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97ilrjfj8pUFRe5S094ixQpLdDuhbA3k3+0nRBAN5U0=;
        b=CC1vrTs0jqiiMpEXcZ4i5eqqQB/tYQhbhlWJMF46zAmUtEkk8/b35yKEXFEBJfd3sQ
         zvIUwypclkY4g16aIetRdZtJimuO9mSmV7T3JtPRzfqwk+Z5YBJEqfVdAaoGJZOa4qWY
         INOJBrcMdUf8Gsw3AnW2pZIeURTyBbkQoEYJNMovMBDiw/s5fuW+GHM3kXlKKgvJZpNT
         D8XpYfVLLODmInZXcfL35aRHBhwK2V4g1eyz358UD5GrbyrKAbajBz5sZXfXBGEfWLvT
         H8lhNXlLDsAgJzKydLJftSmDJohWrQqHR8pCQHW6D5Fe5frHFwLhc1HKCD7gTc7b4yv+
         QKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97ilrjfj8pUFRe5S094ixQpLdDuhbA3k3+0nRBAN5U0=;
        b=pJldj4Be55qnU4mdyII15BZzjYYjZyFfvUk711aGoJ1dHvR2jRmV5jPYBKQ5moJyzf
         MNuELoIQv46kcn06Iolq1b1li/X1LTzeFtUNOPXfQcUo8UtkdR0bO+wJQdEAF7d9Fb3W
         qTT2LIkLkypp/h6VCD+MT82wpX5Y1hinByKJAtYxsI8x055qSBvMvqAnaJWm3RDZgDSc
         zcMcGapvtsWjwtJrZKuPXBkNpjf9q0J5/XkW9tsXqY1H6oCq6n+ZwyGXqDpj8G6IHA9e
         VpRmkgMx5iXjnU9Ii8mf+Qy81sFGs8L1sq54M45ytfSwT5x5RT/42WqxmQmGAhKqVHLn
         6sPQ==
X-Gm-Message-State: ANoB5plI01VfwFcLkTdAPoQORM7+X6iSxg8vfHjnnKxrj6fA7wSWrjF9
        SBgpDj85OksDa9dDGWfGjRU=
X-Google-Smtp-Source: AA0mqf4wz0jzAquNQgvEp2rOnBEUe5yNnzaalWrc4n3aFVS+kHpIjryTUmQTZd3zxnXs57BE1XoucQ==
X-Received: by 2002:a17:90a:5d0e:b0:202:c5cc:15bd with SMTP id s14-20020a17090a5d0e00b00202c5cc15bdmr30633786pji.235.1669107477704;
        Tue, 22 Nov 2022 00:57:57 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b0017a0668befasm11400246ple.124.2022.11.22.00.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 00:57:57 -0800 (PST)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v7 5/7] media: v4l2-ctrls: Reserve user control base for NPCM video controls
Date:   Tue, 22 Nov 2022 16:57:22 +0800
Message-Id: <20221122085724.3245078-6-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221122085724.3245078-1-milkfafa@gmail.com>
References: <20221122085724.3245078-1-milkfafa@gmail.com>
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

Add a control base and reserve 16 controls for Nuvoton NPCM video
controls.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
---
 include/uapi/linux/v4l2-controls.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index b5e7d082b8ad..9623ba378295 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -231,6 +231,12 @@ enum v4l2_colorfx {
  */
 #define V4L2_CID_USER_DW100_BASE		(V4L2_CID_USER_BASE + 0x1190)
 
+/*
+ * The base for Nuvoton NPCM driver controls.
+ * We reserve 16 controls for this driver.
+ */
+#define V4L2_CID_USER_NPCM_BASE			(V4L2_CID_USER_BASE + 0x11a0)
+
 /* MPEG-class control IDs */
 /* The MPEG controls are applicable to all codec controls
  * and the 'MPEG' part of the define is historical */
-- 
2.34.1

