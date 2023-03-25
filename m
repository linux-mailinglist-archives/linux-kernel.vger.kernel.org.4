Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C266C8EB8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 15:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjCYOAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 10:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjCYOAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 10:00:34 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09359F956;
        Sat, 25 Mar 2023 07:00:30 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-54184571389so86406847b3.4;
        Sat, 25 Mar 2023 07:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679752829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jzre8f4hGLlDzi3bj0dGGgAsLeP1auJA2cIh37SnOJY=;
        b=jKUMP0wiU8HtJdcVHiYJuzfrG3Oz0va4tEInOqhd2RNolxlb+X5hrJg3QaUIe3KCxw
         9EYfQZiNBVXGPnM/ateiR5RjljPoV8TVVCsEQ3fHrjoOw6/c6lKRNE6zSRM/1/LS3szS
         JBdLL91SFZyToyaRIhxVTHyy/ZtFxuFfF//FRh3x18cUK854f/orQKqflfaX28NjuPt8
         /ZKRoLGvBhoEK6AL9KJi+RSHRgqJ+edZp20FkqLVn9777GUBo97wsdfEhm1mzVjjQWXw
         JXjRr1cPh7bx50aSykq46EQeqTZsHpAJzCMW0rXl/jriylw5Do4t+SMlvm17fTVUIQ+4
         CD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679752829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzre8f4hGLlDzi3bj0dGGgAsLeP1auJA2cIh37SnOJY=;
        b=vy/2xax7XiKJUT1/pJZrBXAU0Y/xlrBhbQWQFX2OjWlXNUycUdIkjS8srSF88IhrL8
         hAfspX6NSkPl4Xg9iSQxDL7TQKvhDuYI1jiqlWS5fXO2NckawxICf3993nd6tcXmKfSa
         BLjKzyILE3tJTFqseXevEie5k3m0XuPJFCbVDloEAHVZ6ex0fHUckiaNN42wN8X5xN9U
         ZjYScMbnoYufHowpWmRRVWU1tvguhwjZwoXa/o4SX8l1o02zdU24r7t/fQcaRr10worw
         LsvqHJDR6YYV+W8VuWVT/oXjaARrx7xm5Nxcs2JWzPAh7MIE/4UaTpPcz5U298TmbTVP
         qQ1w==
X-Gm-Message-State: AAQBX9crgafOgJxApPSK1tp7OSQYj12Vl4i+cvh6v+0teJ+B2eC37fK+
        wayJsPlGGdd69SdzNGII3WQE3B+p9Z4=
X-Google-Smtp-Source: AKy350bqIIasSid2iQNUPTdmlLHPwXQYzgBzHWXNl5ydEAz3J74dt36ehLPIt3ry/yRcI9ikuRYiEw==
X-Received: by 2002:a81:6cc7:0:b0:540:62ba:c2a0 with SMTP id h190-20020a816cc7000000b0054062bac2a0mr6283503ywc.3.1679752829225;
        Sat, 25 Mar 2023 07:00:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ci27-20020a05690c0a9b00b00545a0818477sm963971ywb.7.2023.03.25.07.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 07:00:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v6.3-rc4
Date:   Sat, 25 Mar 2023 07:00:26 -0700
Message-Id: <20230325140026.3591525-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v6.3-rc4 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.3-rc4

Thanks,
Guenter
------

The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.3-rc4

for you to fetch changes up to 968b66ffeb7956acc72836a7797aeb7b2444ec51:

  hwmon (it87): Fix voltage scaling for chips with 10.9mV  ADCs (2023-03-21 19:14:55 -0700)

----------------------------------------------------------------
hwmon fixes for v6.3-rc4

- it87: Fix voltage scaling for chips with 10.9mV ADCs

- xgene: Fix ioremap and memremap leak

- peci/cputemp: Fix miscalculated DTS temperature for SKX

- hwmon core: fix potential sensor registration failure with thermal subsystem
  if of_node is missing

----------------------------------------------------------------
Frank Crawford (1):
      hwmon (it87): Fix voltage scaling for chips with 10.9mV  ADCs

Iwona Winiarska (1):
      hwmon: (peci/cputemp) Fix miscalculated DTS for SKX

Phinex Hung (1):
      hwmon: fix potential sensor registration fail if of_node is missing

Tianyi Jing (1):
      hwmon: (xgene) Fix ioremap and memremap leak

 drivers/hwmon/hwmon.c        |  7 +++++--
 drivers/hwmon/it87.c         |  4 +++-
 drivers/hwmon/peci/cputemp.c |  8 +++++++-
 drivers/hwmon/xgene-hwmon.c  | 14 +++++++-------
 4 files changed, 22 insertions(+), 11 deletions(-)
