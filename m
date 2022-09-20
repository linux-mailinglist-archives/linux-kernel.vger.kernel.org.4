Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D515A5BDA9B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 05:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiITDD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 23:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiITDDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 23:03:43 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E6658527;
        Mon, 19 Sep 2022 20:03:40 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h188so1174973pgc.12;
        Mon, 19 Sep 2022 20:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=IHv+se6PCST4Oao8xK2ZgRiscYBxXE1DiDrvnYlWrIY=;
        b=NXCegjGzPUIaiuBhU/qR9JqeK5hJjCZdKxe3wIGzQwuVRmK/5e6xX2+wxJaBwDj7yQ
         tFtt60TsXyCvkN2ZE+1jhh/y9C/6BtxTyNNhWupu2cJeAtUPgyVZrYqOQLAyro+Q0mrb
         dk45XPlBec5QDZ5CFAE4zaZ5NgsfHGxjHKRCt2CrvwBYocc/SBOvHJulr1O+aQUdM/Ht
         ZjJ4lgrdXP+ZhADVLpEk7OTiTDBxmCVqmKxlWRVobxQyQY7fST16LzN1/qqmJ/kUtB7p
         CuUe0vc+XxvC0Bn6LxZEEDWN+4RWlz5CPLV57vbEGn0D63L52Ul2amMlOMq4KNU8p69L
         N7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IHv+se6PCST4Oao8xK2ZgRiscYBxXE1DiDrvnYlWrIY=;
        b=ZdDssZtXFJcj7wp0xFzfKo33PIc72iI/3rcRGsK5lknxKl8ggPIPh2ZCTXeh06FW4U
         VNCDKL6vo8coK3H/CkLb+KN2/N8t7m+SmmLSQqT57+xjOl1chXBUcBsZ269Byw2KHwbj
         F8+hNLhYUruwzaVNL/0wgW1Vrx9lal1FAe68zmjTQzvoeWIDZnaykZG7mWKgZgndnNSl
         /mOIHVknTYQN8CRcrTVl/jqvLlwS+QozztFPmyb/RNcB6ocDluduNQg9XkaibspIgsSO
         pQokFhKt5z1DxBFvm+2w/YQOjt5i5VPJCVAhVXJQab+2HAqQ/VB+D7+in+MsGBoTcXrj
         m/iA==
X-Gm-Message-State: ACrzQf1r3tj9bMB1ynZKehJ25ubTHrPopg7qqmqwqrzHa0/0WtC0WxXI
        1bV+sNBHE2fPH2WO3XzzkpymFQwG/4nzHQ==
X-Google-Smtp-Source: AMsMyM4GBHdSc51aiMUpdWHQNLXwGmTJWsrmxM0193CCuRgMdKWWwiKUm5a1KDhi/rol0HCopo+opA==
X-Received: by 2002:a65:464d:0:b0:439:246e:8091 with SMTP id k13-20020a65464d000000b00439246e8091mr18510462pgr.295.1663643019989;
        Mon, 19 Sep 2022 20:03:39 -0700 (PDT)
Received: from skynet-linux.local ([2406:7400:61:8a0f:392d:db19:673c:627a])
        by smtp.googlemail.com with ESMTPSA id t193-20020a635fca000000b0043a18cef977sm171083pgb.13.2022.09.19.20.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 20:03:39 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     andersson@kernel.org, Vladimir Lypak <vladimir.lypak@gmail.com>,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/4] remoteproc: qcom: qcom_wcnss: Add support for pronto-v3
Date:   Tue, 20 Sep 2022 08:33:13 +0530
Message-Id: <20220920030316.1619781-2-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920030316.1619781-1-sireeshkodali1@gmail.com>
References: <20220920030316.1619781-1-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Lypak <vladimir.lypak@gmail.com>

Pronto-v3 is similar to pronto-v2. It requires two power domains, and it
requires the xo clock. It is used on the MSM8953 platform.

Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 drivers/remoteproc/qcom_wcnss.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
index 68f37296b151..ff18bfae5eb6 100644
--- a/drivers/remoteproc/qcom_wcnss.c
+++ b/drivers/remoteproc/qcom_wcnss.c
@@ -141,6 +141,18 @@ static const struct wcnss_data pronto_v2_data = {
 	.num_vregs = 1,
 };
 
+static const struct wcnss_data pronto_v3_data = {
+	.pmu_offset = 0x1004,
+	.spare_offset = 0x1088,
+
+	.pd_names = { "mx", "cx" },
+	.vregs = (struct wcnss_vreg_info[]) {
+		{ "vddpx", 1800000, 1800000, 0 },
+	},
+	.num_pd_vregs = 2,
+	.num_vregs = 1,
+};
+
 static int wcnss_load(struct rproc *rproc, const struct firmware *fw)
 {
 	struct qcom_wcnss *wcnss = (struct qcom_wcnss *)rproc->priv;
@@ -675,6 +687,7 @@ static const struct of_device_id wcnss_of_match[] = {
 	{ .compatible = "qcom,riva-pil", &riva_data },
 	{ .compatible = "qcom,pronto-v1-pil", &pronto_v1_data },
 	{ .compatible = "qcom,pronto-v2-pil", &pronto_v2_data },
+	{ .compatible = "qcom,pronto-v3-pil", &pronto_v3_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, wcnss_of_match);
-- 
2.37.3

