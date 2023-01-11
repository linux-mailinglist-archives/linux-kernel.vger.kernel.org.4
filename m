Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA366665B39
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbjAKMTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjAKMTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 07:19:22 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7001BC31;
        Wed, 11 Jan 2023 04:19:21 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id b3so23244919lfv.2;
        Wed, 11 Jan 2023 04:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iC5Tm3f1bIyIFR/SNMJvXCgdTLuVzDKlqQ4xdi94zMc=;
        b=YeIjkL73qjiBNqZcNqCIWv3VfCydmTEmjEfQTKQU7PTKOaCzIFsgYIscICX3JHz6XJ
         MIWgvpCYYuFXGJnBu9ex9yYfswihiFIrhKvEAAg9fgAJsxlMp6roaKMMe+6qQz8QDui9
         WxAB1cdROtn34/7PCE80aVJBCpZYEl101aC2GrUe4P3pA7fQM3CpkuqrTXBm/JeCgOoJ
         VFrneKecW1weCXNYiV9NeEpmEeeCU0dCtAOnip/US5BfUYZnkEmExWxdRsd+hkXDtLfJ
         ghj0XMJ+wn72EGOapIqjCMYGCFMO7xCr6e4J8iqBKNYbnkza0YL7syHaZai2W9lrgnVH
         5hIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iC5Tm3f1bIyIFR/SNMJvXCgdTLuVzDKlqQ4xdi94zMc=;
        b=L/ZdgGwasdrgY7l1p34uq/SnLjKPNfbv8injeVCIeY9voxSVNi1Jyo4mhbBX7K0Sew
         yLf9xW4m4wYNXFSUWl3/58yB//lOWYDCxnAcP+gKv9OufdGo22vhb53rabxyvUMRNzdg
         BOvZU0AuII54vTrMTV231uz9OsdyrExijuWlp9iv8RDYm3wkewChDVCFgDxXIVRwh1yP
         wPfSwngLkG7URaOtGKv7ioVz3h9wsBImjTwJlGW+WSSNa3PkaJDkF1KES4s3cJS/FoDJ
         Hfh89jwtyRZxWQRMJ4IBiayUgK3ZE7t640PbQe3LMyqO/x22b5ltJ6mN869rOfeljY5K
         J+eg==
X-Gm-Message-State: AFqh2kq4lT0xoPLIPq9CBamb6FST40Si4VA/E89XveFI/E3AmW9Dpfcc
        REmjHOfsdjIcwcG7vg1hIkU=
X-Google-Smtp-Source: AMrXdXt/35t0+3ucLLkQao5tN+iGBAwNJg1p5KDkdOIcCLnfQqPY3oznuDNR7dPpDy4v4d94rH5Ldg==
X-Received: by 2002:a05:6512:2349:b0:4a4:68b9:66cd with SMTP id p9-20020a056512234900b004a468b966cdmr20243785lfu.24.1673439559709;
        Wed, 11 Jan 2023 04:19:19 -0800 (PST)
Received: from PC10319.67 ([82.97.198.254])
        by smtp.googlemail.com with ESMTPSA id f14-20020a0565123b0e00b004b7033da2d7sm2701530lfv.128.2023.01.11.04.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 04:19:19 -0800 (PST)
From:   Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     Konstantin Aladyshev <aladyshev22@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: ethanolx: Enable VUART
Date:   Wed, 11 Jan 2023 15:19:17 +0300
Message-Id: <20230111121917.1636-1-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Virtual UART (VUART) module. This module provides virtual serial
communication capabilities between host CPU and BMC and can be used for
the Serial-Over-LAN (SoL) feature implementation.

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
index d8e8fca44c78..6bded774c457 100644
--- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
@@ -5,6 +5,7 @@
 
 #include "aspeed-g5.dtsi"
 #include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "AMD EthanolX BMC";
@@ -275,6 +276,12 @@ &lpc_ctrl {
 	status = "okay";
 };
 
+&vuart {
+	status = "okay";
+	aspeed,lpc-io-reg = <0x3f8>;
+	aspeed,lpc-interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &pwm_tacho {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.25.1

