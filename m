Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443DA6510C7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 17:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbiLSQ5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 11:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbiLSQ47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 11:56:59 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C11A12D18;
        Mon, 19 Dec 2022 08:56:58 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id gh17so23044100ejb.6;
        Mon, 19 Dec 2022 08:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gb1Ci/peDFXem9KQH4YU7Ajcj0W54+LbHk+JTs6pzhc=;
        b=UmDPOgnX9rup6tCIGhloyjt6lRLcVZejtv4yKWpWgWwcK/Hfacc0swYAY457jUkhri
         z5OzYxcIh/efEjrvv6MzGJIbeH6ygsTbO9N0FgEGjJHwnprbJvYQIpjfGO0bpwGPju8y
         MHnKEqKBLVADfiBhuGYf7+R6UCKEmTgbgSaAm3FoxplZlfxonWhg9FgInq5DJtE6awFS
         DIjXQZLg2sm8Tlchzw8JTDqWRQqk3PZ7P8TUoMYpxbHe/bV7M5vcvTYc8TB0E3zeclwp
         41/8670nFhZvHxF94m47MJ8pzhP79gbv5DUfGRKCPs3s9/ltjvaUU89jBNQANKbv3CHF
         eurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gb1Ci/peDFXem9KQH4YU7Ajcj0W54+LbHk+JTs6pzhc=;
        b=WBfzj+feu5STcO8ZXz3C8LAVm1moxkM5UmtU8kVvTjBnRV/3dGMeMxcILtVyQxqxXx
         QjLrydG7HWP3aXJWmP+XA/JGcOYcg7sn3hfU7ifkszhNA89jhtcxPfXE0FzFX2NJxeyy
         i+lkUoxkJS5MMrM1luU6qe6NzdhPsWDjvOcsEucbso/r/eUE5S2yvo46kUn7xeN3MHs+
         EGHnI0DBRUu0I+1ucex7VYsSAlK3IhIjbAB0EZ1zucitV2QrW3y791CK9TZ56vrcJmBu
         FBv5SxMPqTHOA2uhYtFd+Tenu04udCFxNLsihXnETqV0eLLNIguq94PKEK6SR3wKrJi+
         fTZw==
X-Gm-Message-State: ANoB5pm8hPFpzs/GVUoY5OFKlE6lHiqMeqxZf0DWp3zqBz9Vl0R88aol
        7b81mOoVnFRnNUhHPyT9g8o=
X-Google-Smtp-Source: AA0mqf4bqKwTMm/poacEbbnbaz1b85s0kV6pg/w2GLVW64PdSvJIQpi543GO23QSmuWnnclDXJC8+w==
X-Received: by 2002:a17:906:18e2:b0:78d:f455:c381 with SMTP id e2-20020a17090618e200b0078df455c381mr37139173ejf.39.1671469016673;
        Mon, 19 Dec 2022 08:56:56 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id m18-20020a1709062ad200b0073dbaeb50f6sm4605585eje.169.2022.12.19.08.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 08:56:56 -0800 (PST)
Message-ID: <e54f7b52-3530-59c4-90c6-1fb5a17d6491@gmail.com>
Date:   Mon, 19 Dec 2022 17:56:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 3/5] dt-bindings: phy: add port node to
 phy-rockchip-inno-usb2.yaml
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, airlied@gmail.com,
        daniel@ffwll.ch, vkoul@kernel.org, kishon@kernel.org,
        linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <7f38e245-4fc0-1754-e75c-10c1e31bbd4d@gmail.com>
Content-Language: en-US
In-Reply-To: <7f38e245-4fc0-1754-e75c-10c1e31bbd4d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Rockchip rk3399 a port node with one endpoint can be connected
to a USB Type-C connector node.
Add a port node to the phy-rockchip-inno-usb2.yaml file.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml      | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
index f71920082..ffc7e7560 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
@@ -115,6 +115,11 @@ properties:
     required:
       - "#phy-cells"

+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description:
+      Port node with one endpoint connected to a USB Type-C connector node.
+
 required:
   - compatible
   - reg
--
2.20.1

