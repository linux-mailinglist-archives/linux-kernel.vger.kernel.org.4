Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87FE67B586
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbjAYPLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235947AbjAYPK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:10:58 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391AD58289;
        Wed, 25 Jan 2023 07:10:57 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h12so13377349wrv.10;
        Wed, 25 Jan 2023 07:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K04NI6H8f8RRsBW0KL8tL6HKr2Bz5cQXmicJNH1klmM=;
        b=SA2NQRG/L8QUVWZChVmJ1+8+IwRHdlSAEQCRRz9NBXcZi7iBjHxcyQuHGJt43u4c6e
         llYwjNEegTZnZmdn9Fb5EXaLrLNQC/2/LbrSvfh0phjkGDAtovHvnZOuedSGpM9yxdHr
         cq7cHgRrXAnI0s1mFRwHG/ivgoWw588IqPFeC1EZcLdIWz4jseGVZeQIGV1ZC66Nz/hw
         U1j5SOasK12fW7FmEPaIjqRxH19RHXfm0aTCiBDwJac2TqBNelUnjDwPy85fziB74Dwk
         Pm8pGjiubUTQPnfbXFnNxO0K/ZDNakTMM64W10ZdIfD+bpJK3QmTTJr8LoPjUptYOkg9
         UJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K04NI6H8f8RRsBW0KL8tL6HKr2Bz5cQXmicJNH1klmM=;
        b=k9IJTsN1k3N1C86bdO9+6956OVFKMwGmhCfjqklfE4S0UUv6lMIBN5VJkF7OR3UPgU
         GbiXQ2K0CTJsMf+hnAPzwYRhs0DFH4/j3oX3jz19ol5wnql+mjoAHab39hZaI8XP3Jqe
         g4k4FD/Iyui09OzmxVptwXdwDy4FFAKvsE7JUhbbo2vouJ8qDfF9gyunNoKzuBU6HAOh
         AwaPNpZ+SPBfTkjyzWNyxqhQ5+E8FWF2c0v3u5ULcK6xAzaXtox9NoTlgn2WiqOoaCWd
         P+MRBbTFyYxBBGcem2i1MVEi2vOFS5JNCOYeQhfIgG69PiomtQBaJj3NcrofTERxecIi
         ayVg==
X-Gm-Message-State: AFqh2krkZf2rAqmoGS10iOmvVjGYfdwMQKdY+Ep6dbrCPsvwFR6zrguL
        CZnrZjqfdNx+n2f4YlaSuH8=
X-Google-Smtp-Source: AMrXdXv8xSDMKuPB22yoht7YSdJKa83pN2WZr5uVBiJfuWmo6tGV5xAiy6noeRVyDoNTBw+2C4pl2g==
X-Received: by 2002:adf:fbd0:0:b0:2bd:eb6a:cd43 with SMTP id d16-20020adffbd0000000b002bdeb6acd43mr26306973wrs.15.1674659455687;
        Wed, 25 Jan 2023 07:10:55 -0800 (PST)
Received: from localhost ([82.222.96.52])
        by smtp.gmail.com with UTF8SMTPSA id v7-20020a5d6107000000b002bdc914a139sm5344448wrt.108.2023.01.25.07.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 07:10:51 -0800 (PST)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     u.kleine-koenig@pengutronix.de, thierry.reding@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
Subject: [PATCH v7 0/5] PWM and keyboard backlight driver for ARM Macs
Date:   Wed, 25 Jan 2023 18:10:36 +0300
Message-Id: <20230125151041.55483-1-fnkl.kernel@gmail.com>
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

This is the resend of the v7 of the patch series to add PWM and keyboard
backlight driver for ARM macs. No significant changes this time.

Changes in v1:
Addressing the review comments.

Changes in v2:
Added the reviewed-by and acked-by tags.
Addressing a review comment.

Changes in v3 and v4:
Addressing the review comments.

Changes in v5:
Added t600x device tree changes

v1: https://www.spinics.net/lists/linux-pwm/msg19500.html
v2: https://www.spinics.net/lists/linux-pwm/msg19562.html
v3: https://www.spinics.net/lists/linux-pwm/msg19901.html
v4: https://www.spinics.net/lists/linux-pwm/msg20093.html
v5: https://www.spinics.net/lists/linux-pwm/msg20150.html
v6: https://www.spinics.net/lists/linux-pwm/msg20190.html


Sasha Finkelstein (5):
  dt-bindings: pwm: Add Apple PWM controller
  pwm: Add Apple PWM controller
  arm64: dts: apple: t8103: Add PWM controller
  arm64: dts: apple: t600x: Add PWM controller
  MAINTAINERS: Add entries for Apple PWM driver

 .../bindings/pwm/apple,s5l-fpwm.yaml          |  51 ++++++
 MAINTAINERS                                   |   2 +
 arch/arm64/boot/dts/apple/t600x-die0.dtsi     |   9 +
 .../arm64/boot/dts/apple/t600x-j314-j316.dtsi |  18 ++
 arch/arm64/boot/dts/apple/t8103-j293.dts      |  17 ++
 arch/arm64/boot/dts/apple/t8103-j313.dts      |  17 ++
 arch/arm64/boot/dts/apple/t8103.dtsi          |   9 +
 drivers/pwm/Kconfig                           |  12 ++
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-apple.c                       | 159 ++++++++++++++++++
 10 files changed, 295 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
 create mode 100644 drivers/pwm/pwm-apple.c

-- 
2.37.1 (Apple Git-137.1)

