Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A2069A9D9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjBQLJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjBQLJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:09:12 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4850F66672
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:08:34 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id u22so1306382lfu.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fmvW51s/G6sbMutj7IsS8dP6D7vZZheWzdfjfS0rHbM=;
        b=xmsgkMVkmol7HCMHm8q7Dy+YjxIMqOssIZH8h7VRpfV9/z4TH5hh8NafXiTsRdhwmB
         b45UkkSdwqc3uSDCUWfoosgi68royVu0HRrBoK2sEIqOkRCHJkqMUBph0rifyDFpaR+a
         I0ZojlvVCgzBi4pErOQBf4COIti1TH+7RikqSDAWytqg+EqklfSf7lCyK01Q6GgYITLi
         MtdeEh8IDy0jV8LY60E7hfQjvsCestacYslfCPcfZmcoTbjzAitZZ7E5XlvoEZTIS5zs
         AHClU/07Uy2NdHyEIdKhV3bPDU7OhB3I75zZUSHl6PQQ43+o9cM1oVTflUKgn1DcOrk7
         wXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmvW51s/G6sbMutj7IsS8dP6D7vZZheWzdfjfS0rHbM=;
        b=mPPP6LE9t7jhNp64YUych5A59qan1VckGQmzWegiwt5cfvq2CFDxbXj7XY6m3aQfpH
         xaQXkWqRcwhs0aHjokvAEUoC1PzCh8MHb0LkgkYFSoDyG/jflu4E6/LJwrK+0I2jxnYg
         9c1aen8H7Zh9Kar/UbBM9t+B69nhxuexLi6gPefTMntISoVydfAN3VANslU72Ya4/pqh
         JHnslcEhrFI4GXc6+TdwAhB52XeXACE+b07bWK5tt8VWfcEwE/4bWVlRCvp+NtxDQicH
         jsF421Xcc7xKQUBAuQLm+nmj3TRTRKn5Btq9koqaZh65tbChXot65etZYuPam5Ymx/Lm
         inQg==
X-Gm-Message-State: AO0yUKW9mRn1XpU/YmVIxymoNc8fTqAVGQwFR4oilp3lkgRhwI5dQ2mT
        YmqG5xDgwcO+eq6us5nn8KD/RQ==
X-Google-Smtp-Source: AK7set8KYbNGo+2Ffy18jbqdpV1UCSwm9ifVleRzK3ikkXpxJAmoUnNZFyHWMH55UZko95HmByGB9w==
X-Received: by 2002:a05:6512:149:b0:4db:513f:fe2a with SMTP id m9-20020a056512014900b004db513ffe2amr270509lfo.23.1676632112466;
        Fri, 17 Feb 2023 03:08:32 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id a12-20020a056512020c00b004b57162edfasm640162lfo.117.2023.02.17.03.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 03:08:32 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 17 Feb 2023 12:08:27 +0100
Subject: [PATCH v10 4/6] soc: qcom: cpr: Move common functions to new file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-topic-cpr3h-v10-4-67aed8fdfa61@linaro.org>
References: <20230217-topic-cpr3h-v10-0-67aed8fdfa61@linaro.org>
In-Reply-To: <20230217-topic-cpr3h-v10-0-67aed8fdfa61@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676632104; l=28757;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=jxVKVdhwcrqB2lvEmrvI/SSKr0TpIAxzV+SU+2yQU2o=;
 b=07spDcptrafr+/EcMAtPhp9CT8rhKz4Zf7gAdaqJaJHKeA4UPwrtMFrbCjjsyjGU0RPRjT3eVDu2
 6LQeeN8uBqVQFFAQKuAUWbmKJMkolNdoX098Z/H+Q+2tFAquknUO
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

In preparation for implementing a new driver that will be handling
CPRv3, CPRv4 and CPR-Hardened, format out common functions to a new
file.

