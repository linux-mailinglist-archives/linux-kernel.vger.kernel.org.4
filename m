Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2C76D4769
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjDCOTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbjDCOTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:19:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44722CAE9;
        Mon,  3 Apr 2023 07:19:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 924F9B81BB1;
        Mon,  3 Apr 2023 14:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBF7CC433AC;
        Mon,  3 Apr 2023 14:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680531571;
        bh=xos0D3fdVMOEBHPjf3QnnSL9IaeLNOEWbSRuMsqb6NY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=cPreWi25h4D37MPFSspPF5ffsqnkBojuJ5TzxQnHk17vm7sRyLPUIerYtGP+BS7Dx
         r5DRnHyjThyLYxwaYT55jmk/dgguYVlsvITMUe6g1xHqQMUF3FUJ4DZs8ccLNCCTSi
         uRlm/ujyrhzAz2rjmTjTduiGRUaoSQuikOKUS3LI+8IEzY67QU3xv3G8W9Yo69//O5
         br3dX+6di28hbNGqgjYlB8Q+t7z5GiUGhqyM1W4j1GcPbxC5f9BzbKivpCsv7zTfJA
         clJJKjogFCNbDl75C+YaWhSBRz3TqPqd9CTjl5qaSXK9Q9dkvOcPlqJW5FofmyR2iZ
         70dpLEJJ/ou8g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id DCBF2C76188;
        Mon,  3 Apr 2023 14:19:30 +0000 (UTC)
From:   Sasha Finkelstein via B4 Relay 
        <devnull+fnkl.kernel.gmail.com@kernel.org>
Date:   Mon, 03 Apr 2023 16:19:23 +0200
Subject: [PATCH RESEND v9 5/5] MAINTAINERS: Add entries for Apple PWM
 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230214-fpwm-v9-5-f3094107b16b@gmail.com>
References: <20230214-fpwm-v9-0-f3094107b16b@gmail.com>
In-Reply-To: <20230214-fpwm-v9-0-f3094107b16b@gmail.com>
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
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680531567; l=1107;
 i=fnkl.kernel@gmail.com; s=20230213; h=from:subject:message-id;
 bh=LLne2FY01Cv3xyTc7PhP8exvB0cc4KD6LuWejuJIf7s=;
 b=MR4jjRFtVJL+7RMElEN4l2EhDD5LBOXeL1lW+mDBdzPVj20NpMVkY8UoGEZgo4pCAZz9arb3m
 PvRgRQJ70jjAeY+jXcCaTpL3Hma9PwWktzylk8d/Nc/GwNrBEaFCy0n
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=7LFSAJtxIWAs9LzCIyX0sSvCZy2wQTyEIu1zch6o804=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20230213 with auth_id=28
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: <fnkl.kernel@gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sasha Finkelstein <fnkl.kernel@gmail.com>

Add the MAINTAINERS entries for the driver

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
Acked-by: Sven Peter <sven@svenpeter.dev>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f305..7c0b7c2bb55f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1955,6 +1955,7 @@ F:	Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
 F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
 F:	Documentation/devicetree/bindings/power/apple*
+F:	Documentation/devicetree/bindings/pwm/pwm-apple.yaml
 F:	Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
 F:	arch/arm64/boot/dts/apple/
 F:	drivers/bluetooth/hci_bcm4377.c
@@ -1970,6 +1971,7 @@ F:	drivers/mailbox/apple-mailbox.c
 F:	drivers/nvme/host/apple.c
 F:	drivers/nvmem/apple-efuses.c
 F:	drivers/pinctrl/pinctrl-apple-gpio.c
+F:	drivers/pwm/pwm-apple.c
 F:	drivers/soc/apple/*
 F:	drivers/watchdog/apple_wdt.c
 F:	include/dt-bindings/interrupt-controller/apple-aic.h

-- 
Git-143)

