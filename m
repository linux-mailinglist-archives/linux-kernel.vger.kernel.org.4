Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7828A717AF5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbjEaJBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjEaJBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:01:31 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FA710E
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:01:29 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f3b9c88af8so6529943e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685523688; x=1688115688;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fuKl8R0SVaBERImB5qO7yJ/wWAuRKKhQv+u4wxwoJUU=;
        b=WQaaaPoAY+5xaX6AhZ26wJMpfoene/Rnf8nw30qp3KQuoSJ4IHSHtT1W2Y7ALtUo72
         XLgSSsW+MM9roC71ysqr4DzEd1JsmT2v8mNvLrqQoh4/ZH8xNuX9fETelOWwU35AGAhW
         EaWbRLUEM5/+JFdDFKb4wZaRdJrj3AEFTj/arEAepP914gKOTB/92uAkWyh+HEySNKMo
         TOvqS2iKgp7Z5QMwxZ4aIqDAeoq10zXBCaxLQ0hfAGsCC8LNGdQ9JzGWcrz8vYiEKIIa
         vi0vP6J54Q5qLVpvITOXSC4CiMInddwWxD8IqCwnrnkiV5w62AlLjfoVAzZN08hlHM7f
         h1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685523688; x=1688115688;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fuKl8R0SVaBERImB5qO7yJ/wWAuRKKhQv+u4wxwoJUU=;
        b=UXqH85T4WHyfR6AaSUwxxgg7Km70kphQQ+SUoA+pflB7ovR9r2hEe61e0yKSJ6WB5c
         UP2MMX9paI9cF01BNd8rVnFli6jBnb3DG6OeTTlSqiV+g/9wmtb2ewK9DUhfgssM/S5K
         PyAkBPYYKOSFaspmBBhntorXfA8K7AqknjHjOQL8yPFCfCPRhjL25YUBBbuB0ADgKlpD
         vmqNOW6vScapfytZNxWqdq36lWfiSqflIosRSxxIwjDPkH/tZLKqhHI/JeoOohfcDYqk
         85Uco45Vb8mDPVTe88Oo5goDN+4Ljo1RmibkGXWAU52NJ2StBiaW/k1TxxJzzNaGyLc2
         Ov8w==
X-Gm-Message-State: AC+VfDzgbI6hVBJ760dlHW4pPlToTB+c10q9AaW54cubVJRMLUOXvePQ
        zSq1ZxW/E7iHWZvsdKpaJddVNw==
X-Google-Smtp-Source: ACHHUZ6kOWU5LAZJfE6qDV5Re7ast+TK1RDPbZTIfxwpSoKb2KmFiCQLQcn1bSEZMyIXjLUmsCMJ7A==
X-Received: by 2002:a2e:360e:0:b0:2ae:ce63:a380 with SMTP id d14-20020a2e360e000000b002aece63a380mr2165383lja.17.1685523688006;
        Wed, 31 May 2023 02:01:28 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id f4-20020a2e9184000000b002adbe01cd69sm3217446ljg.9.2023.05.31.02.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 02:01:27 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/4] MMCC MSM8998 fixes
Date:   Wed, 31 May 2023 11:01:19 +0200
Message-Id: <20230531-topic-8998_mmssclk-v1-0-2b5a8fc90991@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN8Md2QC/x2N0QrCMAwAf2Xk2cDaKXb+ioi0XeqCXTcaHYOxf
 zf4eAfH7SBUmQRuzQ6VVhaei4I5NRBHX16EPCiDbW3XXjqDn3nhiK7v3XOaRGJ+YxrOwaZwTS4
 a0DB4IQzVlzhqWr45q1wqJd7+p/vjOH6LfKqQeQAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Imran Khan <kimran@codeaurora.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Joonwoo Park <joonwoop@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685523686; l=1107;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=uWXJDM1O+vnkxqo9vnGAbSBIC66g11fjF+/qeDi1FPs=;
 b=lWRBkIEhd8Fer7WmwpCgmQjf297db9v60VEAtfw1fMCzhY8C/o5Lx9myY+V/caOsGiCxph89Q
 gb0qmEJ0LyaDmj79ij7RbxaG3NTPG4Yk9JDsG6BxfeW01Nc/QybDP3p
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

8998 has a couple of issues related to its clock controllers. This series
attemps to fix some of them.

The DT patch should go in first for bisectability, otherwise
clk/pd_ignore_unused will need to be used, as the SMMU GDSC is no longer
considered always-on.

This series results in less "clk stuck at 'on/off'" messages and should
marginally reduce power consumption.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (4):
      arm64: dts: qcom: msm8998: Properly describe MMSS SMMU
      clk: qcom: gcc-msm8998: Don't check halt bit on some branch clks
      clk: qcom: mmcc-msm8998: Don't check halt bit on some branch clks
      clk: qcom: mmcc-msm8998: Fix the SMMU GDSC

 arch/arm64/boot/dts/qcom/msm8998.dtsi | 8 +++++---
 drivers/clk/qcom/gcc-msm8998.c        | 6 +++---
 drivers/clk/qcom/mmcc-msm8998.c       | 7 ++++++-
 3 files changed, 14 insertions(+), 7 deletions(-)
---
base-commit: d4cee89031c80066ec461bb77b5e13a4f37d5fd2
change-id: 20230531-topic-8998_mmssclk-fd4b2fb7f8c1

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

