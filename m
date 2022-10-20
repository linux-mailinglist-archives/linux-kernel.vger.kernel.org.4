Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6F560582E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiJTHQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiJTHPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:15:53 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AA814139C;
        Thu, 20 Oct 2022 00:15:19 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c24so19523205plo.3;
        Thu, 20 Oct 2022 00:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNv8gA8tAsxZ3GhCAF/BB0Hgp4c3hGik+Ae8sy7Xxgg=;
        b=UySHkiLLUhvWYZUz5+vP/sN1hRjw2qhcKJyMiic7+RlJAdy/IyIjAE0N66MCiSMba7
         5MqS1RaIY05BjMlrH+b48TYi+5zew37TsKtCROStHKvVzaDyDAV6xxIFvAPn506eHBG+
         WAbDM1UvnskoKRqK8Pqx90uWMiGCer8zI9/sAogabu3v+B0qz9oynZ3USvFEM1+81ovN
         boDEL2XXSenCMXPRY7gHDOmhd7dD4kK+9wc1NPtepON0/kJUBuBMQV+bqwzW5WLh8YD+
         ZJFTij9O9FF9277t9Od+MpJbQRTYQrX7sOmEavEgN74fAdrXbWYzxt38BClzkE7Ur7lB
         IeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNv8gA8tAsxZ3GhCAF/BB0Hgp4c3hGik+Ae8sy7Xxgg=;
        b=Z8MC2SKl66R1XahE9RbuerhRCS88PlfG1UvlC7LRKgl/PAG6TSKwNswkCUnwOxBS5P
         7x0ihpzq23HyjOgB/1/dlW5lKZNXLjZo6m42Tz0d5SjDnezgRzQXbMYKqwXW5h1FsQwu
         90SGH5sBPh91lBIcSNBZdgIcfMejkCPjZWD7TCDv82Z9GNTgLaBqTMvRCf5VUnjclV1Z
         i1hMWjFha0JTn3eF1afjB4hET70HQ7Od/7wvq0QV4x+Gzr1xFXnWIyAETcqdcWDciVO3
         sOwMTg8klwXfdqobKfcOEWIVXyrHUqxHyYhKm+AHWevBNhvQ+uUao4mgkq1ZZOwWBzG/
         WzCw==
X-Gm-Message-State: ACrzQf1vbvLNMGm1lt/Mz2nMdOqfvNCWPzf5cXkNT98fl3jSI6Cl+2LT
        puEsVWfjGf8OeNOKontKd3edn4PaxP8=
X-Google-Smtp-Source: AMsMyM5bpeF60pYKXigMLi7Ar/ypS+EihUO/SGfjtBbDyhk5zzR/YlS7zLdP1gRVpnJPSfJmOoe8+w==
X-Received: by 2002:a17:90a:e7c4:b0:20d:451f:a988 with SMTP id kb4-20020a17090ae7c400b0020d451fa988mr14007973pjb.57.1666250068287;
        Thu, 20 Oct 2022 00:14:28 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:a12c:444a:ed28:4831:fc95])
        by smtp.gmail.com with ESMTPSA id m8-20020a170902db0800b0018157b415dbsm12094679plx.63.2022.10.20.00.14.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Oct 2022 00:14:27 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     cy_huang@richtek.com, allen_chiang@richtek.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Add Richtek RT9759 smart cap divider charger support
Date:   Thu, 20 Oct 2022 15:14:18 +0800
Message-Id: <1666250061-18686-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

This patch set is to add Richtek RT9759 smart cap divider charger.

The RT9759 is a high efficiency and high charge current charger.
The efficiency is up to 97.8% when VBAT=4.2V, IBAT=2.5A, and the maximum
charge current is up to 8A. The device integrates smart cap divider topology
with a dual-phase charge pump core and 9 channel high speed ADCs to monitor
the charging process.

Since v2:
- Add Reviewed-by tag for dt-binding patch
- Change ABI document date from Oct 2022 to Nov 2022 and KernelVersion
  from 6.1 to 6.2

ChiYuan Huang (3):
  dt-bindings: power: supply: Add Richtek RT9759 smart cap divider
    charger
  power: supply: rt9471: Add Richtek RT9759 smart cap divider charger
  Documentation: power: rt9759: Document exported sysfs entries

 Documentation/ABI/testing/sysfs-class-power-rt9759 |  37 ++
 .../bindings/power/supply/richtek,rt9759.yaml      |  61 ++
 drivers/power/supply/Kconfig                       |  15 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/rt9759.c                      | 611 +++++++++++++++++++++
 5 files changed, 725 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-rt9759
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9759.yaml
 create mode 100644 drivers/power/supply/rt9759.c

-- 
2.7.4

