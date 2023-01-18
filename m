Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03A7670F70
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjARBFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjARBEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:04:37 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F983669B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:53:37 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r2so32398713wrv.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUb/S2D/vEg5DXQcpUFp2Jq273wdmh34OP7UkZOQF4I=;
        b=WAw2UYmIL1MIUwpp3rXrGRQxX8TeObQ/yufp6z7YIRCncnrxozhX/YZ2BaRZpTA+9U
         WA8rHMp27ax1kyQKFCRS+Bz6qwaBhC43zLpj2kIDRnmMpGeiXVUizcmVAOGhV5+dw788
         WWeLIlrmRU62RJE0OkZJp5jiNK5NMgDTN4S01QsKUWuaLL2L4LbMQYkpkfoYpjIySrp2
         ov36tHDKZVqa2z9ydUfCu59UpdcG4yOHs+TzL+Ni794jXeY/G21PyBwaoNG0RGy5ZQo5
         jUzjfh4Q7YLAx6mpyEZW5jrzctXt556i3KL3U02622PGCsYRZPeGsqTfphO1OVhq/Xds
         2t2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUb/S2D/vEg5DXQcpUFp2Jq273wdmh34OP7UkZOQF4I=;
        b=YSjsYhxLSnXH3tkKyTloMJ8Ks7fnjWmthTERGQocLTPAFQUoREKLTJj34ZLWQ4rL2J
         TjPVqzzVC5d2gR6nwlbDO1t8et5vUUEPxKwZm+Im3z2rOTm/J7sotxx2V1i4XtGTrJq/
         46k80jzePti5i/h1QBC98gBkDrinBQUZwD1QVa1xdbNFZ/qJAA0RLZ87A2kfDOKdaSej
         Yc57GV0YPmVoXauhKM0Jf0eeuZKg04+WZ/+fSOYun6dQVWRuFSND23SsqC6BNQPXs50i
         gz0IPiJ0YYfolasquQ+7lqY3fgSTle3mh7rkbNZuFm1ihFoOLeuFtgYAfbgDxWXJTsBj
         CT8Q==
X-Gm-Message-State: AFqh2krxRSLCvj9RWRJ3PQqEhQWBNgbop3EymujVjLXJo/XScHAXWLHb
        pkgfRRl598wOQrjvlMe6zvB14Q==
X-Google-Smtp-Source: AMrXdXs6eO4upOc4t3YFzQrIHBD5yGscLwqXSnFaTyIXfNyJausZ4dNPogvCSkUFAPbYqrj6tGepaA==
X-Received: by 2002:adf:f406:0:b0:26c:aa9d:93f1 with SMTP id g6-20020adff406000000b0026caa9d93f1mr3786548wro.25.1674003216683;
        Tue, 17 Jan 2023 16:53:36 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600001d100b00241d21d4652sm29609705wrx.21.2023.01.17.16.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 16:53:36 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v3 4/8] phy: qcom-qmp: pcs-pcie: Add v6 register offsets
Date:   Wed, 18 Jan 2023 02:53:24 +0200
Message-Id: <20230118005328.2378792-5-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118005328.2378792-1-abel.vesa@linaro.org>
References: <20230118005328.2378792-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new SM8550 SoC bumps up the HW version of QMP phy to v6 for USB,
UFS and PCIE g3x2. Add the new PCS PCIE specific offsets in a dedicated
header file.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c        |  1 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h | 15 +++++++++++++++
 2 files changed, 16 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 21727e90fad1..d4ca38f31e3f 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -29,6 +29,7 @@
 #include "phy-qcom-qmp-pcs-pcie-v4_20.h"
 #include "phy-qcom-qmp-pcs-pcie-v5.h"
 #include "phy-qcom-qmp-pcs-pcie-v5_20.h"
+#include "phy-qcom-qmp-pcs-pcie-v6.h"
 #include "phy-qcom-qmp-pcie-qhp.h"
 
 /* QPHY_SW_RESET bit */
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h
new file mode 100644
index 000000000000..91e70002eb47
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_PCIE_V6_H_
+#define QCOM_PHY_QMP_PCS_PCIE_V6_H_
+
+/* Only for QMP V6 PHY - PCIE have different offsets than V5 */
+#define QPHY_PCIE_V6_PCS_PCIE_POWER_STATE_CONFIG2	0x0c
+#define QPHY_PCIE_V6_PCS_PCIE_POWER_STATE_CONFIG4	0x14
+#define QPHY_PCIE_V6_PCS_PCIE_ENDPOINT_REFCLK_DRIVE	0x20
+#define QPHY_PCIE_V6_PCS_PCIE_OSC_DTCT_ACTIONS		0x94
+
+#endif
-- 
2.34.1

