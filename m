Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFF3648165
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 12:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiLILOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 06:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLILOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 06:14:42 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02B31F9DF;
        Fri,  9 Dec 2022 03:14:41 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m4-20020a05600c3b0400b003d1cb516ce0so5510279wms.4;
        Fri, 09 Dec 2022 03:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aptsriDL75Ig6gjid308/Jf1kFuZ73/LpGcnByUwftU=;
        b=Tc35s68OF5v/x5JicHtvMLmwSH8H8p5eYTwOaTIPhnSP8L3O4gM+ZWgXAqgbmMWT6I
         +LQ3awlxrnDCU1IkqCWUKc5co5vIituYd4IaOGiXt2GXLJLF4mT3OpErbIfjjbX4jwqa
         ukD5OwKhFtqys/G5DSP1uCXyAT6H6lwqWCEuB2qyIvbM9AMuCKuq+Y1UhNR7OPrGOYzq
         4X3pS+Nns9YEJTxQAsjiXjvu4R4K6db8McQ+uzd641csHEpgzAIr030PogKu+8MuvaKC
         JpnehUiyhcRAA1fTEQIyg2/Krxw9Wn17It8sjZ1tvIr1Wp55h93x9w63jvqWi5usu188
         CEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aptsriDL75Ig6gjid308/Jf1kFuZ73/LpGcnByUwftU=;
        b=jfKjZXgpX96UqSNvSoD/FU8KOrw14CnVAe1Eey7Z0oFykHqsG/Gm2z82cL8RPaYUui
         PbVp60xgSRPIM8L948Jszoq0MsargCDf7Q2NjJQx6jOFkLXo6nnsVOYj2Mh341cFpQO2
         01bF/j12l589mZiSB379NghIFIPyp3xCDEjmBpdiCzVDNQMhUTEmAaq6r9mM2q9oSdBT
         AcP2L5oXdUD3rJ9iuLz37G6MDeTS2cBjfoLouBoyj3h7PSKoqdjbDHNJZAp/qk2wgW7M
         O080aPC/q6qjir58KiYrE2fcLFkzz8EpBWV2QgdC809f8ZBwZBaqNfb4Zk8mQaigWPsV
         gTsQ==
X-Gm-Message-State: ANoB5pkTdHCUYAgcUhq7kEGtcv+asC2aEF2GbygKkHpYr6Q+qNPQO646
        ox4UfQX89TpwjdVIQT7nP64=
X-Google-Smtp-Source: AA0mqf6vJvsHf/sOnwWAxNsXK0x2d6BbzHfgigIkSOCuPrOv+Y6tlWVGrIjefUs5N4uvSBIzkS2A+Q==
X-Received: by 2002:a05:600c:4e54:b0:3cf:51cf:91c with SMTP id e20-20020a05600c4e5400b003cf51cf091cmr4503087wmq.11.1670584480443;
        Fri, 09 Dec 2022 03:14:40 -0800 (PST)
Received: from localhost ([217.131.81.52])
        by smtp.gmail.com with UTF8SMTPSA id bg9-20020a05600c3c8900b003c6f3f6675bsm9149366wmb.26.2022.12.09.03.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 03:14:39 -0800 (PST)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
Subject: [PATCH v4 0/4] PWM and keyboard backlight driver for ARM Macs
Date:   Fri,  9 Dec 2022 14:13:09 +0300
Message-Id: <20221209111313.2701-1-fnkl.kernel@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the v4 of the patch series to add PWM and keyboard
backlight driver for ARM macs.

Changes in v1:
Addressing the review comments.

Changes in v2:
Added the reviewed-by and acked-by tags.
Addressing a review comment.

Changes in v3:
Addressing the review comments.

v1: https://www.spinics.net/lists/linux-pwm/msg19500.html
v2: https://www.spinics.net/lists/linux-pwm/msg19562.html
v3: https://www.spinics.net/lists/linux-pwm/msg19901.html

Sasha Finkelstein (4):
  dt-bindings: pwm: Add Apple PWM controller
  pwm: Add Apple PWM controller
  arm64: dts: apple: t8103: Add PWM controller
  MAINTAINERS: Add entries for Apple PWM driver

 .../bindings/pwm/apple,s5l-fpwm.yaml          |  51 ++++++
 MAINTAINERS                                   |   2 +
 arch/arm64/boot/dts/apple/t8103-j293.dts      |  19 +++
 arch/arm64/boot/dts/apple/t8103-j313.dts      |  19 +++
 arch/arm64/boot/dts/apple/t8103.dtsi          |   9 ++
 drivers/pwm/Kconfig                           |  12 ++
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-apple.c                       | 150 ++++++++++++++++++
 8 files changed, 263 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
 create mode 100644 drivers/pwm/pwm-apple.c

-- 
2.37.1 (Apple Git-137.1)

