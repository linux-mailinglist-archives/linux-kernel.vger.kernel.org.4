Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891C36542DF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbiLVOZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiLVOZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:25:49 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EC625C42;
        Thu, 22 Dec 2022 06:25:48 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id tz12so5243503ejc.9;
        Thu, 22 Dec 2022 06:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fOsi2OwSq3xHI7aui3O414Oo1XlE4pBwJtqzcodoVCQ=;
        b=MlKU5KNhffaWl+HI6LQ+w9cQLnvsbNTJVEYK+oItp52FhknzDgvIMJ+/mBcMmMp/nM
         FBpCzLrvZGFUSW739Xqa/Ck0qPPJgnpjK0rQAn5r8CjtHNetqca/BWq7JNQ+kU+FffjZ
         PxKNZj2lsEPu6ozrQke8Yrx6nOyxq8DCQO3+CF6oFs1k2/eMoo41sh1pwJ5vaBD+e3Rm
         QmtU8bNdMMjy7r4ot3LTZwTOv7Y2MR9p6CCO8dRh9pCJX9XeuvS3t3CHNsI6aIZEHN+s
         pUvz8hEIRjXvtwWLkd+UAXxEgwQIC0kvRIJIJL1TlRSDlX85aGeo05gDzYBkQ/jh/xbf
         Rn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fOsi2OwSq3xHI7aui3O414Oo1XlE4pBwJtqzcodoVCQ=;
        b=RcozcPYsc7GqGd4Xte+1Nnqket5mNOKqHVrNLt6L8VjlDmNAhj6rVSeFpi7EmuRb0g
         ///lVLjOBCSLjRY2FbvTrJgrkVYrvXJ/woHmKbDiGl4junmmbRoY390EpiaN4efA62AV
         tP+ujAIR7mFxY7gHZy8HZO4rLwl9rCF8QruqSL8Gbrqj5GRiqRNaHC0oqyTTJHUit1uS
         ru5t7W8c77iQY4vzKU2yD0j7yfrU5jHfzvItMiTGZnfnZA69sAwPpuw5cVY9AwomsnVU
         v2vUK4vRF9O3nzIkllvhyGCX00m3JHVc9MG0g5pxIwwbSgRBbGNMYmTwIFaqjh4P98He
         xeKQ==
X-Gm-Message-State: AFqh2kodjkxoi8CHjqMu3oLc9xo1oRQ2v8Ar3lXwbSq6zqKJS2zCcU45
        m6RThXo3dIMay6QAJyZngNk=
X-Google-Smtp-Source: AMrXdXs2ZIgjx4BwdrZ9OPUxEcwQhQL93aelpNu8ZOBPma6g87PHYtq+N1Mh0lqNtQZcwkk2DClGQQ==
X-Received: by 2002:a17:906:688f:b0:7ae:31a0:571c with SMTP id n15-20020a170906688f00b007ae31a0571cmr4818918ejr.57.1671719146475;
        Thu, 22 Dec 2022 06:25:46 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id cq17-20020a056402221100b00477f0d89e8fsm432158edb.6.2022.12.22.06.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 06:25:46 -0800 (PST)
Message-ID: <78b4548e-dfe1-d0c6-f96c-5d40f28f8b2e@gmail.com>
Date:   Thu, 22 Dec 2022 15:25:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v6 04/17] dt-bindings: display: bridge: snps,dw-mipi-dsi: fix
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
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        linus.walleij@linaro.org, inki.dae@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com,
        alim.akhtar@samsung.com, linux-samsung-soc@vger.kernel.org
References: <67771143-fd83-383d-41b2-68e8707134e8@gmail.com>
Content-Language: en-US
In-Reply-To: <67771143-fd83-383d-41b2-68e8707134e8@gmail.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
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

