Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD8D6B5863
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 06:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCKFGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 00:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCKFGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 00:06:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E611AFCBDE;
        Fri, 10 Mar 2023 21:06:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B98BB824AA;
        Sat, 11 Mar 2023 05:06:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 060E6C433AA;
        Sat, 11 Mar 2023 05:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678511193;
        bh=DxASz2lknCh6bcl9lub36jkmurw78TkqTmOu4olxjho=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=sOK+tXURFP3I8gTppzO0QuicQxfTdI8fKexF1ffSZ3+DJYdacA2zaePHMJXZSDpfN
         LzMPOH4hWU3uHX4bbslW8q26uuG3z/yTFYggF2MkjqvdpSfn72FlXXgYJ1+lzrsjsm
         Sfopp/u1EiekcDc/8wzY22lIKXaaZEs88n+NtmR0wBoy5vWUKMtbsDY/NGRX9h+ytq
         IQ1xtW30Egtk/ixU/RwsYDcQIXSjy1yMRgcZC/9dpOtkKw5VS++yuJHQOo3zumpWCI
         wQAu0XPUeHxRXLRnGkE4wabjQYqRibl2ybMJ2PIjXKIxzy5gwQFuEH6jUnL/zrYE99
         HL3Vs7/Lm6b7A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id E5F1EC74A44;
        Sat, 11 Mar 2023 05:06:32 +0000 (UTC)
From:   Sasha Finkelstein via B4 Relay 
        <devnull+fnkl.kernel.gmail.com@kernel.org>
Date:   Sat, 11 Mar 2023 06:06:32 +0100
Subject: [PATCH v9 5/5] MAINTAINERS: Add entries for Apple PWM driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230214-fpwm-v9-5-364480b0e4bd@gmail.com>
References: <20230214-fpwm-v9-0-364480b0e4bd@gmail.com>
In-Reply-To: <20230214-fpwm-v9-0-364480b0e4bd@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678511189; l=1109;
 i=fnkl.kernel@gmail.com; s=20230213; h=from:subject:message-id;
 bh=H0yqy74irk0iRnaCY9EguySiHLNBuNpFanSkZMAqDr0=;
 b=PcMZBCrVi/e9W8Otf7XTmZGMc4MjUtkj0HBqoBtpfvEzAtx7XqQL6SfFhs+dWz5SmJlh3Ti94
 1F6Eum2+tIEAK39r2Br7mm3TL4YUqnjU4nZHVCLXUblESYNGIiylfaO
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=7LFSAJtxIWAs9LzCIyX0sSvCZy2wQTyEIu1zch6o804=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20230213 with auth_id=28
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: <fnkl.kernel@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Git-137.1)

