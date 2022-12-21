Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDE9653614
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 19:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbiLUSW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 13:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbiLUSWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 13:22:25 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8D724F0E;
        Wed, 21 Dec 2022 10:22:24 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id m18so38786775eji.5;
        Wed, 21 Dec 2022 10:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W4nOKqhNPXfITegWM0HPaQGxnW8/92aWSrG5eL1mdYs=;
        b=WS7DOe9L1ApSdC1ztqO0WTPbyxOZiwOS3jhJaizn9q35gbYYipyGyQaN3Xjwbqa6gX
         gLxxRvYXGffVsfpTSZ47mY8bjzVvO4IL42t25g9Tb7l+/TSu9qystwjIf/PIY2nwAGuA
         i4bFKkjZts8Jeq3K0amomR8Z/wtRX+iwEoR5/70rsGd4UirlBH3cTD/QddhkrydF4qdb
         uMS6tOZTYm4GNfO3JE4myOYafJX/mYvpR2NchMnV/yUdsgyopxkwCyI20lj6/xWWC6l/
         RpL9jGxQWojGjB4b1FiZLxlR6weI4J+w2SPmL/NR4aJ6ml8mTDGLwJxieSi2SLpAX1fC
         OmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W4nOKqhNPXfITegWM0HPaQGxnW8/92aWSrG5eL1mdYs=;
        b=yecGQCTA7nswTOg2sFWld1+RgfGAtLJFB5UvXYbg7aEf3/qZeNgwhvXd+clZq92jWR
         mT0kcfkPZ4OJtapm6a4QHB3Gg6aWfVKCXaciR7OjmyRAQWdmbecprL8YYDGOSWkjTm3X
         0TJaXVNA9pgSXdTOZCSPmu4n5ALTkeb9VBohQtqzDLru7AifdQE7KkiZ8+DrhYri2Es6
         Y174SlkBxvdgVvu3+J02ot5Z6XLh1TO3Qv03ZPenNYEB99po9SMy8hhs36ptEuBxmy64
         Idmu+jTKsaoIe9qSqBqCZPbl8ysDcCilb5qggmyn5vBGnHPIBDYqV6YiPYpkZcLxbVyM
         XLaw==
X-Gm-Message-State: AFqh2kr7+X7ZEzf9yZ1hDCjuF+O6rkHBCOU/TfRiBm54lhs9fQvtZrxg
        7wwEIJ81FjXYIhrelAO5VdU=
X-Google-Smtp-Source: AMrXdXuMRe3FeX5W6S5TKc7LVJDAVywrUoyC2qybAwz+q/HlkbXkjDrO0bxeEuUsOC6ZkOqLRGjNXg==
X-Received: by 2002:a17:906:d052:b0:7be:e26a:6104 with SMTP id bo18-20020a170906d05200b007bee26a6104mr2006728ejb.52.1671646942588;
        Wed, 21 Dec 2022 10:22:22 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id kv20-20020a17090778d400b0082535e2da13sm4302105ejc.6.2022.12.21.10.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 10:22:22 -0800 (PST)
Message-ID: <899d3a39-19bf-519d-a863-bd7ca1e7c033@gmail.com>
Date:   Wed, 21 Dec 2022 19:22:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 03/12] dt-bindings: display: bridge: snps,dw-mipi-dsi: fix
 clock properties
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        airlied@gmail.com, daniel@ffwll.ch, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, philippe.cornu@foss.st.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org
References: <7f883643-c796-029f-ba38-73532325632d@gmail.com>
Content-Language: en-US
In-Reply-To: <7f883643-c796-029f-ba38-73532325632d@gmail.com>
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

Fix clock properties from the common snps,dw-mipi-dsi.yaml file,
as they don't match with what is used on the SoCs.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../display/bridge/snps,dw-mipi-dsi.yaml         | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/snps,dw-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/snps,dw-mipi-dsi.yaml
index 11fd68a70..0b51c64f1 100644
--- a/Documentation/devicetree/bindings/display/bridge/snps,dw-mipi-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/snps,dw-mipi-dsi.yaml
@@ -26,19 +26,9 @@ properties:
   reg:
     maxItems: 1

-  clocks:
-    items:
-      - description: Module clock
-      - description: DSI bus clock for either AHB and APB
-      - description: Pixel clock for the DPI/RGB input
-    minItems: 2
-
-  clock-names:
-    items:
-      - const: ref
-      - const: pclk
-      - const: px_clk
-    minItems: 2
+  clocks: true
+
+  clock-names: true

   resets:
     maxItems: 1
--
2.20.1

