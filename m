Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9337E6B5858
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 06:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjCKFGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 00:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCKFGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 00:06:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ADEDBC5;
        Fri, 10 Mar 2023 21:06:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32AB160180;
        Sat, 11 Mar 2023 05:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CF29C433EF;
        Sat, 11 Mar 2023 05:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678511192;
        bh=JtaChBzQYjkgb+S2k3CoH3RkfeBU7ykcjARdKyumD6c=;
        h=From:Subject:Date:To:Cc:Reply-To:From;
        b=boUmyt+9Zm9O3hPEycjvot9epCsxP5qDfxn9lnKwAQtE/wg1izCHOr+ahrLfodjO7
         tI+Z9JfDTyaENHk2hnx26bUu/XfYJ21Yjn6H2uQ1rtAS5bszENOzt/rfeN7PCZ3ylf
         HSKwLFjIJcwBLAn/ZBUgRCVvai/A5BYnB8f5YpV9pT1YWAuNJQ8lygzUPjEm8S8dx3
         uVhOXXCxKvwDE6LDu/+2fW7m7JMTPfOhdPKHh8DO7YBdLgiBHC7rBecGNnCWloAD8N
         ljJ27ZMVCHq5NbSJzdFNsj6fkIeesNm8JuhGMYTw+CATY9c9b5pv3dHh3LNsICwaqt
         oT7gotnmVM+vQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 79F0FC61DA4;
        Sat, 11 Mar 2023 05:06:32 +0000 (UTC)
From:   Sasha Finkelstein via B4 Relay 
        <devnull+fnkl.kernel.gmail.com@kernel.org>
Subject: [PATCH v9 0/5] Hi,
Date:   Sat, 11 Mar 2023 06:06:27 +0100
Message-Id: <20230214-fpwm-v9-0-364480b0e4bd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFMMDGQC/22Nyw6DIBBFf8WwLg0qCnbV/2i64DEoSREDhrYx/
 nvBVdN0ee/cc2ZDEYKFiC7VhgIkG62fcxhOFVKTmEfAVueMGtK0pKkpNsvTYc0N66XiWqsa5ak
 UEbAMYlZTGTsRVwjlsAQw9nX4b/ecJxtXH97Hu8RK+2NODBNsJBG9NFKTll1HJ+zjrLxDRZD4P
 4hnqO+6mgui6UDpN7Tv+weMR6Z/5gAAAA==
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <asahi@lists.linux.dev>,
        Sasha Finkelstein <fnkl.kernel@gmail.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sasha Finkelstein <7d578vix8hzw@opayq.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678511189; l=2127;
 i=fnkl.kernel@gmail.com; s=20230213; h=from:subject:message-id;
 bh=JtaChBzQYjkgb+S2k3CoH3RkfeBU7ykcjARdKyumD6c=;
 b=KvIygfPgjrmTwD2LsY8STmFh9Tn0+VjO04VlDpXGwtsrcgxHwkps6z6+DgJQiDo8WMKw5B586
 Ywr44R7TX74Cs7FGFFSQ388dd5gNS0d/TPRG44jR6fmC6TkTpAGKAYF
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=7LFSAJtxIWAs9LzCIyX0sSvCZy2wQTyEIu1zch6o804=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20230213 with auth_id=28
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: <fnkl.kernel@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the v9 of the patch series to add PWM and keyboard
backlight driver for ARM macs. 

Changes in v1:
Addressing the review comments.

Changes in v2:
Added the reviewed-by and acked-by tags.
Addressing a review comment.

Changes in v3 and v4:
Addressing the review comments.

Changes in v5:
Added t600x device tree changes

Changes in v8:
Changed the overflow handling to clamp instead of erroring.

Changes in v9:
Missed a spot where clamping should be applied. Fixed that.

v1: https://www.spinics.net/lists/linux-pwm/msg19500.html
v2: https://www.spinics.net/lists/linux-pwm/msg19562.html
v3: https://www.spinics.net/lists/linux-pwm/msg19901.html
v4: https://www.spinics.net/lists/linux-pwm/msg20093.html
v5: https://www.spinics.net/lists/linux-pwm/msg20150.html
v6: https://www.spinics.net/lists/linux-pwm/msg20190.html
v7: https://lore.kernel.org/r/20230214-fpwm-v7-0-fb0a6bfbd037@gmail.com
v8: https://lore.kernel.org/r/20230214-fpwm-v8-0-65518a0d4944@gmail.com

---
Sasha Finkelstein (5):
      dt-bindings: pwm: Add Apple PWM controller
      pwm: Add Apple PWM controller
      arm64: dts: apple: t8103: Add PWM controller
      arm64: dts: apple: t600x: Add PWM controller
      MAINTAINERS: Add entries for Apple PWM driver

 .../devicetree/bindings/pwm/apple,s5l-fpwm.yaml    |  51 +++++++
 MAINTAINERS                                        |   2 +
 arch/arm64/boot/dts/apple/t600x-die0.dtsi          |   9 ++
 arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi     |  18 +++
 arch/arm64/boot/dts/apple/t8103-j293.dts           |  17 +++
 arch/arm64/boot/dts/apple/t8103-j313.dts           |  17 +++
 arch/arm64/boot/dts/apple/t8103.dtsi               |   9 ++
 drivers/pwm/Kconfig                                |  12 ++
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-apple.c                            | 159 +++++++++++++++++++++
 10 files changed, 295 insertions(+)
---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230214-fpwm-d8f76bc8ddc1

Best regards,
-- 
Sasha Finkelstein <fnkl.kernel@gmail.com>

