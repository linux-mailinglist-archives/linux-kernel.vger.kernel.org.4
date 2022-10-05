Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1898D5F5810
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 18:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiJEQN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 12:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiJEQNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 12:13:52 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E2A2ED43;
        Wed,  5 Oct 2022 09:13:51 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a10so14335135wrm.12;
        Wed, 05 Oct 2022 09:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=EiPAkr/jQo8yOa0N4lixzv4uq38NGMwa1PpH2KlTzQ4=;
        b=orhaGvaUGpNQhy8UcEuI4KSgAUcmCXuFsvTGp8hIuwbn+s9rPWhj/3vIWVzhWURYRW
         YVuFctm6BokimJNUz4TSifQrkkzs876ZF+3yRGOniiulzlxllPQsCxTuuGC4CJWl0N3O
         8O5eEEhHe17Z3mp5HItyS2MYmRvoPYPDj7jJJY2fGIfqKWRExlhzzoO3vzwU2kp/CvBu
         kl1/Yhr9NLrKASbC0nB1yRq4ShRCqSGvfW52ToUuSpI7/VTOJRP32QfdHZDXpI3sIDeZ
         lGEykJuiLAfP5X1bVHk4ixoVG5sks9rI/sgLRyvUNuIKJUEhA48Z1Hdt1QiEa6Poa9Qz
         T0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=EiPAkr/jQo8yOa0N4lixzv4uq38NGMwa1PpH2KlTzQ4=;
        b=Zf2MWDBcdlWhHJKbZY0ylSajIrW3AMfDePEwG1/08CHgp0S/yVaLThm53dwFoM+rzm
         GPGy6CBlfsYpXa1ZEzFvMeeGAdGJyyw7jMPq7tnuXayVYvMDRhxpAhf4zBtSQWqaJoIm
         cqS/8PDG4ZO+CbbtK3JkH11A8IZPjJ5c/L4L9xdEE/KmKMNA8lfY1oyqqC7uhRzvuw5l
         VJIevYUr+uNrUOtDnosLY9/mINLBUaRaaXsgD1Gx8MUixgscvqy9KMd6Uez+pcFx0mSD
         5UVdJaMRwNv297WPY/M2QGKL220qXIa9PkFPG2W+nH8J0Z+2vw/4Ns5EPzV0vWqDMI8y
         RgOw==
X-Gm-Message-State: ACrzQf3uDF1tGDCrbe4WGV8Vp0FK52sIgtWlrnWeoF1ebgq/reNU5X5+
        HzPDvTUhitupcCQa9Xk953w=
X-Google-Smtp-Source: AMsMyM5Ub/IqfW5rxVAxPNshantZRpALijiURltZ4lDG72ufPeawwFRGN+cTP/Bz/I7PK/0ueLpo+g==
X-Received: by 2002:adf:f301:0:b0:22e:4479:c1ba with SMTP id i1-20020adff301000000b0022e4479c1bamr327623wro.133.1664986430168;
        Wed, 05 Oct 2022 09:13:50 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n16-20020a7bcbd0000000b003b483000583sm2210880wmi.48.2022.10.05.09.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 09:13:49 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: lp8788: make const array name static
Date:   Wed,  5 Oct 2022 17:13:48 +0100
Message-Id: <20221005161348.321971-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Don't populate the read-only array name on the stack but instead make
it static. Since the data and the pointers don't change also add in
a missing const. Also makes the object code a little smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/power/supply/lp8788-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply/lp8788-charger.c
index 56c57529c228..802c9491fcdb 100644
--- a/drivers/power/supply/lp8788-charger.c
+++ b/drivers/power/supply/lp8788-charger.c
@@ -520,7 +520,7 @@ static int lp8788_set_irqs(struct platform_device *pdev,
 static int lp8788_irq_register(struct platform_device *pdev,
 				struct lp8788_charger *pchg)
 {
-	const char *name[] = {
+	static const char * const name[] = {
 		LP8788_CHG_IRQ, LP8788_PRSW_IRQ, LP8788_BATT_IRQ
 	};
 	int i;
-- 
2.37.3

