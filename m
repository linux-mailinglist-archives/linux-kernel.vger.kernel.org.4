Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF32C5E98ED
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 07:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbiIZFop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 01:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbiIZFob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 01:44:31 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A925125EB4;
        Sun, 25 Sep 2022 22:44:29 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id l10so5227243plb.10;
        Sun, 25 Sep 2022 22:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8lLdHYxGi9wvCMlavsF7WnFaRiE9i2ATJ5/GJDTh2SI=;
        b=Htl7PBQcJL99NRcPej+Sgy0bU6SqcQoNLBxX1Ub9O+zZEQt8dwIdpaVfo6MMnVId+v
         sNGTdGaPrE5prrvgURUthS8rPx5mzDYFeQj3ni1nnMuGHd4ECKjKDULfXiFdB+TM+SsA
         7/M42PxfdLrstVUSG3AR10da1tbU/XF/f3numXa8HrUS0ib3VTGP+8aYn9uz1CC1sZGo
         LccZs4JhQ7KmSOQMq1JOuQxi88NYGJloRrnf2QzJ680bZjIxUi6ErTV3qjwXdMOSFOM+
         C5xZDvJVGsqHnVykM02GSew3GUZjBombglJOxNhbEd/aLvmb9DpXFVtIF2QBNUyOAYuC
         PIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8lLdHYxGi9wvCMlavsF7WnFaRiE9i2ATJ5/GJDTh2SI=;
        b=23b5Sopn+XltPTJCTAvrT/ndmq/Gs18UbAYQiGxoQaI9hUV4CHDXEzVcvdGl0WcGNH
         ZFx0HRP7Ve7teVQZEkDGvNXP4b6o48RlzTrCAg4340kjx28riPVbaQpw+VMrrWkEVyJ8
         dcgHnG+6ie96iCavzKYjv4fej87CHuxgUcpsVnts9plkYTI3rCIAdiMOqV2RqkaPqoa3
         sNsA1h94HxHmPtK/KK31X2zp4IwNPYsXVBgZaNtM4e57SXGmhYWlYpVHYmOW8yjtOv3+
         CNsYorQYVt6onyBIUCK3oCHuVgETmWoHtLANX9UPtNRRBSV59ftWW5Gsv+VaRSkf3pS2
         N3Cg==
X-Gm-Message-State: ACrzQf3PhG4guIXyFJbS3rGP1ilOm2pV3XevXnOeiWnq84BMuqyIa3ov
        MdqMVy0DomUMyiw8n2tQOCuZ3xFaaf8=
X-Google-Smtp-Source: AMsMyM5DlIxcaGtF1MBCgHTmLvJ4igmSxzL+Gp+PcosNrnUr37PL3SAy/xKyF366FiSAi+QopT39+A==
X-Received: by 2002:a17:90b:4c0c:b0:203:1407:809c with SMTP id na12-20020a17090b4c0c00b002031407809cmr22842060pjb.193.1664171068599;
        Sun, 25 Sep 2022 22:44:28 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:7e1b:858c:19dc:934])
        by smtp.gmail.com with ESMTPSA id r11-20020a170902be0b00b00176c0e055f8sm10110489pls.64.2022.09.25.22.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 22:44:28 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH 5/5] mfd: twl6040: drop twl6040_platform_data and associated definitions
Date:   Sun, 25 Sep 2022 22:44:21 -0700
Message-Id: <20220926054421.1546436-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220926054421.1546436-1-dmitry.torokhov@gmail.com>
References: <20220926054421.1546436-1-dmitry.torokhov@gmail.com>
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

As of df04b6242a58 ("mfd: twl6040: Remove support for legacy (pdata)
mode") the driver no longer references the platform data, so we can drop
its definition, as well as definitions of related structures.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/linux/mfd/twl6040.h | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/include/linux/mfd/twl6040.h b/include/linux/mfd/twl6040.h
index cb1e7a9ce317..286a724e379a 100644
--- a/include/linux/mfd/twl6040.h
+++ b/include/linux/mfd/twl6040.h
@@ -174,35 +174,6 @@
 
 #define TWL6040_GPO_MAX	3
 
-/* TODO: All platform data struct can be removed */
-struct twl6040_codec_data {
-	u16 hs_left_step;
-	u16 hs_right_step;
-	u16 hf_left_step;
-	u16 hf_right_step;
-};
-
-struct twl6040_vibra_data {
-	unsigned int vibldrv_res;	/* left driver resistance */
-	unsigned int vibrdrv_res;	/* right driver resistance */
-	unsigned int viblmotor_res;	/* left motor resistance */
-	unsigned int vibrmotor_res;	/* right motor resistance */
-	int vddvibl_uV;			/* VDDVIBL volt, set 0 for fixed reg */
-	int vddvibr_uV;			/* VDDVIBR volt, set 0 for fixed reg */
-};
-
-struct twl6040_gpo_data {
-	int gpio_base;
-};
-
-struct twl6040_platform_data {
-	struct gpio_desc *audpwron_gpio;	/* audio power-on gpio */
-
-	struct twl6040_codec_data *codec;
-	struct twl6040_vibra_data *vibra;
-	struct twl6040_gpo_data *gpo;
-};
-
 struct gpio_desc;
 struct regmap;
 struct regmap_irq_chips_data;
-- 
2.37.3.998.g577e59143f-goog

