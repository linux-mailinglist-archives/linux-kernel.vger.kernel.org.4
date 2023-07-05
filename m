Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F4174851A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjGENgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjGENgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:36:33 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E01B1713
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 06:36:32 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b69ed7d050so109245541fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 06:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688564190; x=1691156190;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IaHS4pAL4i4Q+Ss6wpXIG3Dh4assAf7OupeBhJe3n5Y=;
        b=rgkxp1dJ+DKMn1Mm4vWOD0A7JPB5Dtv/GWfrcAmELDUBjZGMFzhFAfiinkQfbXvRpc
         VHXfNVNRoahlTrABBdkxFSQ1/Z8NUBvKem2zRllOeygnGgUO/vHjQ1BwJ9Cp44Kl6u2V
         qjfR07Th7j6OnAABY+g83aqC6iK/feOnxm9ALsnuguQ3OsTg8NjqDSfmPFgSUVUlEVdp
         et+OIfD6Jr9J87KGF+InfJX1sQhiUDAHW/QoFUAsWjFkhUzLbQT+pyijTHNvWckgHIsg
         jEvimtZWVz6azlnDLlzOJlaxuNGxX/vZ3I1bpUzcxUsFNi4KdRrWSAUAYZJ5sj6f4qQX
         bpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688564190; x=1691156190;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IaHS4pAL4i4Q+Ss6wpXIG3Dh4assAf7OupeBhJe3n5Y=;
        b=DuHRs+HbYcmNH2E7QfaOVzzs4/7pJutLDq/pKKpuRmzA02WVnoaTzdjzH+63JBWiEM
         4d1Ce2plVG1dewJUiI5yV3KZCLJhlGspe0PJZls2juq+paRcH01n3LYHCeXsbWKRiGX8
         udFkK3Q5hsX84MHEtymOo07BtYie5FGdFSjKBKmQqA93LnSdpPYl41K31nPjf4+Ijaqk
         /NDQUq4V/PGIbDjzCBeTE+ROJ4JhjWAkbDPRLxue5WMEbDB0am39873T3HmbMHvVAAQQ
         zDlYlCKUmpYsJdLWdP0/eWky/34j2r+sRSjxyA65AoKBUtvVnLlmekxgCftrTuI8wwuc
         XQIg==
X-Gm-Message-State: ABy/qLYv6xQu85mrbn6BeNhiPV1xZuKeai+BnCDn1u77w4URP++oqslg
        +IrUOwV2tU1OXub24/9srwvFFg==
X-Google-Smtp-Source: APBJJlGktfmCYuE9mW67slJaeQAqfa6eE+OZTcefqagvTw1cTnO1F2en7ldD7NdTdDC5iJC1RblsdA==
X-Received: by 2002:a2e:9144:0:b0:2b5:80c9:9806 with SMTP id q4-20020a2e9144000000b002b580c99806mr11461321ljg.6.1688564190142;
        Wed, 05 Jul 2023 06:36:30 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id z16-20020a2e7e10000000b002b700952298sm246803ljc.33.2023.07.05.06.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 06:36:29 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/3] SM8350 CPU-adjacent fixes
Date:   Wed, 05 Jul 2023 15:36:20 +0200
Message-Id: <20230705-topic-sm8350_fixes-v1-0-0f69f70ccb6a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANRxpWQC/x2L0QrCMAwAf2Xk2UDaUpz+ioh0NXWB2Y1GZTD27
 ws+3nG3gXITVrh2GzT+icpcDdypgzym+mKUpzF48oHOFPEzL5JR332I9CiysqIvlxhy6J2jAjY
 OSRmHlmoeba3faTK5NP7XZm73fT8Aac5Js3kAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Robert Foss <rfoss@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688564188; l=695;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=uWHj8batm98rBqvJvajF8eoh7pTgjLLAYAzVRZDb8+g=;
 b=UQcKK3vyi5b5ft9cY8Mr5DNzB7gdEvwcJ9duuxDuveC39gr7G0FO23gXdKV7T9Y04cpViDkGP
 SsrxPl9mBZiBzL40ZVcF41BzAShze4XwHbhzwL1kV+utsF1F02KR3YQ
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

I noticed there are some holes in the cpuidle and cpufreq on SM8350.
This series attempts to fix that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (3):
      arm64: dts: qcom: sm8350: Add missing cluster sleep state
      arm64: dts: qcom: sm8350: Fix CPU idle state residency times
      arm64: dts: qcom: sm8350: Add missing LMH interrupts to cpufreq

 arch/arm64/boot/dts/qcom/sm8350.dtsi | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)
---
base-commit: e1f6a8eaf1c271a0158114a03e3605f4fba059ad
change-id: 20230705-topic-sm8350_fixes-2f953c38110f

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

