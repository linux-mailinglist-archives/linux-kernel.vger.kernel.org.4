Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4306918D4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 07:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjBJG41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 01:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjBJG40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 01:56:26 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FAD20D39;
        Thu,  9 Feb 2023 22:56:25 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id n28-20020a05600c3b9c00b003ddca7a2bcbso3318165wms.3;
        Thu, 09 Feb 2023 22:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rX43SfdnHlviRN2+5Vn8Nm0I2gFCbW+tOEQaMAPxnFE=;
        b=MDk1+ak00XX779OydOxtcrmPC1sKMuLSuQZIhDiSnyzxeDhgHldwyIvzVxQW0Yo81Y
         6R4wcq/enm8XeWk9zK9u2CgLbOU0XWc66srZHUpl75jJUu0cgwxmGjivK0U1TZ+ouiOk
         cAY+Ssjqu2UQxxe7nUm/cddK/gVZdiYa3Qg6n1BFm9CqMTFb9rkP8RO/Vl1Z/GJYfFq3
         hjKEfeP/f15gzsI7LuK1tgWCeXEjUUsS1Vv1GMaXkFqlx9/9AbBDybkYth7znxrhECb8
         XRT6AepVD/5EVjj+i5apjIVbI+mDECQ4W9ApCTb2kwAXLrE65nywptM+oBB/fnNUo0CA
         gsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rX43SfdnHlviRN2+5Vn8Nm0I2gFCbW+tOEQaMAPxnFE=;
        b=1Oaqc7qnUkln82vk6TJh3NBMafoYRqDa5x339Psp+rNITzr7q/XZO9jQ8wuZNC687U
         Nts3kJ9PFukQHFEeazY1fuBThgFCY0/AhFmhPGdPmYm7dMPB0jzbCVvte1ldBcoYZw77
         lFVvDVESI0vUIdhvOfvD3cMLBSCZH5jiPAHtvi/IE4bwLrQsWCVPnciKX97VXqje0FUy
         sAJwmeP5GM69JpEyTJVwnKg7p2QdnPWymGHlWxCgHGIQGy5g1LxQyXi02ltP16HaJMFI
         CuL3Y+3KKFzuVnufNfAPPtjH3dktrRLysadNCVkYhOQ8wxsKCz1XYDR+wuCN8R4eJOMy
         f8ow==
X-Gm-Message-State: AO0yUKW2Quhu11VE5XICEeWCSu0phH4SjvUX+PI7kt0rVhpph5gRiRmX
        RJMnWq2EZB1GGrgpSPS2IomAbAyLpuQ=
X-Google-Smtp-Source: AK7set+1n9lj28X3xgGAS6d+Jv9R6brWpUP7bDp6HftkyIbk+mNahxcaofUpjU237ndwYrcI8F3rSQ==
X-Received: by 2002:a05:600c:4a9c:b0:3dd:1b6f:4f30 with SMTP id b28-20020a05600c4a9c00b003dd1b6f4f30mr15665886wmp.3.1676012183140;
        Thu, 09 Feb 2023 22:56:23 -0800 (PST)
Received: from localhost.localdomain (23.red-88-10-60.dynamicip.rima-tde.net. [88.10.60.23])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c468d00b003e001afa274sm4385612wmo.2.2023.02.09.22.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 22:56:22 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH 0/3] watchdog: mt7621-wdt: avoid globals and arch dependencies
Date:   Fri, 10 Feb 2023 07:56:18 +0100
Message-Id: <20230210065621.598120-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Hi all,

This series make an update in the MT7621 SoC's watchdog driver code. This
SoC already provides a system controller node to access reset status
register needed for the watchdog. Instead of using MIPS architecture
dependent operations in header 'asm/mach-ralink/ralink_regs.h' use
a phandle to the system controller node and use it through regmap APIs
from the code. Driver is also using some globals that are not needed at
all if a driver data structure is used along the code. Hence, add all
new needed stuff inside a new driver data structure. With this changes
driver can be properly compile tested.

Thanks in advance for reviewing this!

Best regards,
    Sergio Paracuellos

Sergio Paracuellos (3):
  dt-bindings: watchdog: mt7621-wdt: add phandle to access system
    controller registers
  mips: dts: ralink: mt7621: add phandle to system controller node for
    watchdog
  watchdog: mt7621-wdt: avoid globals and arch dependencies

 .../watchdog/mediatek,mt7621-wdt.yaml         |  12 +-
 arch/mips/boot/dts/ralink/mt7621.dtsi         |   3 +-
 drivers/watchdog/Kconfig                      |   4 +-
 drivers/watchdog/mt7621_wdt.c                 | 121 ++++++++++++------
 4 files changed, 95 insertions(+), 45 deletions(-)

-- 
2.25.1

