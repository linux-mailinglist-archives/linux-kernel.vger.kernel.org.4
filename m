Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F09B6F36B2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 21:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjEATZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 15:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjEATY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 15:24:59 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD97F26AE
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 12:24:53 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-63b620188aeso3373446b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 12:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682969093; x=1685561093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlCXSDngFh1SUws/NWCdUPB1ODSh3zOJ15r+LU+w194=;
        b=kJy/w/9szQMPPeJb7Nxpt4Sr/d8sLB88BocgsO82DII0hFd6BlyhxUgMvHWCanx7gN
         dmI6A2VoBSZHu8vCp4xdyj7Pe5tk9uVC+AUjhrqNNdatMP6YhkC77BLZ1bDGXkkcbR1T
         emSIe1huExaLDtbthYlR7cKTmAXbi4ctLLo+vv4487YcIedVXF7hOM/o+7//3GorqG7w
         hxpgN5OTnv9PbNlZlFaxqbKw4aa2rfV0jr55gnhU5GzLEXkOxdPVXc93grf9F6b0Afru
         628hAtd+j/k0dWoPJS8oGebSBoSnPqQmWHr88SXhiHsuDYxWP3E01ErAT9EWATNRQ0AZ
         LOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969093; x=1685561093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TlCXSDngFh1SUws/NWCdUPB1ODSh3zOJ15r+LU+w194=;
        b=S78y4xvBAFhclrpoAWdbOv7wcxsxIwxDg5/ASdeqUAXx/UDNGOWTseCxs2/fTvfNBp
         m+lRTmlR5dWpPBQaKO1x6a4JxrBoGJTKqU8pCjnlEbYOVDcbTiJPfnEC8oyHvryAt6mb
         tmb3wbZRFcMY8YZAfpslaZLXFKm+e6k3T5WDla7cBak5pIQplXTyuFwJ8GG9zgnIcth8
         BD6MY+KaNPqFr+qm1SoDuUCEOTsd5N9AFNvOGqVfrZwsFipFE/CUi4Ml4DZuC5UXK0Ov
         g3ubVjW4D44EE5cnxhlARoB1RuQm8fEPRcOrJc77F8FLyl3luyRzS1jXEwmZPi6Y4eM/
         EBog==
X-Gm-Message-State: AC+VfDy5MFDdsAttlVn3/TVzAC5bs5WRJ0b+RMP8re+WMKYp0AV5LyoU
        H2hNkhnmHCMWhsum2T3mOgJeVQ==
X-Google-Smtp-Source: ACHHUZ66d44NdKMo0zcHRLfXIFVK1q5DUtWUQLjhdZrE+NP+hjzT/GDKeAK71DgMKEFMrqmAiqDNRw==
X-Received: by 2002:a05:6a00:c8c:b0:641:1f51:bae2 with SMTP id a12-20020a056a000c8c00b006411f51bae2mr19765157pfv.6.1682969092986;
        Mon, 01 May 2023 12:24:52 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1f3b:58fa:39f6:37e1:bb9a:a094])
        by smtp.gmail.com with ESMTPSA id 189-20020a6304c6000000b00513cc8c9597sm17459144pge.10.2023.05.01.12.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:24:52 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org, kishon@kernel.org,
        vkoul@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v9 2/4] phy: qcom-qmp-usb: add support for updated qcm2290 / sm6115 binding
Date:   Tue,  2 May 2023 00:54:30 +0530
Message-Id: <20230501192432.1220727-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230501192432.1220727-1-bhupesh.sharma@linaro.org>
References: <20230501192432.1220727-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the new qcm2290 / sm6115 binding.

The USB QMP phy on these devices supports 2 lanes. Also note that the
binding now does not describe every register subregion and instead
the driver holds the corresponding offsets. This also includes
the PCS_MISC region.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index a49711c5a63d..aa143c081805 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -1414,6 +1414,10 @@ struct qmp_usb_offsets {
 	u16 pcs_usb;
 	u16 tx;
 	u16 rx;
+	/* for PHYs with >= 2 lanes */
+	u16 tx2;
+	u16 rx2;
+	u16 pcs_misc;
 };
 
 /* struct qmp_phy_cfg - per-PHY initialization config */
@@ -1558,6 +1562,16 @@ static const char * const qmp_phy_vreg_l[] = {
 	"vdda-phy", "vdda-pll",
 };
 
+static const struct qmp_usb_offsets qmp_usb_offsets_v3 = {
+	.serdes		= 0,
+	.pcs		= 0xc00,
+	.tx		= 0x200,
+	.rx		= 0x400,
+	.tx2		= 0x600,
+	.rx2		= 0x800,
+	.pcs_misc	= 0xa00,
+};
+
 static const struct qmp_usb_offsets qmp_usb_offsets_v5 = {
 	.serdes		= 0,
 	.pcs		= 0x0200,
@@ -1922,6 +1936,8 @@ static const struct qmp_phy_cfg sm8350_usb3_uniphy_cfg = {
 static const struct qmp_phy_cfg qcm2290_usb3phy_cfg = {
 	.lanes			= 2,
 
+	.offsets		= &qmp_usb_offsets_v3,
+
 	.serdes_tbl		= qcm2290_usb3_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(qcm2290_usb3_serdes_tbl),
 	.tx_tbl			= qcm2290_usb3_tx_tbl,
@@ -2497,6 +2513,12 @@ static int qmp_usb_parse_dt(struct qmp_usb *qmp)
 	qmp->tx = base + offs->tx;
 	qmp->rx = base + offs->rx;
 
+	if (cfg->lanes >= 2) {
+		qmp->tx2 = base + offs->tx2;
+		qmp->rx2 = base + offs->rx2;
+		qmp->pcs_misc = base + offs->pcs_misc;
+	}
+
 	qmp->pipe_clk = devm_clk_get(dev, "pipe");
 	if (IS_ERR(qmp->pipe_clk)) {
 		return dev_err_probe(dev, PTR_ERR(qmp->pipe_clk),
-- 
2.38.1

