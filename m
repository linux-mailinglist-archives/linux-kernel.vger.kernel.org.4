Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091DD6D0BB3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbjC3Qrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbjC3QrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:47:00 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACDCCDF5;
        Thu, 30 Mar 2023 09:46:59 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4PnTpk73zcz9scb;
        Thu, 30 Mar 2023 18:46:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1680194815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TSURVbtcY0YmmwnLZbqD+nMKuO2MCW9bx3mQ70Yn0Pc=;
        b=zl8sYjmHSL5yzHvw74tGSX7QbV7omG8tIGm+HQNfI+XgoIAYmQGppBeF/vwX99cHzd7SN3
        RKL/3ZUjnkHpOHm5y48dDZzxX9szfgNoPD8q0yecoSho/z0UOvHg7T63sjqluihKaxRSuv
        swdnPPDdxUEQ1ZX0GIiiaq9nmnA3WAZ895/yAZMdbtwLzhiGE9/0+TVW6vSv5x3K6kyzSZ
        vhCg0M4tbiXAYeBkX0gLUtep5F2IL2JE4RpjY99RZgitQF8T0yNeB6VOHIjHsfecBIExls
        8Mm3hisR9euZ78w7EnMGW1NqSFV2FeuG4xJKkdx724r/VIW3AtpsglDwHKu3Zw==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH v3 3/3] remoteproc: qcom: pas: add SDM845 SLPI compatible
Date:   Thu, 30 Mar 2023 18:46:33 +0200
Message-Id: <20230330164633.117335-4-me@dylanvanassche.be>
In-Reply-To: <20230330164633.117335-1-me@dylanvanassche.be>
References: <20230330164633.117335-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible for the SDM845 SLPI to the Qualcomm remoteproc q6v5_pas
driver. The SLPI is the same as in SM8150, SM8250, SM8350, and SM8450,
so use the same resource in the driver.

Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index b96020c93e58..f3a7ae503bd1 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -1169,6 +1169,7 @@ static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,sdm660-adsp-pas", .data = &adsp_resource_init},
 	{ .compatible = "qcom,sdm845-adsp-pas", .data = &sdm845_adsp_resource_init},
 	{ .compatible = "qcom,sdm845-cdsp-pas", .data = &sdm845_cdsp_resource_init},
+	{ .compatible = "qcom,sdm845-slpi-pas", .data = &sdm845_slpi_resource_init},
 	{ .compatible = "qcom,sdx55-mpss-pas", .data = &sdx55_mpss_resource},
 	{ .compatible = "qcom,sm6115-adsp-pas", .data = &adsp_resource_init},
 	{ .compatible = "qcom,sm6115-cdsp-pas", .data = &cdsp_resource_init},
-- 
2.39.2

