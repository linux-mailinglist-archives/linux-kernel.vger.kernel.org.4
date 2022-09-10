Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F163B5B46C5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 16:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiIJOcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 10:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiIJOcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 10:32:35 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B7B4A112;
        Sat, 10 Sep 2022 07:32:29 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t7so7815819wrm.10;
        Sat, 10 Sep 2022 07:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=sFfHW+tcAhvs1gk4X+D31/A9ude4NOf/1K3FvL8qEzA=;
        b=XR47zE4K7cWZFBXkzpXSOtjKt00IluqDVpNbPoWXAiA9FzwYaHmKI/UwUkW/7ZfC/Q
         6ibL6zfpG8YN8sj0UZSo8P7oJiXwSHxcyPrfAQRvNgOmHvdexByYpJbcrqMfrfXbkjmV
         gwyXed9rd6l6RrllgkyAJfbA7kkX9MbuMt8w2UouO1jnJkvzhYebIVlbCx/rZKmEUmgR
         EoujilmO/NRyIpgj3Tpk8pazfbMOQ+JQA9Hg4jOdbYKCf+iuISzR7A4r7TXkxbAuLUg2
         x+xpYBAG+KYGzFuFMA+RWVt4nVEJhN+KIe58q+G35O7oHVfmzeZX+/nbwTckbq+QP5wt
         6Fnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=sFfHW+tcAhvs1gk4X+D31/A9ude4NOf/1K3FvL8qEzA=;
        b=n/RrqkQVdH03Rg2tWDWQWg4BXGCrRP0fUREa1yaOnnfZy2IObXdU9MCUwb9fE9yY+N
         CaSJ6u+33OpRvhvPfEK+xpCYGnObTUxc0teVGbeaN3fpgE/JLTGqZmH8iqI20Hb3wzSb
         Vpdps+NzLxTk6DPfRo6VlbhAQ1WYdOcXVHQfG7BmCy7OXBc59Apozc5ZmFQ+QyMXqkDC
         P505Mdju+RqFvDo4My5MTfjREmX6l8WV++KBHo/kJ4ICmwk6XwjKqhhVuB4vGb6i5wI2
         mb4r3RJ8Np8hAWAp84OjAqsemh6+TpHwrvRGD3YAXvBAqgH6OfZbAWoLIc6+N9yCzVoh
         N/VA==
X-Gm-Message-State: ACgBeo28DVutwxckesV3y/8UR1qojIIzTxQwzIlQa/QYCIHg2+C0Nh6v
        IWH8H/48scRw2TSU0NIdnfk=
X-Google-Smtp-Source: AA6agR7AyRP0gNt/nRJaEgmEQXnNoSL7mRSyLOVn8mdCAISjbd70lfGcxObe5S1PdqnLi6V3opWN9g==
X-Received: by 2002:a5d:47aa:0:b0:226:dbf6:680c with SMTP id 10-20020a5d47aa000000b00226dbf6680cmr10604031wrb.581.1662820347641;
        Sat, 10 Sep 2022 07:32:27 -0700 (PDT)
Received: from localhost ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id m36-20020a05600c3b2400b003b46d9c3709sm2255106wms.48.2022.09.10.07.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 07:32:27 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/9] dt-bindings: phy: qcom,qmp-ufs: Fix SM6115 clocks, regs
Date:   Sat, 10 Sep 2022 17:32:10 +0300
Message-Id: <20220910143213.477261-7-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220910143213.477261-1-iskren.chernev@gmail.com>
References: <20220910143213.477261-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Sm6115 UFS PHY has 2 clocks and 3 regs.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
index 6e3c186b9972..815c375d0f7b 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
@@ -121,6 +121,7 @@ allOf:
               - qcom,sc8180x-qmp-ufs-phy
               - qcom,sc8280xp-qmp-ufs-phy
               - qcom,sdm845-qmp-ufs-phy
+              - qcom,sm6115-qmp-ufs-phy
               - qcom,sm6350-qmp-ufs-phy
               - qcom,sm8150-qmp-ufs-phy
               - qcom,sm8250-qmp-ufs-phy
@@ -180,7 +181,6 @@ allOf:
           contains:
             enum:
               - qcom,sc8180x-qmp-ufs-phy
-              - qcom,sm6115-qmp-ufs-phy
     then:
       patternProperties:
         "^phy@[0-9a-f]+$":
@@ -198,6 +198,7 @@ allOf:
           contains:
             enum:
               - qcom,msm8996-qmp-ufs-phy
+              - qcom,sm6115-qmp-ufs-phy
     then:
       patternProperties:
         "^phy@[0-9a-f]+$":
-- 
2.37.2

