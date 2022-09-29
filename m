Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D955EECE9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 07:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiI2FCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 01:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbiI2FCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 01:02:36 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8DF125797;
        Wed, 28 Sep 2022 22:02:33 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so290474pjh.3;
        Wed, 28 Sep 2022 22:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=IHv+se6PCST4Oao8xK2ZgRiscYBxXE1DiDrvnYlWrIY=;
        b=gOgKwMYh73lcy43oAvJRdZIS74zw360Tx53CmbMfCrupdwb0bbT92JJp+7W1de9CDi
         MCUL0SevyOPdMPdg8v+x+Zt7pU43zKIqttxNK0dA+OfcM2XWFDGsJUSTSu0bpC32HRR8
         Fpuw38jgg2IiZWUKudziLqOaMFeZqmxqFiOwCXr9+cajt7ZRtFgOYTIzzPWuKbMQgAto
         AKMGPlBdKgfGfWVXeoXJhiUzFLQE0hJaL1Z/swOwxIbadv9z3Pq1b8vAcx0aLMgzO9A4
         z2Ztnm9HF4QKS4sOg46gKwPs/vB/v8v/sN6gCzHxNuyPDt9PYfPpR8GE5pAqlLJzx8+N
         odwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IHv+se6PCST4Oao8xK2ZgRiscYBxXE1DiDrvnYlWrIY=;
        b=qJ54ZAu+DsxwCUhimu0/nSKoTI3Hv62+4N0GYvtB0Q0lwUhnh5GOcLZsHj4n6VaXnz
         tqyEarJy1pMMYazvRrO1UoiukQpJvO+u3ZF+u2oyM92V1I51hdPUXebTgSuXr8vVA3TW
         J6oq9X4BiqycgsMDKBjmgon5Ef4YgxoZQXX97H80k+MLO5dTgivsvw3PdwXiFBrqkUFL
         tv5i7hXjDkAtX4Y3G4N6rXo5cXiFmQPgwr3dUllbkZ3uzERDGDeNEriskGTWosbTGvzA
         cEY1ZJ+vhhHqaq6gPNJsMvkimh4DrpFd4clHuvS2FC73rNuNOt//t088JtpQTM24DQNW
         ZaCQ==
X-Gm-Message-State: ACrzQf3BpvSgs+3kx+7jbwjVYVp2RKfQt455ISPIVdJoHd2RiI85CAkQ
        h7ZRVEoZlDUGXTjfnKMsgQPnXLQkd5MIuGvB
X-Google-Smtp-Source: AMsMyM74RpMnEp5dkLkVu+o5YxuF8XsAH66rGsuqct+R4EAK1PQRaX0mHKENT140PFsfM77b8MDZ6A==
X-Received: by 2002:a17:903:40c3:b0:17a:d2b:fac2 with SMTP id t3-20020a17090340c300b0017a0d2bfac2mr1644362pld.5.1664427752775;
        Wed, 28 Sep 2022 22:02:32 -0700 (PDT)
Received: from skynet-linux.local ([2a09:bac0:579::681d:4237])
        by smtp.googlemail.com with ESMTPSA id rm13-20020a17090b3ecd00b0020263b7177csm1895962pjb.3.2022.09.28.22.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 22:02:32 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH v5 1/5] remoteproc: qcom: qcom_wcnss: Add support for pronto-v3
Date:   Thu, 29 Sep 2022 10:32:05 +0530
Message-Id: <20220929050209.1464526-2-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220929050209.1464526-1-sireeshkodali1@gmail.com>
References: <20220929050209.1464526-1-sireeshkodali1@gmail.com>
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

