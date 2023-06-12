Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF7A72CE03
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237853AbjFLSZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237782AbjFLSYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:24:55 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89902E7D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:24:53 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f61d79b0f2so5747507e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686594292; x=1689186292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=snY4D3sGE1e7ie+yqodjXNQjLORoB4Le2XvDi4Nyvxs=;
        b=A9iK14Dvr2fyZJ5EIB5ihATVXvBrLUGYQxQX//LCY6bMn/TPCEPQ6ytS+JPXHdvgHz
         THwyJ079Kdd7lQai4ZyZ33SBUHovFnNxdOpVCG6txM2+pEzg4YOp0dNIPrBk+eHg7xYn
         cbIsVDuuarrrGSiPHx8354Pm4OxZ6OJO8Y78TBp+ZZU6h/5xFgieNhpxwd0W9T5mTTvr
         SEiMmF/jjOFTTtqBgPm67jesiZxT9U7sNujAf8hgCYuz65kt/0i3l8iF5nNYQ2h9hcce
         H2Owv887YQZ1VeoXg87COdI//BlEzihdiqoXdG5LlTYj/YpUMFU7xmxM3DyaLMCQr/Fa
         rbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686594292; x=1689186292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snY4D3sGE1e7ie+yqodjXNQjLORoB4Le2XvDi4Nyvxs=;
        b=NP6BBe2WdTrfAKI4FWVMYW8edqhH4Yn7psYh4yaTLexY85rr3PxiO5PnttXMgw2QXu
         0U6I4UCtRMqGO6InHuRnQhLukbOuWKCZSlXkJHr822+EmifogF90kqIKL7oj9MmVBQO7
         RzAmaqgkfphjwPmTcNSOxRd6d9Z0vuaCP766yHJCHvizsIN1gFWN+x8DpznmeqULNc3j
         FWubcer8V7RB7cF4dB0Q7G64qdabNxP9Bct08/lG4g7Ek/8F/4Rekt/3I/4AxNHPTXJk
         vxMF9axpwwNOIrKykRmYb8LnKnLLihi8Yicp6IuFqt62KjWcM2+drm84tmFZJNfUr1yV
         b1SA==
X-Gm-Message-State: AC+VfDx35oC7LNzqlCpJ4KHZCuwAWXAXWY2qWx9Kaqyh9HbTaW9Fd+Tu
        Itm+eCLP6T05jt+pB3AUvFg/OQ==
X-Google-Smtp-Source: ACHHUZ5GWMyPIIBJJW3MLo1GtDkQ8Y5lLPaTgfVI4JvVrQ3FDta9NxGvdJPmseWlKLZIvYWK7rJ3uQ==
X-Received: by 2002:ac2:5b0d:0:b0:4f4:b3a6:4135 with SMTP id v13-20020ac25b0d000000b004f4b3a64135mr4507963lfn.55.1686594291853;
        Mon, 12 Jun 2023 11:24:51 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id v24-20020ac25938000000b004f64073a252sm1502035lfi.96.2023.06.12.11.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:24:51 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 12 Jun 2023 20:24:27 +0200
Subject: [PATCH v3 10/23] interconnect: qcom: Add missing headers in
 icc-rpm.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v3-10-5fb7d39b874f@linaro.org>
References: <20230526-topic-smd_icc-v3-0-5fb7d39b874f@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v3-0-5fb7d39b874f@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686594276; l=801;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=FNDzStoIOSOrT5/ip8w/4v5ja9884ytJ2coU8jem68w=;
 b=HNBzvkKcu+W5oIrXHelkzZNLblTXWh+NlsrCqJcptnuJDB3Gi+ZQ1Heon94MsuDL/nfdvODc4
 AaDMcoxC0AEA2B+JlHMVrQWlcaiCPprNS9cWwynDu64G4EBcgd62MvO
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the header does not provide all the required dependencies.
Fix it.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index aec192321411..057a1a8b3cb9 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -6,6 +6,8 @@
 #ifndef __DRIVERS_INTERCONNECT_QCOM_ICC_RPM_H
 #define __DRIVERS_INTERCONNECT_QCOM_ICC_RPM_H
 
+#include <linux/interconnect-provider.h>
+#include <linux/platform_device.h>
 #include <linux/soc/qcom/smd-rpm.h>
 
 #include <dt-bindings/interconnect/qcom,icc.h>

-- 
2.41.0

