Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9856B67F989
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 17:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbjA1QXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 11:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbjA1QXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 11:23:46 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E098C20D28
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 08:23:43 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id vw16so21075534ejc.12
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 08:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/VnHTYs7TpUcFDkOWjcIjoYKb7zcZR99FeN6TsqyDU=;
        b=LkySxajoMEfD6COiwKQb6x1xUWqIoxXM9WCmhAMHqVxv8Iu50OqogyryD9n67m7b5J
         +GE/av1AvpBBMxczhdG+6ZBEB9r8q/Kwlgct6TS/lf7YVzUsAdism9LMbHxdd5eK+JAr
         MTLX73WF3YJlmIFXj0ASKAKbvAvXJTVCdEKkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/VnHTYs7TpUcFDkOWjcIjoYKb7zcZR99FeN6TsqyDU=;
        b=HeNZn4pb/juwWG7yl/V4Z5VgYGhBgiNw6PZkXxzos5G7cqHgFtaG3O6OI1n+xMY3xE
         tH7+w9r0l2bWCPdUTUgXNlIhg1rtSQ9eMrTtPbhihUCtw2o0qupuZwyhr0AqgJgYeTI9
         VZg1OJZe6PYZXMCPcd6iFt0V6WhER+UrxXrV9htYIW8wexjNj9YjF8vP8XIhFiyukfj5
         1d1/I9dHkSjE/EZcXLr5TJWhkYQy7xcpgCvGnllN0tohNipAn+hMt6wW+O7cgvIQvWie
         f5Hk9pfu+wsyF/qRLMguhKOpMz84XxI9aFEUkYnaMS41eDAny8bh8iWauLy+TWYlQicr
         3hug==
X-Gm-Message-State: AO0yUKVOglFc5bXS72BoHdoGp0EKIhC5qulxjqSqit0oC29QmOJIJSpQ
        XxZEKHXyVzHz73b/KrPMKfxsYDPkZO+ZQexO
X-Google-Smtp-Source: AK7set9sSw1jiP2TNt3LNeAAfIcymypJW9SDN6AZ84YnauS5mzdx5dHAbNxYpKclJiJl2r8Uts+JvQ==
X-Received: by 2002:a17:907:a2ca:b0:879:9bf4:b88a with SMTP id re10-20020a170907a2ca00b008799bf4b88amr8578045ejc.77.1674923022365;
        Sat, 28 Jan 2023 08:23:42 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-25-102-201.retail.telecomitalia.it. [79.25.102.201])
        by smtp.gmail.com with ESMTPSA id b17-20020aa7df91000000b0049b5c746df7sm4109629edy.0.2023.01.28.08.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 08:23:42 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-input@vger.kernel.org
Subject: [PATCH] Input: edt-ft5x06 - fix typo in a comment
Date:   Sat, 28 Jan 2023 17:23:25 +0100
Message-Id: <20230128162325.64467-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'firmares' with 'firmwares'.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/input/touchscreen/edt-ft5x06.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index ddd0f1f62458..04bfefe3c0e0 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -931,7 +931,7 @@ static int edt_ft5x06_ts_identify(struct i2c_client *client,
 	} else {
 		/* If it is not an EDT M06/M12 touchscreen, then the model
 		 * detection is a bit hairy. The different ft5x06
-		 * firmares around don't reliably implement the
+		 * firmwares around don't reliably implement the
 		 * identification registers. Well, we'll take a shot.
 		 *
 		 * The main difference between generic focaltec based
-- 
2.32.0

