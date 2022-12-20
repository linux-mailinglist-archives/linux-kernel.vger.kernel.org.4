Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30736651DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 10:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbiLTJmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 04:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbiLTJl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:41:56 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9785310DF;
        Tue, 20 Dec 2022 01:41:55 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 62so7947965pgb.13;
        Tue, 20 Dec 2022 01:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLpWFlG8mxCCWcewzRCKKTz15AMme8ZuJhE5IEg3io0=;
        b=pr5onYIpgIwqxyD1wGQPdnZ1iGEXKVapyWpDEbM01PRH1XCZBF6M9gt9A2zgqNw+Rz
         7lQSoynKI5RzwiW3YL8T4e11U0t8ng2R2brQYM8d/MKxt4Gw2B9xaG1LpEf763qmz21Z
         +XpQDbWcAA3CgcbAeqgPZ0UmZcfPQ3K7rAoOM5nk8hOoo0c3abWUvuuKI82LrXD0jr6H
         h2TbnnHbQtMauIdEmsncd78226zA02iG78V2qnuzyck61lQxducp7bI+Ckt2j2L+JnYO
         kT1aidxZVuucSA+k6sjhNsb6U3XI3bnaZP6Rz5bzF4YnSS4+/HfiNpes9OHOI9pVijCV
         sR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLpWFlG8mxCCWcewzRCKKTz15AMme8ZuJhE5IEg3io0=;
        b=NGYKw9s9QKBfe72asE8KINu4PwUMO0XHjE/WvurXaL7lT4UBaJd7R1kgdIqIueObpp
         tdCcSkdgyJrpuqL1CyyZU4vh2cxufyTvtvFcYH/aaa1pscUHBpAfoFkUMPOVfyQFNE9h
         DNugl52oEzEG78kF0YYeeROVgcOZRRC2hIS5COczvcVlwgyfrnKVnkj2exBA8qdKwPQq
         mWf994SP33MeZArZoX02+8SMBKWcf4HD8lNxB/UVurrbs/43n230MfHCzu9KmaQnMMwB
         0f7pgcMHDSADwwBWOIMg97iZEANYfFZeJOCvEjzzvQIGlHIV97CHZeBj0JzI8JddGk16
         qhzQ==
X-Gm-Message-State: ANoB5plovJr/J6TxZzDz2Bmzrcj3hNz/feV+ZPeuURr6rmUlNBXXVTCA
        AZi4q5wsZ4zToJzx9u4e2IY=
X-Google-Smtp-Source: AA0mqf5Z46defw4uXeAOP4+3taG47dB6NazuRKQBQrvkUMs8BDqxqrCwwynxHZN5UYX91iJ2vGMSQw==
X-Received: by 2002:a62:33c4:0:b0:56c:7216:fbc6 with SMTP id z187-20020a6233c4000000b0056c7216fbc6mr40481807pfz.30.1671529315156;
        Tue, 20 Dec 2022 01:41:55 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id b17-20020a621b11000000b00576a89978e5sm8210230pfb.63.2022.12.20.01.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 01:41:54 -0800 (PST)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrzej.p@collabora.com
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kflin@nuvoton.com,
        Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v9 5/7] media: v4l2-ctrls: Reserve user control base for NPCM video controls
Date:   Tue, 20 Dec 2022 17:40:53 +0800
Message-Id: <20221220094055.3011916-6-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221220094055.3011916-1-milkfafa@gmail.com>
References: <20221220094055.3011916-1-milkfafa@gmail.com>
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
index b73a8ba7df6c..aa5c9f64f1d6 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -199,6 +199,12 @@ enum v4l2_colorfx {
  */
 #define V4L2_CID_USER_ASPEED_BASE		(V4L2_CID_USER_BASE + 0x11a0)
 
+/*
+ * The base for Nuvoton NPCM driver controls.
+ * We reserve 16 controls for this driver.
+ */
+#define V4L2_CID_USER_NPCM_BASE			(V4L2_CID_USER_BASE + 0x11b0)
+
 /* MPEG-class control IDs */
 /* The MPEG controls are applicable to all codec controls
  * and the 'MPEG' part of the define is historical */
-- 
2.34.1

