Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2299620C2D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 10:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbiKHJ3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 04:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbiKHJ3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 04:29:10 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99306BDE;
        Tue,  8 Nov 2022 01:29:09 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id j12so13652646plj.5;
        Tue, 08 Nov 2022 01:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhquCNxmj0tC0Y1mqZV0fd38EeRIsiOPftoxsnYtrZw=;
        b=DZNEBycTqiCz+7bAyRIJ8gpffcgZmGri10+0rSgz74wddC/7ZMZpWGRlYUZE4E036Q
         fh8arMBqo+Mkw8y4jPPgwwp38FKO+zOX5Sbfe9dKf8x/0PhI2Xv9kJclg04cEgn1EwHw
         ngXUC0xSZIs7nCi8+hCjH59LRwzmczXW96/sAPA2nobWwSO9NpKUTvDrfUyTvkfS69aY
         DfLxW01WITl292Lyy15RFjqARjc4fnCgGPjsjowAQqkXQEoxot8+jdbArz+SYxiDAHP4
         a3xdVqzwkzPGP/QATUZn5pmtsUc6hDJXORKmOk9gpsDJilw8E7pEvePoGIPiLMpBx4z5
         zLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhquCNxmj0tC0Y1mqZV0fd38EeRIsiOPftoxsnYtrZw=;
        b=tsfyhW4Zp5xp2Nox9eNJGTC9567sT+pGMm72yeBhMonpVBldf9KneoFEAP6aV+q5mZ
         SRDBzsiE+o37MdoWKlRzlhkHBpdzf3/HEqGfCEpyNYIgVmuVWwtalzb9pbuoxxSj/ngE
         agkQJd+CQAOOzIC64miJYCnwPJm13oK9z1PzK2FVa+wLn4KGj0V1ybc7CdZFxnVbVxel
         q1ypfqdXX3mFblp8SBG1pTjshdM6lnxZwNeUni/8wf49qmBCfe6nQ9M6M1zrMTwtuQUV
         fCdvygsq1Z3yTNAx7ILtgv98SU2cwzJpWtaJcU7ise3KwroxD0ba/KeWY3c35AFIGsTn
         /ajw==
X-Gm-Message-State: ACrzQf10OfzJzpvKdOLQGJVctunGDmbi+GbfsqMRIIaPEMNdVlVr6INa
        3gqSROH4w2dfWVGaCCtAsjQpYB7zlyY=
X-Google-Smtp-Source: AMsMyM5NzUFgTEXXrK5ktQjLyqFKibaere+M3Puz0MsE5HIPBekAOhVzrznxVqXjiK0op+/W+Pb5wQ==
X-Received: by 2002:a17:903:2446:b0:187:11c6:6a1b with SMTP id l6-20020a170903244600b0018711c66a1bmr48620825pls.39.1667899749144;
        Tue, 08 Nov 2022 01:29:09 -0800 (PST)
Received: from localhost.localdomain ([180.217.157.203])
        by smtp.gmail.com with ESMTPSA id x17-20020a170902ec9100b00186727e5f5csm6467147plg.248.2022.11.08.01.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 01:29:08 -0800 (PST)
From:   Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To:     JJLIU0@nuvoton.com, jim.t90615@gmail.com, KWLIU@nuvoton.com,
        linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
Subject: [PATCH v2 0/3] Support Nuvoton NPCM750 SGPIO
Date:   Tue,  8 Nov 2022 17:28:37 +0800
Message-Id: <20221108092840.14945-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NPCM750 include two SGPIO modules.
Each module supports up eight output ports and eight input ports.
And each port have eight pins, so each module supports up to 64 input and 64 output pins.
the output pin must be serial to parallel device(such as the hc595)
the input in must be parallel to serial device(such as the hc165).


Jim Liu (3):
  gpio:gpio-npcm-sgpio: Add Nuvoton sgpio driver
  arm: dts: nuvoton: npcm7xx: add sgpio node
  dt-bindings: gpio: Add Nuvoton NPCM750 serial I/O expansion
    interface(SGPIO)

 .../bindings/gpio/nuvoton,sgpio.yaml          |  79 +++
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi |  30 +
 drivers/gpio/Kconfig                          |   8 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-npcm-sgpio.c                | 640 ++++++++++++++++++
 5 files changed, 758 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
 create mode 100644 drivers/gpio/gpio-npcm-sgpio.c

-- 
2.17.1

