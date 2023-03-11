Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8098B6B5FB8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 19:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjCKSWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 13:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjCKSW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 13:22:29 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E179C59E7C
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 10:21:48 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id bi9so10767552lfb.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 10:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678558903;
        h=cc:to:subject:date:from:in-reply-to:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zgZZFa9GT3KgzmxYSLg5VRVJ2/WUIFA9QnWnNW5nD4w=;
        b=cv8Tww7Hl739LopzBthOGhZy4VlB2lYgMNEJ49Af7R8DnMDgc3eQyxpawmtQGGbnJe
         25M5PIR2XqPtsEqsMskeyVnSx6yY2J/bMmEO7Ur24ZGeUPehvNgDWHnrcaKCBnG1sc1O
         iMwgKaDW1uJuSG7fArGJ+u2X4RWggw5RzIy81LlKRvNjIBC+2S46UpmqZv6WywqWP1Wu
         nmMt1sS6+skpibAwG5HveoUvKXHXhXIjh0+6ditULRjkO68/MCxHUN+ASOm++biOljZ9
         r8+4Pd9a9jfXKPpZ39ihqiP9PQpc55/bC10Q3lzP7xHTRd2vzEz0dvEvwz24rgMYpB+h
         w2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678558903;
        h=cc:to:subject:date:from:in-reply-to:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zgZZFa9GT3KgzmxYSLg5VRVJ2/WUIFA9QnWnNW5nD4w=;
        b=qpnGbVC3qUQmc8IwHC97KbnvZazWW9k/1eKvj2VOQDoWOO1yeC2kIg/U6z4iEl4c5m
         xX5dsLFALqHFIQpolp42KZRNVcWfFBM8MMhMiM7BtY/U4n9XCurTiyMaPBXt1O55lMD3
         WuLuG13CpMhJeIGJRd2HIN8e+ouu3F1oElWGkk3uOzktnFe8nzrVM9kS1R2rmzrmoADw
         cjIZlpoaeF6oQ/c7wCgmr1kkkneCL58oP9ZM5GmWMJvtUTDz87NJBQIR1Rpo+oPYCKFP
         75w6rwN97b5xudonLeqmLfmP4Ld1rklT5gn+vscK5jDfGNdYkKvoXiyqAHV8Sl7SWTJe
         lNVw==
X-Gm-Message-State: AO0yUKU5yzDbDx2oPFyttxb8Foe8LYUBQxY7XDZsP2g1Xn9ZrIHD9cCt
        sxa/es/tW+tIqn1SqyLhsQp1iZb9uMDRt02L1rc=
X-Google-Smtp-Source: AK7set+IdgFrYxey9LQTQHJF5c9vczy+XT0K28uYXRK0qnHbMOYdzDbTIGUYhAnWf+Id39ZczlRudA==
X-Received: by 2002:a05:6512:24b:b0:4e1:46e9:ec3e with SMTP id b11-20020a056512024b00b004e146e9ec3emr8784984lfo.61.1678558903223;
        Sat, 11 Mar 2023 10:21:43 -0800 (PST)
Received: from 0001-dt-bindings-synopsys-dw-mshc-common-add-fifo-access-.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id w25-20020ac25999000000b004e811e3554dsm386680lfn.185.2023.03.11.10.21.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 10:21:43 -0800 (PST)
Message-Id: <1678558770.495747-1-sleirsgoevy@gmail.com>
In-Reply-To: <1678558770.495747-0-sleirsgoevy@gmail.com>
From:   Sergey Lisov <sleirsgoevy@gmail.com>
Date:   Sat, 11 Mar 2023 21:15:37 +0300
Subject: [PATCH v2 1/2] dt-bindings: synopsys-dw-mshc-common: add
 "fifo-access-32bit" property
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Samsung Exynos boards using the arm64 architecture have DW MMC
controllers configured for a 32-bit data bus but a 64-bit FIFO. On these
systems the 64-bit FIFO registers must be accessed in two 32-bit halves.
---
 .../devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml   | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
index 8dfad89c7..d025b38ca 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
@@ -57,6 +57,13 @@ properties:
       force fifo watermark setting accordingly.
     $ref: /schemas/types.yaml#/definitions/flag
 
+  fifo-access-32bit:
+    description:
+      Specifies that this device requires accesses to its 64-bit registers
+      to be done as pairs of 32-bit accesses, even on architectures where
+      readq is available.
+    $ref: /schemas/types.yaml#/definitions/flag
+
   dmas:
     maxItems: 1
 
-- 
2.38.3


