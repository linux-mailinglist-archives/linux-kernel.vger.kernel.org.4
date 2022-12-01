Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333A663F61C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 18:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiLARZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 12:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiLARZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 12:25:29 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109A525C65;
        Thu,  1 Dec 2022 09:25:29 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-143ffc8c2b2so2936453fac.2;
        Thu, 01 Dec 2022 09:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=o4SL2qQtVNDajwN9ygYSjpW78VenkkkZuoHCF2FKV6M=;
        b=KylwmePAilaWNd40ryK6VQeiIE9BXRlJ4iPgzRzp7xChDfebK32ZQCj0EWZ0YUymUf
         QWdAA7Ykv0m6QBKgtj1a8eydzlnMfdRzpWkJcN0k5Tf++xbJOOb1PCXPvkBMtLoZ1Wgd
         eE7voof6QUKwsjr0LybzNzJ3YNc1OE9mkLz7CdVfHC/iMKLltRRVvgPu6M1KL9g3oEeI
         SRPySUTkZQoiP+p5Gq/JsizL3ifnHGoKMkKYYUFUNVDdjbxYhTad2jnvgv6/vNdXtOIV
         9qS2aK2kF1zC/SJQkdUrmPiQ5+0pXiR9ungnJpty2PoATqkxg9f3776cgGaKgZbxTXKv
         2gcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4SL2qQtVNDajwN9ygYSjpW78VenkkkZuoHCF2FKV6M=;
        b=tA49DHLd6GeweD3PNnqQZjRBTdeWY8y/jVFJpXE+kLjJarc8Hgcwq20le6bzkJt0lm
         YBaw24nsyiPNB88ftjbI2nsshhLj3yfqfucy7qpTDI+nWUVQUILWryQiQKqQbFGMVdPL
         Z3Zt8WGD4rvtcNYghnl21wGI70Gsgr3y3oRKssv52KtZL+qIL9jaERV5hhyIiUUHbgz7
         YxIh9xH+TerDZvSZFFQp7nM4g8dThYDBkI5loZ0gLEzNL99BUXlI7/s0hQ1ii6n2UKY5
         Je9mmUotIb0tu346zvANAIfJtbNuyfVbFfOWKP9ujIcKLlcxWAnvuWkTrsRDW1rP+C/3
         jwDw==
X-Gm-Message-State: ANoB5plWs5B2gCksnkb+mPgMQggp9hip8QMQzW1sFCOm1qvyfYTKtrhi
        y0pDeGTPfYzXtsNP4OEy8ExCxYiN+EM=
X-Google-Smtp-Source: AA0mqf7xlmd6CKHc12w3hACcxP3J/URytYcUGpV39hcAzjBPlBXu3XzHg4EnB37+8PQCP6QD1bVDdA==
X-Received: by 2002:a05:6870:9a18:b0:142:efc1:1394 with SMTP id fo24-20020a0568709a1800b00142efc11394mr26395149oab.11.1669915528295;
        Thu, 01 Dec 2022 09:25:28 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o13-20020a056870524d00b00130e66a7644sm2954746oai.25.2022.12.01.09.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 09:25:27 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v6.1-rc8
Date:   Thu,  1 Dec 2022 09:25:26 -0800
Message-Id: <20221201172526.2290129-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.36.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

Please pull hwmon fixes for Linux v6.1-rc8 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.1-rc8

Thanks,
Guenter
------

The following changes since commit 094226ad94f471a9f19e8f8e7140a09c2625abaa:

  Linux 6.1-rc5 (2022-11-13 13:12:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.1-rc8

for you to fetch changes up to 9bdc112be727cf1ba65be79541147f960c3349d8:

  hwmon: (asus-ec-sensors) Add checks for devm_kcalloc (2022-12-01 09:20:55 -0800)

----------------------------------------------------------------
hwmon fixes for v6.1-rc8

- Fix refcount leak and NULL pointer access in coretemp driver

- Fix UAF in ibmpex driver

- Add missing pci_disable_device() to i5500_temp driver

- Fix calculation in ina3221 driver

- Fix temperature scaling in ltc2947 driver

- Check result of devm_kcalloc call in asus-ec-sensors driver

----------------------------------------------------------------
Derek Nguyen (1):
      hwmon: (ltc2947) fix temperature scaling

Gaosheng Cui (1):
      hwmon: (ibmpex) Fix possible UAF when ibmpex_register_bmc() fails

Ninad Malwade (1):
      hwmon: (ina3221) Fix shunt sum critical calculation

Phil Auld (1):
      hwmon: (coretemp) Check for null before removing sysfs attrs

Yang Yingliang (2):
      hwmon: (i5500_temp) fix missing pci_disable_device()
      hwmon: (coretemp) fix pci device refcount leak in nv1a_ram_new()

Yuan Can (1):
      hwmon: (asus-ec-sensors) Add checks for devm_kcalloc

 drivers/hwmon/asus-ec-sensors.c | 2 ++
 drivers/hwmon/coretemp.c        | 9 ++++++++-
 drivers/hwmon/i5500_temp.c      | 2 +-
 drivers/hwmon/ibmpex.c          | 1 +
 drivers/hwmon/ina3221.c         | 4 ++--
 drivers/hwmon/ltc2947-core.c    | 2 +-
 6 files changed, 15 insertions(+), 5 deletions(-)
