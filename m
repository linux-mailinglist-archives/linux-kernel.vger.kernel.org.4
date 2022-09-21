Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F895BF569
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 06:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbiIUEiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 00:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiIUEiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 00:38:00 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C806F7C76D;
        Tue, 20 Sep 2022 21:37:59 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so4536277pjh.3;
        Tue, 20 Sep 2022 21:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=IHv+se6PCST4Oao8xK2ZgRiscYBxXE1DiDrvnYlWrIY=;
        b=ZBIGadPCYyhCRYzH7/ofjO2x1Ah7RZwTA2RiVAW8qmVzQhefE2bBH/XUwDGAzvN5e0
         afk0LALfAj/s2k8RhsPNkbg1z2WHSgPN98rvFWKnji5fG7Es7lPlkVR8znXbTxmkVAog
         jOo0a6w4/ElCaa2gfvtQN/QDplicjLsHNZXFNv4GFv3w50ILY1Su32a5j+6D90HZ+qju
         NWa9KMRODZDQaNVkCC922mx+PAf4B0QopLYDrJ+YZWRg3fS2Mp9sIFlE4A1cbu3J3NSZ
         kUAOD2ubVq5CzeBF4OzZyKhJKNUW5e6sNi/5F4OmVxFpTrP+45RSgxEZM16XweCyDWIT
         W2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IHv+se6PCST4Oao8xK2ZgRiscYBxXE1DiDrvnYlWrIY=;
        b=UR9ciJQVszxikOEewch/ztAXa2dC7ff1LdFgz6IRftTOIsLT/p2BGgvPS1YcUu3VcO
         r9WmMWou4oYyB8gcN8Ckg2DJdmfrb/BkVIQJL7wFoWlGiyFkVzvtugV8li6Dd8vX+D0Q
         IBjW08IN0t4uSSaG4IKNi7EiOKxfAfJznPbKq6hc1PF6nTYyi9xMjq5GAADwR3h/hEXl
         o3z2kYWsktCRJltmeJ1X5ZkygyqLJapUkwT9FHj1izcX5SJho1SL81mO9YaubQepvD4W
         oNdgPFjZmmLIHjZvkn4P5o4QPo/zY59VPYyfDLgJgSDgSvdz6u9Ph5BPV8zEXZH3fC7B
         prCg==
X-Gm-Message-State: ACrzQf3/eDY+yxpIMOENndVO0pPEYcw5desJniqr0IUuEHf2pgFwnYkd
        BuzJ9+4woj4jra+lP/pWQBzErUhSeLJJ3Q==
X-Google-Smtp-Source: AMsMyM5DdZX/SFYSUWhTdABDq4D8cN85oFa2HwBqNCo0rcNJEt/EY52OG2GRZZgswAkoPCxqOBrxTg==
X-Received: by 2002:a17:90b:2bd3:b0:203:1a03:6b1b with SMTP id ru19-20020a17090b2bd300b002031a036b1bmr7345748pjb.58.1663735078699;
        Tue, 20 Sep 2022 21:37:58 -0700 (PDT)
Received: from skynet-linux.local ([2406:7400:61:8a0f:392d:db19:673c:627a])
        by smtp.googlemail.com with ESMTPSA id t185-20020a6378c2000000b0042c0ffa0e62sm821182pgc.47.2022.09.20.21.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 21:37:58 -0700 (PDT)
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
Subject: [PATCH v4 1/4] remoteproc: qcom: qcom_wcnss: Add support for pronto-v3
Date:   Wed, 21 Sep 2022 10:06:45 +0530
Message-Id: <20220921043648.2152725-2-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220921043648.2152725-1-sireeshkodali1@gmail.com>
References: <20220921043648.2152725-1-sireeshkodali1@gmail.com>
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

