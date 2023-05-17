Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07901706E5F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjEQQkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjEQQku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:40:50 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DB23AA2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:40:48 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f1411e8111so1214026e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684341646; x=1686933646;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2xdDvmJDjqeVtU3worCYJR7EC7H+K8m1I2mTyMfP2vk=;
        b=V7aY0VMoo5ZCcwwrG13zZge67I985EbaaSZQLLuVnRLN98V8FQ39lsc9A0ZrgMuh8a
         IgQTjCzBy6vRpq1VFMhrsUyGsw4kZaqpy9A+mky9v41JtOnW3EFhLcGao4VtA5WGsbEw
         DUMmtlJl4V7VtL8hxXA7CmEZ5ObVcVRmN6vTzvnlm9ZxbYx/r3mAEaR6HApQmcRJKK8n
         gNS0dnLy8+WmNhYTVgD7Q8Jc2boE+7WJlJ2BjMtkX65QuvEFivxBp1nVjSWCq+B4cKN7
         UD/BHgMp75p10FEd3nDx8/VDO1cGKaEpYS/psffBxY8FNky3KLEutp0+VLd6zzAttq+x
         dOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684341646; x=1686933646;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2xdDvmJDjqeVtU3worCYJR7EC7H+K8m1I2mTyMfP2vk=;
        b=fO1973N6mMMKM2kQd++tZDG21vZjL3WscII1jDNDpFaD7vA2j/PcJ76qkmzM7KDmMe
         I2yvccNThrA/OC3iRMrOHxBxfjOJkIrafwIi6hm1F6JDUljoyzpofiXrmTo3CC6R5wdH
         NyTkuKov+7GK8wXtLl9lShdRMgI1n0MuEUrq+QbsUcrva9HqT2iyRGqNLMrxW7vN7sbs
         gY/k2Dj0FIfKpWxkVXn3iMZf6MPn5rghFMhLa9SYIBXlMQ3JAaExkTP8iUtlKeYr9ubv
         ATekYwE/A9BtIOT2zcZJpwlcU68oBjkP15w19qfY+3VUOa09ZhQEharxrcNDz/FhsXOL
         2NYw==
X-Gm-Message-State: AC+VfDzaltcsVX+/0+k3Ftd1ACvixf6Wro73r/CcMA07NVOrT76KYzMD
        lwbve9WO30rdDLkXwzocqLFAFQ==
X-Google-Smtp-Source: ACHHUZ6xO2wXHIeSKpXgjPvEao6Re1B1D5J4M9TVxhe62Z8YP9EkytjJcIfVEuvmU44MgXxjEUY6cA==
X-Received: by 2002:a2e:4949:0:b0:2a7:6d19:b569 with SMTP id b9-20020a2e4949000000b002a76d19b569mr8845521ljd.53.1684341646547;
        Wed, 17 May 2023 09:40:46 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id 9-20020a05651c040900b002a8c271de33sm1919259lja.67.2023.05.17.09.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 09:40:46 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/4] SM8450 GPUCC
Date:   Wed, 17 May 2023 18:40:37 +0200
Message-Id: <20230517-topic-waipio-gpucc-v1-0-4f40e282af1d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIUDZWQC/x2NQQqDMBAAvyJ7dkFNq+JXpIdkXXVBkpBoFcS/d
 +lxBoa5IXMSzjAUNyT+SpbgFeqyAFqtXxhlUoamakz1rjvcQxTC00qUgEs8iLDtp9Z0vTHuRaC
 hs5nRJetp1dQf26YyJp7l+p/Gz/P8AJUHtGd5AAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684341644; l=1188;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=e/lggVuMBS0PkLLWqBbNb2RZISCTXYwBvDmZ80YVsjY=;
 b=z9/TsFBmiMuoPWT2k/rdDOETkZ0VZaNOt070SFR76uEiO9x6oS1NDGGhTMQEuJ7ur57g0hEii
 sPOsfM5rzz1DqYc3WwUekvnePl/6qb62vMU/O4Y1pyPp64uyKusaGEa
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce hardware clock control to ultimately avoid spurious rcg
(re)configurations and introduce GPUCC for SM8450.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (4):
      dt-bindings: clock: Add Qcom SM8450 GPUCC
      clk: qcom: rcg2: Make hw_clk_ctrl toggleable
      clk: qcom: gcc-sm8450: Enable hw_clk_ctrl
      clk: qcom: Add support for SM8450 GPUCC

 .../bindings/clock/qcom,sm8450-gpucc.yaml          |  73 ++
 drivers/clk/qcom/Kconfig                           |   8 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/clk-rcg.h                         |   2 +
 drivers/clk/qcom/clk-rcg2.c                        |   2 +
 drivers/clk/qcom/gcc-sm8450.c                      |  39 ++
 drivers/clk/qcom/gpucc-sm8450.c                    | 766 +++++++++++++++++++++
 include/dt-bindings/clock/qcom,sm8450-gpucc.h      |  48 ++
 include/dt-bindings/reset/qcom,sm8450-gpucc.h      |  20 +
 9 files changed, 959 insertions(+)
---
base-commit: 065efa589871e93b6610c70c1e9de274ef1f1ba2
change-id: 20230517-topic-waipio-gpucc-68d637833b4c

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

