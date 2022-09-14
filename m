Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D388D5B8324
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiINIhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiINIgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:36:49 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95F769F62;
        Wed, 14 Sep 2022 01:36:42 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x94so3822475ede.11;
        Wed, 14 Sep 2022 01:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=kt5GlcghiEZEWnX96kcMxRkX+FcCnGIoa1IqlXa5C8M=;
        b=olr6PFb8pTdAfMOPZ9XruhUVqeCuTHQJHdH9qkKvmz5NRj5RVi7UdH+02XMj1ygG2J
         lK++MdmpIr14FvZKYviN2lkYy5IoeaSmp0/2vjUjY8m7EcNOGSBtK+5RWAuvAfHQ4JHa
         UQ+8fpsInWp2YoE+AiFgyvM10y6HQavXwF42dyEhudIRmsd7SH3Nr1JvueWK9YCUsvjT
         HAjrP/yaf0AU0RP1ywwGh09wkJ+BQgsYCLKiUV+xlQoh7ArvQqQUMBIm5CCb3alzHK2T
         hVdReXPMmzRdNLAw+mCHEmV7e6PzBHxUzQP2RwFdu4uJzGnD4kF2HDRyyVA4AAcsN7da
         L3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kt5GlcghiEZEWnX96kcMxRkX+FcCnGIoa1IqlXa5C8M=;
        b=xLsWOR/niqejHB3LOyBdjHpl2osgj5mCOaNrNcbJLcSYaIWR8g0+8lCbkBYatWm3S6
         a6V90d4pzBvaremG4sR+6OwMV2UAvhgZ1AHzqJuXBT8X/CatcCQb7zx41oUn8dmN8JCa
         bftBI+AnuooKEjp+gbeOr6OWynkODIwAABiKAj6+TVj6fMyp4vJw8cMkxLybipAT83Ej
         8FoUmXR36TEliCLVyZcv7de7BoSo6Dfw7ZCWeI4zoHIUXmaYzXtkbaevmRUBRgS6uAAL
         Fain7aDTfbsBMp86zP29cnp/FMXhh/sdtT+x5Rjvm1YSq+vr2T9+E63xE1jeJf901ZtL
         nhCg==
X-Gm-Message-State: ACgBeo1DXZE8mXfdeTack0Rj2LnLA41kJss5+bWOpMMH7x97BFve6YMT
        tt8lfcMIRf6QCvTYOpo46g4=
X-Google-Smtp-Source: AA6agR5oZG2EAibaK/VGHtwmO5yurv10J3GzuBAJzqSGTOF5pWl06SFhLNBElTH0VIeAsg4SAudFDA==
X-Received: by 2002:a05:6402:2b8b:b0:43a:5475:f1ae with SMTP id fj11-20020a0564022b8b00b0043a5475f1aemr29351937edb.363.1663144600796;
        Wed, 14 Sep 2022 01:36:40 -0700 (PDT)
Received: from felia.fritz.box (200116b826cf470059b9799edefde240.dip.versatel-1u1.de. [2001:16b8:26cf:4700:59b9:799e:defd:e240])
        by smtp.gmail.com with ESMTPSA id 21-20020a170906309500b0073ddff7e432sm7417346ejv.14.2022.09.14.01.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 01:36:40 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] crypto: revert unintended config name change for CRYPTO_SHA1_ARM64_CE
Date:   Wed, 14 Sep 2022 10:36:26 +0200
Message-Id: <20220914083626.17713-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3f342a23257d ("crypto: Kconfig - simplify hash entries") makes
various changes to the config descriptions as part of some consolidation
and clean-up, but among all those changes, it also accidently renames
CRYPTO_SHA1_ARM64_CE to CRYPTO_SHA1_ARM64.

Revert this unintended config name change.

See Link for the author's confirmation of this happening accidently.

Link: https://lore.kernel.org/all/MW5PR84MB18424AB8C095BFC041AE33FDAB479@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM/

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/arm64/crypto/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index 7ba9bcb6d409..8bd80508a710 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -36,7 +36,7 @@ config CRYPTO_POLY1305_NEON
 	  Architecture: arm64 using:
 	  - NEON (Advanced SIMD) extensions
 
-config CRYPTO_SHA1_ARM64
+config CRYPTO_SHA1_ARM64_CE
 	tristate "Hash functions: SHA-1 (ARMv8 Crypto Extensions)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_HASH
-- 
2.17.1

