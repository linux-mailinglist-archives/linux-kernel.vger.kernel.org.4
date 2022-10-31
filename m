Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6E2613BAE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiJaQrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiJaQrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:47:33 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CA312629
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:47:32 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id cl5so5159760wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xKTqAkxJgMWx6sBMNSE6aZbt6frvVDq8u09kfz+kAfA=;
        b=XRcmdZ4LO0owByPD5STPLCr2UYHDXmzbX7K1uLrLp0SOM6/QXVwHX3X/2izgX3DHeH
         3a2gczFLc9gHwDbBwP0MIcHXlUV3cfdvLKA9fvVBskFtLJ7is1P2OXUnb6A6mJpEUggS
         wwQ2XyG/maewHSkOjIZf6kvSFpAmaqpe1pJ4lM0I7bm67V7sPrSDC1ZWc71YEjcL2Eom
         YLg2hj89uMii3gfsoP1q7wpIJNDsktqDsrj+3G60XoWQH7u5Zd1a6mkr1yK3Vb9kj0UN
         0KTuqzbDJkpIbsOM53u0t2oN+9xPygxvlJzEGfDNrKoBYJvr/XFbUf0P8v+PiKSUG+wR
         ZY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xKTqAkxJgMWx6sBMNSE6aZbt6frvVDq8u09kfz+kAfA=;
        b=EO6sns/SBXj9xydXaEZy6NouxNpWHIcwK4afUxcAOAgGwOfj/1GOlEN7ZYXv1ZOixY
         sy3POnuqWh7gZYeWM//rCnQZ4/fKA8rhOjWuC5CQZiZ69i1+M7peQyzNxn/aKXXofUOF
         vK9Ww2h6+LN2bZaYOfJiGbOzmY+6CIDyQjTjYl08jg8Y7SyfIAHEKE7SE2QOckb7OSpy
         /MYzxLiOVkDMBswRvHYKoxqzGcIt6Lcn0U9+oAiagBQ5E/Zcv/qX0gc/gectZarI9JBI
         h6HbVoGj52RdtABT6Nawfk4hZhvIkQimaBK7MNWQ1tuv8wJrXZmI53gGGXn8T3Wd+WL8
         Ewng==
X-Gm-Message-State: ACrzQf2sJ9s/iVFfr0A3s+5b14Vt0eov/HV7RmUe0PwjjB2wXCAHlPVF
        A3aOuijJ8/9cg6Rb1kp8psAKww==
X-Google-Smtp-Source: AMsMyM4jP4ham9rkHQIKGWu7iRmlbMIYmA2Dcqhqsr+EJ555arOEBiRDyVkQMUQq9czGPTPFVQelzA==
X-Received: by 2002:a5d:4b90:0:b0:236:702f:2093 with SMTP id b16-20020a5d4b90000000b00236702f2093mr9210941wrt.577.1667234850953;
        Mon, 31 Oct 2022 09:47:30 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id q8-20020a05600c46c800b003b4868eb71bsm7488871wmo.25.2022.10.31.09.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 09:47:30 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 31 Oct 2022 17:47:27 +0100
Subject: [PATCH 3/4] dt-bindings: amlogic: document Odroid Go Ultra compatible
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <20221031-b4-odroid-go-ultra-initial-v1-3-42e3dbea86d5@linaro.org>
References: <20221031-b4-odroid-go-ultra-initial-v1-0-42e3dbea86d5@linaro.org>
In-Reply-To: <20221031-b4-odroid-go-ultra-initial-v1-0-42e3dbea86d5@linaro.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This documents the Odroid Go Ultra, a portable gaming device,
with the following characteristics:
- Amlogic S922X SoC
- RK817 & RK818 PMICs
- 2GiB LPDDR4
- On board 16GiB eMMC
- Micro SD Card slot
- 5inch 854×480 MIPI-DSI TFT LCD
- Earphone stereo jack, 0.5Watt 8Ω Mono speaker
- Li-Polymer 3.7V/4000mAh Battery
- USB-A 2.0 Host Connector
- x16 GPIO Input Buttons
- 2x ADC Analog Joysticks
- USB-C Port for USB2 Device and Charging

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 9fda2436c618..e16b5fa55847 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -163,6 +163,7 @@ properties:
               - azw,gsking-x
               - azw,gtking
               - azw,gtking-pro
+              - hardkernel,odroid-go-ultra
               - hardkernel,odroid-n2
               - hardkernel,odroid-n2-plus
               - khadas,vim3

-- 
b4 0.10.1
