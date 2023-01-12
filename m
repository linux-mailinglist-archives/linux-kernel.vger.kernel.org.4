Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82D5668464
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240426AbjALUx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbjALUwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:52:55 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CB910041;
        Thu, 12 Jan 2023 12:26:35 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id y18so17022795ljk.11;
        Thu, 12 Jan 2023 12:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdJ1as/2HorMVf7SThF1+kvjBcYBpePpyfZVaXdM4A0=;
        b=XDTIIvu2AnKqlyYZPRSEI2bdQXkR7OBDU6M4TySFVrDa74XXR4jor4RavZgRSHERR9
         G/OCJTry/k8Ls46lPcqsH6T+RVXkTWQWbf7tWPwhcwN45A4qzrmX9rtL3ENi3jEJuY7q
         1MfM/GPYR0LJm1Ce2mBITwapSXu8j4THFB2q0IDab96U0Y/Tm5Z1TSwvMOrimvesmc9T
         Kaf8nfUkw1BO7mAXcEu5stvTpzLz0lC2BjjEQAnhenew+uK7aVtwWxU8PnpacsNvl53H
         hm+H9jrWhvCBqG9E2IrS63tlNDD1sTJ/8RGiUMtqLvX8f4qUGJ5DY3xiOeoPBV8WgLUH
         AUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZdJ1as/2HorMVf7SThF1+kvjBcYBpePpyfZVaXdM4A0=;
        b=3w742yK2fIIkqgG2kU34EGUXiPYBuWvZtWOgXaRX2Za987dGCdaHHvfjniAF/v3ozW
         zP9zoCa7h8bf8e/0EA91gbb7UPYhNpzjmxDF5Yc2XZF0VaJekYpyMttwWLkW09jUTqwL
         3uYSBwSz9GTV3WYpWOd+kaNxowla/OJ/32xSD+ASNMsBhY/vIZB9nXbLPQCpc9LzYohv
         02P/sq4VKNBFBHhigAHrNjFtVP16oWR0gyH2irndFiKwxFAXn6gSKliA67WxSBXoA2Bb
         4diCgJqpMdLw0r4XSsZJlQwEn5xYmWbCPcr3caqqsobbeF9RpbelVX+hr/1pZ7FpqBtR
         rTNw==
X-Gm-Message-State: AFqh2kq6B/NQH5zjS2DSvqMwv+f9FPe3MVy6+1mtl2rXMS+wDlZhQPd5
        oJxXXxNRUTUp04QCq05vmGWHsDD4GxmQMA==
X-Google-Smtp-Source: AMrXdXtku+83OIxTf7ix3J64PH5I1QLQ69P+6F/sHtg3HG6oAiYvk0giYm3olkgj8rW4lJ4c5mtb4A==
X-Received: by 2002:a2e:a221:0:b0:282:3796:60cc with SMTP id i1-20020a2ea221000000b00282379660ccmr6059307ljm.53.1673555194791;
        Thu, 12 Jan 2023 12:26:34 -0800 (PST)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id k6-20020a2eb746000000b00281350bb5fbsm2346731ljo.2.2023.01.12.12.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 12:26:34 -0800 (PST)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] remoteproc: qcom_q6v5_mss: Handle platforms with only single power domain
Date:   Thu, 12 Jan 2023 22:26:05 +0200
Message-Id: <20230112202612.791455-3-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230112202612.791455-1-matti.lehtimaki@gmail.com>
References: <20230112202612.791455-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Luca Weiss <luca@z3ntu.xyz>

For example MSM8226 has only one power domain (cx) which is attached
internally in power domain and cannot be attached in this driver.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 2f4027664a0e..745627a36bcf 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -1820,6 +1820,13 @@ static int q6v5_pds_attach(struct device *dev, struct device **devs,
 	if (!pd_names)
 		return 0;
 
+	/* Handle single power domain */
+	if (dev->pm_domain) {
+		devs[0] = dev;
+		pm_runtime_enable(dev);
+		return 1;
+	}
+
 	while (pd_names[num_pds])
 		num_pds++;
 
@@ -1843,8 +1850,15 @@ static int q6v5_pds_attach(struct device *dev, struct device **devs,
 static void q6v5_pds_detach(struct q6v5 *qproc, struct device **pds,
 			    size_t pd_count)
 {
+	struct device *dev = qproc->dev;
 	int i;
 
+	/* Handle single power domain */
+	if (dev->pm_domain && pd_count) {
+		pm_runtime_disable(dev);
+		return;
+	}
+
 	for (i = 0; i < pd_count; i++)
 		dev_pm_domain_detach(pds[i], false);
 }
-- 
2.34.1

