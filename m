Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344C16BCDD2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjCPLRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjCPLRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:17:14 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DD4C48AD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:17:09 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id x36so1253076ljq.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678965428;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0mnANG0WP3DmVcvz1/YwEmwBOAubSIpodiPhLQQRHPQ=;
        b=RzD6kGo45mF1NC8IwGwp1zoMdZiY/uwKOFdG0Gku81ZiR6TajnHjupDXa3KXXnqkLm
         b1jdXXJxMatCz3vl8euA8Yl9D3n/VHxiWF5+yy3Wsf2ieKvPnVKeOP1mDb025CTOlsSU
         XjmTMe76vdRHfP6pi55UkFl2z5bdGeD+etYICMpmkV3500gfrCNlY/cJNy6ttgihzm3G
         +AQ+GIUnRkXaPIIvM1T2FFB0PWJLsQzyMT68M6kviJ3vwY+Rvcnw3BkNNINAPzZicaZY
         c5Ov+RWsl8Bm0BexF7vKBCKhl1jMARnBYdnV/A1DxwEWB18ByHB7Wk5I629KkpGYn7Ek
         b8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678965428;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0mnANG0WP3DmVcvz1/YwEmwBOAubSIpodiPhLQQRHPQ=;
        b=HhsRYAzMRuQZZUZDEJpHjjG3pYnqYLH9Chw0+qXSbNgZlQ1CEnNKdCEz6f80E49fZZ
         T+45xezZ8svEQn2c+OmVi2v/D9EazD39egXzS3WtuVvkJ8v+73P3NgvhCeqy8cyk+/wK
         lcmlVjSlEo08xy2DzbjD8V1WroY5LZVodYpONlIfNmjnqwqREcybAfHp9Ft4ta5v/G28
         PKpYqy66QXH1csAoNBssSYNE0J5LBMnEeSWvOdl89IQBwZ8UsYuqIRPa7j7MgN/mgPJd
         9b2VHkqZujFClIPj7cR8efxjkQbp2DCZ9ZfJ18tBPCB+3L+NZYKdLwLLDAEf49QYzHmR
         LVYA==
X-Gm-Message-State: AO0yUKWG1FRNACt6hoVbBu+BJwKm9ccDHtriQiYYPket7hdcJtQiX7dY
        ozX/xYH9OtBMPyhx3V0Enl4IYw==
X-Google-Smtp-Source: AK7set9M9vMVB99HuWwfZmcxzJSQHkiSodthWkCxQ2Mc+9AVjxWrSiXpIzRKWDHZnNqcXE8DfZsohA==
X-Received: by 2002:a05:651c:30e:b0:290:bca:b4d1 with SMTP id a14-20020a05651c030e00b002900bcab4d1mr1782028ljp.33.1678965427986;
        Thu, 16 Mar 2023 04:17:07 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id u28-20020ac243dc000000b004db2978e330sm1194222lfl.258.2023.03.16.04.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 04:17:07 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/5] SM6350 GPU
Date:   Thu, 16 Mar 2023 12:16:55 +0100
Message-Id: <20230315-topic-lagoon_gpu-v1-0-a74cbec4ecfc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKf6EmQC/x2N0QrCMAwAf2Xk2cDWoYi/IiJpjF2gpKV1Qxj7d
 4OPd3DcDl2aSofbsEOTTbsWc5hOA/BClgT15QxhDPM4T2f8lKqMmVIp9kx1xSsHisyRLxLBs0h
 dMDYyXjy0NWeXtclbv//P/XEcP8JmKdJ3AAAA
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678965426; l=1107;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=RF7HIBV67A6DiVij2JcKkT2mEA9SaWaW5WsM/kqTxv4=;
 b=QW5XBYK11eROypzH3UX8psBBD5OI0JKN6JJUBvRp0LYvt/43LzbGr4lU9EV9m+X1R0X2NpjoNxm1
 Qiu7SFcsAq2t3FlIt8JYILtpTxlkOUrpkgJQhSNXujfaqlDtTmvi
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add all the required nodes for SM6350's A619 and fix up its GPUCC
bindings.

This has been ready for like 1.5y now, time to finally merge it as
the display part will take some more time (due to the HW catalog rework).

Depends on (bindings, admittedly I could have organized it better):
https://lore.kernel.org/linux-arm-msm/20230314-topic-nvmem_compats-v1-0-508100c17603@linaro.org/#t

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (5):
      dt-bindings: clock: qcom,gpucc: Fix SM6350 clock names
      arm64: dts: qcom: sm6350: Add GPUCC node
      arm64: dts: qcom: sm6350: Add QFPROM node
      arm64: dts: qcom: sm6350: Add GPU nodes
      arm64: dts: qcom: sm6350: Fix ZAP region

 .../devicetree/bindings/clock/qcom,gpucc.yaml      |  29 +++-
 arch/arm64/boot/dts/qcom/sm6350.dtsi               | 177 ++++++++++++++++++++-
 2 files changed, 197 insertions(+), 9 deletions(-)
---
base-commit: 225b6b81afe63b3850b7cee0a3590f51144f2a75
change-id: 20230315-topic-lagoon_gpu-8c2abccbc6eb

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

