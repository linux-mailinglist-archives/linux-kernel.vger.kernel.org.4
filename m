Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31396663F1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbjAKTpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbjAKTos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:44:48 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBAA2DF;
        Wed, 11 Jan 2023 11:43:01 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id g19-20020a05600c4ed300b003d9eb1dbc0aso10554732wmq.3;
        Wed, 11 Jan 2023 11:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CyBu08uMqErM+zzJyPRDJRWX5ryfOT/RoKB9om6pnjA=;
        b=DeGEnoYZH8PDB2qNjumnoF+OGXj5H6pdchxfO2hZYhXDKe4sx1wjOvscmOwDYm1m/w
         J/rsv0NsmUFOlxcjflDu5JTs686rxvl8Y2mVlqX10tB98ztIkpSfstJE8YAIEOrZe9Di
         f9hISqMw46LmJRUrmHvs+SZYiAgOxXwEdnVrZBm9b91xRhoizjQcM9ue7ZllDHVbKARW
         qtw+5+rTpyNg1rBmoRcid/5t0rszPClLJ8JRmcgQBuMs6N3eiSxmhmSaK7A/DdVhKHSF
         9en63kA37YDFAX18+RDGYEgTJrftJRuWBGnDjhtStv55YNgx0VL9un7lStg/2jd9+jLL
         styQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CyBu08uMqErM+zzJyPRDJRWX5ryfOT/RoKB9om6pnjA=;
        b=dTnqP/aaQw5KQ/5Fl4r1KduNEmf1FuWHkPOiM7SkMyYlwpZISk/IczpGuo8OQlk70m
         O3cXNmHRyOfK3jnQeWIZICcKlt380kdDF5yfCf/cG+HcpOad3wYK2kUi/1Wc/aTECU2/
         /jUQt5qi9hIcqKQ6vvTYqjmlpU04wkmbH/ldW3owQF0YYuiC+X+B7GV/iXTXIeNKUy21
         mdP4wqNWCDoj+ksJqWLGXchndkGTQSj5ceC3swXnPHyAv0qrtlUHUnv3v9ecpuegLhPu
         UwOOE7uu31bih29wtehWSbaFjb7JdjnkTEZ7cRSiToX41TiTig6QvStD+JPuNFX5qO/d
         PqgA==
X-Gm-Message-State: AFqh2koG8eAvk+6DWOLQbVTAJiy2l8aJTl9wV3FY+FMwPiBDnnRAO/n0
        D9oINTUE0UaF7zGkR5RVaM64nEC5QZk=
X-Google-Smtp-Source: AMrXdXvD3VbsAH/ou1No7M1RDdaMGDOKkewoQsiYmTXPg2MDovWtZ3zZ4tyfpsI6QaeEPQCsHxgfWg==
X-Received: by 2002:a05:600c:1c11:b0:3d1:e583:51a0 with SMTP id j17-20020a05600c1c1100b003d1e58351a0mr55320858wms.25.1673466179733;
        Wed, 11 Jan 2023 11:42:59 -0800 (PST)
Received: from localhost.localdomain (93-34-92-88.ip49.fastwebnet.it. [93.34.92.88])
        by smtp.googlemail.com with ESMTPSA id bt19-20020a056000081300b002bdc3f5945dsm2179789wrb.89.2023.01.11.11.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 11:42:59 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Robert Marko <robimarko@gmail.com>
Subject: [RESEND PATCH 1/2] clk: qcom: clk-rcg2: introduce support for multiple conf for same freq
Date:   Wed, 11 Jan 2023 20:42:49 +0100
Message-Id: <20230111194250.15793-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some RCG frequency can be reached by multiple configuration.

We currently declare multiple configuration for the same frequency but
that is not supported and always the first configuration will be taken.

These multiple configuration are needed as based on the current parent
configuration, it may be needed to use a different configuration to
reach the same frequency.

To handle this introduce 2 new macro, FM and C.

- FM is used to declare an empty freq_tbl with just the frequency and an
  array of confs to insert all the config for the provided frequency.

- C is used to declare a fre_conf where src, pre_div, m and n are
  provided.

The driver is changed to handle this special freq_tbl and select the
correct config by calculating the final rate and deciding based on the
one that is less different than the requested one.

Tested-by: Robert Marko <robimarko@gmail.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/clk-rcg.h  | 14 ++++++-
 drivers/clk/qcom/clk-rcg2.c | 84 +++++++++++++++++++++++++++++++++----
 2 files changed, 88 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
index 01581f4d2c39..18f4f7b59f36 100644
--- a/drivers/clk/qcom/clk-rcg.h
+++ b/drivers/clk/qcom/clk-rcg.h
@@ -7,7 +7,17 @@
 #include <linux/clk-provider.h>
 #include "clk-regmap.h"
 
