Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4889A69514C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 21:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjBMUFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 15:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjBMUF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 15:05:27 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1B01E1FF;
        Mon, 13 Feb 2023 12:05:23 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso12132799wms.0;
        Mon, 13 Feb 2023 12:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XDRWQUYYQAXAeo7Um4o8LaTWj0my2qwhFm/K7Pa7hRw=;
        b=eRU3VW8Z4INSs5hDy8dIa2iGknHBp6bZYvhfOXuPmeNw+Efm3tu4AfKl2WWX6bJep5
         u2gdmtstm4ISr7UEs4xXww8gL46IEWX8QURvdW9vO98QRQSJz1oG+0sJOLlM+9GV9vjX
         OTee0rU6t8lJBe0xwYcYXwwv2lHsXbIbW9HBy3hSAnhVtwcj6cd7XC5M/DTVgsR3MF2Z
         GSnc7bxkISJPU8BC12KvZ+bCQy8cLqvVRMUaMuZT10XOk3zZImYUdcF//YL2h+h2du9g
         sTETpcgB+oPfz001ucw5jLdlCLRIK5PyjABEcmESF10A7CKJfP1I9vKrB5A91b34SJF1
         4frA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XDRWQUYYQAXAeo7Um4o8LaTWj0my2qwhFm/K7Pa7hRw=;
        b=VgF1WW07DUQ8iAv71V0UppO7zy55H7pqlNB56d4FDBzrovX0gxHmtuvB7C8nv0RZZD
         yPLKMM2TX1JuXIpAsXxQOozKVrC4r+LCEgeaLE6hLf61dPayJ03gLyoAKHW5xJncsIy9
         5+AKKyhEjmEuEL/M/4+b8y/AO3IjCtYWlSnt2LKwUAvy4aCZItsC7AeaAjLF2ZHVGLrf
         xvMcw229zo0iKjAx9r9wIqtYigThFjaE2O11abEXDbQ7OTDvIa0b2R6uAczIp8tHwqsV
         xmokGnEPdczSJpVQtlIO7pMQHfBu21CJoDMlSEp5h8kh2+u90rDvKsI8kBACLo5FC8aO
         C01w==
X-Gm-Message-State: AO0yUKUan9JtDTjcLnZ/C02csOWu5MXiSLIejlenyuY7wxvg8GX8BVIo
        8NgVwsGFZ+71IyaWyUC2MRRvlsyTNw8=
X-Google-Smtp-Source: AK7set9qjBBbCid3z4jkNeAR+EFowHQ/mTWmEzvDRwcT5IXXIz0cXKZZZqAGgpeAeLLYKeLkRNt89g==
X-Received: by 2002:a05:600c:35c4:b0:3df:9858:c03c with SMTP id r4-20020a05600c35c400b003df9858c03cmr6780177wmq.17.1676318721359;
        Mon, 13 Feb 2023 12:05:21 -0800 (PST)
Received: from localhost.localdomain (23.red-88-10-60.dynamicip.rima-tde.net. [88.10.60.23])
        by smtp.gmail.com with ESMTPSA id c129-20020a1c3587000000b003dc1a525f22sm15591242wma.25.2023.02.13.12.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 12:05:20 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v6 0/3] watchdog: mt7621-wdt: avoid globals and arch dependencies
Date:   Mon, 13 Feb 2023 21:05:16 +0100
Message-Id: <20230213200519.889503-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
dependent operations in header 'asm/mach-ralink/ralink_regs.h' get
node syscon regmap using 'syscon_regmap_lookup_by_compatible()' and use.
regmap APIS. Driver is also using some globals that are not needed at
all if a driver data structure is used along the code. Hence, add all
new needed stuff inside a new driver data structure. With this changes
driver can be properly compile tested.

Thanks in advance for reviewing this!

v1 of this series here [0].
v2 of this series here [1].
v3 of this series here [2].
v4 of this series here [3].
v5 of this series here [4].

Changes in v6:
    - Get regmap syscon using 'syscon_regmap_lookup_by_compatible()'
    - Add COMPILE_TEST and dependencies to Kconfig.
    - Collect Philippe Mathieu-Daudé 'Reviewed-by' tag for watchdog node
      warning fix.

Changes in v5:
    - Drop patches related with device tree ABI breakage and only
      maintain the rest.
    - Collect Arinc 'Reviewed-by' tag for watchdog node warning fix.

Changes in v4:
    - Add a patch to fix a watchdog node warning with 'make dtbs_check'
      because of a wrong node name.
    - Collect Guenter 'Reviewed-by' tags for watchdog driver code.
    - Add a missing 'COMPILE_TEST' to Kconfig which was lost when driver
      code was split in two patches in v2.

Changes in v3:
    - rename phandler from 'ralink,sysctl' into 'mediatek,sysctl'.
    - Drop error message added in PATCH 3 that modifies functionality
      and we only want to maintain current functionaloty by now.

Changes in v2:
    - Remove no needed compatible 'syscon' from bindings.
    - Rewrite new syscon phandle description in bindings.
    - Remove 'syscon' from compatible in 'mt7621.dtsi'.
    - Split PATCH 3 into two different patches:
        - PATCH 3: removes static globals using a driver data structure.
        - PATCH 4: remove ralink architecture dependent includes and code.

Best regards,
    Sergio Paracuellos

[0]: https://lore.kernel.org/linux-watchdog/20230210065621.598120-1-sergio.paracuellos@gmail.com/T/#t
[1]: https://lore.kernel.org/linux-watchdog/20230210121735.639089-1-sergio.paracuellos@gmail.com/T/#t
[2]: https://lore.kernel.org/linux-watchdog/20230210173841.705783-1-sergio.paracuellos@gmail.com/T/#t
[3]: https://lore.kernel.org/linux-watchdog/20230211073357.755893-1-sergio.paracuellos@gmail.com/T/#t
[4]: https://lore.kernel.org/linux-watchdog/20230213120638.850612-1-sergio.paracuellos@gmail.com/T/#t

Sergio Paracuellos (2):

Sergio Paracuellos (3):
  mips: dts: ralink: mt7621: rename watchdog node from 'wdt' into
    'watchdog'
  watchdog: mt7621-wdt: avoid static global declarations
  watchdog: mt7621-wdt: avoid ralink architecture dependent code

 arch/mips/boot/dts/ralink/mt7621.dtsi |   2 +-
 drivers/watchdog/Kconfig              |   4 +-
 drivers/watchdog/mt7621_wdt.c         | 118 +++++++++++++++++---------
 3 files changed, 81 insertions(+), 43 deletions(-)

-- 
2.25.1

