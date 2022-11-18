Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9E662EDD0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241320AbiKRGlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241231AbiKRGkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:40:22 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BC29B3A8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:40:09 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id p16so2970074wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVs1+pBS6b7mgzZAZ0lZyrLTVIwOsFaSW1gBztH01Cw=;
        b=VP3GkIcZmHCUd0Sd2jepX17rgMsNZ/3T+RR9CUpp00R6lYsOpMHAEpzBAMxz5tFBCQ
         OgWLY/6QSIrqfbSbMZiPEO31ruiwHySTadxebOQ5QB8aDRmuz3ugKBAJdnWz+3wG223i
         fsBdP9SrzAuzxGtvVEOb0l+c2+drt4Pm1geMKOfeXKYICnN2sc1A6vJ37QATMjAzHBbh
         ++uB++3kCeKMUfXJbV7hPoajmk5wSS/uqXzUikXuV8f+Bev81LCHVb15Vva315NHtcNY
         dyiAfZJh9lS1vyQ7NqhDu8mczXP2Bkc9ySFx4meYYE1rGMCi1Bl+CnDoKf7BmAU1KTYD
         Apbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVs1+pBS6b7mgzZAZ0lZyrLTVIwOsFaSW1gBztH01Cw=;
        b=ZbQinDLWmWYWFkp7rcvD7bRP2WG3Cw8orrbIFWT0+uq8lIMJlrNM2iEwY3+PZgvu0Q
         9ZJsq6JT4dg/ggwwsXamhJUkkx2q8XbWkTIRhw25cDcknclWq0xuMbxaZUvgLYHxPDin
         Q4ddYPYZf1jhj8Y0ZObEdFI3kxRiH+4zn7cm7LjMlmB32nv/VmBhrgAMaKc0myyzBCRS
         rM4C8u6kGWfJAeVf4TS7JphKdYI86mmZuwaWKUTjicNC1evmp6fQTAzm+jSkTSuePZBt
         Xt3AFF+uaO0ZBNdEOzoLobRIN2uM0IfpKyzOCo7nhErnnbs7DAR2ugi/JQG7gUnhfvQd
         SDVw==
X-Gm-Message-State: ANoB5plRPY4cin2J6K5wEd8ok+bbxiNLiWjnkE+FJ+yBLnKi8UWtiPOD
        o8YJb6JkxdUWIHtYdvVNDSb9mw==
X-Google-Smtp-Source: AA0mqf6KWoAdB3k24CTWAmLnlIn5igybEH4+8Voi9Q7shtK59o/vNSuqwHcOpMQd2XqqKjiVHj1Llg==
X-Received: by 2002:a05:600c:4f12:b0:3cf:e7bd:303a with SMTP id l18-20020a05600c4f1200b003cfe7bd303amr7655359wmq.151.1668753607668;
        Thu, 17 Nov 2022 22:40:07 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id j13-20020adff54d000000b0023655e51c33sm2785902wrp.4.2022.11.17.22.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:40:07 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 12/13] dt-bindings: vendor-prefixes: Add ONIE
Date:   Fri, 18 Nov 2022 06:39:31 +0000
Message-Id: <20221118063932.6418-13-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118063932.6418-1-srinivas.kandagatla@linaro.org>
References: <20221118063932.6418-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

As described on their website (see link below),

   "The Open Network Install Environment (ONIE) is an open source
    initiative that defines an open “install environment” for modern
    networking hardware."

It is not a proper corporation per-se but rather more a group which
tries to spread the use of open source standards in the networking
hardware world.

Link: https://opencomputeproject.github.io/onie/
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6e323a380294..65a74026cf2b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -927,6 +927,8 @@ patternProperties:
     description: One Laptop Per Child
   "^oneplus,.*":
     description: OnePlus Technology (Shenzhen) Co., Ltd.
+  "^onie,.*":
+    description: Open Network Install Environment group
   "^onion,.*":
     description: Onion Corporation
   "^onnn,.*":
-- 
2.25.1

