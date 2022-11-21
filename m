Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A43632B5D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiKURp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiKURpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:45:21 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6B057B69;
        Mon, 21 Nov 2022 09:45:19 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id v8so6285261edi.3;
        Mon, 21 Nov 2022 09:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNL6IfTe0wzPq8NWBK/D96/5y8l3oPapGeg3sP1iP80=;
        b=dLhwAvRFJe9dchF5SlF7ogMjH13Pn6iK4bxfoIQiE97ocKlAgrKq3Ar3GgtgtJKfGJ
         s/O72OTVsNvv/EiYuci7viuu6cDSVg22gjpQLhVYJHIlvsVhHPTbmiber2ea9U9GrLb3
         JsVBE1OojpPa1oX3NA0Bk1bmjuH/4QGz35S4ErMgIwB7uRJ8VKuFHWGECFZOB1dM6QcM
         u8P32EeuImZq7VHnVYE0Ity0o12rE81sECLWAV5Z+2oKSbokt9Rxkn/lq8ymXNoZORno
         RA/kd0GE//5CNTFYaKh0Ox/dgx1dQYtgjQN1ilhQil8pIApqLdb6WEkjdYHpG+p36LzT
         TogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNL6IfTe0wzPq8NWBK/D96/5y8l3oPapGeg3sP1iP80=;
        b=AbaM6D/ukKbftvZX0twQfL93er2P7ivN+I/aqDDWCMLJpesLJTCE+C7J4lJL7fgCeW
         JWjqbz5A+358e8SMEex+rrCWPEzrOJO4WBF72LhTXCWiniCedc6tS9GvS0qV+556vzSY
         6IpScXvekBSrrZnUzZT0iikf3mw53tr3eY0ByLH0xObpddsrdZb+5L4GhDIZOEN3mRsw
         YCBAwUFih/4/qesZGTGAVBnPbCMbTOE+xsTYUPeqQKBYZFWsVilDB52RoI4LN9nWV+kX
         jy+vJ4QXWUnid3Qh5AqRD1xcWPjUVmQSTHkpKP5kko6UYdeURd3KU2QFlMnuomYPsUdt
         NCtw==
X-Gm-Message-State: ANoB5plmhIqrGY+lTY1g9k7kliHu167TIWNfZsinmMnuHic4bLnPC8D+
        MTSBLdSrNKuzgnglBmtj/Xg=
X-Google-Smtp-Source: AA0mqf5tktH45X/K7WSst1WSDXG6NCTfMsMwbFnE94eu773Cg61+GPcdMqm0ADWd+wNyEsvR1EuCxg==
X-Received: by 2002:aa7:db90:0:b0:459:aa70:d4fd with SMTP id u16-20020aa7db90000000b00459aa70d4fdmr16907330edt.162.1669052717948;
        Mon, 21 Nov 2022 09:45:17 -0800 (PST)
Received: from localhost ([217.131.81.52])
        by smtp.gmail.com with UTF8SMTPSA id g2-20020a056402428200b0046146c730easm5464345edc.75.2022.11.21.09.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 09:45:17 -0800 (PST)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
Subject: [PATCH RESEND v3 4/4] MAINTAINERS: Add entries for Apple PWM driver
Date:   Mon, 21 Nov 2022 20:42:28 +0300
Message-Id: <20221121174228.93670-5-fnkl.kernel@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221121174228.93670-1-fnkl.kernel@gmail.com>
References: <20221121174228.93670-1-fnkl.kernel@gmail.com>
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

