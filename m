Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB1869A94B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 11:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjBQKqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 05:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjBQKqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:46:39 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA12635AF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:46:38 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id g16so1203106lfv.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1ChaGpjQwwb81za9r3ksbVLIpw4MoGpa0RPeBLjHFc=;
        b=gMeQQgAnk1atn0rL6BryiTB78nsooMdcYRikoqKGpBVATtiJr7yjwgWFR7EX5DpTL1
         WJ4S3MNL1wQCeAUPLq5qQm/SlT1RIvj37WwqHQ+zbBAQyX71vSAKhQk6lalqAWyVXhrH
         QGEI4imlsDcq8aeTsyI6hKolSzSZSYIrQ/746SZLZuLlaqXPNjprKEO/0ceUkaZffZXZ
         yPmKRJ+S4PEX354pZ50X6cZQ+QI666njircV8ZyinGuCelgABPO3t9AYAJKxF3mSJstA
         ksAeuDE+CkCgkc2Gl7Ws/yJGWK1yjs1hkWXL6tQdvSXfTakhtfyQDhRsVA6gu2F5JFXK
         CBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1ChaGpjQwwb81za9r3ksbVLIpw4MoGpa0RPeBLjHFc=;
        b=L3b2pPQ9KCJxoSfLdW9/fHP/0EKbBXPfc1eYMBqvq0Q0D5TpHeEM9PpPP0y0xrsfqz
         +nBBd32jLbFOwWokjtlYNcQYn/cKbxdsvWjmMWRVKG3N0YRVwuN7MDmVB/XNtESP+ksx
         O4ejLRSaTRVN4RhrZH9gTG1OMcdiB6jQ3hfkDSxO9LywPb0tRMRUzCvmaChRpwOq5fEw
         p0mbOdg0zPYVjjxl1T4fezk5KB6BbPhEYSwjKilEYJM1LrzQHzdhll7LUFeeEqqMBGoX
         +w9yk65b5GvlUbVx1zck4HMfShQ3YYyW0Kx0QGAz8y6/pieEbn1nIXsmVtzuNaTLmRNL
         AdZA==
X-Gm-Message-State: AO0yUKU+7eLWMblLX2sN47sBqsrwk2WLs7mZ/Tf+7uf+A3XP5R3gbefK
        d/WXjUJuE4SkcO5XFXoQO7zh3w==
X-Google-Smtp-Source: AK7set8HxLN5QJZa7aXty06Alvq62w3MD6azAVgwNNTZIUqZXOdEw6NoxZlKAGqi1S3qqDQg8/zbNw==
X-Received: by 2002:ac2:4352:0:b0:4b6:eaed:f18f with SMTP id o18-20020ac24352000000b004b6eaedf18fmr2875944lfl.38.1676630796758;
        Fri, 17 Feb 2023 02:46:36 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id c13-20020a05651221ad00b004b53eb60e3csm645940lft.256.2023.02.17.02.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 02:46:36 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 17 Feb 2023 11:46:24 +0100
Subject: [PATCH v5 03/10] interconnect: qcom: Sort kerneldoc entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-topic-icc-fixes-v5-v5-3-c9a550f9fdb9@linaro.org>
References: <20230217-topic-icc-fixes-v5-v5-0-c9a550f9fdb9@linaro.org>
In-Reply-To: <20230217-topic-icc-fixes-v5-v5-0-c9a550f9fdb9@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Jun Nie <jun.nie@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Masney <masneyb@onstation.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676630791; l=1082;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=XFgUKc3AlZgnfCuw55xIk05sTMPQPjx7/I9LSefm9vw=;
 b=YKLLA28lh4MPb/UwnFbrn6LQ6RglPbnUhRasB1hdlK+lzAcmpZ+MsXq7QEMrAmDAY4HOFa7h1sB2
 HRIZ6fvHCJ/wVt375KFfUx9Qr+AfjjVXWiVvZkxjC8jHOIynMTUn
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort the kerneldoc entries the same way the struct members are
sorted.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 8aed5400afda..21f440beda86 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -23,12 +23,12 @@ enum qcom_icc_type {
 /**
  * struct qcom_icc_provider - Qualcomm specific interconnect provider
  * @provider: generic interconnect provider
- * @bus_clks: the clk_bulk_data table of bus clocks
  * @num_clks: the total number of clk_bulk_data entries
  * @type: the ICC provider type
- * @qos_offset: offset to QoS registers
  * @regmap: regmap for QoS registers read/write access
+ * @qos_offset: offset to QoS registers
  * @bus_clk_rate: bus clock rate in Hz
+ * @bus_clks: the clk_bulk_data table of bus clocks
  */
 struct qcom_icc_provider {
 	struct icc_provider provider;

-- 
2.39.1

