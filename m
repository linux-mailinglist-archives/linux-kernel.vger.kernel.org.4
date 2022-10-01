Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC225F196A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 05:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbiJADXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 23:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbiJADWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 23:22:20 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED1A4BA54;
        Fri, 30 Sep 2022 20:15:07 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id u69so5632960pgd.2;
        Fri, 30 Sep 2022 20:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=WS8+aHrpEJcPx+GL0ClM0OpEIxuUEQEiHn73/H2YPtI=;
        b=OifcXVKgL/Y2MR8NT6VuBy0ERXN+g28z9Z0Tn9ortQcDze37w0ZylmrF7KACE9WIkA
         L65S0lgi3brOlvLdjUKvd+FsCfN1tI2Y51nePP5mDgt9wP5McLaSYSindE63TCH/jfmf
         mk6e2IRb0K9ypp/aRAlcv9v/gNPW6QRuCXtnIXjrxQilcvkNUM2QHzoP+1pdO19OU8lq
         gVSbeIl1HkMxJKfoNYxWc2r04Qz3zJoV+777ZfqCPjaiIY7kgeXHM2TXLXCojhH8JupY
         lqDkePVV/P/1GE+otFYBWtZrtjxktKyqsYgzkKIbFDt5PPChDNAGd81mFMpRNh+60C9c
         u5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WS8+aHrpEJcPx+GL0ClM0OpEIxuUEQEiHn73/H2YPtI=;
        b=OwvHDqRj6EWeHuS0JnbSyEGSsK5gUY9iFxRP2zbUSat5r6Vkl5/9Iwx5CIcWYRi1H8
         y6rmH72wZRK0S8PA2mJCyOVbZTKcGvjmjLTqRO3SPKvIy14T/GsS+9+lpIFMxUKZZpi+
         pjjCxdmm/kHpoYD2gjY3urCO5uBdFK9npWJ4IWAG5kOnHI9HI6GquQ7MtpktYVxltr0n
         DPbkPz8+aaW4ZRp82tnlVBB8aRqLw9ipzE4RtelA85nSAWIlWg2ivpr56CQ42e1MYfFk
         bpzFyjGtJNSJnxeFdGQ1YAScLPO1BYsBKXQ4xSDlANHrRLd7SF1zKZtFt9tf70Dey5ga
         GTfQ==
X-Gm-Message-State: ACrzQf3TR1mdFe0Q4j4siYhRSjYYxTMmOPEFYm/SVlQIskypnfcBaFzj
        lkdSJpyYsrFh2VvZyYlO4HFQncaUaUZoio5q
X-Google-Smtp-Source: AMsMyM7Ya4zNiDzlQhvFBKSCqIoTqCJ+bIjL9mMOIXZ59mxgEuLN8Ft5BFS06JWUhvZx9/87kUmDWg==
X-Received: by 2002:a05:6a02:4a:b0:447:f9d7:4e32 with SMTP id az10-20020a056a02004a00b00447f9d74e32mr608935pgb.412.1664594041901;
        Fri, 30 Sep 2022 20:14:01 -0700 (PDT)
Received: from skynet-linux.local ([2406:7400:61:5d7c:3fe4:8f6d:b1b6:f2bf])
        by smtp.googlemail.com with ESMTPSA id cp1-20020a170902e78100b00172a567d910sm2627371plb.289.2022.09.30.20.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 20:14:01 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH v6 1/5] remoteproc: qcom: qcom_wcnss: Add support for pronto-v3
Date:   Sat,  1 Oct 2022 08:43:40 +0530
Message-Id: <20221001031345.31293-2-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001031345.31293-1-sireeshkodali1@gmail.com>
References: <20221001031345.31293-1-sireeshkodali1@gmail.com>
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

Pronto-v3 is similar to pronto-v2. It requires two power domains, one
regulator, and it requires the xo clock. It is used on the MSM8953
platform.

Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 drivers/remoteproc/qcom_wcnss.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
index 68f37296b151..f599d5d5719d 100644
--- a/drivers/remoteproc/qcom_wcnss.c
+++ b/drivers/remoteproc/qcom_wcnss.c
@@ -141,6 +141,17 @@ static const struct wcnss_data pronto_v2_data = {
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
+	.num_vregs = 1,
+};
+
 static int wcnss_load(struct rproc *rproc, const struct firmware *fw)
 {
 	struct qcom_wcnss *wcnss = (struct qcom_wcnss *)rproc->priv;
@@ -675,6 +686,7 @@ static const struct of_device_id wcnss_of_match[] = {
 	{ .compatible = "qcom,riva-pil", &riva_data },
 	{ .compatible = "qcom,pronto-v1-pil", &pronto_v1_data },
 	{ .compatible = "qcom,pronto-v2-pil", &pronto_v2_data },
+	{ .compatible = "qcom,pronto-v3-pil", &pronto_v3_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, wcnss_of_match);
-- 
2.37.3