-#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
+#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n), 0, NULL }
+
+#define FM(_f, _confs) { .freq = (_f), .confs_num = ARRAY_SIZE(_confs), .confs = (_confs) }
+#define C(s, h, m, n) { (s), (2 * (h) - 1), (m), (n) }
+
+struct freq_conf {
+	u8 src;
+	u8 pre_div;
+	u16 m;
+	u16 n;
+};
 
 struct freq_tbl {
 	unsigned long freq;
@@ -15,6 +25,8 @@ struct freq_tbl {
 	u8 pre_div;
 	u16 m;
 	u16 n;
+	int confs_num;
+	const struct freq_conf *confs;
 };
 
 /**
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 76551534f10d..7d3b59ec2b50 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -209,11 +209,60 @@ clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	return __clk_rcg2_recalc_rate(hw, parent_rate, cfg);
 }
 
+static void
+clk_rcg2_select_conf(struct clk_hw *hw, struct freq_tbl *f_tbl,
+		     const struct freq_tbl *f, unsigned long req_rate)
+{
+	unsigned long best_rate = 0, parent_rate, rate;
+	const struct freq_conf *conf, *best_conf;
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	struct clk_hw *p;
+	int index, i;
+
+	/* Search in each provided config the one that is near the wanted rate */
+	for (i = 0, conf = f->confs; i < f->confs_num; i++, conf++) {
+		index = qcom_find_src_index(hw, rcg->parent_map, conf->src);
+		if (index < 0)
+			continue;
+
+		p = clk_hw_get_parent_by_index(hw, index);
+		if (!p)
+			continue;
+
+		parent_rate =  clk_hw_get_rate(p);
+		rate = calc_rate(parent_rate, conf->n, conf->m, conf->n, conf->pre_div);
+
+		if (rate == req_rate) {
+			best_conf = conf;
+			break;
+		}
+
+		if (abs(req_rate - rate) < abs(best_rate - rate)) {
+			best_rate = rate;
+			best_conf = conf;
+		}
+	}
+
+	/*
+	 * Very unlikely.
+	 * Force the first conf if we can't find a correct config.
+	 */
+	if (unlikely(i == f->confs_num))
+		best_conf = f->confs;
+
+	/* Apply the config */
+	f_tbl->src = best_conf->src;
+	f_tbl->pre_div = best_conf->pre_div;
+	f_tbl->m = best_conf->m;
+	f_tbl->n = best_conf->n;
+}
+
 static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
 				    struct clk_rate_request *req,
 				    enum freq_policy policy)
 {
 	unsigned long clk_flags, rate = req->rate;
+	struct freq_tbl f_tbl;
 	struct clk_hw *p;
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	int index;
@@ -232,7 +281,15 @@ static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
 	if (!f)
 		return -EINVAL;
 
-	index = qcom_find_src_index(hw, rcg->parent_map, f->src);
+	f_tbl = *f;
+	/*
+	 * A single freq may be reached by multiple configuration.
+	 * Try to find the bast one if we have this kind of freq_table.
+	 */
+	if (f->confs)
+		clk_rcg2_select_conf(hw, &f_tbl, f, rate);
+
+	index = qcom_find_src_index(hw, rcg->parent_map, f_tbl.src);
 	if (index < 0)
 		return index;
 
@@ -242,18 +299,18 @@ static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
 		return -EINVAL;
 
 	if (clk_flags & CLK_SET_RATE_PARENT) {
-		rate = f->freq;
-		if (f->pre_div) {
+		rate = f_tbl.freq;
+		if (f_tbl.pre_div) {
 			if (!rate)
 				rate = req->rate;
 			rate /= 2;
-			rate *= f->pre_div + 1;
+			rate *= f_tbl.pre_div + 1;
 		}
 
-		if (f->n) {
+		if (f_tbl.n) {
 			u64 tmp = rate;
-			tmp = tmp * f->n;
-			do_div(tmp, f->m);
+			tmp = tmp * f_tbl.n;
+			do_div(tmp, f_tbl.m);
 			rate = tmp;
 		}
 	} else {
@@ -261,7 +318,7 @@ static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
 	}
 	req->best_parent_hw = p;
 	req->best_parent_rate = rate;
-	req->rate = f->freq;
+	req->rate = f_tbl.freq;
 
 	return 0;
 }
@@ -357,6 +414,7 @@ static int __clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	const struct freq_tbl *f;
+	struct freq_tbl f_tbl;
 
 	switch (policy) {
 	case FLOOR:
@@ -372,7 +430,15 @@ static int __clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (!f)
 		return -EINVAL;
 
-	return clk_rcg2_configure(rcg, f);
+	f_tbl = *f;
+	/*
+	 * A single freq may be reached by multiple configuration.
+	 * Try to find the best one if we have this kind of freq_table.
+	 */
+	if (f->confs)
+		clk_rcg2_select_conf(hw, &f_tbl, f, rate);
+
+	return clk_rcg2_configure(rcg, &f_tbl);
 }
 
 static int clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
-- 
2.37.2

