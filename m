Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1011371859B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbjEaPF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbjEaPEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:04:53 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A461BD
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:04:33 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so6975506e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685545471; x=1688137471;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RNLO4nYhnPqhn1ZR80So3i5u5QMBlsTPDRXJyuHPHdo=;
        b=IW4qp84ak6aVsS6ws9/7Pp8DqyEOrs+9UEeJvZNDjHNkRJK7ylKhyn9B4KH/8xtUuk
         cE91OGaDJx6+Zzq41GBxXXGz8LKhN80qTfwnbdmUIkeQ1bQKkcygFTXPriAqbveV9b+p
         a8hQWDqfha7UI+8c9SlmnWuMwoDlVmvIXxYbIzcNEnpyEED93dcAE7Wm+DTrplwjgKIr
         H6TKdN3632fu3RZGqhO8jPLMl37Th/dVXL07/DBVmJhHhH9YQ33k8I8iIWNj1GsTmDq8
         q/jX+UzpY7Vob0ZUDOuS02PYbsKl490VO7GuET7mNmgbeU1rF10H4mCApe0jB///9/27
         QuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685545471; x=1688137471;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNLO4nYhnPqhn1ZR80So3i5u5QMBlsTPDRXJyuHPHdo=;
        b=PmuF+ag+gxweqRCZPsVs7zoLyAQXMKiQqcqYoxmKeYMutDjH8dAdgUJFMHsEI/mPhn
         1YB8Em1XDTbkg9wtHLJHuXWKBdOFLNqIREtLZs3OAv293sMEnDbV6fP7fkQ0sANvbiu5
         z2ecMwMliw5sElCvYAmv8mpJPSl+FXuc4Qc0OmK46fuyegzfhANSAOTcIc1wE0m/nrS6
         G++G7qhATHPRv1tvPLtAMC+bJSFOgEOYLfPDIMqING/hUKK4CZ3mETaIIGo8jUC9BpHj
         CIvSBQ6h1lX/tm1Jr3/aAp5FHrHc3KXRF9q1B/pRq3RCtgjrVF09L8/YtDTsPmmCMuLZ
         q/0Q==
X-Gm-Message-State: AC+VfDxUTriIoNOYkxIQAt5wl8SvIaOLZ97lbQkE+bKFr+BTp8uW6WUQ
        MNSecRBTWka5eLgVqypJCtrEjA==
X-Google-Smtp-Source: ACHHUZ6isPAGGyNErW2TVjyf8oGAklK5h/wCFAwLXiR8DWB6O0Ru3p8wOQXRM0yqKVFYFrkgCrZ/ug==
X-Received: by 2002:a05:6512:3743:b0:4f2:7ce7:dcf3 with SMTP id a3-20020a056512374300b004f27ce7dcf3mr2862793lfs.17.1685545471043;
        Wed, 31 May 2023 08:04:31 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id v25-20020a197419000000b004f019d3eab4sm756325lfe.23.2023.05.31.08.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 08:04:30 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 31 May 2023 17:04:23 +0200
Subject: [PATCH 1/2] dt-bindings: arm-smmu: Add SM6375 GPU SMMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-topic-sm6375_gpusmmu-v1-1-860943894c71@linaro.org>
References: <20230531-topic-sm6375_gpusmmu-v1-0-860943894c71@linaro.org>
In-Reply-To: <20230531-topic-sm6375_gpusmmu-v1-0-860943894c71@linaro.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685545468; l=1196;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=gJOlh+EMoLh8KOQ53iJ7hyFLc362lflmhqV5kwupSas=;
 b=XwOLMmcbcNw6AK7Mgvhj4n75W9cOGfnCWczMCWaASiSS8xGuTRrID/XD8y6uvnCtSaElXVUmf
 0Guxw3Bd1nKAZP1Fh2z0QLkXI0IovjimDCL6++lgmi08X6H+GDD2kU7
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

SM6375 has a "Qualcomm SMMU V2" implementation for its GPU SMMU. It
does not however qualify for the qcom,adreno-smmu compatible, as it can
not do split pagetables. It consumes a single clock and a single genpd.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index ba677d401e24..aec9137713c9 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -29,6 +29,7 @@ properties:
               - qcom,msm8996-smmu-v2
               - qcom,msm8998-smmu-v2
               - qcom,sdm630-smmu-v2
+              - qcom,sm6375-smmu-v2
           - const: qcom,smmu-v2
 
       - description: Qcom SoCs implementing "qcom,smmu-500" and "arm,mmu-500"
@@ -267,6 +268,7 @@ allOf:
             enum:
               - qcom,msm8998-smmu-v2
               - qcom,sdm630-smmu-v2
+              - qcom,sm6375-smmu-v2
     then:
       anyOf:
         - properties:

-- 
2.40.1

