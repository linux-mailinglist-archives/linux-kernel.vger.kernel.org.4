Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8DC74133C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjF1OBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjF1OAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:00:53 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C2326AB
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 07:00:51 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fa16c6a85cso6587407e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 07:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687960849; x=1690552849;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dAlp+yDxSxsRQptzR5NDOwv6iD3bpQxnIcoaRH90yZA=;
        b=gYGMmZjQMT2xQ+MvbxcKxMB+lwJeW4SP8q8Ud2ot95OfKdvkuSLkgy8NadKM9kXLXk
         dwxRfgCRNOakD32hgwNcO3Q+gsPVq1dSg/h87w1589V8HKD74zsOrJ6pc/a8ticZUbD1
         +chhL/eqi5fHoxGSwfDChmx9LRPT9PI+XZOgPopzLbGXIGcugRrgEfDHNnDj1oelIdpd
         Csz4YnKeQGOF1is9KcJrXQ+C522wwQVIrp5UvwYp+iMSwRRgWMzGgvyemd93SFrG7xSg
         Rlq0ke9ztTGh34i89YSzj5iHR+3DT8mGuBOqLbapQyWoPGsFidQt6qyGV7Yk6Qd52T6Z
         agBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687960849; x=1690552849;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAlp+yDxSxsRQptzR5NDOwv6iD3bpQxnIcoaRH90yZA=;
        b=JmxszaQ1M0xiL/ZKm4nVIz+0luZoEXuN6q3kgUuOEatdA45goe4y7pJYD4vb+Z3pJx
         OC9t4pA43ctPf7Sh5nXceVr1OrjLHSUBgETzS0Jle6fq0sSDAi7e4AAjbaIHI+wxWxPb
         SILUchzefzhwT59wNvAsgFArExuoU1N4xhD7SOZyxojHF1OVvKCtOHTb5eSBKTZo2Y8A
         5F/q49T2gMwvxz4WfNBKbKqVmi1zZUCGgLzyuJf/OlvnZsVMkq07ZRG8S2CxZ3AQOrR6
         iNrS0oRuR2MVyk296hB512qnSHNqg183sOkrR+4pTgmCq0ZoP1OEpUyY2wP5RPEIke5R
         TYZw==
X-Gm-Message-State: AC+VfDzpwKMuMEWZuj/6bEBNvepS49JPGgY4TWsjVYpfx6XOi60fGphA
        bmVUiasT0x+s4rQkRXHepdCT6g==
X-Google-Smtp-Source: ACHHUZ6+0QrVCijCULs7HiQyO+Cshv/YeYgtY9a7qwj9YjpcRA/BS3PqPSxytyuGL1axxBfACtcl3w==
X-Received: by 2002:a05:6512:74a:b0:4f9:b032:5361 with SMTP id c10-20020a056512074a00b004f9b0325361mr7259068lfs.10.1687960849612;
        Wed, 28 Jun 2023 07:00:49 -0700 (PDT)
Received: from [192.168.1.101] (abyk82.neoplus.adsl.tpnet.pl. [83.9.30.82])
        by smtp.gmail.com with ESMTPSA id w2-20020a05651204c200b004f8586ab633sm1941359lfq.279.2023.06.28.07.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 07:00:49 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 28 Jun 2023 16:00:42 +0200
Subject: [PATCH v12 03/10] dt-bindings: opp: v2-qcom-level: Document CPR3
 open/closed loop volt adjustment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-topic-cpr3h-v12-3-1a4d050e1e67@linaro.org>
References: <20230217-topic-cpr3h-v12-0-1a4d050e1e67@linaro.org>
In-Reply-To: <20230217-topic-cpr3h-v12-0-1a4d050e1e67@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687960842; l=1423;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=WRqHzfry/bVzZ1IkMj1Q1p4NGE07AGHXQmZVGRY1FDM=;
 b=fmRAjhcXakJvteIMyPJ3dqzr/YpyAJd1sbA3FlZU+g97vJPUQvq4+nkL3Y9g27jcuZ6MD3hl3
 c8VgaIzIBU/DVfcqSRYBj1Tp2NsHo25lyAmd/r63DUtB/OuralTt5Dr
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

CPR3 and newer can be fed per-OPP voltage adjustment values for both
open- and closed-loop paths to make better decisions about settling
on the final voltage offset target. Document these properties.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/opp/opp-v2-qcom-level.yaml         | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
index a30ef93213c0..b203ea01b17a 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
@@ -34,6 +34,20 @@ patternProperties:
         minItems: 1
         maxItems: 2
 
+      qcom,opp-cloop-vadj:
+        description: |
+          An array of per-thread values representing the closed-loop
+          voltage adjustment value associated with this OPP node.
+        $ref: /schemas/types.yaml#/definitions/int32-array
+        maxItems: 2
+
+      qcom,opp-oloop-vadj:
+        description: |
+          An array of per-thread values representing the open-loop
+          voltage adjustment value associated with this OPP node.
+        $ref: /schemas/types.yaml#/definitions/int32-array
+        maxItems: 2
+
     required:
       - opp-level
       - qcom,opp-fuse-level

-- 
2.41.0

