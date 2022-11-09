Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF4362250A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiKIICN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiKIICA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:02:00 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8311CB0F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 00:01:57 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id j15so24502779wrq.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 00:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lM0qTsp6rbYbqc9pr6/MVMIZyyG5748zn5WICW4j5iw=;
        b=KwAXO1o3SO13QTYoT227StTfCrRajGbm/w8mo5zcghDvmOiXgc9qQB7l1DxIYNyLq2
         l9MVGQaNt09MsclU189LUkWOdjV5OR6zfxOdt/M0N1YnEKklWV6zuqBa1T3/RSYM7eAj
         pfD3ip838TR38xsk9dactSZmRsj5f5KTjvqMgPWVvAnR5OWCNNY5CnJKC5Rz6ckGZsuy
         eK2tCFYxrkEjl2qcCxvqltH8kiab1jIDOhjGgC06YlxufWOJoF1HppgKd1O/JmUF2Dh4
         KDtllODTZzH26pZnQf8V6KbjflgInhEzA35QuzeLguaSJe92JO1ISJvBRS17iLVvEkF7
         0PVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lM0qTsp6rbYbqc9pr6/MVMIZyyG5748zn5WICW4j5iw=;
        b=n0qrSIF7cS7dlVRE4y6lIq1xjvz5M3m9K2uH8JDaKqjZffb66ceL8CGJ0SnUnOCIta
         TqMiTdPSi4P6FGrXdzdGqxm5KsZNBoozBMNOTpsJZB0mgfdgsrNJMzzVqW2F5RYqtiBz
         RUSVwjGp4XbFxzJL8OdoC6+DNLN/AhDEL1cLF37YWyyqo57ELFaFHmVq1KUKatkfLZpe
         GV0k9Xbmg/j6+17Ou9fJaMVB6oWjU8BhUmZr0KyJh04XbFHu8NMgyQ3p9elpfLER/coy
         29lj0oi9SIZCpt39TptUCMWOkRDt9UGzhBAqddRVORDKUupmKhmtJSktzZiuzB+6WxWB
         odgw==
X-Gm-Message-State: ACrzQf2yqnBFQAcnkGP6HDdKjBMpFdBML7JCBB9cgl10aFmzKYlVjy0a
        ppkndo9O/8+x/ncuSAvL1QjB
X-Google-Smtp-Source: AMsMyM77C82Bm88u32nZsLobuc1cSlI2gIXR21N+dKHn4tTOg9+5bR6l2o30RpKnWlLeKP25HL6wJg==
X-Received: by 2002:adf:fc8d:0:b0:236:7433:2b2c with SMTP id g13-20020adffc8d000000b0023674332b2cmr36493882wrr.527.1667980915907;
        Wed, 09 Nov 2022 00:01:55 -0800 (PST)
Received: from localhost.localdomain ([117.202.189.229])
        by smtp.gmail.com with ESMTPSA id l26-20020a05600c2cda00b003cf774c31a0sm769427wmc.16.2022.11.09.00.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 00:01:55 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org
Cc:     johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 3/3] cpufreq: qcom-hw: Add CPU clock provider support
Date:   Wed,  9 Nov 2022 13:31:20 +0530
Message-Id: <20221109080120.19078-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109080120.19078-1-manivannan.sadhasivam@linaro.org>
References: <20221109080120.19078-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 drivers/cpufreq/qcom-cpufreq-hw.c | 41 +++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 5e0598730a04..c0e4b223f9c1 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/clk-provider.h>
 #include <linux/cpufreq.h>
 #include <linux/init.h>
 #include <linux/interconnect.h>
@@ -54,6 +55,7 @@ struct qcom_cpufreq_data {
 	bool cancel_throttle;
 	struct delayed_work throttle_work;
 	struct cpufreq_policy *policy;
+	struct clk_hw cpu_clk;
 
 	bool per_core_dcvs;
 
@@ -615,8 +617,20 @@ static struct cpufreq_driver cpufreq_qcom_hw_driver = {
 	.ready		= qcom_cpufreq_ready,
 };
 
+static unsigned long qcom_cpufreq_hw_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct qcom_cpufreq_data *data = container_of(hw, struct qcom_cpufreq_data, cpu_clk);
+
+	return qcom_lmh_get_throttle_freq(data);
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
@@ -659,8 +673,15 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 
 	qcom_cpufreq.soc_data = of_device_get_match_data(dev);
 
+	clk_data = devm_kzalloc(dev, struct_size(clk_data, hws, num_domains), GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+
+	clk_data->num = num_domains;
+
 	for (i = 0; i < num_domains; i++) {
 		struct qcom_cpufreq_data *data = &qcom_cpufreq.data[i];
+		struct clk_init_data clk_init = {};
 		struct resource *res;
 		void __iomem *base;
 
@@ -672,6 +693,26 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 
 		data->base = base;
 		data->res = res;
+
+		/* Register CPU clock for each frequency domain */
+		clk_init.name = devm_kasprintf(dev, GFP_KERNEL, "qcom_cpufreq%d", i);
+		clk_init.flags = CLK_GET_RATE_NOCACHE;
+		clk_init.ops = &qcom_cpufreq_hw_clk_ops;
+		data->cpu_clk.init = &clk_init;
+
+		ret = devm_clk_hw_register(dev, &data->cpu_clk);
+		if (ret < 0) {
+			dev_err(dev, "Failed to register Qcom CPUFreq clock(%d)\n", i);
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

