Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A17861E282
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 15:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiKFOHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 09:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiKFOHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 09:07:10 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DED4958F;
        Sun,  6 Nov 2022 06:07:10 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-13c2cfd1126so10188712fac.10;
        Sun, 06 Nov 2022 06:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2KhYhp2BwkuWBEvWp+z7vdf8yClr0/C6oTL4ZhQsXHc=;
        b=h9iVakAxBuQR8O0gRXf9iumT6VSg28deMK+k7Qdlh0ktdRFDf/CfjFGy2OoO8DAaCk
         1JG/v6mxtOj38AAs6KYNAS/UN49qaHn0zEiPeo4sKuakvZ8G7TgMD3njxyZ4/7YAXh6z
         8/cRxdxQSUDbeyEui6FgUNxpf4faoaBra8815FqcZ8v3GtpGOtRg+L4IMAgnxhN5NDX3
         xYBWDKAmjWkQAO3cAyomAAkAbm1IkDCsa3QYEr1C6onW9OHFMU/FHG9iBEen/WRpSiWE
         /eOX5bA9qRKL3oHrGdpO1JgO0LeSi58R9RIXn9I/LRkI4enjXt0yvUgpRreN04q6wWH1
         /OTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KhYhp2BwkuWBEvWp+z7vdf8yClr0/C6oTL4ZhQsXHc=;
        b=IQqKziAXSWJu6WezQwJzMrlqJTMR5guDBGhY6RtijGMo6mGKzMW7wsEuwkRJonI1MA
         GuB7S4RoRI53eJhaSSbueRWsqBMXZDPBLz+Plaac1PE9+7jFGvI6gQJT7jxK17u4CqTf
         LCovI7d7baTV+hJcJAIXNpuCrwUJbYYtAXYBzOwOp+s0PlBir4jsPcFRgFfrD3ZLCQXS
         dP3VR2bk48k6apbUEju+5crR0NrFgJekrP+fcaVUTZrHsUk3f6G+T241aev5rDL95XeA
         lXA7MnXa3INmMaMH3SPVLAIInnr0w165tIrE3QCdpP7HlmAPSDge0Mdn2aXNEcQfBB1i
         K+sw==
X-Gm-Message-State: ACrzQf0fV6zy+pxFCR023Tw5JIybjzFzz95KWMOKiwKormaB3KKBotwg
        sa7V0vX1CaRuH8ZsBV4aC0x0B3uwEfM=
X-Google-Smtp-Source: AMsMyM4Ew2NSS4liq5UU3de2aiBY9yMDPmg6umCLzma1g+EgiPVQjLRH9mdEHxHsOzM14uO7CjasvQ==
X-Received: by 2002:a05:6870:5a9:b0:13d:9452:c8e1 with SMTP id m41-20020a05687005a900b0013d9452c8e1mr10622738oap.188.1667743629233;
        Sun, 06 Nov 2022 06:07:09 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ba12-20020a056870c58c00b0013b911d5960sm1895535oab.49.2022.11.06.06.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 06:07:07 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v6.1-rc4
Date:   Sun,  6 Nov 2022 06:07:06 -0800
Message-Id: <20221106140706.808902-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.36.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v6.1-rc4 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.1-rc4

Thanks,
Guenter
------

The following changes since commit 30a0b95b1335e12efef89dd78518ed3e4a71a763:

  Linux 6.1-rc3 (2022-10-30 15:19:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.1-rc4

for you to fetch changes up to 1e699e177e339e462cdc8571e3d0fcf29665608e:

  Revert "hwmon: (pmbus) Add regulator supply into macro" (2022-11-04 16:47:01 -0700)

----------------------------------------------------------------
hwmon fixes for v6.1-rc4

Fix two regressions:

- Commit 54cc3dbfc10d ("hwmon: (pmbus) Add regulator supply into macro")
  resulted in regulator undercount when disabling regulators. Revert it.

- The thermal subsystem rework caused the scmi driver to no longer register
  with the thermal subsystem because index values no longer match.
  To fix the problem, the scmi driver now directly registers with the
  thermal subsystem, no longer through the hwmon core.

----------------------------------------------------------------
Cristian Marussi (1):
      hwmon: (scmi) Register explicitly with Thermal Framework

Guenter Roeck (1):
      Revert "hwmon: (pmbus) Add regulator supply into macro"

 drivers/hwmon/pmbus/pmbus.h |   1 -
 drivers/hwmon/scmi-hwmon.c  | 116 +++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 103 insertions(+), 14 deletions(-)
