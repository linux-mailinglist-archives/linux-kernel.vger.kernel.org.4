Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D776A8F34
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 03:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjCCC3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 21:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCCC3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 21:29:21 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEEE1D91D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 18:29:17 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id n2so1772275lfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 18:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677810556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UvP5dlba1SnOnrJzjTH6Yl38TduqMTlOKCpl48T8jEQ=;
        b=OkKBIYGskI8jazmVLYRtLg4JtLcn8LoNaZlhg21xJqeazztJtRcpDjcwxXIVRBzDMJ
         qVCYtAoWfpl3MelFjQ2BelyxK6gP7TJ0bt7wIbSujs3aY6gx+rWfM53j3heQjBCqNmLK
         ZuiWG/8iRy9LYvrnYRJ8GABZm/FxSJecb7xVnaSWfykUSvFwofcsx3GUp543UcUjnlxz
         smVMKoxdN2NFs+xRFgqFHmI78MFDo8baw5uWKy1GzidOyi51IOQzwZBToKtiRi65+XuN
         R0Do2HpONuIgURYRGjdyqjFqPdnylHnDvHrsDzd68+GaoU1HZGRdXl8NUmHSQJ2FswsH
         umeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677810556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UvP5dlba1SnOnrJzjTH6Yl38TduqMTlOKCpl48T8jEQ=;
        b=727TPz+bAZGzfxYB7BddPY5VD5khgJ4aBoDE0ax/ArSVIaQS25BvCzb8U1U8MeVx2y
         bvSjOAU2gHeUizcgs3mnOtgcQa/Hj6C4LHzeCUSGAwkG7EME1c8qI1MQyZ3p/Ghx3mGw
         Q/eDxp8C4IWg8Y4eriaJJz4FJjIOZIuAzkJD0rc/NEzJNzI6zy0gGnzJ/I7Hfmuo9qPz
         +lZxhneey2i1jkshufyQcpax3A3AxFcDhc0m4KsmiKvVgcG+0JbT/hd/s0b5WTHcaO78
         5POzXXk/ai7j02Uk+9O8O1BeJPelQl2Uyl+PxXeLb7jtNNuUneizeq7L2pW0LA5C2lPF
         4Ygg==
X-Gm-Message-State: AO0yUKU373PwUJ3h/BNoPgDljRWNLOSHwng2Om08/e+cZyRkvQ3QaJIl
        O7Nw7/tFQcc/YexjSlqFc4zLRw==
X-Google-Smtp-Source: AK7set9JjiCFK0hySnnZzBVLri4plc02xY98zNDdSOnD3TbrIu5/e83yF/+vv9n6WeSh3X3fvvczNw==
X-Received: by 2002:a05:6512:21d:b0:4c6:4ff7:ba04 with SMTP id a29-20020a056512021d00b004c64ff7ba04mr104917lfo.2.1677810556189;
        Thu, 02 Mar 2023 18:29:16 -0800 (PST)
Received: from localhost.localdomain (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id p10-20020ac246ca000000b004cb1135953fsm175574lfo.240.2023.03.02.18.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 18:29:15 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] clk: qcom: gcc-sm6375: Update the .pwrsts for usb gdsc
Date:   Fri,  3 Mar 2023 03:29:11 +0100
Message-Id: <20230303022912.2171177-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.2
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

The USB controller on sm6375 doesn't retain its state when the system
goes into low power state and the GDSCs are turned off.

This can be observed by the USB connection not coming back alive after
putting the device into suspend, essentially breaking USB.

Fix this by updating the .pwrsts for the USB GDSCs so they only
transition to retention state in low power.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gcc-sm6375.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-sm6375.c b/drivers/clk/qcom/gcc-sm6375.c
index ad3c4833990d..93164670fbe1 100644
--- a/drivers/clk/qcom/gcc-sm6375.c
+++ b/drivers/clk/qcom/gcc-sm6375.c
@@ -3534,7 +3534,7 @@ static struct gdsc usb30_prim_gdsc = {
 	.pd = {
 		.name = "usb30_prim_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 };
 
 static struct gdsc ufs_phy_gdsc = {
-- 
2.39.2

