Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1A96B4BC5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjCJP5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjCJP5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:57:25 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5E2F741
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:51:36 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id l25so5478797wrb.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678463495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7rAHD7fKN+d5LXJmYh701SPQypdto2hSUjcoVGtRUMU=;
        b=cYjWkG0i0JfbUWP2Y+8Ik/AMlSn1huUyNXYTvDdE6RHDKFhVt2nokYIRF0DWg4dLF/
         9R0+rGx7j0+MavmlFqN6xyYU+e+9B+KBLBQefEMLgrpo393qK+XoMmBhipvHVfaXaR9G
         u6VmWiqKMHxd67/ALrTg3GwhF8m8BI1hEU11L7YDtWCO2c+TQECZrH6TPg5FG7Mue8Yl
         bg4cpxSAbUnTkRMYHZtPwoGfQeOgKsFx2YArU8B1yW4VHbuafP6jUc2qZH4+SCIO5deR
         hcwtgHYNCKewkThTCjYS88drnP/JOSrqX+/AKm5ML6Z6aiyGT6RdO8oxgkzefYE2179v
         m5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678463495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7rAHD7fKN+d5LXJmYh701SPQypdto2hSUjcoVGtRUMU=;
        b=8RH646m+Yx9cEs+caNJaYJ/rB3vBHzfEKzNMKj1dspWmuRF5M4o2d6mN5FxACzBbiH
         kX3qKGOSNsiX/XlYlAqMDn9ijpnidHJ8CTd/CV81/BiWgiZkxPUHXTZXOoJpKpjBQFZI
         771FBZVEniqPCmfuChZBLqb+iyqxfwUhhsm0eLn1xelxHReeZAtHnFYXafxHDdvPcj+U
         UA1MciQygFvVl0P5j4E9MeZO2u/a8qzGPSF0owK1kbW8tfOdpo5wrAUKg/jdR9nfpSUG
         isfBZ3/hpkDKLdRRHjAcyCFSotCx0W1bVnMjv8/GLJNsiAXiINCq3WpNF2Dcg37fmWe0
         jUvQ==
X-Gm-Message-State: AO0yUKX2jQD1P6s8xjANb7WqyWvP8KEmikyIV4hLAuuopT4Cl7HYuzeq
        pn8zOEPshf8AIDnc7U2J0vI=
X-Google-Smtp-Source: AK7set+d7Q+0h2RUYMfZYXj6ucr0U0beV4MqE4yhacgerLbbG6Q064+eN+N6+rJ+eBQA10OxLrmbjA==
X-Received: by 2002:adf:cc8f:0:b0:2c9:23c4:8f93 with SMTP id p15-20020adfcc8f000000b002c923c48f93mr16353992wrj.57.1678463495023;
        Fri, 10 Mar 2023 07:51:35 -0800 (PST)
Received: from alaa-emad.. ([41.42.191.171])
        by smtp.gmail.com with ESMTPSA id t8-20020a05600001c800b002c7e1a39adcsm140139wrx.23.2023.03.10.07.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 07:51:34 -0800 (PST)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     vireshk@kernel.org, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        eng.mennamahmoud.mm@gmail.com
Subject: [PATCH 1/2] staging: greybus: Fix Alignment with parenthesis
Date:   Fri, 10 Mar 2023 17:51:24 +0200
Message-Id: <b6521b9a75a4088d621246b436c7ec5d35365690.1678462486.git.eng.mennamahmoud.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Fix " CHECK: Alignment should match open parenthesis "
Reported by checkpath

Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
---
 drivers/staging/greybus/fw-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/fw-core.c b/drivers/staging/greybus/fw-core.c
index 57bebf24636b..f562cb12d5ad 100644
--- a/drivers/staging/greybus/fw-core.c
+++ b/drivers/staging/greybus/fw-core.c
@@ -89,7 +89,7 @@ static int gb_fw_core_probe(struct gb_bundle *bundle,
 			}
 
 			connection = gb_connection_create(bundle, cport_id,
-						gb_fw_mgmt_request_handler);
+							  gb_fw_mgmt_request_handler);
 			if (IS_ERR(connection)) {
 				ret = PTR_ERR(connection);
 				dev_err(&bundle->dev,
-- 
2.34.1

