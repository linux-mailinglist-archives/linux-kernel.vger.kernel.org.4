Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF2E64BCB2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 20:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbiLMTEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 14:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236663AbiLMTEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 14:04:00 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452E4F28;
        Tue, 13 Dec 2022 11:03:59 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id p36so6491842lfa.12;
        Tue, 13 Dec 2022 11:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zQF6hMxTmG4slJ9Nz3trIgcsMDVZJZQDuZmv2zhDQHk=;
        b=Q+fdIT8hdXjsy1pkEw8iH3UM4HoedY27FzR/yBfHRUQQoUhlbasG/OktcKkqkbB9pD
         E8qUAiABYUpVYenvWdqVnX3WWTiprBwgeS8/aeXu9i4TdE7WUER2TouIIn5dxyPiTJW7
         UC1DE2DVbYvmVCzUF0XjhZ/0oPx8LVkBTnMAl+HqbWMpoivCZ9MoeRRSjX1x39iFlE8n
         Ye0/ZU6ACxT5el2M+bzWGjhxU8cjFsPkjN1FFmY7cMQpQLvqkJfDFKtKeiX6CRXuk7vQ
         I/01YKMCUtBJ2sKoRpNfMchpvKx5z3dRi0673cy/IsO3Ka5jTkg/iY/rVTnbE57vYD45
         lMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQF6hMxTmG4slJ9Nz3trIgcsMDVZJZQDuZmv2zhDQHk=;
        b=a8HUae0z8FIZoHiSZnLmdXiqNLEPpZ0Nn2Lg45PbY3oUUZAbKwEYXVzApC0v5Uorzd
         O5HnB808mxAqpxxy9fRMv+sTXK4NTY2vecqpaTlj49cRj7J7y0082cdWOiIhUWmKsTt8
         3ECt0D+zrfYsaeU+arW+m0CyM+oAqDXKNt3FzbtIUs6pz58zxZvSnOdGEBG6DVzZTwcT
         ndv3IoiMajimy6dssUrx8uQUjZxHiQEfYsHRRPUId4eK+FBWvf0+FQcVrDA1O7DAsY5/
         wqFmbxDp/tRaFFSWYCECpNet1C60MS3/gMuOHypQaVeDGj/jbA6/TCdZKrsAPgCcarTj
         P62Q==
X-Gm-Message-State: ANoB5pmJGj0Dk2dZRqsEMxfU6teRTbdxH9vbrGQNSg+vhbQmlDYl6Ujr
        uJFQhVmfe7KlAI+Puo2DdGo=
X-Google-Smtp-Source: AA0mqf6MaCUVan1IJEPVjs/aiMbQp9mjcMuZj72AS4fv7ti1UhQKYHuVyV5MD8wOjbPiUap9ZDgaZw==
X-Received: by 2002:a05:6512:4cb:b0:4b5:6417:43bb with SMTP id w11-20020a05651204cb00b004b5641743bbmr5097373lfq.51.1670958237582;
        Tue, 13 Dec 2022 11:03:57 -0800 (PST)
Received: from DESKTOP-5EKDQDN.localdomain (78-63-10-115.static.zebra.lt. [78.63.10.115])
        by smtp.gmail.com with ESMTPSA id z2-20020a196502000000b004b54ca56cf9sm472232lfb.303.2022.12.13.11.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 11:03:57 -0800 (PST)
From:   =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>
Subject: [PATCH] Input: atkbd - fix typo in comment
Date:   Tue, 13 Dec 2022 21:03:05 +0200
Message-Id: <20221213190305.6477-1-aldas60@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Certain keyboards to not like" -> "Certain keyboards do not like"

Signed-off-by: Aldas Taraškevičius <aldas60@gmail.com>
---
 drivers/input/keyboard/atkbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 246958795..08f87c592 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -247,7 +247,7 @@ static void *atkbd_platform_fixup_data;
 static unsigned int (*atkbd_platform_scancode_fixup)(struct atkbd *, unsigned int);
 
 /*
- * Certain keyboards to not like ATKBD_CMD_RESET_DIS and stop responding
+ * Certain keyboards do not like ATKBD_CMD_RESET_DIS and stop responding
  * to many commands until full reset (ATKBD_CMD_RESET_BAT) is performed.
  */
 static bool atkbd_skip_deactivate;
-- 
2.37.2

