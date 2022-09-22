Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18585E5A6A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 07:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiIVFHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 01:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiIVFHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 01:07:36 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D194BD1D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 22:07:33 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n15so6682534wrq.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 22:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=tK5lHod9VIHuRKzd2GfoBvHOMOlwl6X/2A4iC9byFb8=;
        b=a9md+zipNrdcG51Uh3J+YDPzyDFpdS5vspX0xhvCCjhvHC7hX/jgD6RRtjMWCAlPh/
         ZJQBhdeyucGybkXSexctNtWZu+2wGFzaxsb32PQTND4DticEkFQp6ybznXkkXmQ0NXNN
         M6+R955dcU869qQjJiMuG8kWsh+cRD/R/E2/H1nARjEjpqfHuh3QDWnXXbNZanJA6rE9
         xmFQStY4c5GBmQXXK7nOaBtKa1EmvTjXV0qgK7BGL0NejFwGrUDs9iS8e9TOO8bj3ioK
         808FtGjqFhCuUhCAcooUr8Y0B35hw95EeMButTH55Os2lk5xgKB4S/5g/zO2RqfdlWb+
         FIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=tK5lHod9VIHuRKzd2GfoBvHOMOlwl6X/2A4iC9byFb8=;
        b=etJQO5KW/bWUwubymi0xyHLTOUutWYK6vTat2r2+Qvgkxo1k36Z9NXZa09c/7ylV1j
         zD/ODFxC3ki55hP09CXIHLMlYFJiXkBnLr4LobLFVoH670lOHckCZlwJi5KE7nbrpKst
         5W2MnJ0dK0ia9jwk20GtgrM39Q3lWgy/kAB6JDwn1Djlo3V4dbqIV0oDBsuSDZ66sWaO
         IJEkUSkGn+kVD2+k2f0XLc24KTOM+oLbt+JbyQix2RAcNCAt8YgaR6agGbgcHCBpy4F2
         DlK+FF0OcyOHIB0JDBCZ4oqQzPC97KX24cOwpeNJALwii5j4VEMjol2UpmLBKlurTL/o
         cVVA==
X-Gm-Message-State: ACrzQf0kmjywDXmndDO/vAwT0aGYUy4y8r+PzqptvscotR4KzfgaRC+D
        i9dpXMYxOXo91u6rVcgv1iO6ZQ==
X-Google-Smtp-Source: AMsMyM5eCpN6/NrR5/m8G++8LJFcS8SxeD5LG49USZN9hSF4Aa6pRv+23IrjXrTI+WFSmDl93Op4vg==
X-Received: by 2002:a5d:5a9e:0:b0:22a:498d:d2fd with SMTP id bp30-20020a5d5a9e000000b0022a498dd2fdmr744732wrb.390.1663823252350;
        Wed, 21 Sep 2022 22:07:32 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c294c00b003b47ff307e1sm4569595wmd.31.2022.09.21.22.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 22:07:31 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH 0/2] Add max6639 regulator and devicetree support
Date:   Thu, 22 Sep 2022 07:07:16 +0200
Message-Id: <20220922050718.1079651-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add devicetree support for MAX6639.

Changes:
- add dt-binding
- add max6639 specific property i.e., maxim,rpm-range

Marcello Sylvester Bauer (2):
  dt-bindings: hwmon: Add binding for max6639
  hwmon: (max6639) Change from pdata to dt configuration

 .../bindings/hwmon/maxim,max6639.yaml         | 112 ++++++++++++
 drivers/hwmon/max6639.c                       | 162 +++++++++++++-----
 include/linux/platform_data/max6639.h         |  15 --
 3 files changed, 231 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
 delete mode 100644 include/linux/platform_data/max6639.h


base-commit: 9f6ca00b5be47e471e9703e6b017e1e2cfa7f604
-- 
2.35.3

