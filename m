Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9F8651C2B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 09:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbiLTIFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 03:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLTIFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 03:05:51 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595F7E03;
        Tue, 20 Dec 2022 00:05:49 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id vv4so27377032ejc.2;
        Tue, 20 Dec 2022 00:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wlvFHSM2RP+PNNDHtW3ieuOTdii0G62X5MBvZ2V8pw=;
        b=DzQpJy1YuDICiFFo5pvGUUvsMHbV1zXfHdwuQxVsi0lWUG4Tiwjzht2EtdLWrKjLaw
         YO9FLwzoYGvVfnQlBpfM3r6WL8eCsodlqIXtg0gICKvAIzboSYoA2kHYpbCv+0b6vWdD
         /LWA9cGRH3sbKAsSqLtI3k/wXluUeIAoHdjb82Q1mlXzVtA0gELb+QnjRjMrAWlG1gXm
         ft/5cnl94ua/jvqh9e9Xk875pNJqi02ndMQm/Ayglf8qyLA2ZQcmh1fdFrgGwxqm7TnG
         TvsAwlLJ/meo2C49I5lCdw+ycR+r4Wi1JGxgQkLaL7trrrcEsFzI0hOvCqSoP1gZ1dxT
         HEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wlvFHSM2RP+PNNDHtW3ieuOTdii0G62X5MBvZ2V8pw=;
        b=ozAlENPRhlAad62DMIpzfPhqQQhnUGFqDZF+HqqhNhu0bzu8Ur/Nd0LaOkLTuH1iu+
         askMPIiK3SLuca9lXJAGiocKhBlJHMrnjX7O/vqPM+pVRk1+4WoMTyxBsBsY4/Wo1UEW
         iV4vQOFvDJOj3o78RgXOPO2jjiBnB/FTES+FSiNAJZ/erT5lHWVFwYhRiClZtDH7D+DG
         vbd6E3NcvFyxsr1mRDLzPETo0867tubHE57+wO+GNhSlkIY2mmSihXjb0fSWip4sC+wc
         tr3UgpBjb7EwonCcb/cFV8ag+ORs2yN4wcj+ccFceJv4AqDpbOpSOexDDi0eerzuyOd5
         T1Sw==
X-Gm-Message-State: AFqh2krzFqoftgnhZ4xUv1M1+Fv1n1M6j8nCpLpt3z/SpGzI7SLwTZo1
        /9UfrpvM3HZD7NOk2MLmxMY=
X-Google-Smtp-Source: AMrXdXuaAZucjnEltzM0+MhP1yNON2tjJW5PR8pqNtPWWPcRzlFdJ+gpwKt8OL9HxtTjB1IXMjsupQ==
X-Received: by 2002:a17:907:d093:b0:81e:8dd4:51c3 with SMTP id vc19-20020a170907d09300b0081e8dd451c3mr6315697ejc.76.1671523547595;
        Tue, 20 Dec 2022 00:05:47 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:954c:45e:aaca:69b])
        by smtp.gmail.com with ESMTPSA id jx14-20020a170906ca4e00b007b47749838asm5263634ejb.45.2022.12.20.00.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 00:05:47 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-crypto@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] crypto: ux500: update debug config after ux500 cryp driver removal
Date:   Tue, 20 Dec 2022 09:05:36 +0100
Message-Id: <20221220080536.30794-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 453de3eb08c4 ("crypto: ux500/cryp - delete driver") removes the
config CRYPTO_DEV_UX500_CRYP, but leaves an obsolete reference in the
dependencies of config CRYPTO_DEV_UX500_DEBUG.

Remove that obsolete reference, and adjust the description while at it.

Fixes: 453de3eb08c4 ("crypto: ux500/cryp - delete driver")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/crypto/ux500/Kconfig | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/ux500/Kconfig b/drivers/crypto/ux500/Kconfig
index dcbd7404768f..ac89cd2de12a 100644
--- a/drivers/crypto/ux500/Kconfig
+++ b/drivers/crypto/ux500/Kconfig
@@ -15,8 +15,7 @@ config CRYPTO_DEV_UX500_HASH
 	  Depends on UX500/STM DMA if running in DMA mode.
 
 config CRYPTO_DEV_UX500_DEBUG
-	bool "Activate ux500 platform debug-mode for crypto and hash block"
-	depends on CRYPTO_DEV_UX500_CRYP || CRYPTO_DEV_UX500_HASH
+	bool "Activate debug-mode for UX500 crypto driver for HASH block"
+	depends on CRYPTO_DEV_UX500_HASH
 	help
-	  Say Y if you want to add debug prints to ux500_hash and
-	  ux500_cryp devices.
+	  Say Y if you want to add debug prints to ux500_hash devices.
-- 
2.17.1

