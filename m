Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D1863E8C6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 05:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiLAEK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 23:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiLAEKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 23:10:18 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D069F48E;
        Wed, 30 Nov 2022 20:10:06 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id fp23so2063qtb.0;
        Wed, 30 Nov 2022 20:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iwiLrcYqrOHeSqU5MKCU589ont+JTVo09KPZ5wBCLIk=;
        b=KtVbLWyOMJwJD4azBChn8YETOryZRilnVsPexgHPbMr1TuGDPv/DiFTW5xEL01Iv7K
         AhAHUBkKHiGhxRtPWc5xzM0bLSlQbI0FYBZxGMDfwGjhAq8obat7Bb4+sdzJKK/GcgyI
         bGmsc2aKiU3sghAiDjtirUweHrL4pHEQa8ufyrVtThCVUU9nIBaNULGjoWCxXSdAbpGm
         X4RV2ADFhBwaboGgeVD2cBTyj+II25NWJ+TEbsx3e3igZ5VThnPNydQ6eTDTRqVb6xFg
         FyYPm+VrEWmX+Iyc8Vu9rKnFi/yAB4ow6SOdYjjSh4+JY959aaAU4OgX6nDm934hxMFX
         nrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iwiLrcYqrOHeSqU5MKCU589ont+JTVo09KPZ5wBCLIk=;
        b=S/rtrzPCDbgD2O7rBgpg6vzM3ahRJoCYPnu97F6K68s6SWf1bShwPIkEjD+JeK0v/V
         zZige21VJ8qb4oLUN6aBnUN0XDT+5GKE335gGWIuwDfzZ47ctWdB7LsA8INxbKxYtNLr
         v98mw2PLz7gLe+pmRJc4Flkb6F5+ARlI03ecalMifxqJX9BDD9HlQpS4MHN1bNOMVhx3
         yBCpEPBd1CWmiSGj1Bc4P3Kqv1bNEeMmfiRY58nD5pXt9L0VKLZOzCmhuawRvbGSuE5J
         k4HsSf0HddxVWft70jTN0mT0ACMQ6IOE+6Y6AyhUanw28fh0G8hW3pi4v7OxCENijsMz
         vY/g==
X-Gm-Message-State: ANoB5pm81lRUQCB124zbZaAToMwZ0vQS0G5JKUFuQYVWLuLUvEykAkKF
        C+uS2rScDS1Asc9s93O+DtuWO1oc/sU=
X-Google-Smtp-Source: AA0mqf4Aqs7A+jPKMXnqK/COz9IEVPQsemdujtANqZqbf2ue3olEhmBpg8+DJMQepELzayz7YLpYEw==
X-Received: by 2002:a05:622a:1e1b:b0:3a4:30bc:849a with SMTP id br27-20020a05622a1e1b00b003a430bc849amr59180635qtb.524.1669867805478;
        Wed, 30 Nov 2022 20:10:05 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab ([96.237.180.62])
        by smtp.gmail.com with ESMTPSA id w21-20020a05620a445500b006fa4ac86bfbsm2586704qkp.55.2022.11.30.20.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 20:10:04 -0800 (PST)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-input@vger.kernel.org, lee@kernel.org, lee.jones@linaro.org,
        Mr.Bossman075@gmail.com
Subject: [PATCH v1] drivers/mfd: simple-mfd-i2c: Add generic compatible
Date:   Wed, 30 Nov 2022 23:10:04 -0500
Message-Id: <20221201041004.1220467-1-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
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

Some devices may want to use this driver without having a specific
compatible string. Add a generic compatible string to allow this.

Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
 drivers/mfd/simple-mfd-i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
index f4c8fc3ee463..cf2829f703e2 100644
--- a/drivers/mfd/simple-mfd-i2c.c
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -73,6 +73,7 @@ static const struct simple_mfd_data silergy_sy7636a = {
 };
 
 static const struct of_device_id simple_mfd_i2c_of_match[] = {
+	{ .compatible = "generic-simple-mfd-i2c" },
 	{ .compatible = "kontron,sl28cpld" },
 	{ .compatible = "silergy,sy7636a", .data = &silergy_sy7636a},
 	{}
-- 
2.38.1

