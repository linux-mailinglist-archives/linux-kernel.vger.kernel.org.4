Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB29614FBB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 17:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiKAQx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 12:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKAQxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:53:54 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EDD1CFC5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 09:53:53 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id r186-20020a1c44c3000000b003cf4d389c41so10359277wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 09:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5KTGPfY53P6cSiWbqgN1AbYmbLHz/QFsA7amJqzGEz8=;
        b=BKtB6UXAvsLm60XezA/LxdRsAgUUriBKU+eyxF1llBnM9ezcy+A+/zjjSy+muf5Nmd
         a7WRm797TVYB40i+OdGEhyne1/JU5c4TLtFWvbAVvfoa0cBSUHaUCJPjN/6iyBl/7Nmi
         blRPf52o4BNM9rTOvJMAlIgLEn+OHmaBS4/idq17zfWdbaPd57QrjLXZ1ek4MFXDQL4o
         0+ATLJYwn3bXbn3mnhlB/xkhp0fUQ/t0GmXis6pW2AyvT0u96rLOnAppgOeuujZZQoZL
         R3q3RyJOyHC1G+wpjS6OcdEiJ5WOQYNISGLnBZuaD7Pg99U8HhOlvONlnTYcqjMFuBHy
         CpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5KTGPfY53P6cSiWbqgN1AbYmbLHz/QFsA7amJqzGEz8=;
        b=kFcMh6xRTc8Cs9DyzjzjGPWzPzb7wob6BVO2CyWQNSifzLM+gpqy42zngwmrMT/Ck2
         eq/Ua/61oty4BHFoEs4jInwOeA7vvB0dfsbfHxqMJpCj8Zjr5k6L6GxPgR65TODkJsak
         g49K96im224OwdzqS3yl3Z5LlVrLz5DvN8NBVpb8qgx2XAl6zUaoOreCqW4Haf9ymnKu
         fFUuq2DVwDx7BGmoubTol68yUQ0wTZkCqAQGDB/0yYeJXkkBn+u5AEnBw6ctg/gJ7YyL
         yhz0AZDJUmaU4OfWkXHi2kM18GtPjfKXUt+FCuQiEh/WrRNbc/AyPd+S1Uifr9Sn5OiD
         txlQ==
X-Gm-Message-State: ACrzQf3Tcju6/cG0LAsU+9gb1vUZONVUcwTQUaqcgGus+pRk+9Nn/wtB
        9BqbY3kWmC8g9to95yEJPI1Lv4wLYL5LRj8p
X-Google-Smtp-Source: AMsMyM5dXXrw0MM2O5QP0x/65SBi13YnmixamTQ4rydgW+ET402KeKWueFRNbQq3JuVPCN8LVCEzDQ==
X-Received: by 2002:a05:600c:154f:b0:3cc:767a:4653 with SMTP id f15-20020a05600c154f00b003cc767a4653mr23216611wmg.70.1667321631791;
        Tue, 01 Nov 2022 09:53:51 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c35ca00b003c6f1732f65sm9186716wmq.38.2022.11.01.09.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 09:53:51 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v4 0/2] mfd: max597x: Add support for max597x
Date:   Tue,  1 Nov 2022 17:53:42 +0100
Message-Id: <20221101165344.3455723-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

max597x is multifunction device with hot swap controller, fault
protection & upto four indication leds.

max5978 has single hot swap controller whereas max5970 has two hot swap
controllers.

Changes in V4:
- Add NULL entry for of_device_id
- Memory allocation check
Changes in V3:
- Address code review comment
Changes in V2:
- Update depends in Kconfig.

Marcello Sylvester Bauer (1):
  dt-bindings: mfd: Add bindings for MAX5970 and MAX5978

Patrick Rudolph (1):
  mfd: max597x: Add support for MAX5970 and MAX5978

 .../devicetree/bindings/mfd/max5970.yaml      | 164 ++++++++++++++++++
 drivers/mfd/Kconfig                           |  12 ++
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/max597x.c                         |  92 ++++++++++
 include/linux/mfd/max597x.h                   | 103 +++++++++++
 5 files changed, 372 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/max5970.yaml
 create mode 100644 drivers/mfd/max597x.c
 create mode 100644 include/linux/mfd/max597x.h


base-commit: 6b780408be034213edfb5946889882cb29f8f159
-- 
2.37.3

