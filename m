Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9B26767CC
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 18:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjAURvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 12:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjAURvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 12:51:12 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C84018146
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 09:51:11 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id lp10so4936008pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 09:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DmMM8HxK/B3KbHc42TPSNl4hDLLS89ngW+LwX+9KTvE=;
        b=bBxIclhQ0tzUeSW0970bszoxoaaiwN0LzaD3cA8ywjf3YGLU+KIfPgOpuzhHS6ArJH
         7+Po0Q6kLteg0yQ9y1xwqqtTCy5eqW0C6leZwNvOGiEsnsIZ5bV51PtyqZbRNC0LCr6v
         +1OMXPR6LqtQVjwxk6eQPG8AmBQ1UJrDdD5SgjL8/ZNuzqYmBLMsRodcWyZ8fpDbD47T
         8/YPiZyExMolwDNSu43TeKflfwKf9xj+sS9m0fixMSCJx0UU7fLyXeuwvWfmWWdN7V2i
         vjuFUjIQpHAxyniBiHBTZCr+duQc5s8QWb2XUZZVQc3w3/pfmV4MA45AaeVpevHauKc0
         xVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DmMM8HxK/B3KbHc42TPSNl4hDLLS89ngW+LwX+9KTvE=;
        b=67T33t2lWGWElWG2Opw1zw6mc7We3ik6dCre5GE/vfSyf6PILWPg0OtW1Iphi3HjUI
         I+I6MBzzL3f8S20w9INZYboMpi9xjA6YnbEuoKfr+XtDwSgegunXMyPm39vUEQb4HXz9
         QcuXqptyvgCeavhsvkAf1PwV4+2wby1RtpIzrd/G5PSDteE0hH2tIVvt2Mwih1Ff6S5t
         kTvFkdRzGm9UHRn/lMmCLxlZ6y7i9exrY09OGwUKMGyaG7Vv0EvPvO+pzS676dL++XVg
         HPv1XijQdFqAzgMZthruwuE/323ERJyvKZbAKJXdq3OkvXVxLpLjR8zlbvXlIETn6Zws
         t9LQ==
X-Gm-Message-State: AFqh2kpBBfwcr/d93xAVTSEaiu00wPN0fICER6lCtFgIsj9qyfBDkxcs
        DeWx6X3RQEcQYhcDcmvodQQHhlb2yJDcJo1I
X-Google-Smtp-Source: AMrXdXtO0dWloykTBiaEeXcbi2derUFjbI+FTKWyqN7Qz04+8Cgbv4T9gU/7XtyOydzrUMbIpYPXiQ==
X-Received: by 2002:a17:90b:3784:b0:225:be98:f5b5 with SMTP id mz4-20020a17090b378400b00225be98f5b5mr19940850pjb.23.1674323470285;
        Sat, 21 Jan 2023 09:51:10 -0800 (PST)
Received: from arch ([198.211.32.105])
        by smtp.gmail.com with ESMTPSA id hi21-20020a17090b30d500b00218abadb6a8sm3666282pjb.49.2023.01.21.09.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 09:51:10 -0800 (PST)
Date:   Sun, 22 Jan 2023 01:51:06 +0800
From:   fengwk <fengwk94@gmail.com>
To:     broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: amd: yc: Add Xiaomi Redmi Book Pro 15 2022 into DMI
 table
Message-ID: <Y8wmCutc74j/tyHP@arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This model requires an additional detection quirk to enable the
internal microphone - BIOS doesn't seem to support AcpDmicConnected
(nothing in acpidump output).

Signed-off-by: fengwk <fengwk94@gmail.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 0d283e41f66d..4d46f06199ba 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -227,6 +227,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Redmi Book Pro 14 2022"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "TIMI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Redmi Book Pro 15 2022"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.39.1

