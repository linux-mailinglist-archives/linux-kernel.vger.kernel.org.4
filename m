Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD6562BC66
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238274AbiKPLrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237870AbiKPLqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:46:03 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BE752881
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:31:40 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d9so24706198wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pty7pOlEQit8rNbT7RktFTnCxtM/ayFjNMrbR0K5j2o=;
        b=Sb3LQJEIyItpGF6RkzbGkqafMyjNwi+czBZ3n6qANGLRoZcRDfabtCv0Ok+wbjEN6B
         hrgcgSyuxbWkkUIr6FEk7ZGZ1s79WwxxtiBc/AJ+w/ukrsrhVxu1rCPHV49uNMALegOZ
         RZJymJCiV3/LoCCdf08llr5ZEi5QA9OVGwSjDhkcKXDfDIFPbFGf8sqicyVJILsszgZY
         a9jKgJQbiKa8vLYev2uYXehht/ypvFIz99sO8jhKVwJLnQX29IP3U8bKVoFBQogoj8GB
         NW2fRYJ+8C2D//k4V9np03jZ7LyD97CkqDDsvOJlLL6AdG96NFk/SIds+M092A1pOytx
         5t/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pty7pOlEQit8rNbT7RktFTnCxtM/ayFjNMrbR0K5j2o=;
        b=QS7k/xnoKT9ZwNsLfv3yuleR1t9pgJJ/Ap63BzPSkI9W8VunvkN6aFoC7QhIZ6VYyW
         0BZGHWuwRjCYE0huoZSpv7bpn8Y7c02NvtyLSEyzauWEqPXfHWagYKER34LziDgLHpPk
         fUij83cso/oKVccZZmZcrqH06Ju6XcEzmrnm/APlVm4SQXVe3XJdqBmGAcXpdMPpg+io
         DzYUdROLxN5j+wZZg2XsSE4x12VRq7wv9IM9zQg4M9/GuwTx9pGt//VGgUZEg1MhLV9a
         CjXmPj4wHOlXaF0bmKrBJbw3SlfD3W8a0Ey6VfCXd0sBLo3zxVphjyMMqMc3tztgZyN0
         SGzA==
X-Gm-Message-State: ANoB5pm8qwK9zZxTZxz+TOA6oOsplNjhoor3LKyPrc5zpzwf/cF8g+8w
        5gbKSET5A2itfe702iNuWG5gFA==
X-Google-Smtp-Source: AA0mqf4ALxzdaom2QwimPdl+DufulYkMqxmFMrw0t9UUoZAI1A6DVNsE5IxuaiTLgQ+Vg1KvIgmkzA==
X-Received: by 2002:adf:f7d0:0:b0:22e:3d63:80bc with SMTP id a16-20020adff7d0000000b0022e3d6380bcmr14267848wrq.30.1668598299188;
        Wed, 16 Nov 2022 03:31:39 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id g4-20020a5d4884000000b002383e977920sm14762329wrq.110.2022.11.16.03.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 03:31:38 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH] dt-bindings: soc: qcom: aoss: Add compatible for SM8550
Date:   Wed, 16 Nov 2022 13:31:28 +0200
Message-Id: <20221116113128.2655441-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible for SM8550.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
index da232f8d20d2..98d087cf4fc0 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
@@ -35,6 +35,7 @@ properties:
           - qcom,sm8250-aoss-qmp
           - qcom,sm8350-aoss-qmp
           - qcom,sm8450-aoss-qmp
+          - qcom,sm8550-aoss-qmp
       - const: qcom,aoss-qmp
 
   reg:
-- 
2.34.1

