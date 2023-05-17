Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E17C70699A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjEQNUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjEQNTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:19:53 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA02213A
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:19:52 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2ac81d2bfbcso6933931fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684329591; x=1686921591;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3kzxnJh8kwu6FPZd5DyZQ2yCT8GH0SerhssKYLQ8joI=;
        b=YdjrP+PvS6i5ITbD7jiRnt8DT3K87W0va4m7NafjnWZwk+s5eO6NOUgrd20qUISUd2
         7raXVmGlmgjdA9MuVUHX77Z+f4b7w0SxWlce+pkxM64prHj4cvPuR1Q6P69beojHEPXC
         rAxGWN6j2muQO+F1ZrrLTG0Qf2fiyed8njFLxefXjBRqfsu5LiH7He1HcsdV5MMfaoWM
         W1iIAurotF6st/WH+2KZsZhkwVUSERUcGZN8ftVAbHumDumxUV47ydoYp/dq4aYdnr63
         T5Jvd8MY4mp5d0ZE9a966FGpQ/fgqWYGTfWreDDkUrqysHG0BdHNHlnhevav6eabl8RL
         5n0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684329591; x=1686921591;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kzxnJh8kwu6FPZd5DyZQ2yCT8GH0SerhssKYLQ8joI=;
        b=P/yJuPCDF+Cc6JeYWFiDvepyuO9gASLoxo/UqGMtB4k84qMAygNhh3jaOYBJiev4gD
         ppOFBB8uNqvxLadnSjaIhvIHNhPF0W6i2l7UT+VplFhKCl/jOYMybFQJWSo9smh3iYO+
         PS8sLj1yp+EpVdBI49Kpj3GIC/Hicgg5kTqfqQkpwIsvnIyex27oz/LoZ/J/vlJDeW7e
         DPcka/BVyt9C/PgqBXeqb1fryqeMDZaa9iR/OT/Gcjn54+cDHtL7SVyhnA/kuyVUo/yp
         WQMOVwIimVPP4ZWYVaKX6aOXZjJTFerq5aTvq4r55uiGpHVhp9b8UFTkagyBkaIcPhBD
         LOUQ==
X-Gm-Message-State: AC+VfDyI9r8SHgglLgEFLUZ9QPVcwS/Gf5Him/mOzq05cwMJw7sJjOeH
        Vn53N/nKqLZaqwDcvqFFI8WsF/Xobju3S1P0eBo=
X-Google-Smtp-Source: ACHHUZ6hUhxKn4wAIQLsgt5ygTi0gbVvuPzHulNn5EflCX+TpjTKZBP//XX3662rkgTaRFhLkFDa2g==
X-Received: by 2002:a2e:9989:0:b0:2ad:ad0b:d0fb with SMTP id w9-20020a2e9989000000b002adad0bd0fbmr10065318lji.30.1684329590789;
        Wed, 17 May 2023 06:19:50 -0700 (PDT)
Received: from [10.167.154.1] ([2a00:f41:c93:874f:be7b:fb6c:26f9:307c])
        by smtp.gmail.com with ESMTPSA id f7-20020a2e9187000000b002adadef95c0sm3007457ljg.124.2023.05.17.06.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 06:19:50 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 17 May 2023 15:19:44 +0200
Subject: [PATCH 2/3] dt-bindings: power: qcom,rpmpd: Format RPMh levels
 better
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-topic-kailua-rpmhpd-v1-2-cd3013d051a6@linaro.org>
References: <20230517-topic-kailua-rpmhpd-v1-0-cd3013d051a6@linaro.org>
In-Reply-To: <20230517-topic-kailua-rpmhpd-v1-0-cd3013d051a6@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684329587; l=2752;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=miOU6wFywRrGPuGE8Wa5Jxx2F51sqJAUPCdunf9NR3Q=;
 b=Ga3ieyrCriRnLBXJyKGdPbRFfHdpDaW+ogkdft+8FGCunr5lsU+AfV5f8U+eGe3Dnz4Toijns
 bd/hMSHuJZRDtGZQjTMUte6GJSGpPmxEFRHQ/8fZv1mlVC4tJ/rvEfa
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

