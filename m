Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294907389DC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbjFUPkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbjFUPk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:40:28 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA280199C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:40:03 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f955850e30so2095546e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687361955; x=1689953955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BghQG/dm7/BMhBzVnoR8Ldw/7EWxlY1Xs4R63bOlCig=;
        b=Qr5r/G6sUrShsL1kKCwZWhXdsO1CA7qrG/oVm5PalRAnDMv/eKBShslHhHHm+lQxBA
         VW5cqs+Q0lxCp9IezWmr9A9x32gq64yT9CraSwAtZ6y8Kf0FU9Ab85oRn5kgEwATHn4h
         0bXhC6iC0bxGvfN+rE9/sGWz0Gyx+XmON52t17ZIKV+NHi/EkCGJYAotkwzTSFXnZb4O
         EninryVQ+GU4FWxQSq5swJLmQGtNXoz6T+0nC04TzkzEKrjx2xcprzWPkrFImN+xkHmi
         0rnM9XbnHIF8JuP0uVkwcNxUVHmJJUMSfWyv60XEAZQ1laRcci0u1Sjyhwa59GwzkVEd
         j/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687361955; x=1689953955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BghQG/dm7/BMhBzVnoR8Ldw/7EWxlY1Xs4R63bOlCig=;
        b=EaG6qcK6KaAwce4KrfzCbDfBkHHgcge72U9JiKaG0LrphrQUgDLdX0KOXcBHLFsHR2
         QquQNySUeE7nFzIfo7SlDEWRsvJhvn9ckyW3+hnlLMIiKDXgg+I9JfZrnSRbECtgQOd5
         AJgyN9fHA4SwcMroAMAM8h+3IFzgzj1IsC2nZNnVdEZ4CU5wG5b/ROQEkADD+HVK2dg0
         Zah4Lr/OJdsXqa/2dV+jQGIUm+OF8gOvkp70pXHoyzqasB9+VxDu2f0cKSzWiYv10vLT
         Cj41tiTPC/btFRUpRpjsm8Vov5DOs7eRpielq4K3dsIXM/LrbMXRPqspYqeH+2erWamk
         VIwQ==
X-Gm-Message-State: AC+VfDy5UcxwDVNiVXGZv29Xw4QX0dd10oaVITBclnGrSFg6R/8KtIKT
        v2qMgPs7yiWeQJ0UZcngOLW4dw==
X-Google-Smtp-Source: ACHHUZ7/PmkT+EWUVQKl8CZF7zrx/14OmR4HcShNYlxrqfaYfuZUS3Z79EYjFnFPNP5icbTpClrNhQ==
X-Received: by 2002:a19:650c:0:b0:4f8:6ac4:1aa9 with SMTP id z12-20020a19650c000000b004f86ac41aa9mr3829046lfb.21.1687361955307;
        Wed, 21 Jun 2023 08:39:15 -0700 (PDT)
Received: from [192.168.1.101] (abxj193.neoplus.adsl.tpnet.pl. [83.9.3.193])
        by smtp.gmail.com with ESMTPSA id l15-20020a19c20f000000b004f73eac0308sm821078lfc.183.2023.06.21.08.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:39:15 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 21 Jun 2023 17:39:10 +0200
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Mitsumi Electric
 Co., Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-topic-mm8013-v1-1-4407c6260053@linaro.org>
References: <20230621-topic-mm8013-v1-0-4407c6260053@linaro.org>
In-Reply-To: <20230621-topic-mm8013-v1-0-4407c6260053@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687361953; l=1059;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=1SFTi5kMC47UI2etI3CVctdHR0kSEqrXW6o1drxOzw8=;
 b=nffvquqf7dMVT3ELuTqaPfrF7sjNKg1738r4zR2ESSEDTPuDgCr9CxsDwvf2YDgGp4+lr0zO5
 QdM/n6pUKqPCzboEfBVbjasfCPRtJlgiYX8H2D4fBaom0cwCAklb+5p
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mitsumi was [1] a Japanese company making various electronics devices
and components. They've merged into a new entity, MinebeaMitsumi in 2017.

Their current main page is available at [2]

[1] https://en.wikipedia.org/wiki/Mitsumi_Electric
[2] https://product.minebeamitsumi.com/en/
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index af60bf1a6664..6142c40cf06e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -865,6 +865,8 @@ patternProperties:
     description: MiraMEMS Sensing Technology Co., Ltd.
   "^mitsubishi,.*":
     description: Mitsubishi Electric Corporation
+  "^mitsumi,.*":
+    description: Mitsumi Electric Co., Ltd.
   "^mixel,.*":
     description: Mixel, Inc.
   "^miyoo,.*":

-- 
2.41.0

