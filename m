Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FFF62B7AE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238071AbiKPKUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbiKPKUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:20:34 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8372126B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:20:11 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso2776734wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ibv+5YEHVAYxDSspsvnfANXTqnasTlWYJgau3UGpbZg=;
        b=oqwKO0I4oUXU/WX3HEjhUkL3jbBmIiKg/61u7OXDVcOxweWRas/AE/BwkSrn/jpxdg
         UI5PEwwWlHkBh6grH+IYllAJBT51uRmLx68VUqiKXVjezJEfvOf/EZbzmKPxgIDnRiRs
         4ZJQSBLkDX3p5VjaDbR1HM9eT/jAgRQSt8Tg5rJvTFNDRcCAdKjMkGzoSQNjdBrkPHs7
         8UB24gSxoLXdgy/StL/IWW8R43CeOe61zvZy0hC06POFhZjYhKkKZBGUYJTdt+EuXEn5
         yXoGZWRKL7bed5AbgsnSGCQ36nf6WBV72EcnlIFyiU3u3rGrc3+n7asKEtQwWik6IxeU
         uARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibv+5YEHVAYxDSspsvnfANXTqnasTlWYJgau3UGpbZg=;
        b=ZRytqw5Vg/W7S1u5J9MH7eYEpLt34MBtOU4uqmOBMC4PKahknONs+Z+/KSZ8qedkuO
         1A8/pgaXNgv0zkcu2Ad4asDZQ+6i2BOQO7GffZLCMjsUKODf6usFmpD27nHkwf5GQXaT
         XWbBcOOV4Yz4xDJM29fyGgUroc17/Se8vf4UYtl0MR3XrvMyXWFScptSsFxkextBOOOR
         QjPi4Y35PLaq2EBf0ywNw6HqcX+MB0S4iRgZQL7BACBq3WS14Ba8WFFv2AkUAIm47HCi
         +SgvP+wRNfOISbCsWqsdZ0OrwV4omW1fS8whEw6IQrXfl1V+MpLM8F5MiXZdUPnzOlPj
         BPUw==
X-Gm-Message-State: ANoB5plTuFd1AaYOA39AjlydN85b+D8EaQR3EJ0sDK11LPW7sCfe4op4
        XPA0u9zyhOi1GwTbQw4CPaoNLA==
X-Google-Smtp-Source: AA0mqf6fM7ZsDPtfpP7ah663PmKAcCanlgICfSh207kSCgxvqhSn88+AGeuSSxUDdN2XSjFioPrWRw==
X-Received: by 2002:a7b:c04d:0:b0:3cf:a8a5:63ab with SMTP id u13-20020a7bc04d000000b003cfa8a563abmr1608489wmc.101.1668594010071;
        Wed, 16 Nov 2022 02:20:10 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c4f1200b003c6f3f6675bsm1709900wmq.26.2022.11.16.02.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:20:09 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 16 Nov 2022 11:20:07 +0100
Subject: [PATCH 4/4] remoteproc: qcom_q6v5_pas: add sm8550 adsp, cdsp & mpss
 compatible & data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221114-narmstrong-sm8550-upstream-remoteproc-v1-4-104c34cb3b91@linaro.org>
References: <20221114-narmstrong-sm8550-upstream-remoteproc-v1-0-104c34cb3b91@linaro.org>
In-Reply-To: <20221114-narmstrong-sm8550-upstream-remoteproc-v1-0-104c34cb3b91@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     devicetree@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the compatible & data for the aDSP, cDSP and MPSS found in
the SM8550 SoC.

This platform requires the "Devicetree" firmware to be loaded along the
main firmware.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 65 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index e79a5fcbc986..15e740815da0 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -1054,6 +1054,68 @@ static const struct adsp_data sm8450_mpss_resource = {
 	.ssctl_id = 0x12,
 };
 
+static const struct adsp_data sm8550_adsp_resource = {
+	.crash_reason_smem = 423,
+	.firmware_name = "adsp.mdt",
+	.dtb_firmware_name = "adsp_dtb.mdt",
+	.pas_id = 1,
+	.dtb_pas_id = 0x24,
+	.minidump_id = 5,
+	.has_aggre2_clk = false,
+	.auto_boot = false,
+	.proxy_pd_names = (char*[]){
+		"lcx",
+		"lmx",
+		NULL
+	},
+	.load_state = "adsp",
+	.ssr_name = "lpass",
+	.sysmon_name = "adsp",
+	.ssctl_id = 0x14,
+};
+
+static const struct adsp_data sm8550_cdsp_resource = {
+	.crash_reason_smem = 601,
+	.firmware_name = "cdsp.mdt",
+	.dtb_firmware_name = "cdsp_dtb.mdt",
+	.pas_id = 18,
+	.dtb_pas_id = 0x25,
+	.minidump_id = 7,
+	.has_aggre2_clk = false,
+	.auto_boot = false,
+	.proxy_pd_names = (char*[]){
+		"cx",
+		"mxc",
+		"nsp",
+		NULL
+	},
+	.load_state = "cdsp",
+	.ssr_name = "cdsp",
+	.sysmon_name = "cdsp",
+	.ssctl_id = 0x17,
+};
+
+static const struct adsp_data sm8550_mpss_resource = {
+	.crash_reason_smem = 421,
+	.firmware_name = "modem.mdt",
+	.dtb_firmware_name = "modem_dtb.mdt",
+	.pas_id = 4,
+	.dtb_pas_id = 0x26,
+	.minidump_id = 3,
+	.has_aggre2_clk = false,
+	.auto_boot = false,
+	.decrypt_shutdown = true,
+	.proxy_pd_names = (char*[]){
+		"cx",
+		"mss",
+		NULL
+	},
+	.load_state = "modem",
+	.ssr_name = "mpss",
+	.sysmon_name = "modem",
+	.ssctl_id = 0x12,
+};
+
 static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,msm8226-adsp-pil", .data = &adsp_resource_init},
 	{ .compatible = "qcom,msm8974-adsp-pil", .data = &adsp_resource_init},
@@ -1094,6 +1156,9 @@ static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,sm8450-cdsp-pas", .data = &sm8350_cdsp_resource},
 	{ .compatible = "qcom,sm8450-slpi-pas", .data = &sm8350_slpi_resource},
 	{ .compatible = "qcom,sm8450-mpss-pas", .data = &sm8450_mpss_resource},
+	{ .compatible = "qcom,sm8550-adsp-pas", .data = &sm8550_adsp_resource},
+	{ .compatible = "qcom,sm8550-cdsp-pas", .data = &sm8550_cdsp_resource},
+	{ .compatible = "qcom,sm8550-mpss-pas", .data = &sm8550_mpss_resource},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, adsp_of_match);

-- 
b4 0.10.1