Update cpr_get_fuses in preparation for CPR3 implementation, change
parameters where necessary to not take cpr.c private data structures.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
[Konrad: rebase, apply review comments, don't break backwards compat, improve msg]
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/Makefile     |   2 +-
 drivers/soc/qcom/cpr-common.c | 363 +++++++++++++++++++++++++++++++++++++++
 drivers/soc/qcom/cpr-common.h | 108 ++++++++++++
 drivers/soc/qcom/cpr.c        | 386 +++---------------------------------------
 4 files changed, 494 insertions(+), 365 deletions(-)

diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 6e88da899f60..c3a5bf014265 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -3,7 +3,7 @@ CFLAGS_rpmh-rsc.o := -I$(src)
 obj-$(CONFIG_QCOM_AOSS_QMP) +=	qcom_aoss.o
 obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
 obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
-obj-$(CONFIG_QCOM_CPR)		+= cpr.o
+obj-$(CONFIG_QCOM_CPR)		+= cpr-common.o cpr.o
 obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
 obj-$(CONFIG_QCOM_MDT_LOADER)	+= mdt_loader.o
 obj-$(CONFIG_QCOM_OCMEM)	+= ocmem.o
diff --git a/drivers/soc/qcom/cpr-common.c b/drivers/soc/qcom/cpr-common.c
new file mode 100644
index 000000000000..7c877b263241
--- /dev/null
+++ b/drivers/soc/qcom/cpr-common.c
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2019, Linaro Limited
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/debugfs.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_opp.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "cpr-common.h"
+
+int cpr_populate_ring_osc_idx(struct device *dev,
+			      struct fuse_corner *fuse_corner,
+			      const struct cpr_fuse *cpr_fuse,
+			      int num_fuse_corners)
+{
+	struct fuse_corner *end = fuse_corner + num_fuse_corners;
+	u32 data;
+	int ret;
+
+	for (; fuse_corner < end; fuse_corner++, cpr_fuse++) {
+		ret = nvmem_cell_read_variable_le_u32(dev, cpr_fuse->ring_osc, &data);
+		if (ret)
+			return ret;
+		fuse_corner->ring_osc_idx = data;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpr_populate_ring_osc_idx);
+
+static int cpr_read_fuse_uV(int init_v_width, int step_size_uV, int ref_uV,
+		     int adj, int step_volt, const char *init_v_efuse,
+		     struct device *dev)
+{
+	int steps, uV;
+	u32 bits = 0;
+	int ret;
+
+	ret = nvmem_cell_read_variable_le_u32(dev, init_v_efuse, &bits);
+	if (ret)
+		return ret;
+
+	steps = bits & (BIT(init_v_width - 1) - 1);
+	/* Not two's complement.. instead highest bit is sign bit */
+	if (bits & BIT(init_v_width - 1))
+		steps = -steps;
+
+	uV = ref_uV + steps * step_size_uV;
+
+	/* Apply open-loop fixed adjustments to fused values */
+	uV += adj;
+
+	return DIV_ROUND_UP(uV, step_volt) * step_volt;
+}
+
+const struct cpr_fuse *cpr_get_fuses(struct device *dev, int tid,
+				     unsigned int num_fuse_corners)
+{
+	struct cpr_fuse *fuses;
+	unsigned int i;
+	char cpr_name[11]; /* length of "cpr" + length of UINT_MAX (7) + \0 */
+
+	fuses = devm_kcalloc(dev, num_fuse_corners, sizeof(*fuses), GFP_KERNEL);
+	if (!fuses)
+		return ERR_PTR(-ENOMEM);
+
+	/* Support legacy bindings */
+	if (tid == UINT_MAX)
+		snprintf(cpr_name, sizeof(cpr_name), "cpr");
+	else
+		snprintf(cpr_name, sizeof(cpr_name), "cpr%d", tid);
+
+	for (i = 0; i < num_fuse_corners; i++) {
+		char tbuf[50];
+
+		snprintf(tbuf, sizeof(tbuf), "%s_ring_osc%d", cpr_name, i + 1);
+		fuses[i].ring_osc = devm_kstrdup(dev, tbuf, GFP_KERNEL);
+		if (!fuses[i].ring_osc)
+			return ERR_PTR(-ENOMEM);
+
+		snprintf(tbuf, sizeof(tbuf), "%s_init_voltage%d", cpr_name, i + 1);
+		fuses[i].init_voltage = devm_kstrdup(dev, tbuf, GFP_KERNEL);
+		if (!fuses[i].init_voltage)
+			return ERR_PTR(-ENOMEM);
+
+		snprintf(tbuf, sizeof(tbuf), "%s_quotient%d", cpr_name, i + 1);
+		fuses[i].quotient = devm_kstrdup(dev, tbuf, GFP_KERNEL);
+		if (!fuses[i].quotient)
+			return ERR_PTR(-ENOMEM);
+
+		snprintf(tbuf, sizeof(tbuf), "%s_quotient_offset%d", cpr_name, i + 1);
+		fuses[i].quotient_offset = devm_kstrdup(dev, tbuf, GFP_KERNEL);
+		if (!fuses[i].quotient_offset)
+			return ERR_PTR(-ENOMEM);
+	}
+
+	return fuses;
+}
+EXPORT_SYMBOL_GPL(cpr_get_fuses);
+
+int cpr_populate_fuse_common(struct device *dev,
+			     struct fuse_corner_data *fdata,
+			     const struct cpr_fuse *cpr_fuse,
+			     struct fuse_corner *fuse_corner,
+			     int step_volt, int init_v_width,
+			     int init_v_step)
+{
+	int uV, ret;
+
+	/* Populate uV */
+	uV = cpr_read_fuse_uV(init_v_width, init_v_step,
+			      fdata->ref_uV, fdata->volt_oloop_adjust,
+			      step_volt, cpr_fuse->init_voltage, dev);
+	if (uV < 0)
+		return uV;
+
+	/*
+	 * Update SoC voltages: platforms might choose a different
+	 * regulators than the one used to characterize the algorithms
+	 * (ie, init_voltage_step).
+	 */
+	fdata->min_uV = roundup(fdata->min_uV, step_volt);
+	fdata->max_uV = roundup(fdata->max_uV, step_volt);
+
+	fuse_corner->min_uV = fdata->min_uV;
+	fuse_corner->max_uV = fdata->max_uV;
+	fuse_corner->uV = clamp(uV, fuse_corner->min_uV, fuse_corner->max_uV);
+
+	/* Populate target quotient by scaling */
+	ret = nvmem_cell_read_variable_le_u32(dev, cpr_fuse->quotient, &fuse_corner->quot);
+	if (ret)
+		return ret;
+
+	fuse_corner->quot *= fdata->quot_scale;
+	fuse_corner->quot += fdata->quot_offset;
+	fuse_corner->quot += fdata->quot_adjust;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpr_populate_fuse_common);
+
+int cpr_find_initial_corner(struct device *dev, struct clk *cpu_clk,
+			    struct corner *corners, int num_corners)
+{
+	unsigned long rate;
+	struct corner *iter, *corner;
+	const struct corner *end;
+	unsigned int i = 0;
+
+	if (!cpu_clk) {
+		dev_err(dev, "cannot get rate from NULL clk\n");
+		return -EINVAL;
+	}
+
+	end = &corners[num_corners - 1];
+	rate = clk_get_rate(cpu_clk);
+
+	/*
+	 * Some bootloaders set a CPU clock frequency that is not defined
+	 * in the OPP table. When running at an unlisted frequency,
+	 * cpufreq_online() will change to the OPP which has the lowest
+	 * frequency, at or above the unlisted frequency.
+	 * Since cpufreq_online() always "rounds up" in the case of an
+	 * unlisted frequency, this function always "rounds down" in case
+	 * of an unlisted frequency. That way, when cpufreq_online()
+	 * triggers the first ever call to cpr_set_performance_state(),
+	 * it will correctly determine the direction as UP.
+	 */
+	for (iter = corners; iter <= end; iter++) {
+		if (iter->freq > rate)
+			break;
+		i++;
+		if (iter->freq == rate) {
+			corner = iter;
+			break;
+		}
+		if (iter->freq < rate)
+			corner = iter;
+	}
+
+	if (!corner) {
+		dev_err(dev, "boot up corner not found\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "boot up perf state: %u\n", i);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpr_find_initial_corner);
+
+unsigned int cpr_get_fuse_corner(struct dev_pm_opp *opp, u32 tid)
+{
+	struct device_node *np;
+	u32 fc;
+
+	np = dev_pm_opp_get_of_node(opp);
+	if (of_property_read_u32_index(np, "qcom,opp-fuse-level", tid, &fc)) {
+		pr_debug("%s: missing 'qcom,opp-fuse-level' property\n",
+			 __func__);
+		fc = 0;
+	}
+
+	of_node_put(np);
+
+	return fc;
+}
+EXPORT_SYMBOL_GPL(cpr_get_fuse_corner);
+
+unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
+				     struct device *cpu_dev)
+{
+	u64 rate = 0;
+	struct device_node *ref_np;
+	struct device_node *desc_np;
+	struct device_node *child_np = NULL;
+	struct device_node *child_req_np = NULL;
+
+	desc_np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
+	if (!desc_np)
+		return 0;
+
+	ref_np = dev_pm_opp_get_of_node(ref);
+	if (!ref_np)
+		goto out_ref;
+
+	for_each_available_child_of_node(desc_np, child_np) {
+		child_req_np = of_parse_phandle(child_np, "required-opps", 0);
+
+		if (child_np && child_req_np == ref_np) {
+			of_property_read_u64(child_np, "opp-hz", &rate);
+			goto out;
+		}
+	}
+
+out:
+	of_node_put(child_req_np);
+	of_node_put(child_np);
+	of_node_put(ref_np);
+out_ref:
+	of_node_put(desc_np);
+
+	return (unsigned long) rate;
+}
+EXPORT_SYMBOL_GPL(cpr_get_opp_hz_for_req);
+
+int cpr_calculate_scaling(struct device *dev,
+			  const char *quot_offset,
+			  const struct fuse_corner_data *fdata,
+			  const struct corner *corner)
+{
+	const struct fuse_corner *fuse, *prev_fuse;
+	u64 freq_diff;
+	u32 quot_diff = 0;
+	int scaling, ret;
+
+	fuse = corner->fuse_corner;
+	prev_fuse = fuse - 1;
+
+	if (quot_offset) {
+		ret = nvmem_cell_read_variable_le_u32(dev, quot_offset, &quot_diff);
+		if (ret)
+			return ret;
+
+		quot_diff *= fdata->quot_offset_scale;
+		quot_diff += fdata->quot_offset_adjust;
+	} else {
+		quot_diff = fuse->quot - prev_fuse->quot;
+	}
+
+	freq_diff = fuse->max_freq - prev_fuse->max_freq;
+	freq_diff = div_u64(freq_diff, 1000000); /* Convert to MHz */
+	scaling = 1000 * quot_diff;
+	do_div(scaling, freq_diff);
+	return min(scaling, fdata->max_quot_scale);
+}
+EXPORT_SYMBOL_GPL(cpr_calculate_scaling);
+
+int cpr_interpolate(const struct corner *corner, int step_volt,
+		    const struct fuse_corner_data *fdata)
+{
+	unsigned long f_high, f_low, f_diff;
+	int uV_high, uV_low, uV;
+	u64 temp, temp_limit;
+	const struct fuse_corner *fuse, *prev_fuse;
+
+	fuse = corner->fuse_corner;
+	prev_fuse = fuse - 1;
+
+	f_high = fuse->max_freq;
+	f_low = prev_fuse->max_freq;
+	uV_high = fuse->uV;
+	uV_low = prev_fuse->uV;
+	f_diff = fuse->max_freq - corner->freq;
+
+	/*
+	 * Don't interpolate in the wrong direction. This could happen
+	 * if the adjusted fuse voltage overlaps with the previous fuse's
+	 * adjusted voltage.
+	 */
+	if (f_high <= f_low || uV_high <= uV_low || f_high <= corner->freq)
+		return corner->uV;
+
+	temp = f_diff * (uV_high - uV_low);
+	temp = div64_ul(temp, f_high - f_low);
+
+	/*
+	 * max_volt_scale has units of uV/MHz while freq values
+	 * have units of Hz.  Divide by 1000000 to convert to.
+	 */
+	temp_limit = f_diff * fdata->max_volt_scale;
+	do_div(temp_limit, 1000000);
+
+	uV = uV_high - min(temp, temp_limit);
+	return roundup(uV, step_volt);
+}
+EXPORT_SYMBOL_GPL(cpr_interpolate);
+
+int cpr_check_vreg_constraints(struct device *dev, struct regulator *vreg,
+			       struct fuse_corner *f)
+{
+	int ret;
+
+	ret = regulator_is_supported_voltage(vreg, f->min_uV, f->min_uV);
+	if (!ret) {
+		dev_err(dev, "min uV: %d not supported by regulator\n",
+			f->min_uV);
+		return -EINVAL;
+	}
+
+	ret = regulator_is_supported_voltage(vreg, f->max_uV, f->max_uV);
+	if (!ret) {
+		dev_err(dev, "max uV: %d not supported by regulator\n",
+			f->max_uV);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpr_check_vreg_constraints);
+
+MODULE_DESCRIPTION("Core Power Reduction (CPR) common");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/soc/qcom/cpr-common.h b/drivers/soc/qcom/cpr-common.h
new file mode 100644
index 000000000000..2cd15f7eac90
--- /dev/null
+++ b/drivers/soc/qcom/cpr-common.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/regulator/consumer.h>
+
+enum voltage_change_dir {
+	NO_CHANGE,
+	DOWN,
+	UP,
+};
+
+struct fuse_corner_data {
+	int ref_uV;
+	int max_uV;
+	int min_uV;
+	int range_uV;
+	/* fuse volt: closed/open loop */
+	int volt_cloop_adjust;
+	int volt_oloop_adjust;
+	int max_volt_scale;
+	int max_quot_scale;
+	/* fuse quot */
+	int quot_offset;
+	int quot_scale;
+	int quot_adjust;
+	/* fuse quot_offset */
+	int quot_offset_scale;
+	int quot_offset_adjust;
+};
+
+struct cpr_fuse {
+	char *ring_osc;
+	char *init_voltage;
+	char *quotient;
+	char *quotient_offset;
+};
+
+struct fuse_corner {
+	int min_uV;
+	int max_uV;
+	int uV;
+	int quot;
+	int step_quot;
+	const struct reg_sequence *accs;
+	int num_accs;
+	unsigned long max_freq;
+	u8 ring_osc_idx;
+};
+
+struct corner {
+	int min_uV;
+	int max_uV;
+	int uV;
+	int last_uV;
+	int quot_adjust;
+	u32 save_ctl;
+	u32 save_irq;
+	unsigned long freq;
+	bool is_open_loop;
+	struct fuse_corner *fuse_corner;
+};
+
+struct corner_data {
+	unsigned int fuse_corner;
+	unsigned long freq;
+};
+
+struct acc_desc {
+	unsigned int	enable_reg;
+	u32		enable_mask;
+
+	struct reg_sequence	*config;
+	struct reg_sequence	*settings;
+	int			num_regs_per_fuse;
+};
+
+struct cpr_acc_desc {
+	const struct cpr_desc *cpr_desc;
+	const struct acc_desc *acc_desc;
+};
+
+int cpr_populate_ring_osc_idx(struct device *dev,
+			      struct fuse_corner *fuse_corner,
+			      const struct cpr_fuse *cpr_fuse,
+			      int num_fuse_corners);
+const struct cpr_fuse *cpr_get_fuses(struct device *dev, int tid,
+				     unsigned int num_fuse_corners);
+int cpr_populate_fuse_common(struct device *dev,
+			     struct fuse_corner_data *fdata,
+			     const struct cpr_fuse *cpr_fuse,
+			     struct fuse_corner *fuse_corner,
+			     int step_volt, int init_v_width,
+			     int init_v_step);
+int cpr_find_initial_corner(struct device *dev, struct clk *cpu_clk,
+			    struct corner *corners, int num_corners);
+u32 cpr_get_fuse_corner(struct dev_pm_opp *opp, u32 tid);
+unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
+				     struct device *cpu_dev);
+int cpr_calculate_scaling(struct device *dev,
+			  const char *quot_offset,
+			  const struct fuse_corner_data *fdata,
+			  const struct corner *corner);
+int cpr_interpolate(const struct corner *corner, int step_volt,
+		    const struct fuse_corner_data *fdata);
+int cpr_check_vreg_constraints(struct device *dev, struct regulator *vreg,
+			       struct fuse_corner *f);
\ No newline at end of file
diff --git a/drivers/soc/qcom/cpr.c b/drivers/soc/qcom/cpr.c
index 144ea68e0920..0229403bbd87 100644
--- a/drivers/soc/qcom/cpr.c
+++ b/drivers/soc/qcom/cpr.c
@@ -26,6 +26,8 @@
 #include <linux/clk.h>
 #include <linux/nvmem-consumer.h>
 
+#include "cpr-common.h"
+
 /* Register Offsets for RB-CPR and Bit Definitions */
 
 /* RBCPR Version Register */
@@ -124,45 +126,12 @@
 
 #define FUSE_REVISION_UNKNOWN		(-1)
 
-enum voltage_change_dir {
-	NO_CHANGE,
-	DOWN,
-	UP,
-};
-
-struct cpr_fuse {
-	char *ring_osc;
-	char *init_voltage;
-	char *quotient;
-	char *quotient_offset;
-};
-
-struct fuse_corner_data {
-	int ref_uV;
-	int max_uV;
-	int min_uV;
-	int max_volt_scale;
-	int max_quot_scale;
-	/* fuse quot */
-	int quot_offset;
-	int quot_scale;
-	int quot_adjust;
-	/* fuse quot_offset */
-	int quot_offset_scale;
-	int quot_offset_adjust;
-};
-
 struct cpr_fuses {
 	int init_voltage_step;
 	int init_voltage_width;
 	struct fuse_corner_data *fuse_corner_data;
 };
 
-struct corner_data {
-	unsigned int fuse_corner;
-	unsigned long freq;
-};
-
 struct cpr_desc {
 	unsigned int num_fuse_corners;
 	int min_diff_quot;
@@ -184,44 +153,6 @@ struct cpr_desc {
 	bool reduce_to_corner_uV;
 };
 
-struct acc_desc {
-	unsigned int	enable_reg;
-	u32		enable_mask;
-
-	struct reg_sequence	*config;
-	struct reg_sequence	*settings;
-	int			num_regs_per_fuse;
-};
-
-struct cpr_acc_desc {
-	const struct cpr_desc *cpr_desc;
-	const struct acc_desc *acc_desc;
-};
-
-struct fuse_corner {
-	int min_uV;
-	int max_uV;
-	int uV;
-	int quot;
-	int step_quot;
-	const struct reg_sequence *accs;
-	int num_accs;
-	unsigned long max_freq;
-	u8 ring_osc_idx;
-};
-
-struct corner {
-	int min_uV;
-	int max_uV;
-	int uV;
-	int last_uV;
-	int quot_adjust;
-	u32 save_ctl;
-	u32 save_irq;
-	unsigned long freq;
-	struct fuse_corner *fuse_corner;
-};
-
 struct cpr_drv {
 	unsigned int		num_corners;
 	unsigned int		ref_clk_khz;
@@ -801,50 +732,6 @@ static int cpr_set_performance_state(struct generic_pm_domain *domain,
 	return ret;
 }
 
-static int
-cpr_populate_ring_osc_idx(struct cpr_drv *drv)
-{
-	struct fuse_corner *fuse = drv->fuse_corners;
-	struct fuse_corner *end = fuse + drv->desc->num_fuse_corners;
-	const struct cpr_fuse *fuses = drv->cpr_fuses;
-	u32 data;
-	int ret;
-
-	for (; fuse < end; fuse++, fuses++) {
-		ret = nvmem_cell_read_variable_le_u32(drv->dev, fuses->ring_osc, &data);
-		if (ret)
-			return ret;
-		fuse->ring_osc_idx = data;
-	}
-
-	return 0;
-}
-
-static int cpr_read_fuse_uV(const struct cpr_desc *desc,
-			    const struct fuse_corner_data *fdata,
-			    const char *init_v_efuse,
-			    int step_volt,
-			    struct cpr_drv *drv)
-{
-	int step_size_uV, steps, uV;
-	u32 bits = 0;
-	int ret;
-
-	ret = nvmem_cell_read_variable_le_u32(drv->dev, init_v_efuse, &bits);
-	if (ret)
-		return ret;
-
-	steps = bits & ~BIT(desc->cpr_fuses.init_voltage_width - 1);
-	/* Not two's complement.. instead highest bit is sign bit */
-	if (bits & BIT(desc->cpr_fuses.init_voltage_width - 1))
-		steps = -steps;
-
-	step_size_uV = desc->cpr_fuses.init_voltage_step;
-
-	uV = fdata->ref_uV + steps * step_size_uV;
-	return DIV_ROUND_UP(uV, step_volt) * step_volt;
-}
-
 static int cpr_fuse_corner_init(struct cpr_drv *drv)
 {
 	const struct cpr_desc *desc = drv->desc;
@@ -854,7 +741,6 @@ static int cpr_fuse_corner_init(struct cpr_drv *drv)
 	unsigned int step_volt;
 	struct fuse_corner_data *fdata;
 	struct fuse_corner *fuse, *end;
-	int uV;
 	const struct reg_sequence *accs;
 	int ret;
 
@@ -870,23 +756,15 @@ static int cpr_fuse_corner_init(struct cpr_drv *drv)
 	fdata = desc->cpr_fuses.fuse_corner_data;
 
 	for (i = 0; fuse <= end; fuse++, fuses++, i++, fdata++) {
-		/*
-		 * Update SoC voltages: platforms might choose a different
-		 * regulators than the one used to characterize the algorithms
-		 * (ie, init_voltage_step).
-		 */
-		fdata->min_uV = roundup(fdata->min_uV, step_volt);
-		fdata->max_uV = roundup(fdata->max_uV, step_volt);
+		ret = cpr_populate_fuse_common(drv->dev, fdata, fuses,
+					       fuse, step_volt,
+					       desc->cpr_fuses.init_voltage_width,
+					       desc->cpr_fuses.init_voltage_step);
+		if (ret)
+			return ret;
 
-		/* Populate uV */
-		uV = cpr_read_fuse_uV(desc, fdata, fuses->init_voltage,
-				      step_volt, drv);
-		if (uV < 0)
-			return uV;
 
-		fuse->min_uV = fdata->min_uV;
-		fuse->max_uV = fdata->max_uV;
-		fuse->uV = clamp(uV, fuse->min_uV, fuse->max_uV);
+		fuse->step_quot = desc->step_quot[fuse->ring_osc_idx];
 
 		if (fuse == end) {
 			/*
@@ -924,25 +802,9 @@ static int cpr_fuse_corner_init(struct cpr_drv *drv)
 		else if (fuse->uV < fuse->min_uV)
 			fuse->uV = fuse->min_uV;
 
-		ret = regulator_is_supported_voltage(drv->vdd_apc,
-						     fuse->min_uV,
-						     fuse->min_uV);
-		if (!ret) {
-			dev_err(drv->dev,
-				"min uV: %d (fuse corner: %d) not supported by regulator\n",
-				fuse->min_uV, i);
-			return -EINVAL;
-		}
-
-		ret = regulator_is_supported_voltage(drv->vdd_apc,
-						     fuse->max_uV,
-						     fuse->max_uV);
-		if (!ret) {
-			dev_err(drv->dev,
-				"max uV: %d (fuse corner: %d) not supported by regulator\n",
-				fuse->max_uV, i);
-			return -EINVAL;
-		}
+		ret = cpr_check_vreg_constraints(drv->dev, drv->vdd_apc, fuse);
+		if (ret)
+			return ret;
 
 		dev_dbg(drv->dev,
 			"fuse corner %d: [%d %d %d] RO%hhu quot %d squot %d\n",
@@ -953,126 +815,6 @@ static int cpr_fuse_corner_init(struct cpr_drv *drv)
 	return 0;
 }
 
-static int cpr_calculate_scaling(const char *quot_offset,
-				 struct cpr_drv *drv,
-				 const struct fuse_corner_data *fdata,
-				 const struct corner *corner)
-{
-	u32 quot_diff = 0;
-	unsigned long freq_diff;
-	int scaling;
-	const struct fuse_corner *fuse, *prev_fuse;
-	int ret;
-
-	fuse = corner->fuse_corner;
-	prev_fuse = fuse - 1;
-
-	if (quot_offset) {
-		ret = nvmem_cell_read_variable_le_u32(drv->dev, quot_offset, &quot_diff);
-		if (ret)
-			return ret;
-
-		quot_diff *= fdata->quot_offset_scale;
-		quot_diff += fdata->quot_offset_adjust;
-	} else {
-		quot_diff = fuse->quot - prev_fuse->quot;
-	}
-
-	freq_diff = fuse->max_freq - prev_fuse->max_freq;
-	freq_diff /= 1000000; /* Convert to MHz */
-	scaling = 1000 * quot_diff / freq_diff;
-	return min(scaling, fdata->max_quot_scale);
-}
-
-static int cpr_interpolate(const struct corner *corner, int step_volt,
-			   const struct fuse_corner_data *fdata)
-{
-	unsigned long f_high, f_low, f_diff;
-	int uV_high, uV_low, uV;
-	u64 temp, temp_limit;
-	const struct fuse_corner *fuse, *prev_fuse;
-
-	fuse = corner->fuse_corner;
-	prev_fuse = fuse - 1;
-
-	f_high = fuse->max_freq;
-	f_low = prev_fuse->max_freq;
-	uV_high = fuse->uV;
-	uV_low = prev_fuse->uV;
-	f_diff = fuse->max_freq - corner->freq;
-
-	/*
-	 * Don't interpolate in the wrong direction. This could happen
-	 * if the adjusted fuse voltage overlaps with the previous fuse's
-	 * adjusted voltage.
-	 */
-	if (f_high <= f_low || uV_high <= uV_low || f_high <= corner->freq)
-		return corner->uV;
-
-	temp = f_diff * (uV_high - uV_low);
-	temp = div64_ul(temp, f_high - f_low);
-
-	/*
-	 * max_volt_scale has units of uV/MHz while freq values
-	 * have units of Hz.  Divide by 1000000 to convert to.
-	 */
-	temp_limit = f_diff * fdata->max_volt_scale;
-	do_div(temp_limit, 1000000);
-
-	uV = uV_high - min(temp, temp_limit);
-	return roundup(uV, step_volt);
-}
-
-static unsigned int cpr_get_fuse_corner(struct dev_pm_opp *opp)
-{
-	struct device_node *np;
-	unsigned int fuse_corner = 0;
-
-	np = dev_pm_opp_get_of_node(opp);
-	if (of_property_read_u32(np, "qcom,opp-fuse-level", &fuse_corner))
-		pr_err("%s: missing 'qcom,opp-fuse-level' property\n",
-		       __func__);
-
-	of_node_put(np);
-
-	return fuse_corner;
-}
-
-static unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
-					    struct device *cpu_dev)
-{
-	u64 rate = 0;
-	struct device_node *ref_np;
-	struct device_node *desc_np;
-	struct device_node *child_np = NULL;
-	struct device_node *child_req_np = NULL;
-
-	desc_np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
-	if (!desc_np)
-		return 0;
-
-	ref_np = dev_pm_opp_get_of_node(ref);
-	if (!ref_np)
-		goto out_ref;
-
-	do {
-		of_node_put(child_req_np);
-		child_np = of_get_next_available_child(desc_np, child_np);
-		child_req_np = of_parse_phandle(child_np, "required-opps", 0);
-	} while (child_np && child_req_np != ref_np);
-
-	if (child_np && child_req_np == ref_np)
-		of_property_read_u64(child_np, "opp-hz", &rate);
-
-	of_node_put(child_req_np);
-	of_node_put(child_np);
-	of_node_put(ref_np);
-out_ref:
-	of_node_put(desc_np);
-
-	return (unsigned long) rate;
-}
-
 static int cpr_corner_init(struct cpr_drv *drv)
 {
 	const struct cpr_desc *desc = drv->desc;
@@ -1110,7 +852,7 @@ static int cpr_corner_init(struct cpr_drv *drv)
 		opp = dev_pm_opp_find_level_exact(&drv->pd.dev, level);
 		if (IS_ERR(opp))
 			return -EINVAL;
-		fc = cpr_get_fuse_corner(opp);
+		fc = cpr_get_fuse_corner(opp, 0);
 		if (!fc) {
 			dev_pm_opp_put(opp);
 			return -EINVAL;
@@ -1186,7 +928,7 @@ static int cpr_corner_init(struct cpr_drv *drv)
 		corner->uV = fuse->uV;
 
 		if (prev_fuse && cdata[i - 1].freq == prev_fuse->max_freq) {
-			scaling = cpr_calculate_scaling(quot_offset, drv,
+			scaling = cpr_calculate_scaling(drv->dev, quot_offset,
 							fdata, corner);
 			if (scaling < 0)
 				return scaling;
@@ -1224,47 +966,6 @@ static int cpr_corner_init(struct cpr_drv *drv)
 	return 0;
 }
 
-static const struct cpr_fuse *cpr_get_fuses(struct cpr_drv *drv)
-{
-	const struct cpr_desc *desc = drv->desc;
-	struct cpr_fuse *fuses;
-	int i;
-
-	fuses = devm_kcalloc(drv->dev, desc->num_fuse_corners,
-			     sizeof(struct cpr_fuse),
-			     GFP_KERNEL);
-	if (!fuses)
-		return ERR_PTR(-ENOMEM);
-
-	for (i = 0; i < desc->num_fuse_corners; i++) {
-		char tbuf[32];
-
-		snprintf(tbuf, 32, "cpr_ring_osc%d", i + 1);
-		fuses[i].ring_osc = devm_kstrdup(drv->dev, tbuf, GFP_KERNEL);
-		if (!fuses[i].ring_osc)
-			return ERR_PTR(-ENOMEM);
-
-		snprintf(tbuf, 32, "cpr_init_voltage%d", i + 1);
-		fuses[i].init_voltage = devm_kstrdup(drv->dev, tbuf,
-						     GFP_KERNEL);
-		if (!fuses[i].init_voltage)
-			return ERR_PTR(-ENOMEM);
-
-		snprintf(tbuf, 32, "cpr_quotient%d", i + 1);
-		fuses[i].quotient = devm_kstrdup(drv->dev, tbuf, GFP_KERNEL);
-		if (!fuses[i].quotient)
-			return ERR_PTR(-ENOMEM);
-
-		snprintf(tbuf, 32, "cpr_quotient_offset%d", i + 1);
-		fuses[i].quotient_offset = devm_kstrdup(drv->dev, tbuf,
-							GFP_KERNEL);
-		if (!fuses[i].quotient_offset)
-			return ERR_PTR(-ENOMEM);
-	}
-
-	return fuses;
-}
-
 static void cpr_set_loop_allowed(struct cpr_drv *drv)
 {
 	drv->loop_disabled = false;
@@ -1296,54 +997,6 @@ static int cpr_init_parameters(struct cpr_drv *drv)
 	return 0;
 }
 
-static int cpr_find_initial_corner(struct cpr_drv *drv)
-{
-	unsigned long rate;
-	const struct corner *end;
-	struct corner *iter;
-	unsigned int i = 0;
-
-	if (!drv->cpu_clk) {
-		dev_err(drv->dev, "cannot get rate from NULL clk\n");
-		return -EINVAL;
-	}
-
-	end = &drv->corners[drv->num_corners - 1];
-	rate = clk_get_rate(drv->cpu_clk);
-
-	/*
-	 * Some bootloaders set a CPU clock frequency that is not defined
-	 * in the OPP table. When running at an unlisted frequency,
-	 * cpufreq_online() will change to the OPP which has the lowest
-	 * frequency, at or above the unlisted frequency.
-	 * Since cpufreq_online() always "rounds up" in the case of an
-	 * unlisted frequency, this function always "rounds down" in case
-	 * of an unlisted frequency. That way, when cpufreq_online()
-	 * triggers the first ever call to cpr_set_performance_state(),
-	 * it will correctly determine the direction as UP.
-	 */
-	for (iter = drv->corners; iter <= end; iter++) {
-		if (iter->freq > rate)
-			break;
-		i++;
-		if (iter->freq == rate) {
-			drv->corner = iter;
-			break;
-		}
-		if (iter->freq < rate)
-			drv->corner = iter;
-	}
-
-	if (!drv->corner) {
-		dev_err(drv->dev, "boot up corner not found\n");
-		return -EINVAL;
-	}
-
-	dev_dbg(drv->dev, "boot up perf state: %u\n", i);
-
-	return 0;
-}
-
 static const struct cpr_desc qcs404_cpr_desc = {
 	.num_fuse_corners = 3,
 	.min_diff_quot = CPR_FUSE_MIN_QUOT_DIFF,
@@ -1531,7 +1184,8 @@ static int cpr_pd_attach_dev(struct generic_pm_domain *domain,
 	if (ret)
 		goto unlock;
 
-	ret = cpr_find_initial_corner(drv);
+	ret = cpr_find_initial_corner(drv->dev, drv->cpu_clk, drv->corners,
+				      drv->num_corners);
 	if (ret)
 		goto unlock;
 
@@ -1616,6 +1270,7 @@ static int cpr_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct cpr_drv *drv;
+	const struct cpr_desc *desc;
 	int irq, ret;
 	const struct cpr_acc_desc *data;
 	struct device_node *np;
@@ -1631,6 +1286,7 @@ static int cpr_probe(struct platform_device *pdev)
 	drv->dev = dev;
 	drv->desc = data->cpr_desc;
 	drv->acc_desc = data->acc_desc;
+	desc = drv->desc;
 
 	drv->fuse_corners = devm_kcalloc(dev, drv->desc->num_fuse_corners,
 					 sizeof(*drv->fuse_corners),
@@ -1670,11 +1326,13 @@ static int cpr_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	drv->cpr_fuses = cpr_get_fuses(drv);
+	drv->cpr_fuses = cpr_get_fuses(drv->dev, UINT_MAX, desc->num_fuse_corners);
 	if (IS_ERR(drv->cpr_fuses))
 		return PTR_ERR(drv->cpr_fuses);
 
-	ret = cpr_populate_ring_osc_idx(drv);
+	ret = cpr_populate_ring_osc_idx(drv->dev, drv->fuse_corners,
+					drv->cpr_fuses,
+					desc->num_fuse_corners);
 	if (ret)
 		return ret;
 

-- 
2.39.1

