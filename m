Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7693C68DC90
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjBGPIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjBGPIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:08:30 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BB517CD4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 07:08:24 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id bg5-20020a05600c3c8500b003e00c739ce4so3061817wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 07:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xervDpi9D639e9DmVkznZiAeNp4KA5UAiEcaVrDAWRQ=;
        b=bwIrr9KidC8Qn0R8ATT8N5cRgCb1mbPALzqcqYGbi3HIifdS+hZeXXejIs1vkeR3P1
         +ri+ni7agOD9Qpn93hZAIoFmsNptdkPQgAkayVNVsmk79XKApQeGbM/LvC7bG9P4/R6x
         kZzgJXBVfi3KP+LeEJ7/1kYC6LH7/2KiqU/5UNk7ABNNl5Dx8Bf/I6Zs1RP89Wkgzwqq
         327w7evF4Yf3jAvuziHNB9TRYPEknTgJV3A24rRvUT0IkwX8MGTkwBdNoA43WR4jA/1f
         O3jiEZGyZEx0qJczhEQcx76fag5ZPVbFqVyRhueOZpqmrRksZn5Ukq+DMqV1acfzDOiy
         ry+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xervDpi9D639e9DmVkznZiAeNp4KA5UAiEcaVrDAWRQ=;
        b=qYQVBeP17hNUP4nePRYfQvbIyYjrYxY9CYt08MnFBxuq1MNKgenEc5m7e66tsj4Auj
         MWvkO77Aayq8i2p6wl4eJnTHrsG5fGXqgc7nxTcODPoKgU94uwz9J9vFXG+AhzXueuQ+
         Ya2VGtI79srfRuZ33PZnFoSzcY4XvrCZL+ZW+lQCEu+ypIegL6b8oYtIeXTYa9Ej7NP9
         2itLiC0P26+AJZxb6atXMODLXjbl/6lhrC7Exvsqlm1X/hFOvKF7CUi2RU/rA5Yl32jj
         umZ8hqM8XZ4bGlGmNcYXzjdNBnao6019lwX6JAwZK+iUEgpdSgD+PWrhmctj6JQisMUC
         /1hA==
X-Gm-Message-State: AO0yUKXnVCTaJKNyyj+06RzT+RwpvuaKl3b7hnvGwRB0cvCioLQNKxSL
        JuHJoCDMhT+8JIro6rv0aCC3mA==
X-Google-Smtp-Source: AK7set9clGcAkYsuGtSupI1CVB5MZwN0SdmoLG01l6SzS7ZVU5JafWQcOjImOdmzeKWDn29HnXxb4w==
X-Received: by 2002:a05:600c:1887:b0:3dc:4318:d00d with SMTP id x7-20020a05600c188700b003dc4318d00dmr3336477wmp.11.1675782502585;
        Tue, 07 Feb 2023 07:08:22 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id j33-20020a05600c1c2100b003db0ad636d1sm22092173wms.28.2023.02.07.07.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 07:08:22 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 07 Feb 2023 16:08:01 +0100
Subject: [PATCH 8/8] arm64: dts: amlogic: meson-gxm-s912-libretech-pc:
 remove unused pinctrl-names from phy node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-b4-amlogic-bindings-fixups-v2-v1-8-93b7e50286e7@linaro.org>
References: <20230207-b4-amlogic-bindings-fixups-v2-v1-0-93b7e50286e7@linaro.org>
In-Reply-To: <20230207-b4-amlogic-bindings-fixups-v2-v1-0-93b7e50286e7@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Yuntian Zhang <yt@radxa.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following bindings check error:
phy@78000: 'pinctrl-0' is a dependency of 'pinctrl-names'

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
index 874f91c348ec..6c4e68e0e625 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
@@ -305,7 +305,6 @@ &usb {
 };
 
 &usb2_phy0 {
-	pinctrl-names = "default";
 	phy-supply = <&vcc5v>;
 };
 

-- 
2.34.1

