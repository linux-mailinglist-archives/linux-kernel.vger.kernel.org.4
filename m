Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E419693F54
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 09:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjBMIKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 03:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBMIKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 03:10:53 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD00CC0B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 00:10:52 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id m14so11163317wrg.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 00:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ta3MBMsVl9WETNEtjkbzkIRfhDoGM1dM2ieDBX/DnFs=;
        b=KITfg+d9VfePRMusAbRZxQCq0f84Eb6hvNhOLZAhL4OjxpLP7kX97JwdWcjGStWQLA
         YOIdhkDurSpk2cgzxSSyshhYU1ksK1WNt/ZseDUXdwhX031T6V8VdAsgyEgeBGXWeeaE
         flFczKytYt3xOXjvp1uD0DuKd7s9Bgioc/0C8TD+3nyaPiJbl/HNChAKRjiaa8nBf8uq
         ccDKvOjKEApz505Mu9PFfOb4luWwmqWZZv0+OkWEgptd023uSfqbxeQEfdu81Qnk3QJy
         a37BJJXdwwOUqHvEh80IVvlEE4sfhaLnq1sQMvNOE86RH6A/9AapETBBihAdyCPe5C8L
         jynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ta3MBMsVl9WETNEtjkbzkIRfhDoGM1dM2ieDBX/DnFs=;
        b=ZpdiENcAbHMSFWGpu4xkx/KO0u1F5PQm1YKdwbwQUEkhdhzgV5wEYzbfxe5GamdntU
         Eq1s3ZGfaRzHrbw3B4tFVeFHprdXZq6jt7jQYuIrC77y1JVQpW8RJbMVMYEY9OhSmHfF
         014ONxFRWd/SJWESWqjKDsw0JurAthN6QhKanjepFvcrUYOY/TaGsN0b+82ABAt/B714
         H+T7gRK8bCEOba+Br9SP96QPB8SpOBz/c5fo9Z7RT6KrBklNaw5wgSgXDmP6qFYOnAd9
         t8kzpT+Su808FqR3PnLSeU0T8MnyT4Fu6+3NpRmeSPvE6YZwjTk7ok0+FW9E4hxW1oTE
         6O1g==
X-Gm-Message-State: AO0yUKVX7qxRbY9cgyvDldkQ5a5IJ27MOfia7T/J9ahDqwA4kKKnVzTp
        pcsNbWts1LG+DK/Kq29xCWvLrzRUPk1g6Dua
X-Google-Smtp-Source: AK7set/9DP8M07TnEguBcVq5nJR0fVpHWDoNvcyEC0ltypfRk+RNDWKB4qtHhUgRrxy9pyeJPFvSUg==
X-Received: by 2002:adf:efcc:0:b0:2c3:e07d:46cc with SMTP id i12-20020adfefcc000000b002c3e07d46ccmr20113668wrp.41.1676275851220;
        Mon, 13 Feb 2023 00:10:51 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d6d42000000b002c4061a687bsm10006951wri.31.2023.02.13.00.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 00:10:50 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Peng Fan <peng.fan@nxp.com>
Cc:     Abel Vesa <abelvesa@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: clk: imx: Add Peng Fan as reviewer
Date:   Mon, 13 Feb 2023 10:10:38 +0200
Message-Id: <20230213081038.3958833-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peng Fan will step up to help with reviewing.
Add his email to the i.MX clocks drivers entry.

Cc: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 57d1d6ecb33d..af62e299726f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14905,6 +14905,7 @@ F:	drivers/iio/gyro/fxas21002c_spi.c
 
 NXP i.MX CLOCK DRIVERS
 M:	Abel Vesa <abelvesa@kernel.org>
+R:	Peng Fan <peng.fan@nxp.com>
 L:	linux-clk@vger.kernel.org
 L:	linux-imx@nxp.com
 S:	Maintained
-- 
2.34.1

