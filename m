Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E257072CF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 22:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjEQUNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 16:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjEQUNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 16:13:36 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B9D6A58
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:13:32 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f387d97dddso1491288e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684354410; x=1686946410;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4MkwaG45dwbFLpCnrCtiuWihS+msbfT86nmMyqxuCE=;
        b=W1nZKzoQCW/zlSlxuOfTIs+v4ffA3p1XZPx+rO2HIEVNHPNy9pQ3fy+GbqzFkJA9G3
         M3ftVFnTKRVYh4nL+cpLG+ouWmHUt4jKV/b0XNtLCXWjuDGIWvJbBF2LaRyCHqpZZK6r
         kMx3iTdlkMmumNkEOVUU1UUFb2eO7Zg74V7YJeWMhfUSl2aDNHlavn4mQBimhyrYbIVW
         JDVzBpNpxJxZJkP5MxtgahuW9AOdv0pCdEKSEZqPKZ5JSSZUewqF3kEvUuT8eJ0/2Iq/
         Ju8TKULAvTJ3cxQVOwUu6s+NxCax7b7EONY6k3R/sJNlWKBoMs0METk1tSz3x1NYobtH
         1znQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684354410; x=1686946410;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4MkwaG45dwbFLpCnrCtiuWihS+msbfT86nmMyqxuCE=;
        b=BOHkFf+oolkMZmh8edRq/3aH7dc0/3XxScOjxS2c0Ojlw/Zz8tPTOdLx/RDL4EVeP3
         +V0JkhpT/flg+60JzJGOL433ACFnJme7ZMdIfgbOD68w5MTWalZLhMkIhAVpHNiwvu5P
         SaqK/PFgSjz5jsJgWlBg6FCY9eBCC/sVApnjGJUqdLSdK684fnh0wkA0G7RvYLRgHwpS
         DbeX0Bu9AWfO1rsBT7bgPPxAUd15LW6E8XJMU3QAGWF7UElZhbILbyu2Cwcn97eaXSB/
         MTbJ4Ayr+5b4l3/qtRRtwz3qDw6o2mZsrKMJLg+GPqy7JeUsCUuLqF8SEb5c61BUtg4R
         6ZLg==
X-Gm-Message-State: AC+VfDxmHyJUFMhpJh46+QZetn5S6fFbaSFnnWWHafIuUE4Pd02ciLGJ
        fGt5SB5ZdQjUr3RVErkrzUReWw==
X-Google-Smtp-Source: ACHHUZ6p3dYPweRsYExmUfOQbW0N3Hl6Eag3VXD14Q/6zW8ajZknTB1/N24jWl+vraB0vvZ6A/VMyg==
X-Received: by 2002:ac2:5ec5:0:b0:4cb:280b:33c9 with SMTP id d5-20020ac25ec5000000b004cb280b33c9mr535630lfq.24.1684354410757;
        Wed, 17 May 2023 13:13:30 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id p27-20020ac246db000000b004f382ae9892sm1190899lfo.247.2023.05.17.13.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 13:13:30 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 17 May 2023 22:12:51 +0200
Subject: [PATCH v2 2/3] dt-bindings: power: qcom,rpmpd: Format RPMh levels
 better
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-topic-kailua-rpmhpd-v2-2-3063ce19c491@linaro.org>
References: <20230517-topic-kailua-rpmhpd-v2-0-3063ce19c491@linaro.org>
In-Reply-To: <20230517-topic-kailua-rpmhpd-v2-0-3063ce19c491@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684354400; l=2869;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=rkz3rDD9UJ1lh0oaKwuo6UWyGych2wWx1GG3p1Uh5sc=;
 b=/xV2wCMDg+dtNNOsTBZmr3nxaglGCFZU1xdccHGhSQZrfJaW+FVFw0vlrNixVbLuC7BBndEoE
 AuYYnUP0SPsA3Z19xwWbOPbLV0mIAiawN8nSRPZvwnIj2MLz3A++2Gv
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After adding the missing levels with a nice, easy-to-read diff,
reformat the defines to make them nice to look at..

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 include/dt-bindings/power/qcom-rpmpd.h | 46 +++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index e34c01e650d6..4ede277d20e1 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -207,29 +207,29 @@
 #define SC8280XP_XO		15
 
 /* SDM845 Power Domain performance levels */
-#define RPMH_REGULATOR_LEVEL_RETENTION	16
-#define RPMH_REGULATOR_LEVEL_MIN_SVS	48
-#define RPMH_REGULATOR_LEVEL_LOW_SVS_D2	52
-#define RPMH_REGULATOR_LEVEL_LOW_SVS_D1	56
-#define RPMH_REGULATOR_LEVEL_LOW_SVS_D0	60
-#define RPMH_REGULATOR_LEVEL_LOW_SVS	64
-#define RPMH_REGULATOR_LEVEL_LOW_SVS_P1	72
-#define RPMH_REGULATOR_LEVEL_LOW_SVS_L1	80
-#define RPMH_REGULATOR_LEVEL_LOW_SVS_L2	96
-#define RPMH_REGULATOR_LEVEL_SVS	128
-#define RPMH_REGULATOR_LEVEL_SVS_L0	144
-#define RPMH_REGULATOR_LEVEL_SVS_L1	192
-#define RPMH_REGULATOR_LEVEL_SVS_L2	224
-#define RPMH_REGULATOR_LEVEL_NOM	256
-#define RPMH_REGULATOR_LEVEL_NOM_L0	288
-#define RPMH_REGULATOR_LEVEL_NOM_L1	320
-#define RPMH_REGULATOR_LEVEL_NOM_L2	336
-#define RPMH_REGULATOR_LEVEL_TURBO	384
-#define RPMH_REGULATOR_LEVEL_TURBO_L0	400
-#define RPMH_REGULATOR_LEVEL_TURBO_L1	416
-#define RPMH_REGULATOR_LEVEL_TURBO_L2	432
-#define RPMH_REGULATOR_LEVEL_TURBO_L3	448
-#define RPMH_REGULATOR_LEVEL_SUPER_TURBO 464
+#define RPMH_REGULATOR_LEVEL_RETENTION		16
+#define RPMH_REGULATOR_LEVEL_MIN_SVS		48
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_D2		52
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_D1		56
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_D0		60
+#define RPMH_REGULATOR_LEVEL_LOW_SVS		64
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_P1		72
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_L1		80
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_L2		96
+#define RPMH_REGULATOR_LEVEL_SVS		128
+#define RPMH_REGULATOR_LEVEL_SVS_L0		144
+#define RPMH_REGULATOR_LEVEL_SVS_L1		192
+#define RPMH_REGULATOR_LEVEL_SVS_L2		224
+#define RPMH_REGULATOR_LEVEL_NOM		256
+#define RPMH_REGULATOR_LEVEL_NOM_L0		288
+#define RPMH_REGULATOR_LEVEL_NOM_L1		320
+#define RPMH_REGULATOR_LEVEL_NOM_L2		336
+#define RPMH_REGULATOR_LEVEL_TURBO		384
+#define RPMH_REGULATOR_LEVEL_TURBO_L0		400
+#define RPMH_REGULATOR_LEVEL_TURBO_L1		416
+#define RPMH_REGULATOR_LEVEL_TURBO_L2		432
+#define RPMH_REGULATOR_LEVEL_TURBO_L3		448
+#define RPMH_REGULATOR_LEVEL_SUPER_TURBO 	464
 #define RPMH_REGULATOR_LEVEL_SUPER_TURBO_NO_CPR	480
 
 /* MDM9607 Power Domains */

-- 
2.40.1

