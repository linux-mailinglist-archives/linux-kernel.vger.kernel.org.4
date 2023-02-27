Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52936A4FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 00:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjB0Xtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 18:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0Xti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 18:49:38 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B48829E2B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 15:49:32 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso4931181wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 15:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1RmGHrJS0CdMHCznjZxbk3tDqwQcVokCoUIpr6DAOEI=;
        b=i6C5R8HSVhydMGiWEqUzXtK49WziOZJsqrBIwxrYGvymjIVGTcOp0O8137EbwkHFDK
         QeRdoSAebhHQwg3cDokGpGxxKhaEHW4VUPv6PwrmoFO9KAmcAw3GdAoTzjCqjKnG8fpb
         FpEUT4Rxg7AVCLZCgSNC8DRaU6G7dqMEeS3/Bl68bnnMzK5yFWNvWBf4Z60zdyAfmQCx
         3kcAkr3Lyv5NcG4o0/PyRIPcCkmna4Oie0L7eb1rHUzkO3rVsIMn2B5UkqEjsfsmqDtY
         STdN+MF0dzeoBnorZtAbsUR6gH0sVYWsOk05SpSsRszuBbGsK9ES4iOFE+F9QpPgEjiN
         XK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1RmGHrJS0CdMHCznjZxbk3tDqwQcVokCoUIpr6DAOEI=;
        b=jFAGDUuPjfIHpxCe+Jmqcr6oLSKxIjHfb6IzIW8flJ7JlNl+sV7wK2wYmZg/XLHDv5
         aXM7dtdIV+xN8z9f2ESBwarkv6SJfqT+OZeuX3skXe5Vbg5UTUbDX0Dxfovuzg6NcJBq
         x7E2Vdo55RrO5yAaZ0If5Jeb34+q4BfMelB9pa9eDZtkW5x69l5TAHt8T+KsPZPKP85B
         WIyOE81/ENO+9P6l9ykcYFtt7cDiCyNHxEty5njWUt1YvGjPKRpc3ErwZPv+SUjBn2d3
         vZRdNEnQhwyLJqY2iFdai4odh2vWr1yHHepRko7rWdnKOx70LMelFx/cJx3akwLIxT5j
         BkWw==
X-Gm-Message-State: AO0yUKUP9PuTp+ojck/OH2AXJNp6Lp9kMcu+2lxVgwv0Z5GCcWXd8oIW
        sxyRrLT9j3FL/iUqI5m3VT2962JSpbRjew==
X-Google-Smtp-Source: AK7set/1CgH8bnhHkVG2+skBvkiQIEjx38OKqAP+hJncaUgOipM6V/zyl1ks2KzWQ/A5PTD3ZUKYVw==
X-Received: by 2002:a05:600c:354c:b0:3df:9858:c03a with SMTP id i12-20020a05600c354c00b003df9858c03amr7646124wmq.15.1677541770144;
        Mon, 27 Feb 2023 15:49:30 -0800 (PST)
Received: from ducanhle-OMEN-16n0.home (2a01cb058424d4006dccd80de8a63aa6.ipv6.abo.wanadoo.fr. [2a01:cb05:8424:d400:6dcc:d80d:e8a6:3aa6])
        by smtp.gmail.com with ESMTPSA id fc19-20020a05600c525300b003e215a796fasm11767472wmb.34.2023.02.27.15.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 15:49:29 -0800 (PST)
From:   Duc Anh Le <lub.the.studio@gmail.com>
To:     broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, Duc Anh Le <lub.the.studio@gmail.com>
Subject: [PATCH v2] ASoC: amd: yc: Add DMI entries to support HP OMEN 16-n0xxx (8A43)
Date:   Tue, 28 Feb 2023 00:49:21 +0100
Message-Id: <20230227234921.7784-1-lub.the.studio@gmail.com>
X-Mailer: git-send-email 2.37.2
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

This model requires an additional detection quirk to enable the internal microphone.
Signed-off-by: Duc Anh Le <lub.the.studio@gmail.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 36314753923b..baad3bce3b7c 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -255,6 +255,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "15NBC1011"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8A43"),
+		}
+	},
 	{}
 };
 
-- 
2.37.2

