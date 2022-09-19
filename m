Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E545BC422
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiISISW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiISISO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:18:14 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32C51D316;
        Mon, 19 Sep 2022 01:18:13 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e16so46240591wrx.7;
        Mon, 19 Sep 2022 01:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=I4HLCm0SU2DVt/DsRYzlKugKxcj0Dff9UNyb49sz804=;
        b=LSixgBwfLkw+IsIWyMVg/o500XR8i4dqac114uYt0GRboVmCvVHTZYR2gRIR2n0RpU
         PKQZQoW4JRf44+lM0zUfnsuPwm20cdYeHuNBWUDbJ1s6xASKjCDNd3bOovwDIMeLFU1U
         zSdE3dgXAlRLJeWLXziMHnjK5i4zipKkJ5WW6ruD7GTlzyTKSieKYcy3gHsdMsSu98Tp
         Qkkexx8jfNbUqFhY99yulk4mDElmIbMJO169u/UgXv18YZUehtCuDKBcsTuJSmzksV+T
         cRuTHrRly5QnHX5s243yNhPuKy7JdbL6+vd+KJkNT0KlwV2IwefLPhntlbgOKNJU9j69
         jFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=I4HLCm0SU2DVt/DsRYzlKugKxcj0Dff9UNyb49sz804=;
        b=q2Vncw0e3fWl7v1hPZSjaX+ISXv+2dIUEPvnqCBT0NfQ57nqTEta3EWMWnFyRAw/oV
         +fBTDppCO/DpQRwmUXARcLixvsCO2VijhuHFVNMNfIfigeAThG41Gr0sJJeTaMHf0Udk
         yaXw/Ne+/GkOVdbC+UG19R7BZqGQo20DNKSwUDSRXGseZB8+U48ghdETSHQpd+pw1AuG
         Nwk6DJfDvMrxSqNFXxXt6GbHhB8soMCvChTO2SPRnjNopFB5JEn0C/dAWKFL8b3ROr5p
         CXoyMsvfJapD2qMTRLVP50OnvRBMKwE5s488ERn+sYpX5+eI6EcWc9E1aYKk/vjARhVu
         H53g==
X-Gm-Message-State: ACrzQf2ofnAvzct1jxQ2SA26+MHioW2eEqbJnypUdavfIklX3Hxw5vW7
        lLq7+x4LH+MCyI6z08dqdKw=
X-Google-Smtp-Source: AMsMyM4vJ+ZX6lE+itZlnK9wl9FVoA+jti79/ygC6vi3eTYSq6DuqLg+pgFcK24op9pMeYbt+j3Yhg==
X-Received: by 2002:a05:6000:1090:b0:228:a963:3641 with SMTP id y16-20020a056000109000b00228a9633641mr10030816wrw.289.1663575492040;
        Mon, 19 Sep 2022 01:18:12 -0700 (PDT)
Received: from felia.fritz.box (200116b826812b0018444688cfe72784.dip.versatel-1u1.de. [2001:16b8:2681:2b00:1844:4688:cfe7:2784])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b003a8434530bbsm13254007wmq.13.2022.09.19.01.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 01:18:11 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Imre Kaloz <kaloz@openwrt.org>, Krzysztof Halasa <khalasa@piap.pl>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] MAINTAINERS: adjust ARM/INTEL IXP4XX ARM ARCHITECTURE to ixp4xx clean-up
Date:   Mon, 19 Sep 2022 10:17:53 +0200
Message-Id: <20220919081753.16934-1-lukas.bulwahn@gmail.com>
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

Commit c83227a5d05e ("irq/gpio: ixp4xx: Drop boardfile probe path") and
commit 155e4306107f ("clocksource/drivers/ixp4xx: Drop boardfile probe
path") remove files include/linux/irqchip/irq-ixp4xx.h and
include/linux/platform_data/timer-ixp4xx.h, but miss to adjust MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about
broken references.

Remove file entries for those files in ARM/INTEL IXP4XX ARM ARCHITECTURE.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
v1: https://lore.kernel.org/lkml/20220601050200.22213-1-lukas.bulwahn@gmail.com/

v1 -> v2:
  added tags from v1, no other change.

Linus, please pick this minor non-urgent clean-up patch for ixp4xx arm.

 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 46f3c706f487..babb441f7474 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2247,8 +2247,6 @@ F:	drivers/clocksource/timer-ixp4xx.c
 F:	drivers/crypto/ixp4xx_crypto.c
 F:	drivers/gpio/gpio-ixp4xx.c
 F:	drivers/irqchip/irq-ixp4xx.c
-F:	include/linux/irqchip/irq-ixp4xx.h
-F:	include/linux/platform_data/timer-ixp4xx.h
 
 ARM/INTEL KEEMBAY ARCHITECTURE
 M:	Paul J. Murphy <paul.j.murphy@intel.com>
-- 
2.17.1

