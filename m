Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C93F5F6AAF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 17:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbiJFPdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 11:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbiJFPdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 11:33:33 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D511BD05F;
        Thu,  6 Oct 2022 08:33:31 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bj12so5312539ejb.13;
        Thu, 06 Oct 2022 08:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZER3GnLgH8ps+jkaQJjcuLnyn92vEKkHnEoe4H1D2LQ=;
        b=kPg81Qchf7R98Q4NLTv6O0eM/pNKIfdLoc9HnSst1neZ4Kmf3Y2+gLQuRf411+j+kB
         PgA598jRhP4c1b2hAhPuIMcRQg3Z3oniT2+zBT5jcAPzo32x1tkkB8IMqQ7l78Scilgx
         qOFhNR3k/ombE+lDhrMHNq9TrylY5IRxKPkBQFuZhJmBtFzcQkILJTjnrVHRadYlZewH
         FlyxHnIfTcT1l+rDA++eyEeoshpOrxSjAJWyp/au19EI3gJ61qnRzklOOG8s5VD08OAw
         Efsh26WCGm31HVahL+y2HQM3C9fLw4WU9PR+Iq06RboRM4q+yjb4D6OZwtNPkGtWk6Dt
         XJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZER3GnLgH8ps+jkaQJjcuLnyn92vEKkHnEoe4H1D2LQ=;
        b=JYbqSHcyaKQx7S9jJb1h4Yb2r2HYsCuYbxXCrnENN4SFuVENg3dfYo7/xJfbv6Txmd
         0XBML9OJGgdlgQLZ5CE3j+ez3PmWaqB6GddsBf1nYX3TKqERhwLW8KBDoEIttRh5rNM5
         0I0LtJXlIIySYL6B1tUUREQWqef59dD6bWPruP1b4jxm6ZDoFGaZJ1+Si02uZ/DqlY6w
         nauvbtlBL95gQFirJMtTDobXk+I2CYbLpU8k6MOROphkmkgJ58pJlhBwzsSXnkhzWxAs
         /wkU2j24yrnExaU/XjUUK5jS6cXW8Vom5PM1DVXW27ZSTC+nHbiahvCQWGlQJ/85PxPD
         QWRg==
X-Gm-Message-State: ACrzQf0REBDuLaABEtQq5j1TrfMeRIh2qfkiwJ6AcYaty4Iy5ggmns8n
        uUXe0fy388yPyd+Cz3B4UO/rVyZR3Q8=
X-Google-Smtp-Source: AMsMyM531iI3Y+qaKGAyVoqVXqcp6yfdS+4q6n9yYy4QxJrR1m3i6VvOUBwhBBLW6JhxqhJmCtLixw==
X-Received: by 2002:a17:907:1c08:b0:78d:3428:644b with SMTP id nc8-20020a1709071c0800b0078d3428644bmr333403ejc.131.1665070409720;
        Thu, 06 Oct 2022 08:33:29 -0700 (PDT)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id v23-20020a056402185700b0043bbb3535d6sm6058490edy.66.2022.10.06.08.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 08:33:28 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v6.1-rc1
Date:   Thu,  6 Oct 2022 17:33:25 +0200
Message-Id: <20221006153325.2253653-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.37.3
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

Hi Linus,

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-6.1-rc1

for you to fetch changes up to 4709f9ea338d34276d747c88323f964e148c0c09:

  pwm: sysfs: Replace sprintf() with sysfs_emit() (2022-09-28 17:52:02 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v6.1-rc1

The Rockchip and Mediatek drivers gain support for more chips and the
LPSS driver undergoes some refactoring and receives some improvements.
Other than that there are various cleanups of the core.

----------------------------------------------------------------
Andy Shevchenko (9):
      pwm: sysfs: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      pwm: lpss: Move exported symbols to PWM_LPSS namespace
      pwm: lpss: Move resource mapping to the glue drivers
      pwm: lpss: Use device_get_match_data() to get device data
      pwm: lpss: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr() macros
      pwm: lpss: Make use of bits.h macros for all masks
      pwm: lpss: Add a comment to the bypass field
      pwm: core: Replace custom implementation of device_match_fwnode()
      pwm: sysfs: Replace sprintf() with sysfs_emit()

Johan Jonker (1):
      dt-bindings: pwm: rockchip: Add rockchip,rk3128-pwm

Sebastian Reichel (1):
      dt-bindings: pwm: rockchip: Add description for rk3588

Uwe Kleine-König (1):
      pwm: lpss: Deduplicate board info data structures

xinlei lee (1):
      dt-bindings: pwm: Add compatible for Mediatek MT8188

zhaoxiao (1):
      pwm: rockchip: Convert to use dev_err_probe()

 .../devicetree/bindings/pwm/mediatek,pwm-disp.yaml |  1 +
 .../devicetree/bindings/pwm/pwm-rockchip.yaml      |  2 +
 drivers/pwm/core.c                                 |  2 +-
 drivers/pwm/pwm-lpss-pci.c                         | 48 +++++-----------------
 drivers/pwm/pwm-lpss-platform.c                    | 40 +++++-------------
 drivers/pwm/pwm-lpss.c                             | 46 ++++++++++++++++++---
 drivers/pwm/pwm-lpss.h                             | 12 +++++-
 drivers/pwm/pwm-rockchip.c                         | 18 +++-----
 drivers/pwm/sysfs.c                                | 20 ++++-----
 9 files changed, 92 insertions(+), 97 deletions(-)
