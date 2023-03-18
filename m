Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15E16BFA0A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 13:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjCRM2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 08:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCRM2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 08:28:03 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FEB367CC;
        Sat, 18 Mar 2023 05:28:02 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id bf15so3465053iob.7;
        Sat, 18 Mar 2023 05:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679142481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1kMfWrNyQ1D1ri91TyZtrmDYPVhJFlZsofnqJcHljYU=;
        b=m/SVzELGlViEe/y2fWFpWGDBi6pII2bdmW35mfBP5gQiQOj7OxqwuLsSx+o0kx9XCg
         4skdyfUAaxY+keEvGlgFo5k+g/aU3nEXjWrRpcj2Oc3uOdtjp4pvka6tnNyHsM8+aKZQ
         BecboiuPmtmVcLT8Qd5TN7tip5El1unUjVox/kTDwsYCTC8xlrgAm80wEmrc512Mphy0
         e919atQU3cKlTzTHxhB/7THeNm4K77XHp4CLpMz+m8tX3rrXof1OGUCJK7zSK5xYLePZ
         SUWrIc/mVC4YQyXUudcxvWAIAffu7s3tu1vI9Ye0CWh5jxcAt/ZgeHV6ya8c+I0KohEz
         LsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679142481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kMfWrNyQ1D1ri91TyZtrmDYPVhJFlZsofnqJcHljYU=;
        b=T70yTqf+wIa6YlPoUqN73jnw9E0solS8b1We3Gz4DJx+lgu741qmeEo5mjC7vdSPko
         r+ICCeh9IwOzf4x99ekbM4iFoqBklwuYS1smx7HMSlCwUEFooDu+dcIkwqt7zXWcj+4W
         NzmoMF/hD+wvu579ALJwVU9JiOt/bV3KzMmU6xK9PJoG5XeGPt6+CCz1ely1eTAMqlQp
         ywqEb3QYAE/DULcVbe9TN4j+dIcDDvLJCsT41uR4Tt037x6oVPbhEcskl/c3ri7vDms9
         CDjFgL295jUfpW4/beHmJidEw/R/TtabMKKv02zThzjqc5nvy+D0VrtmvR94DU3OjVFP
         +b2g==
X-Gm-Message-State: AO0yUKU9HoVshXCN60TlWBBMZN34UFeSZBzsEYXSTdh3TecUfsASjfkh
        0SG6W1MpB9YDqHqa1QHkkLdp/dvgGCw=
X-Google-Smtp-Source: AK7set+gexTdc8Ur8d0cBb13JbFlkR9KoLhYjq0ZsExpcwtv9WVby4JVQUfX9t5RKEwJiJacnFqUSQ==
X-Received: by 2002:a6b:da18:0:b0:71f:8124:de52 with SMTP id x24-20020a6bda18000000b0071f8124de52mr1206427iob.9.1679142481331;
        Sat, 18 Mar 2023 05:28:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h11-20020a056602130b00b007535c8726c7sm1323317iov.38.2023.03.18.05.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 05:28:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v6.3-rc3
Date:   Sat, 18 Mar 2023 05:27:58 -0700
Message-Id: <20230318122758.2140868-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

Please pull hwmon fixes for Linux v6.3-rc3 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.3-rc3

Thanks,
Guenter
------

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.3-rc3

for you to fetch changes up to ab00709310eedcd8dae0df1f66d332f9bc64c99e:

  hwmon: (ltc2992) Set `can_sleep` flag for GPIO chip (2023-03-15 19:15:00 -0700)

----------------------------------------------------------------
hwmon fixes for v6.3-rc3

- ltc2992, adm1266: Set missing can_sleep flag

- tmp512/tmp513: Drop of_match_ptr for ID table to fix build with !CONFIG_OF

- ucd90320: Fix back-to-back access problem

- ina3221: Fix bad error return from probe function

- xgene: Fix use-after-free bug in remove function

- adt7475: Fix hysteresis register bit masks, and fix association
  of 'smoothing' attributes

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      hwmon: tmp512: drop of_match_ptr for ID table

Lars-Peter Clausen (3):
      hwmon: (ucd90320) Add minimum delay between bus accesses
      hwmon: (adm1266) Set `can_sleep` flag for GPIO chip
      hwmon: (ltc2992) Set `can_sleep` flag for GPIO chip

Marcus Folkesson (1):
      hwmon: (ina3221) return prober error code

Tony O'Brien (2):
      hwmon: (adt7475) Display smoothing attributes in correct order
      hwmon: (adt7475) Fix masking of hysteresis registers

Zheng Wang (1):
      hwmon: (xgene) Fix use after free bug in xgene_hwmon_remove due to race condition

 drivers/hwmon/adt7475.c       |  8 ++---
 drivers/hwmon/ina3221.c       |  2 +-
 drivers/hwmon/ltc2992.c       |  1 +
 drivers/hwmon/pmbus/adm1266.c |  1 +
 drivers/hwmon/pmbus/ucd9000.c | 75 +++++++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/tmp513.c        |  2 +-
 drivers/hwmon/xgene-hwmon.c   |  1 +
 7 files changed, 84 insertions(+), 6 deletions(-)
