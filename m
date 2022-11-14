Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B126276DA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbiKNH5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbiKNH5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:57:48 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36751237
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:57:47 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l39-20020a05600c1d2700b003cf93c8156dso7266641wms.4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3U74mFDMpN62FdLEwAEXWD976tY7wKj8syGMpCbQ/2s=;
        b=U49NwKMRpu9BVfE8/S/Bu/n5Y5Nt+7hkJJFiVIiNWD898lHThkA5CAlwSiNTWwEPE1
         PJVj4yh7koHVDTlkFMCn/3KkDsJXZMT8nQLn5vlG3gJgfSYEJN1RQG4WxVg0WSIUfYJk
         qk7YEpV6SAFk3PVnKNTm99BrN3BGCKwYkFm/rhAElfkpKjjozxV0a7FDJ3xAZ4YFYYjJ
         UMz1mxlItvO73rhJlnzk5A+g7Uo5uN9oK8wOBjpYxJBm5UsxGu8M1Wnib7w8+DvCiRO8
         aZ3j8jZYN4CQxSFUIJMMML8tOe2sDCTnJ0nenSxdCc7+lIk6C988CZljO0+DgobKk8lG
         sHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3U74mFDMpN62FdLEwAEXWD976tY7wKj8syGMpCbQ/2s=;
        b=qRS96ML+WkPaBbqLeWwwVrAhdtm1Fq9KtCQujYOrAjyDEaZzlXGrKA500UcAsw3Rwd
         bA6AiN/0sclIrJ1IC/ZveqccV7LZA+6IHQSiSJilZ+8DcANp6PVqkKdaFekVpZBe1Ph+
         9uFvezqHEJy7nh0s52paIZHO4AcYd5YberXfScwSzuT5zq1JUPKxBAdQFjxB9lARNwBz
         fTaZDP7r+uLULsXTWIcFYb8R/b6qLGtttDz9BqUD/TEngEduzSKNzEczBWztmYEiTSVt
         6AzNVTOtbovORdHraUweEbhL8bDXlllf8E//YFiK0pnFSs5JmNY5eMVMSkga3PecmOkN
         kMkw==
X-Gm-Message-State: ANoB5plsHvuYGftm0REObxNpFva+MA6dmq5/649ZRzHOyxCUPPD80VUO
        zgFbd9B+5Gvrl8QcywY0XVEoXJhxDPZ4vxE1
X-Google-Smtp-Source: AA0mqf4sSjWC4fiTrv54VzXcqDPNsiM57TAYLdUTPhd73MNacaC5CSu3ZLwRtsBPj30iqjJ/gN9f2g==
X-Received: by 2002:a7b:ca52:0:b0:3cf:81af:8b69 with SMTP id m18-20020a7bca52000000b003cf81af8b69mr6695103wml.147.1668412665455;
        Sun, 13 Nov 2022 23:57:45 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id p25-20020a05600c1d9900b003c64c186206sm11617768wms.16.2022.11.13.23.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 23:57:45 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v9 0/2] mfd: max597x: Add support for max597x
Date:   Mon, 14 Nov 2022 08:57:37 +0100
Message-Id: <20221114075739.4117439-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
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

max597x is multifunction device with hot swap controller, fault
protection & upto four indication leds.

max5978 has single hot swap controller whereas max5970 has two hot swap
controllers.

Changes in V9:
- Update properties description
- update required property
Change in V8:
- Set additionalproperties to false
Change in V7:
- Update id
- Remove empty line
Changes in V6:
- Update missing vendor prefix
- Update indentation in example
Changes in V5:
- Fix dt schema error
Changes in V4:
- Add NULL entry for of_device_id
- Memory allocation check
Changes in V3:
- Address code review comment
Changes in V2:
- Update depends in Kconfig.

Marcello Sylvester Bauer (1):
  dt-bindings: mfd: Add dt-schema MAX5970 and MAX5978

Patrick Rudolph (1):
  mfd: max597x: Add support for MAX5970 and MAX5978

 .../bindings/mfd/maxim,max5970.yaml           | 172 ++++++++++++++++++
 drivers/mfd/Kconfig                           |  12 ++
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/max597x.c                         |  92 ++++++++++
 include/linux/mfd/max597x.h                   | 103 +++++++++++
 5 files changed, 380 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
 create mode 100644 drivers/mfd/max597x.c
 create mode 100644 include/linux/mfd/max597x.h


base-commit: 6b780408be034213edfb5946889882cb29f8f159
-- 
2.37.3

