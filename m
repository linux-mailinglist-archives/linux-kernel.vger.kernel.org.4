Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D057611842
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiJ1QyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiJ1QyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:54:05 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE8E21CD41;
        Fri, 28 Oct 2022 09:54:03 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id kt23so14268728ejc.7;
        Fri, 28 Oct 2022 09:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VlWXXhBJnoc4ngEOzP/zoEPXuNu3Pcb27/diH3nA+U=;
        b=LZzR4NF5aoNbliaJSdl30q2EeC7dveHrEZucBmr23Nlq4IrlxZQkMjIW7sDrxWvoN8
         ZH+klDe6aAHzQATRGHz8yf+Fl2GXzKKKD+yilDoMpyjCqEnn4pX5MQ+o0mI8TeeQbmdW
         oKvLqfzKbhkewDLcdKdmr0Z7bIw6jwfZghXizSP5p1eELZwPrC+wmHoCRZwgd+PwCIN6
         IzcAWNLUIJ6LJOjRm9brUnjpjrcAVWBhMX2HrZXFKVt79h9x1ktnCcRths+1BgWnv45P
         H8y96CMGIIHJv+U2qnkiyINb8a/MwbEuwLN0SjVV1OTnjP/xHtAH+tBcnBwsqKdtw/XC
         037A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VlWXXhBJnoc4ngEOzP/zoEPXuNu3Pcb27/diH3nA+U=;
        b=pfCm+hGzFb8YeDVzDLYEN0x5kR8JwpGt1UIp3bX0/WSEmaF0UrYDR9qcUgoIvO47cp
         3xLfaxdxpGh/9yd1n7J8WldV4BBej2gX8UlL6yA1cbsjt+aUsq/v8wrqGD2O6soTz6rB
         QCHqFSEZFQG+5+89iugV3HuF2mDdq0HLdS5/hCN2GwKScbc3tBHYW6c/AfuTo1/0NldP
         YwQxkDtza9K6tNKVHoug5DmCun/lhy4+A1aowngLFGQ+h9adLBAK0OFIFt6OWLZbkWCs
         vrSMtq0TRu4vENvRaRmlFbpasdDUILKtHEFzCwrc35I6pI3Dg88bG15sNN8rGeDIZ9m/
         4yRg==
X-Gm-Message-State: ACrzQf2PmfSzKTpSMsqBk10e2SR8uVGZEVsNO1GzEquLnr41sBrMzGlr
        P+0V9EoHUB+7tl5q097QTMI=
X-Google-Smtp-Source: AMsMyM5cCSODkVuBwT/DJJYlpmYX8i7CSbA1kEFYW/4yDxRGIAM38PVcrW56Lv4bA3NjSchaBDai7Q==
X-Received: by 2002:a17:907:6d84:b0:78d:f2b0:14c8 with SMTP id sb4-20020a1709076d8400b0078df2b014c8mr202721ejc.749.1666976041659;
        Fri, 28 Oct 2022 09:54:01 -0700 (PDT)
Received: from localhost ([88.227.58.131])
        by smtp.gmail.com with UTF8SMTPSA id p17-20020a17090653d100b0077826b92d99sm2417677ejo.12.2022.10.28.09.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 09:54:01 -0700 (PDT)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
Subject: [PATCH 4/4] MAINTAINERS: Add entries for Apple PWM driver
Date:   Fri, 28 Oct 2022 19:52:16 +0300
Message-Id: <20221028165215.43662-5-fnkl.kernel@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20221028165215.43662-1-fnkl.kernel@gmail.com>
References: <20221028165215.43662-1-fnkl.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the MAINTAINERS entries for the driver

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e04d944005ba..4c9719a2439a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1908,6 +1908,7 @@ F:	Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
 F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
 F:	Documentation/devicetree/bindings/power/apple*
+F:	Documentation/devicetree/bindings/pwm/pwm-apple.yaml
 F:	Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
 F:	arch/arm64/boot/dts/apple/
 F:	drivers/clk/clk-apple-nco.c
@@ -1921,6 +1922,7 @@ F:	drivers/mailbox/apple-mailbox.c
 F:	drivers/nvme/host/apple.c
 F:	drivers/nvmem/apple-efuses.c
 F:	drivers/pinctrl/pinctrl-apple-gpio.c
+F:	drivers/pwm/pwm-apple.c
 F:	drivers/soc/apple/*
 F:	drivers/watchdog/apple_wdt.c
 F:	include/dt-bindings/interrupt-controller/apple-aic.h
-- 
2.37.3

