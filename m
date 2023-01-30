Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55910680685
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 08:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbjA3Hdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 02:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbjA3Hdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 02:33:40 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670EC23840;
        Sun, 29 Jan 2023 23:33:36 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id m2so28611097ejb.8;
        Sun, 29 Jan 2023 23:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqQ934JWSGPRtN10m9jH2L8S8kM1Q6Pi2aTaTuPesk0=;
        b=YYeZg554V3NqyL6dwLyNgBhyrgk8MXV//FB3Kjsbx7B6ok8MBRkxBJgTnoY84SDvMG
         9y4kbKdrVw10Ek6MBlXG2FnFUWfkHZxiMsrLlpNpO64T7GE1VrWoLiKqArDq6vkrLqHx
         DtV3UwSIHrErWaZPQJiVZhT77bj+T5StutazyD+gddecuyPMbD8Yt01C/iW8K221K0S6
         795FAvGnUDpAa7DhZ/EOWhzg3EWf/oudStUxvtAP4oPgtf2vSQLM8QFH/Rp7CHu2lMaL
         75b/qvQ37/NxV4N4MgFce2c5bqvxCm8iPyTZxfkScbG98GbdUAGgvjsTmnOIDa2DNL/C
         JW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqQ934JWSGPRtN10m9jH2L8S8kM1Q6Pi2aTaTuPesk0=;
        b=5MY4sXvQJJYhwVjCUAIOzLjJjFb4l3+hpTKCst/fPyxiJViy78pHi7TlHDrSgHf4BH
         VQb+CSnsILLKBdYnDsfuF5qCt9ilKDyQb9mkL2NQLkSYDMEmCHRfnfOY5fblBZHR8Wvf
         HthjQrZABRJnARv8QjoTN9n/6nA5e5tNV8jIjWg3bnAf3kVOxycE423SzE01uri4ESXW
         iCHVZWdKHJeVJ3I9nKQJviLLvfLIsUsS2ZqEiC0+VIi5H6p/7m4w8TexNLzlhsMm3P5G
         kv1wt/EwcIyDCZWgh3ZAm8KuidVXj1ARhiqeYfI46SR3/W/5xiQkvryP/Ae5UJtFNUOo
         URJg==
X-Gm-Message-State: AO0yUKVfv8LgKMLsK2hhkj6SDtsc7PyQEHFGevN/eyMQIAVd0B//PXHz
        YCzHFNmvo3wLJLiDnrwNaF0=
X-Google-Smtp-Source: AK7set92Dsb90ymDMZDctLBT9JmHOpG2cC7hczPLPI0Y8mfE06+zWE+OVpzP7XOjN8ZrcC2TYTiLFg==
X-Received: by 2002:a17:907:6f1b:b0:887:2320:57e5 with SMTP id sy27-20020a1709076f1b00b00887232057e5mr4870130ejc.46.1675064014778;
        Sun, 29 Jan 2023 23:33:34 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:893:4a0f:7898:3492])
        by smtp.gmail.com with ESMTPSA id z2-20020a170906714200b00888161349desm1505532ejj.182.2023.01.29.23.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 23:33:34 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jenny Zhang <jenny.zhang@starfivetech.com>,
        Jia Jie Ho <jiajie.ho@starfivetech.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Olivia Mackall <olivia@selenic.com>,
        linux-crypto@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: repair file entry for STARFIVE TRNG DRIVER
Date:   Mon, 30 Jan 2023 08:31:09 +0100
Message-Id: <20230130073109.32025-1-lukas.bulwahn@gmail.com>
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

Commit c388f458bc34 ("hwrng: starfive - Add TRNG driver for StarFive SoC")
adds the STARFIVE TRNG DRIVER section to MAINTAINERS, but refers to the
non-existing file drivers/char/hw_random/starfive-trng.c rather than to the
actually added file drivers/char/hw_random/jh7110-trng.c in this commit.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Repair this file entry in STARFIVE TRNG DRIVER.

Fixes: c388f458bc34 ("hwrng: starfive - Add TRNG driver for StarFive SoC")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Jia Jie, please ack this patch.

Herbert, please pick this minor fix patch on top of the commit above. Thanks.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b615c8418e80..7d87a78446cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19845,7 +19845,7 @@ STARFIVE TRNG DRIVER
 M:	Jia Jie Ho <jiajie.ho@starfivetech.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/rng/starfive*
-F:	drivers/char/hw_random/starfive-trng.c
+F:	drivers/char/hw_random/jh7110-trng.c
 
 STATIC BRANCH/CALL
 M:	Peter Zijlstra <peterz@infradead.org>
-- 
2.17.1

