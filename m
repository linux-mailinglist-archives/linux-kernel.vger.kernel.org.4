Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC2D7072C7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 22:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjEQUNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 16:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjEQUNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 16:13:30 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47A32D55
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:13:28 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so1527090e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684354407; x=1686946407;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H5WruFuMLsK6il76ZmJiHugLl+bZzo0hvjMDD0Qg1jI=;
        b=aLP4ikbRC9VY40VDjBZxuWvRloQNr4WeW3oz5OYVIPi/6jEXGfLT8odrwlRM4njiYi
         RbmeAlgFub/ogQ6g8k/9Z8yzrxYkFez0wOriXN2vWCzW8Sk5322qdkUElpn/NZsnOfNB
         VKOFLg6sJTT2gZVgLji2C1P+8M3cZWGlJbCOHnGtoYjfVPvLO0XmvLbZyUz/sVEUk/K9
         IELNHBabObSvp5bZjaUrZp9fhUhQjYgPs4jFpyunsdzfhId0SXLzBamgXXs9rfhpZtsD
         DCe5NVgRbCNH1A5PipSVAQ0bbBzEsISHthWb/sKpLSjDJrs0QtDGtQxZnO6ObIQs+QaU
         u/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684354407; x=1686946407;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5WruFuMLsK6il76ZmJiHugLl+bZzo0hvjMDD0Qg1jI=;
        b=E+ln2oln34cdNp+pmWOFH+QvD3+gbgx67Z4lQNe67XTHTWSaVkWSzF146qYoM/DH45
         iblyJJZx5TiMIIYWFgUMVByEeo+CdfrZkLHsMU4MUbJUKd04XsFwoQ9CYUy60zS2myAk
         t62aeNw31/9ViB5KzGj+FdzW0iKfdQ9uvJvsB6HLDlPVpNlClKSg1H7Y8vTmkAXrcpRw
         h1xaTEUc+Gcfs2jl877FLI9SiJUgTtiSf/WCk2+IeYSJinc/FX6gKon5MEhgjOo13f17
         G8fup4ZFJ0TXJ14S/Rrx8juhTjUqDoNkFkJewYSwtfQJ7f2QBMyfI4YyHatNgS/5us0A
         Jyfg==
X-Gm-Message-State: AC+VfDyGtxszLuSQW/Lz3/D5u1oz9m+RmGE4fUxcCX9N05niCic0Hjvl
        VqUPhyYIOjju/O3ir76KOrkJkA==
X-Google-Smtp-Source: ACHHUZ5/3j67dYwXUI8pwy8T3GFD4qAtMAYQBL+I+T1uYrUznQfiqSZNeCMuJ8H8DfcIQ+67GW9VIg==
X-Received: by 2002:ac2:531c:0:b0:4f3:941c:986d with SMTP id c28-20020ac2531c000000b004f3941c986dmr602639lfh.44.1684354407034;
        Wed, 17 May 2023 13:13:27 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id p27-20020ac246db000000b004f382ae9892sm1190899lfo.247.2023.05.17.13.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 13:13:26 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 17 May 2023 22:12:50 +0200
Subject: [PATCH v2 1/3] dt-bindings: power: qcom,rpmpd: add missing RPMH
 levels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-topic-kailua-rpmhpd-v2-1-3063ce19c491@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684354400; l=1806;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=FQX/ZyV3QW8xEQQr1VaQD9lAWELAiM8u+TWjR9SmENk=;
 b=dsoWxr8l3xh7X40X4WzZlcAH9mngP3ux/kQ6yLVzT4jJdem5u1i/L8i3BPPjzzt1yBjMglDEE
 M6hs65iT3wtA75FsdqWsoZTsrI9hAwjvQlwnP/eckDJwxItQNnlaoq2
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a lot of RPMh levels that we haven't included yet.. some
sadly turned out to be necessary, add them!

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 include/dt-bindings/power/qcom-rpmpd.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index 1bf8e87ecd7e..e34c01e650d6 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -209,18 +209,28 @@
 /* SDM845 Power Domain performance levels */
 #define RPMH_REGULATOR_LEVEL_RETENTION	16
 #define RPMH_REGULATOR_LEVEL_MIN_SVS	48
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_D2	52
 #define RPMH_REGULATOR_LEVEL_LOW_SVS_D1	56
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_D0	60
 #define RPMH_REGULATOR_LEVEL_LOW_SVS	64
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_P1	72
 #define RPMH_REGULATOR_LEVEL_LOW_SVS_L1	80
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_L2	96
 #define RPMH_REGULATOR_LEVEL_SVS	128
 #define RPMH_REGULATOR_LEVEL_SVS_L0	144
 #define RPMH_REGULATOR_LEVEL_SVS_L1	192
 #define RPMH_REGULATOR_LEVEL_SVS_L2	224
 #define RPMH_REGULATOR_LEVEL_NOM	256
+#define RPMH_REGULATOR_LEVEL_NOM_L0	288
 #define RPMH_REGULATOR_LEVEL_NOM_L1	320
 #define RPMH_REGULATOR_LEVEL_NOM_L2	336
 #define RPMH_REGULATOR_LEVEL_TURBO	384
+#define RPMH_REGULATOR_LEVEL_TURBO_L0	400
 #define RPMH_REGULATOR_LEVEL_TURBO_L1	416
+#define RPMH_REGULATOR_LEVEL_TURBO_L2	432
+#define RPMH_REGULATOR_LEVEL_TURBO_L3	448
+#define RPMH_REGULATOR_LEVEL_SUPER_TURBO 464
+#define RPMH_REGULATOR_LEVEL_SUPER_TURBO_NO_CPR	480
 
 /* MDM9607 Power Domains */
 #define MDM9607_VDDCX		0

-- 
2.40.1

