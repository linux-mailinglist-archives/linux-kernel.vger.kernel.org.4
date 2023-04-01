Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D736D325D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 17:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjDAPVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 11:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjDAPVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 11:21:45 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64A725561
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 08:21:34 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so26497347pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 08:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680362494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K5RiXiRfIkcAMC1TBQgvY4q/0BgHA+0V6MqvfT0iAvc=;
        b=M3qYVznF3OoM/sCmDwJ+hOpclUyKZFX8M54sixUtLhjDoVx18LlgqT9RypIyH6e76/
         DZBTCcwFwOq093kZWnWnjvgow+NgANudDt9CZl/IwAvJu4x2OXCVGKxPImBpoxHIx8sv
         qwX3nSVvdyuec4H5YNzumCqzX4RLvwyNL938tnTnTTi3tQEpt3nZ5IPOw9wVJm3o17tX
         +Y6+FyzqtobOy2cKVjvU4tWbUjCIgYIPa8kvnxp+dq91iBgTuLlZcWAoVqx8eZaU3jga
         3RZhXdcP83jLZGQyB9WyxjCzm64LerkEkl+tT1g7d5gSuz37Qt5XXpSIYWlk3waJDS00
         K0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680362494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K5RiXiRfIkcAMC1TBQgvY4q/0BgHA+0V6MqvfT0iAvc=;
        b=YrV52c7lUFTAXiXsvWGs4mIeELM5f9e2EhJS4qg9xuF6O2GR6rIVkzmFwm+NZRY4is
         yexcUCueGWB6gdZCqy0xT8rlnIb1q98fxJRSEdbOcPjqz/8/wTZkROvYpLc7TW7pf2M+
         Z4p2dC/ZPZPF9HhJYVfFPx9jmT81Ji+vrSNeshmKfuP4Kf5vsBESrz7TE2s++ocQq399
         H2f8+U1DeK8d/qJaQpTk6tJLbnjIuD6MBxp0WaP5/mvJaKekCOPfL6PzJgPQltpesT1e
         zMXMN4Fm5gVJDRA6sG+VrHTHCT+jYw3hgDloAQ2ICnwfB4zJezsiij+XFPirM1H7bO2s
         0rfQ==
X-Gm-Message-State: AAQBX9fi346wQZCXEHIa99M54bye2Vkv3s1tpMfx9APWCAqgAK/gN09H
        R/AjUV+X/WoRrjo/eEddqTAQX2akmS1Jyg==
X-Google-Smtp-Source: AKy350ZMEtxCM8VTjTlX4YYrq97GNtoxStfE4erbpQbzWV8h0BAhl9jbmgiEAeTYTyG8wIHGLK5FUQ==
X-Received: by 2002:a17:90b:3891:b0:237:3dfb:9095 with SMTP id mu17-20020a17090b389100b002373dfb9095mr35326480pjb.6.1680362493880;
        Sat, 01 Apr 2023 08:21:33 -0700 (PDT)
Received: from n0067ax-linux62.localnet (125-209-164-55.tpgi.com.au. [125.209.164.55])
        by smtp.gmail.com with ESMTPSA id 63-20020a17090a0fc500b0023493354f37sm6832236pjz.26.2023.04.01.08.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 08:21:33 -0700 (PDT)
From:   Prajna Sariputra <putr4.s@gmail.com>
To:     broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: amd: yc: Add DMI entries to support HP OMEN 16-n0xxx (8A42)
Date:   Sun, 02 Apr 2023 02:21:30 +1100
Message-ID: <2283110.ElGaqSPkdT@n0067ax-linux62>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This model requires an additional detection quirk to enable the internal microphone.

Signed-off-by: Prajna Sariputra <putr4.s@gmail.com>
Cc: stable@vger.kernel.org
---
Based on https://lore.kernel.org/r/20230227234921.7784-1-lub.the.studio@gmail.com/

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 0acdf0156f07..a428e17f0325 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -262,6 +262,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "OMEN by HP Gaming Laptop 16z-n000"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8A42"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {




