Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91E65EC883
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbiI0Ps4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbiI0Psc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:48:32 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102F0B40D3;
        Tue, 27 Sep 2022 08:46:15 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 78so9734290pgb.13;
        Tue, 27 Sep 2022 08:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=PSNk7s384Z23aLn5Ts/fh2+6l6mQAiWhXglxXj3QkQo=;
        b=I9tU3OGuKElcXtC5fj11d05cuOJHUUcF594AcLK7mVLG4TfilDQKwNFLo+pHZ+rlUi
         t3yyq9NBQDnNpyfvaiQkmS4UjguM80jgoVVXcg1wczG0EL1lygLQ2VptOeg7Y0U9bUlQ
         ZKSVKHZm2i/3vGyg/ufZQpM9hfUz2Qdf1aJl4IYxpM7ZMB+8CgIPTZk3Pr3oJU30jXSr
         3c0Fz4A4YeQhQ6feVcznoq4iIkofrcW59BG2ifE+AU9Oe9Hcar6UlUk6u3hOnFX7kuLq
         JW1UNYj4MWfhU6XxZXheiAOEJK4gr/afkWbwHv+pJYrTur+U+ZihD0/vS5LYf3nosqeI
         EDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=PSNk7s384Z23aLn5Ts/fh2+6l6mQAiWhXglxXj3QkQo=;
        b=reKJyFkEZ0ulWB2d9r1uE4Bddd7s3rjVkfVSazJqtNILDf6bKwJRdc9HH7DHIOQ9Vx
         67jW8IhUKDmih1D8oKT+HwmKacSY/EXSzk71WvirsUtRx2uXdVogPPS385LsA4RFkB9u
         dC073Ttf8bERvLn3k2fwLSgG+UQ2KWgSXrR6RSuI7vd5jJyls3sqExa0AYPMqSkPkKRB
         Q8A4EAt0B15xlqG2FbsEBorYMiW9LKmUtemk97uW6VrRle6oQCfk7iuMbWKupTprwgKW
         rxyt2JwIuNJWDylObbhl9DXqL2zwew+H0D01PD1E/EPaqHfmploWam1faBJCy73GAbhW
         P+Nw==
X-Gm-Message-State: ACrzQf0hzOmGwgtFbl7IlaenLrq9h41GRWizYF6/Wq8VHRBC6MNAu4K3
        49zXEbgsNT0MkfroNKRk7Lw=
X-Google-Smtp-Source: AMsMyM5FtxO56pH1RDQtuutIKpl7iKPoYUGXg2P6c2fkmidL/yLHRjZkfLcZBJZ8ZiYaHcSn2mWyFQ==
X-Received: by 2002:a62:82cc:0:b0:553:e631:14f0 with SMTP id w195-20020a6282cc000000b00553e63114f0mr29760685pfd.63.1664293575224;
        Tue, 27 Sep 2022 08:46:15 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:9739:ab49:3830:2cbb])
        by smtp.gmail.com with ESMTPSA id cp7-20020a170902e78700b0017839e5abfasm1681204plb.263.2022.09.27.08.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 08:46:14 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] watchdog: twl4030_wdt: add missing mod_devicetable.h include
Date:   Tue, 27 Sep 2022 08:46:09 -0700
Message-Id: <20220927154611.3330871-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
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

The driver is using of_device_id and therefore needs to include
mod_devicetable.h header. We used to get this definition indirectly via
inclusion of matrix_keypad.h from twl.h, but we are cleaning up
matrix_keypad.h from unnecessary includes.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v2: changed from of.h to mod_devicetable.h per Andy Shevchenko

 drivers/watchdog/twl4030_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/twl4030_wdt.c b/drivers/watchdog/twl4030_wdt.c
index 355e428c0b99..36b4a660928d 100644
--- a/drivers/watchdog/twl4030_wdt.c
+++ b/drivers/watchdog/twl4030_wdt.c
@@ -9,6 +9,7 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/watchdog.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/twl.h>
-- 
2.38.0.rc1.362.ged0d419d3c-goog

