Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4810762C901
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 20:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbiKPTbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 14:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbiKPTbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 14:31:35 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C33A6315C;
        Wed, 16 Nov 2022 11:31:34 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a14so31642468wru.5;
        Wed, 16 Nov 2022 11:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=supRVz4T52oVqFelsFhkEjn9HuP+OJvPsiaQRkXaSXY=;
        b=RuwduGQoL6RNZdNsCkvAs1s01RvLdNpuhqMxQcM5zQYPC05mFOSpK7h66qWpQM3Lqi
         679YLRtq9sU/uy08ZbP1DDSQ7PPiTxEHCN4OlRc5mpMv/F5NYMOvF0jlUjGvuSKl+2sg
         QQ12EX6uhHBWQIS/D9Gs4IDpTIZqq+2RRKGt9Y/aMhezL1HszIRZr1Y5yfrv4KYH1v2i
         KM/OS9f7jcSZ8l2xeyM5FizpK6PyBLZgrqth5uagibIBp3Heju7m69Ln22nWAEJwbZdn
         cqXKOS6Q4HyQNvH78lT/aqGYdTrsW/+/y3rU5AJKQER/3322TcYoNtMYz7Rxi5/2n7nu
         ecbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=supRVz4T52oVqFelsFhkEjn9HuP+OJvPsiaQRkXaSXY=;
        b=k6+xy86EcnlEGkSMQfQmR6nvpoKhnS/5iuUHGyWQPjcpXsGOk0VjKphF7mhK/5m7WT
         jBXBTMOVMHD0QeGzoyRXokk1VGOuaCrjJSbD7VnsT3zCyYRjyGjvwhD9WAw1Wc0Pr4yW
         AR4PZ2IBX0lmpS8h8BjgT0DUd+xzYmN/hzmsjTkfox0obl+0d566bEc/7bb0O4Gz/Hh8
         /YYBp2n90NGIQxhOt7FkW0e+/b8RjWqbbWcMs7tAryVFAIa0Wf4e6QnVac9LprSKkzsE
         ofHxy9zN27Ij4shhT/lF+D3JCeYjkRgFB0yQOpM+RPxb62diP2js2JfuEIx1a8ja28ip
         2zRA==
X-Gm-Message-State: ANoB5pn1Qv/jlPtYBljb5WBJq2PdYVQVOaIHY9MlrJ17AryWTZPFiF88
        ogSsdlZi2uSHei0rH71KqCo=
X-Google-Smtp-Source: AA0mqf4LY6JFZkmH5+c+/H2WjbTvikrkg74sq1CpTEgiQpUYahnaPsbCsrWLj1aOUCvNV/AgTVS9aQ==
X-Received: by 2002:a5d:5741:0:b0:236:960f:161d with SMTP id q1-20020a5d5741000000b00236960f161dmr15517728wrw.376.1668627092709;
        Wed, 16 Nov 2022 11:31:32 -0800 (PST)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id q125-20020a1c4383000000b003c6cd82596esm3044646wma.43.2022.11.16.11.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 11:31:32 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        samuel@sholland.org
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 1/2] media: dt-bindings: allwinner: video-engine: Fix number of IOMMU channels
Date:   Wed, 16 Nov 2022 20:31:04 +0100
Message-Id: <20221116193105.363297-2-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116193105.363297-1-jernej.skrabec@gmail.com>
References: <20221116193105.363297-1-jernej.skrabec@gmail.com>
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

Cedrus (video engine) on Allwinner H6 actually uses two IOMMU channel,
not just one. However, Cedrus on SoCs like D1 only uses one channel.

Allow up to 2 IOMMU channels.

Fixes: 62a8ccf3a248 ("arm64: dts: allwinner: h6: Fix Cedrus IOMMU usage")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../bindings/media/allwinner,sun4i-a10-video-engine.yaml        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml b/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml
index 541325f900a1..257bb372d166 100644
--- a/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml
+++ b/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml
@@ -55,7 +55,7 @@ properties:
     description: Phandle to the device SRAM
 
   iommus:
-    maxItems: 1
+    maxItems: 2
 
   memory-region:
     maxItems: 1
-- 
2.38.1

