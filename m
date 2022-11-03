Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8B1618AA0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 22:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiKCVef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 17:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbiKCVeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 17:34:31 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BFF205CD
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 14:34:30 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a14so4626155wru.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 14:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FU1biKPNaMrVrfMfS/cMbDD3VDogi7+hixB8NxqtjUU=;
        b=aez89FowVGLmljMWoxs9uY4bYW5Evns1l2erpjLe8kCpR2+MI9j+F6U1+i9gmvWLWV
         QWUl8RcJJwFsVJx/mc3RfEC0sevE0JUCZB2dJvT/SkdHn2thxqiQuWILNRtZATE+IGu4
         AextxmVxtdQ2Xt6vbFVlkpdAJ6Oa3nJsuT8QjKUovga1CjyYGtTN1kkOnL6/CeieAR7a
         lVIXDiUstuh4zW0jYO9kXAYrjGKzYh2Ao1gbQknLkqRj+J14TEsUx4foErM+ZPEmMnqo
         Y+3e/gC6KpWGGTbX2M8eXiyh2XaZfjtVTENAkbG4lmkFi6sV9OV46A76fKUM0/thrAXo
         LRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FU1biKPNaMrVrfMfS/cMbDD3VDogi7+hixB8NxqtjUU=;
        b=tlk2QDkt6IJFYg/qENPZkNTGeKQdhNEwmeSROjpz87WJy1ockIE9VL1HGF4cRHIBtX
         frItcu7bKVMtejxNanSj9ueqw0i7ZX0HvGBli3aWe7mDlSEWnUoeZeqWANt7LN1Mc94g
         6AOfNo/xKKVhanNSfKR8GO9lVx7Xw3M/eJjagD6DlaDAuz3HgrRYPRkniKxC5JfSj5hj
         InD6gK/ZY3nyIh93cD7MPSHrRH/+z6GYUUICUt3H44usiaKU8VPwGtjnCYLT3tKs7Da2
         V7yuMnUoe7/PnOIVDGH49gF2ZhMZ8n/pooF7TCv1ScsRbnxRVdWkKD757ddXPHoRw0KB
         SeKA==
X-Gm-Message-State: ACrzQf2w+lR4Ecu6IJ869E9sh32ZyBovJLvARVRso4ljm764KhsYDe0x
        KEXoRe8jQ/WQ8/94teylee/rJk7d0uUcyU0x
X-Google-Smtp-Source: AMsMyM5onYk+70UofaWQtrMixi6I+de28mPZhvbEba/xUcxjEaSXtjZuvLTkP2c+cGobgRTdQe4HHA==
X-Received: by 2002:adf:e84f:0:b0:235:d53a:2d7f with SMTP id d15-20020adfe84f000000b00235d53a2d7fmr20719446wrn.334.1667511269190;
        Thu, 03 Nov 2022 14:34:29 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id bq7-20020a5d5a07000000b0022e035a4e93sm1757027wrb.87.2022.11.03.14.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 14:34:28 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v8 0/2] mfd: max597x: Add support for max597x
Date:   Thu,  3 Nov 2022 22:34:23 +0100
Message-Id: <20221103213425.2474772-1-Naresh.Solanki@9elements.com>
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
  dt-bindings: mfd: Add bindings for MAX5970 and MAX5978

Patrick Rudolph (1):
  mfd: max597x: Add support for MAX5970 and MAX5978

 .../bindings/mfd/maxim,max5970.yaml           | 170 ++++++++++++++++++
 drivers/mfd/Kconfig                           |  12 ++
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/max597x.c                         |  92 ++++++++++
 include/linux/mfd/max597x.h                   | 103 +++++++++++
 5 files changed, 378 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
 create mode 100644 drivers/mfd/max597x.c
 create mode 100644 include/linux/mfd/max597x.h


base-commit: 6b780408be034213edfb5946889882cb29f8f159
-- 
2.37.3

