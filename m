Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F215626082
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 18:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbiKKReh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 12:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbiKKRe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:34:28 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FE5657C5;
        Fri, 11 Nov 2022 09:34:23 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id q9so14249131ejd.0;
        Fri, 11 Nov 2022 09:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNL6IfTe0wzPq8NWBK/D96/5y8l3oPapGeg3sP1iP80=;
        b=ZiUNfWdS+2kgkaKJuTKbf+3zGC6VlGeB9T3IBZAioQZkrkhbJwmO60/IQP7d4odxOd
         UQ9P/NHEflrVY3Um9feS1Tq2bYLLXYUUmZOpTPgtpvRLA1a0cCvcG8zFNIWOKIwtyApR
         kmw9g2Yj5pzFx2qaZzl2VuzjXA859mMBprMcsy+6rpX8mUKZO2UIi29+pX5+5QinRPnt
         te6I9Y0Vl5WvYvNH/QQfWUziOp1hqe1GBkRFVW6YDYRjTnAxRe6pblWJkitt61N++Q8W
         Yky075tee/8i0S7Jdvfa0RullX4+2DxdfuZRmvF2rrsmNWbH72mRmHlzDHiA+ltP6EE2
         TFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNL6IfTe0wzPq8NWBK/D96/5y8l3oPapGeg3sP1iP80=;
        b=l75qbZwtbERoAe1H1n9d1l9fFuFxVW+r4WTrf94poo8ZSUDhzpEttyk0ED4YkpmB/2
         H97i5kEgTw6DpFJeWtHow7sqrdKAAPJKXFodtuwVy8WMLWyanLX2ijbd/TiDW6/D2+4L
         0z4He6iZW7AkA1YVKQJu/K6ycxSXm4yVRHL82tWOk13j6h0sA0D0GtOQeq/htNx5q63I
         GimMy11Ruk+N5E47FLeQ4Y+jVmrEsMiFjzqVFyrsVy9VXMA21OfLbJGmiHfN4n4FU13n
         fW+Ot7UQgiqUrqXgSeXcDlMwojP9MDUAgAWIN/0ecCAJkRZ9y6kYSYNrRARcmBy2h+3a
         4cnA==
X-Gm-Message-State: ANoB5pke60/kgcviB5fGljVJ7w/OU6CnsY0eblDjxzozvJNOIi/eZOSn
        0Pou8wsn1H8q3A002+RgnHs=
X-Google-Smtp-Source: AA0mqf4WNUX8D3AJJ+yKFXFkOeOfQnJkafQvX4JqhdEVmSHraQl66sol6L5QnsfhPdMBvLHU7ww+uQ==
X-Received: by 2002:a17:906:2852:b0:7ad:9f03:fd44 with SMTP id s18-20020a170906285200b007ad9f03fd44mr2722601ejc.73.1668188063262;
        Fri, 11 Nov 2022 09:34:23 -0800 (PST)
Received: from localhost ([85.153.204.139])
        by smtp.gmail.com with UTF8SMTPSA id lb21-20020a170907785500b0073dbaeb50f6sm1072867ejc.169.2022.11.11.09.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 09:34:22 -0800 (PST)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
Subject: [PATCH v3 4/4] MAINTAINERS: Add entries for Apple PWM driver
Date:   Fri, 11 Nov 2022 20:33:48 +0300
Message-Id: <20221111173348.6537-5-fnkl.kernel@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20221111173348.6537-1-fnkl.kernel@gmail.com>
References: <20221111173348.6537-1-fnkl.kernel@gmail.com>
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

Add the MAINTAINERS entries for the driver

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
Acked-by: Sven Peter <sven@svenpeter.dev>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 046ff06ff97f..69f56f7cf907 100644
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
2.38.1

