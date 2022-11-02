Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35AA615DFA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbiKBIih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiKBIi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:38:29 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C1D2793F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 01:38:23 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id f9so15647221pgj.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 01:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dhoFn1ZtCyAs/+qCp2eCTiNCa1Q3Al3mgUmbiNZfxI=;
        b=UWRy0RPpNm7wlerLKGEhAZXzXLeA8etRLack1Pq/khiT5F466cWJeQQvGYdXYFdixO
         uiygCzzZwkiAi1s1mrxuUEuwfVNO6qq8nkCF43i+stFxMWFXGp8ZnVypP0HFl/SEh/Ef
         STHgrvN7SRvthn555mrWqdlSjzQOrSx+wo2FeOFrOPyad8sjCoWzN0wkMUZkHFH/XeL2
         vrfbzKNq3P/RC9Uje5+pjZ6ISGo5C5NpJgTD/DgKl/Qz4HCjwsbyhGIxFktnbrAMF5hK
         4XKI/fX8bFG6I3jAbV13HHCcIqdte6ScTkcedLDj3pBkQdbVnorjzjAhcBRo/0JWZ40o
         PgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dhoFn1ZtCyAs/+qCp2eCTiNCa1Q3Al3mgUmbiNZfxI=;
        b=Icqgn4z6+jv3kqfjXerzUEFAtwgdmVLGGQIKSKYkhw56gR7Yde61nk0AnCknlICq1G
         RK6Tp3cvR94NqtinA73XlZmByys6/Y7iqUsk60rU78sc3kK+smxpyGt9tyc8lpkdvQ7Y
         czN1PzguR14mgsFubhuZr6AJ4jrAIGnfL6nFzNXDDt0elRGuuK0n4dJNEJkuy2wVm7zw
         EnDr3poji37Zn4K4e5TdmTEum/PR7x0ZKEUy81bWwrStL7DwGdCdag+qRI3PZdh+6sZI
         ztTlDPa8eQVDY7I4SsMxPux3yviYI7dSik5YG/YPUSqlyn9telaJD/XnPLIN7J+sehFv
         31ew==
X-Gm-Message-State: ACrzQf2O97XSlVsoKhBzSBQVisWjPjjd2QddbsE8VdOI553X6/ONMNu/
        yhGij9guUu00eLxwRYdw0VPs
X-Google-Smtp-Source: AMsMyM5bOfAILnTTDp4H4LLMEeXBSxnsGtZCnI32rlTDQ9LMkVksrCprUFCbuCQ3SKrULvt1UPd2mw==
X-Received: by 2002:a63:2a8b:0:b0:46e:9fda:2171 with SMTP id q133-20020a632a8b000000b0046e9fda2171mr20798235pgq.106.1667378303216;
        Wed, 02 Nov 2022 01:38:23 -0700 (PDT)
Received: from localhost.localdomain ([117.193.209.178])
        by smtp.gmail.com with ESMTPSA id x19-20020aa79573000000b0056bcb102e7bsm7887770pfq.68.2022.11.02.01.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 01:38:22 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org
Cc:     johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 3/3] cpufreq: qcom-hw: Add CPU clock provider support
Date:   Wed,  2 Nov 2022 14:07:51 +0530
Message-Id: <20221102083751.56330-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102083751.56330-1-manivannan.sadhasivam@linaro.org>
References: <20221102083751.56330-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qcom CPUFreq hardware (EPSS/OSM) controls clock and voltage to the CPU
cores. But this relationship is not represented with the clk framework
so far.

So, let's make the qcom-cpufreq-hw driver a clock provider. This makes the
clock producer/consumer relationship cleaner and is also useful for CPU
related frameworks like OPP to know the frequency at which the CPUs are
running.

The clock frequency provided by the driver is for each frequency domain.
We cannot get the frequency of each CPU core because, not all platforms
support per-core DCVS feature.

Also the frequency supplied by the driver is the actual frequency that
comes out of the EPSS/OSM block after the DCVS operation. This frequency is
not same as what the CPUFreq framework has set but it is the one that gets
supplied to the CPUs after throttling by LMh.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 43 +++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 76f840636828..b824f1bb04f4 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/clk-provider.h>
 #include <linux/cpufreq.h>
 #include <linux/init.h>
 #include <linux/interconnect.h>
@@ -53,6 +54,7 @@ struct qcom_cpufreq_data {
 	bool cancel_throttle;
 	struct delayed_work throttle_work;
 	struct cpufreq_policy *policy;
+	struct clk_hw cpu_clk;
 
 	bool per_core_dcvs;
 };
@@ -601,8 +603,20 @@ static struct cpufreq_driver cpufreq_qcom_hw_driver = {
 	.ready		= qcom_cpufreq_ready,
 };
 
+static unsigned long qcom_cpufreq_hw_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct qcom_cpufreq_data *data = container_of(hw, struct qcom_cpufreq_data, cpu_clk);
+
+	return qcom_lmh_get_throttle_freq(data) / HZ_PER_KHZ;
+}
+
+static const struct clk_ops qcom_cpufreq_hw_clk_ops = {
+	.recalc_rate = qcom_cpufreq_hw_recalc_rate,
+};
+
 static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 {
+	struct clk_hw_onecell_data *clk_data;
 	struct device *dev = &pdev->dev;
 	struct device *cpu_dev;
 	struct clk *clk;
@@ -645,8 +659,16 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 
 	qcom_cpufreq.soc_data = of_device_get_match_data(dev);
 
+	clk_data = devm_kzalloc(dev, struct_size(clk_data, hws, num_domains), GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+
+	clk_data->num = num_domains;
+
 	for (i = 0; i < num_domains; i++) {
 		struct qcom_cpufreq_data *data = &qcom_cpufreq.data[i];
+		struct clk_init_data init = {};
+		const char *clk_name;
 		struct resource *res;
 		void __iomem *base;
 
@@ -658,6 +680,27 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 
 		data->base = base;
 		data->res = res;
+
+		/* Register CPU clock for each frequency domain */
+		clk_name = devm_kasprintf(dev, GFP_KERNEL, "qcom_cpufreq%d", i);
+		init.name = clk_name;
+		init.flags = CLK_GET_RATE_NOCACHE;
+		init.ops = &qcom_cpufreq_hw_clk_ops;
+		data->cpu_clk.init = &init;
+
+		ret = devm_clk_hw_register(dev, &data->cpu_clk);
+		if (ret < 0) {
+			dev_err(dev, "Failed to register Qcom CPUFreq clock\n");
+			return ret;
+		}
+
+		clk_data->hws[i] = &data->cpu_clk;
+	}
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_data);
+	if (ret < 0) {
+		dev_err(dev, "Failed to add Qcom CPUFreq clock provider\n");
+		return ret;
 	}
 
 	ret = cpufreq_register_driver(&cpufreq_qcom_hw_driver);
-- 
2.25.1

