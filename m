Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53C067D048
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjAZPdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjAZPds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:33:48 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C1CEC47
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:33:47 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9CD9C3F2F8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1674747225;
        bh=QSepvCE+QvU8qyq2q6n9pYjju+rfRtTHn1zPijhNAtQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=jFM07lZ9N602ZtRGn2jqQIdVIV9kUsZfPmvvGutzWkERD7OZD4tZYa1+zXfcEM0G5
         lmgz6OWcNhO0hhhICxoIxKuW1nc0IBinPHbu3SHWaq71cg1vWLneOMPB5REac5cxLl
         YOu0Q+20aBX8L2COTLFz6ImfQfOO48dxgpZD7d0s30FT/CjKz6/Rg5Rf/zbjfVKNRX
         ui/8gwBxEje6zdigegfie3mcmH1hTfdhaoS/g8Lqi35R5lWDOVDXHOg74NnVS5//5Q
         OzCaYTEAtt5xGAbaQPfnyOJRLWB7aY7zFriwufY1NQB2F1h99XqbJxdiPMAiSnXQFy
         mOFb04/nwz/1w==
Received: by mail-ed1-f71.google.com with SMTP id y20-20020a056402271400b0046c9a6ec30fso1636032edd.14
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:33:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSepvCE+QvU8qyq2q6n9pYjju+rfRtTHn1zPijhNAtQ=;
        b=aps8T3AzxdFxoGEUFbWAKi31bfBx8nzqYUGHDbwseA6+4U+VZtA30lsS+SZM1b8vsg
         5bezH4qZfzfy6pGTB5v+QF/o9Eg/q5OfMnCgwv1WnywTrJO+8LTSThIuTGisq/i9yIDe
         fZgXmIDAPSAApb/d3LCnpTBgt9/B3cJ36N1pkAgfDnkV3R/ABWiiIOmGY56R5x5x0Lu7
         Z+kc30nI2jB7IoXhtLyv/phDtdH+o1ThAFTfI6X4eKvoGiu9+ehK1F0l+fjDPTcZxlwQ
         Z3TF/t8mL8kdhcHHMw/C64b1hTCM+tCbgOHywROokM0hXLTcj72k66yWj0zpHA2o44Dq
         UhEA==
X-Gm-Message-State: AFqh2koO9JWVOo9KWdB41ufMHxRBBhxIW7IVzHxq84QEGXJJnF6a/eHz
        SfDPBJVirCSDqQ3SoVMAyyRLeh8LZp/Q1wWrY//t2xW3CbhhTguGvmTCmeMHFfTcq/E2Q2jah7g
        IMXMmihFiLAy/qP2XxB7kvIrrFFnvyd7K+JgokS6NtA==
X-Received: by 2002:a17:906:25c5:b0:84d:47e3:fe49 with SMTP id n5-20020a17090625c500b0084d47e3fe49mr35905485ejb.39.1674747223481;
        Thu, 26 Jan 2023 07:33:43 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsAha39SMJh+dIs31L8P5oRWYkNCJsasKCeyOKDBVSTao7E4ia4lwRK4rgCwDXA08+pLu3zqg==
X-Received: by 2002:a17:906:25c5:b0:84d:47e3:fe49 with SMTP id n5-20020a17090625c500b0084d47e3fe49mr35905463ejb.39.1674747223261;
        Thu, 26 Jan 2023 07:33:43 -0800 (PST)
Received: from localhost.localdomain ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id ec14-20020a0564020d4e00b0048c85c5ad30sm876174edb.83.2023.01.26.07.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 07:33:42 -0800 (PST)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     juerg.haefliger@canonical.com
Cc:     gregkh@linuxfoundation.org, jbrunet@baylibre.com,
        khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, martin.blumenstingl@googlemail.com,
        mchehab@kernel.org, narmstrong@baylibre.com
Subject: [PATCH v2 resend] media: meson: vdec: Add MODULE_FIRMWARE macro
Date:   Thu, 26 Jan 2023 16:32:58 +0100
Message-Id: <20230126153258.1558471-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220818064810.17856-1-juerg.haefliger@canonical.com>
References: <20220818064810.17856-1-juerg.haefliger@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The meson-vdec module loads firmware so add MODULE_FIRMWARE macros to
provide that information via modinfo.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

---
v2:
  - Drop duplicates
  - Add Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/staging/media/meson/vdec/vdec_platform.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/staging/media/meson/vdec/vdec_platform.c b/drivers/staging/media/meson/vdec/vdec_platform.c
index 88c9d72e1c83..70c9fd7c8bc5 100644
--- a/drivers/staging/media/meson/vdec/vdec_platform.c
+++ b/drivers/staging/media/meson/vdec/vdec_platform.c
@@ -280,3 +280,12 @@ const struct vdec_platform vdec_platform_sm1 = {
 	.num_formats = ARRAY_SIZE(vdec_formats_sm1),
 	.revision = VDEC_REVISION_SM1,
 };
+
+MODULE_FIRMWARE("meson/vdec/g12a_h264.bin");
+MODULE_FIRMWARE("meson/vdec/g12a_vp9.bin");
+MODULE_FIRMWARE("meson/vdec/gxbb_h264.bin");
+MODULE_FIRMWARE("meson/vdec/gxl_h264.bin");
+MODULE_FIRMWARE("meson/vdec/gxl_mpeg12.bin");
+MODULE_FIRMWARE("meson/vdec/gxl_vp9.bin");
+MODULE_FIRMWARE("meson/vdec/gxm_h264.bin");
+MODULE_FIRMWARE("meson/vdec/sm1_vp9_mmu.bin");
-- 
2.34.1

