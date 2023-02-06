Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0571A68BA2D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjBFKaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjBFK3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:29:33 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3FC227AE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:28:46 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id n28-20020a05600c3b9c00b003ddca7a2bcbso8358698wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AE3M2/yhwK/yfMkId8ujWbLu0/ZXL1uAWfn/x+3jb4M=;
        b=k3AAZzYJrq3qu40FpHTzpgncdoVohC5Muj09kxEP9qrBF2OzrRT85Iv3lgMSR4sVQR
         Gi6zilW0eg5XVGjadckbWJjrEXOn9iG3c/KGbxHdEW3w2eV/iCu6LkrZOWn/Yrq1se94
         NOXU7BGLOVBYBQ6sEHlO+fCpV9YUg4y7DV1X5ZIB1iCB+lCVIajFchwvhVX23fnO8b0X
         q757phh0fNjV0m4RECwZqqPlWgXSMU1vM4wVmDhK8px1YWe2x2+cAPTmeXorlidyU3yE
         5eZBibLBVLgCdA8d9NNusaP0WEtp+3C6/ABRkunBpxw4MLXpUfvY12HYsf5RNZpokIz4
         tlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AE3M2/yhwK/yfMkId8ujWbLu0/ZXL1uAWfn/x+3jb4M=;
        b=Aw19w0SyLVAa1aGNJy/jUewgyJqUKzrfd59be0jiFTn+TqyjgtV4fRLj+gAGqwQaQI
         010p6nc1xzUkB5V2ICRjqXxjgiFEB0LcKrlYOh5gT/0wBNGtlXpL+LRdR5S9ZxRlIs9k
         B3optkVbqEIRVP9LsO+P7zIWdj7WLRW6Q2CxUp+5q06KN+uA3RUuxjGdld1JGdE+Eq65
         0VrpYiCVfSrNuXiyYfwP7exexzY+CoPIrSWpszTRy/DbizbCsuMFa9XY37dHqh5BiA98
         /fE/EvHNB5+oAzsl75kG1ps6x2WsE13IcXBoG0FUKV/BCzGNdF2mTQ1MudVq+LCeohEa
         fFpA==
X-Gm-Message-State: AO0yUKWfE4FXK30ZcBOIXxhmjMMrNBFKHfPY0gFXe6rpGoIT4oNcseWG
        qMhZc04g8hbbpqSFwC0gLbmotaY9wmf6cCG/
X-Google-Smtp-Source: AK7set9LIHb8h5pQLf2PzTA19U/1MYtxoMtks2BR2ZclGt3eubrR81sfBlXe4qgro3SVpUGDyaHHmw==
X-Received: by 2002:a05:600c:3795:b0:3dc:5a13:c7d1 with SMTP id o21-20020a05600c379500b003dc5a13c7d1mr302308wmr.16.1675679324076;
        Mon, 06 Feb 2023 02:28:44 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm11002446wmo.21.2023.02.06.02.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:28:43 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 24/37] MAINTAINERS: add myself as sl28vpd nvmem layout driver
Date:   Mon,  6 Feb 2023 10:27:46 +0000
Message-Id: <20230206102759.669838-25-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
References: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

Add myself as a maintainer for the new sl28vpd nvmem layout driver.

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 69d1e8ad52c5..a02a59628f5c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19222,6 +19222,12 @@ F:	drivers/irqchip/irq-sl28cpld.c
 F:	drivers/pwm/pwm-sl28cpld.c
 F:	drivers/watchdog/sl28cpld_wdt.c
 
+SL28 VPD NVMEM LAYOUT DRIVER
+M:	Michael Walle <michael@walle.cc>
+S:	Maintained
+F:	Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
+F:	drivers/nvmem/layouts/sl28vpd.c
+
 SLAB ALLOCATOR
 M:	Christoph Lameter <cl@linux.com>
 M:	Pekka Enberg <penberg@kernel.org>
-- 
2.25.1

