Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1846B1452
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjCHVl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjCHVlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:41:20 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1B685A5D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 13:40:51 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id y14so18056501ljq.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 13:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678311615;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rV1fhlo3d+5jqHbCH3aEpZYk1ZijM8P8h8hsb2YwO9c=;
        b=ezT8WuYyjFDM6IgaPlJ57M6E7KscASp9bjgGSDCh/IxrnVM46DG5lR/QLqf3bt9q34
         F758u7JCt5/Y07+we4LWhdoA5uaDN+2P7JruTe4xd+kiIaFn04u2voejMq3V3LsP4z6E
         Smfn6NHWKEPKUMXAscwpMDkG9O8Hn8QjVh5yAmSFqeLUgsKZpcEIMt+zuF/FLGVoLfvm
         N2FVqDPFHz/6pfM2OK+coOHDQBT/24yytu7caQwqu+weXv8mMGSj4sKW2vRyy6oatw/7
         mKSd7NoxpAFLIPjVVjuAXrTcTUytoAnoJvVRFWDouUgw1XclWLZLqpFuzz9VtJyFNAJV
         z33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678311615;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rV1fhlo3d+5jqHbCH3aEpZYk1ZijM8P8h8hsb2YwO9c=;
        b=4LlFVqwOHeC9MWXyAbDbtYGKW9acgIYbldBNZhm8xpql8Khv5IBR+KIZxEZpz09SKg
         Z/mBYP7YcuYyBuHYRekpdL365iODRrsEnogtxfFiZD2Nzd/pYaoKKt+94LeIUwjDdomn
         eH2ss0AEvXqDiyBf4xNJqEvQLYBT7duJZ9CI6ItcirutgTTPqO1tXoFCOQZL+bURtDTC
         cv3GaUU94zmMrJTrqx348Kzai1BnNxmcbWZABPgb4kJYDmwinZoZ/DnI4+sdOysXaSRY
         0uStj1vlo7jczvjNW9ZDQ5F3fDZvDPTAoJl+jNbtfNYlgBj8HSG326qKSusW5it6xEDB
         o2xQ==
X-Gm-Message-State: AO0yUKVvGhuJxQrCjcwXX6PbuycTK8KZNsJINmSNDFnGcgv7FzVpWY8S
        7hdKhQk86AnThDAlIH2tm7pbFk0105Jv79zzO8Q=
X-Google-Smtp-Source: AK7set8eEugLCh/YVNJZoVh4tUPtoQ5e3lgIl55BTFsdd/f8+eioSVbiftSXWXMis83HK5wDk1Xtbg==
X-Received: by 2002:a2e:a986:0:b0:298:6a97:5985 with SMTP id x6-20020a2ea986000000b002986a975985mr1544278ljq.43.1678311615573;
        Wed, 08 Mar 2023 13:40:15 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id a6-20020a2e8606000000b00295a2a608e9sm2688844lji.111.2023.03.08.13.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 13:40:14 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 08 Mar 2023 22:40:09 +0100
Subject: [PATCH v7 3/9] interconnect: qcom: Sort kerneldoc entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-qos-v7-3-815606092fff@linaro.org>
References: <20230228-topic-qos-v7-0-815606092fff@linaro.org>
In-Reply-To: <20230228-topic-qos-v7-0-815606092fff@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678311609; l=1082;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=5QScrGeiOGfZL7HfpuChoBRhoWNcpAGpYtvwcTxAXqc=;
 b=8YaabyUpY76DRFWI/hb829IEV7eM30lU2LLVvazFJy/4Jbi0WR4PEew4wI1B26fDSLS7ClRpywku
 L3uoNSLdCrznee8bX727SuLzB98jw1NmSqUGWiXAIa+3g3CQq2xr
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort the kerneldoc entries the same way the struct members are
sorted.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 8aed5400afda..21f440beda86 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -23,12 +23,12 @@ enum qcom_icc_type {
 /**
  * struct qcom_icc_provider - Qualcomm specific interconnect provider
  * @provider: generic interconnect provider
- * @bus_clks: the clk_bulk_data table of bus clocks
  * @num_clks: the total number of clk_bulk_data entries
  * @type: the ICC provider type
- * @qos_offset: offset to QoS registers
  * @regmap: regmap for QoS registers read/write access
+ * @qos_offset: offset to QoS registers
  * @bus_clk_rate: bus clock rate in Hz
+ * @bus_clks: the clk_bulk_data table of bus clocks
  */
 struct qcom_icc_provider {
 	struct icc_provider provider;

-- 
2.39.2

