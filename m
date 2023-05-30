Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCA8715B7C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjE3KVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjE3KUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:20:31 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AAC126
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:20:17 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f3b5881734so4789680e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685442015; x=1688034015;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gyt3egYQ4ZXwXortJqKnfq0jNA9L3ka+zbPWgIHRD7s=;
        b=LH67/zhwHHjr6N5quOb5F/GjMiXeHM+XmgCoA5fLikqGcZ6ZVD2Nr5rH5JVRPZefg8
         2Kzbuz3z2jsrUzSroRSPEU31LtROiIJIt7fHCkO85wXUHlhT8faseCkyH61gsX4DRzxn
         2a+Tj6b4AJAHrODAvDRbtc8EGYtLUpwvKDIVlB0aEZBnbs4eoJ1vL5eoy/j8hMc3Llgo
         Fbc4Vrg5r4M9tFlH4I8up9RSJ6leIak7A/ATGd1aQBC8/nHKulj7T3F0a/yGdeIGDcLN
         s7BPhA7ALJPbPs4SFvbfHPJQSHwGCVaMMSmIGcYGQVRcA/KYz0CXUDanKliA3vO/irgC
         J0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685442015; x=1688034015;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyt3egYQ4ZXwXortJqKnfq0jNA9L3ka+zbPWgIHRD7s=;
        b=QGmUJYonsA1TvMTzEYDlS1g4OjjLTubZKvIJ2loz0PkFwPzeyzv2Y+IUNL8nyCcuQG
         lqxIH1jh1qSDGnCvYNkOhcBOVsNeKGaB728Bx+sy/kygA5qvtrKE1kFu36nRYWlZAfbh
         eIj3qQRwjm+r1vXLtx2Is1osg6QgX8hX8kYLnARvtpRWYbJtCAamzKzzLEEbAE03M67q
         58u8pQZM1hsnibTWRa6Qze/MFPj3diNacmLx3djDXB1ij/3otY+qpX3NCCPKFF6WRxpL
         hmynhH4AUtzxx5lNsfaxj2pYeFxmC/XHBnoW6wDRiMNQAzCG8BubmdCuF6vbZZyWV/3O
         TsoQ==
X-Gm-Message-State: AC+VfDyH0Qx3Il47ZwCFSPeOIOb9fwMO4A/o3+EGs++SSknfu41yPxZ7
        9qWwOmSbAYxj0gLBcdxdXdCSDA==
X-Google-Smtp-Source: ACHHUZ5o20dbYFk+vD9wZn++JjWHjzWIkzo6uhuwMxBu1uxae32FdX1IMksGvjvWYCi0U+vP2SeOZg==
X-Received: by 2002:ac2:5dc1:0:b0:4f4:6189:1d0 with SMTP id x1-20020ac25dc1000000b004f4618901d0mr575192lfq.7.1685442015510;
        Tue, 30 May 2023 03:20:15 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id c25-20020ac24159000000b004cc8196a308sm290902lfi.98.2023.05.30.03.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 03:20:15 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 30 May 2023 12:20:08 +0200
Subject: [PATCH 09/20] interconnect: qcom: Add missing headers in icc-rpm.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v1-9-1bf8e6663c4e@linaro.org>
References: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685442001; l=740;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=jTkx4EPVwXQN5FFZMT7EdA8vRYwWcRLDeFIEIuIiyzQ=;
 b=0/T2QmK3afylcI3Vrr1VjeycV0no3AjFREcQ8+Jjm103oHojwnH7NaZLHhWInbWiSc7tIUO7v
 AI6tRrVqk7gDgHmwPiO8rgO52Ife1mka9aSw4eN9pbVtDoMLomssIIp
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

Currently the header does not provide all the required dependencies.
Fix it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index aec192321411..09abdd0c891e 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -6,6 +6,8 @@
 #ifndef __DRIVERS_INTERCONNECT_QCOM_ICC_RPM_H
 #define __DRIVERS_INTERCONNECT_QCOM_ICC_RPM_H
 
+#include <linux/platform_device.h>
+#include <linux/interconnect-provider.h>
 #include <linux/soc/qcom/smd-rpm.h>
 
 #include <dt-bindings/interconnect/qcom,icc.h>

-- 
2.40.1

