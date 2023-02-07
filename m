Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD4468D992
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 14:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjBGNlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 08:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjBGNkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:40:51 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689F42DE78
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 05:40:42 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r2so13581169wrv.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 05:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=urkAIxuw0vH+tmqjpky10ko8VbPTxFMdI1E8QACAnss=;
        b=hQRx+/nCyCWiqMX210IH4LQUymrymE1yjavw4Lt99bs0YUHEqoLJOtRQXNJ9F6siXO
         r7+l7weL97KXIAddry/5olN+KHoBgjycgv1KrZpqx61bYgYV9z+dD/FMhSoksTf/NEnq
         LOsWAUzXOX89eomlIg5UkpXmrd7SJ2tvun4XhFXeQOvibDXmOU3m075KMB2wX0RBsasr
         7np4HCk1WWgbQPyo/trnok0BJ4mFBgeyUbPrf1q43oxiPs6IONiEqEELwD/+FncxVJTN
         B0/l6n1J/uTSXiDrtinlPrkuwRbB/w5eBiiwBr8Mlu+tNkoAjAceFnQZJyc9YNeVMBke
         ehfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=urkAIxuw0vH+tmqjpky10ko8VbPTxFMdI1E8QACAnss=;
        b=SnUjcPUO1mvAv/kzcVz8HJT+LvPA1MY3Tqcqfi/4ntAZ1FKqfmvJCY6pYdJGtyWBta
         xXm+0GQ1iFirq1MaSzNEuUMgqUWJftS15brbn42hhmCYyu3Kx5YPnTGAmRWtooVwiWzj
         Aw2nevkpRbdxqY8FDoZkQtB++4Aub1kUPzVjLKcXdUuizyWkuMvWGasqqNNWHX6nphvy
         esFrjk4t85lUJikRbTvVlsILCD9k2EZ+OPaS7GfddDXU+qZ2/KlU21dKPv9bomL5rUko
         fn4ai3y820igazPj6c2/gmM+C7x13OiFN9BjrJIupBjAGWRlcrjbGFwb+pqAOppwV8NU
         fwrQ==
X-Gm-Message-State: AO0yUKWVgjgx155mj4WJb2PS4SPDqP7OXvFjboWEVZi3gDESBKSdcL4i
        11DTszJv+SW7vK6zGm2PA7RMHg==
X-Google-Smtp-Source: AK7set9e1f+KMJDJ5s1jQQQtxkd8i0niz6R2HKOrVZkG+bItiOLwyLcSPAi3KM9YcZ2sW5cGUxsiWw==
X-Received: by 2002:adf:f6cc:0:b0:2c3:e356:694e with SMTP id y12-20020adff6cc000000b002c3e356694emr2916605wrp.22.1675777240965;
        Tue, 07 Feb 2023 05:40:40 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id o1-20020a5d4a81000000b002c3d67aac74sm10866280wrq.88.2023.02.07.05.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 05:40:40 -0800 (PST)
From:   neil.armstrong@linaro.org
Date:   Tue, 07 Feb 2023 14:40:39 +0100
Subject: [PATCH v2] dt-bindings: arm-smmu: Add compatible for SM8550 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-topic-sm8550-upstream-smmu-bindings-v2-1-680cbfae6dac@linaro.org>
X-B4-Tracking: v=1; b=H4sIANZU4mMC/x3NywqDMBCF4VeRrDuQTiq9vEpxkcuoAyZKxpSC+
 O4duvzO4j+HEapMYl7dYSp9WHgtCrx0Js6+TASc1AYtOov2Dvu6cQTJj7630DbZK/mszg0Cl8R
 lEkhhfOINY3RXZ7QUvBCE6kuctVXasui4VRr5+79+D+f5A05+/BGKAAAA
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@linaro.org>

Add the SoC specific compatible for SM8550 implementing
arm,mmu-500.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Rebased on new bindings using qcom,smmu-500 & arm,mmu-500
- Dropped driver changes since we rely on qcom,smmu-500 fallback
- Link to v1: https://lore.kernel.org/all/20221116114001.2669003-1-abel.vesa@linaro.org/
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 807cb511fe18..bc27919ab9f9 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -53,6 +53,7 @@ properties:
               - qcom,sm8250-smmu-500
               - qcom,sm8350-smmu-500
               - qcom,sm8450-smmu-500
+              - qcom,sm8550-smmu-500
           - const: qcom,smmu-500
           - const: arm,mmu-500
 

---
base-commit: 49a8133221c71b935f36a7c340c0271c2a9ee2db
change-id: 20230207-topic-sm8550-upstream-smmu-bindings-dbf9242cc313

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

