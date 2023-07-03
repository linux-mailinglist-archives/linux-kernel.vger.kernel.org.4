Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4A77461D1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjGCSJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjGCSJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:09:12 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A9DE76
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 11:09:08 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b6c5ede714so57495761fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 11:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688407746; x=1690999746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MaLvcsL3KzbjUpT9ZeG+u5opgZrVVaC1oiBBoWVhEGo=;
        b=k9npHbpgke71twb2HaIv1ryk3y+GBScMzCUqDTv22PHXzOkfoafTrvZU4kyUG34TH2
         2bYtvd233VvdsCUY+tjigHcT6WbqLB6swEKVork4sq6bgHJGRK84/rlMonqCeiCYyw5t
         je5rgTOaAFTg81ke0XTmQPdMoUaNd2phPI0F2DaaJSDVOldPvyXBDuuBau0+0ACWvwKJ
         Vg6rkc2Bm7WNeiJdsHaRJMqBlj3iPrMmzirdhzUSPlP/UiG7MVpZmDUOH7xnfHS3dTVD
         +sDoFk+pCsRs6VNCi1W6hAzS6fNkt1nUnuSrQ0AKCm15MdHqCQQeg8QyUzrzfB04nvxj
         1H3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688407746; x=1690999746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MaLvcsL3KzbjUpT9ZeG+u5opgZrVVaC1oiBBoWVhEGo=;
        b=QT0lN7uDlE0G+7YG4pjfZgSiXfMLfiGNcPnNpCD6YuDRohWbn6B4kGZXDMqx+u5tWu
         zBfx9emsMLuPLUzChn1N1DAzg3QgwyLs86SdsYlq8EBA7e0cHilirWLyxkrtkcXE784S
         3KBy4pAnL3t2u88R7+tW3SL3EwQE3P33eCgwB2RMzzuk9NGZ0zco7XMRQrKkyaAcEXgu
         ZAsNabCe7RQYfsc5vKE3fOiwzYvL1LfBylH7T7BD/2pYCYKm7F6aW5OSwGIIAT1iunqG
         H97j9pQacf8eGWno1kXCIcPTYEfryEneWF1zzjxL6yuBsiWw5p3+G600Es++aj/F3K7G
         0P1A==
X-Gm-Message-State: AC+VfDyDzgXGlZo7ZTU6/OWUtfpUsWMLJvBwkuNvUhroFGojIquzF0Sx
        wcGtxLfN9Rbr8mcSlW/RWQOQfA==
X-Google-Smtp-Source: ACHHUZ5yfWffuC2iObfiPSKb6yiAXtYgqdFw2xooVoDVSDbi1M8bJgAdX8nByiCN/my2UybDmBK3Iw==
X-Received: by 2002:a05:6512:ba1:b0:4fb:90e3:ccd6 with SMTP id b33-20020a0565120ba100b004fb90e3ccd6mr5955783lfv.5.1688407746387;
        Mon, 03 Jul 2023 11:09:06 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id l17-20020a2ea311000000b002b690038aecsm5241157lje.112.2023.07.03.11.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 11:09:06 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 03 Jul 2023 20:09:01 +0200
Subject: [PATCH 1/2] dt-bindings: clock: qcom,sm8350-videocc: Add SC8280XP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230703-topic-8280_videocc-v1-1-8959d4d0a93e@linaro.org>
References: <20230703-topic-8280_videocc-v1-0-8959d4d0a93e@linaro.org>
In-Reply-To: <20230703-topic-8280_videocc-v1-0-8959d4d0a93e@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688407743; l=844;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=UlYhVd3E2gsncxyf5DL1L0tqAJNX0vy4imnztJ0IE2w=;
 b=6kHdQ5NJMB/6rG4JKOfRaZEN8Z4MDDpgenibd7O5X9ALcGWvoeOIiBvUduINaO/4QC3m8Jji2
 cR8mk1fkampDkJpq/JARGDFEELobEpOoYFEjhBcQeyfN7oHd1E3qpIe
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SC8280XP reuses the SM8350 video clock controller block, changing just a
couple tunables. Docuemnt it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml
index 23505c8c3dbd..2114664978e1 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml
@@ -19,7 +19,9 @@ description: |
 
 properties:
   compatible:
-    const: qcom,sm8350-videocc
+    enum:
+      - qcom,sc8280xp-videocc
+      - qcom,sm8350-videocc
 
   clocks:
     items:

-- 
2.41.0

