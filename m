Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0335967E893
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbjA0Org (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjA0Ore (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:47:34 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9427DBE7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 06:47:33 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so5574264wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 06:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1KKJUq5WKhzjaSp+Mwo81aQ4gVmuVUpw2n+7Kp/Unuo=;
        b=jdR+Ko3ozAmvYFX9JLmNVn5iV4Csy6QSZG1a/YPXUY/+s0qx9oppoMcDIzS/yMXo11
         cJqFXITk2Gb7eu2JCNtJIgmYbAZaNi1hXFy8qX8ipThmzZ4aLU+nCNHvz+SMb98Y3h5V
         GusdNp0oXBaNNfiv/fnxupM07T1MnwVeiV/XDX/FdOR5PVuJTv4f6gp+IHkcnMShxBnv
         aNaDCAgF1tSJJSTPwjfTS72J+dqao8PO2hKQZabvSveQ3tKnZTs0Z9ZZUKRwiuKQ1qFu
         YDdgCCBYsdsgWYWidcp9F6wfCwFFpOgOXVUMVzW4SalPbcKBqI9BbhgbVOe0OqEPwH1E
         QLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1KKJUq5WKhzjaSp+Mwo81aQ4gVmuVUpw2n+7Kp/Unuo=;
        b=OQdB9kVlsbzICE8cF+hiXaMyLiJRII5KunoNjy+X5fff6SmqcGVDSCjI/dLR7eyCOm
         iAJuyosphir/ZwcL8PA9wCQ7idG8wFvsnyjeUH63cXE3PiDKBwvzDE4kyAjVTDbwKCGJ
         pPzwkIvsjwkYyZWmT51V2K7luYGlmSfqAB3sMzkCeUwnfxQqU1ncEuCMFjuKL6JFwVKR
         BwmB/Y16DkWreiRCyC5J0QTdjFc8mIYiOLrjGO+cDZFTHFsf8P+X/6Py05qufaQjQ37c
         ylfegLwZLOCFIf/d32M4gjvvymU5uewp3lUiuYp1zhtcC167Xh30lKA2rjNq2p57ot0t
         JkVw==
X-Gm-Message-State: AFqh2kpLa4bxdqbDJ19HNCSIr4B9796rJ0S41sXzWypWBww6Hup4ujBL
        gt0j7nZFTcDo4mW3LnqbE3V76A==
X-Google-Smtp-Source: AMrXdXv4N0OXmz+FUj99xgWrogLlCVx4448xlj97WtMIyfMl+0CKekDVru6FDwQXvG7KAqgZYZasIQ==
X-Received: by 2002:a05:600c:3c92:b0:3d3:4007:9c88 with SMTP id bg18-20020a05600c3c9200b003d340079c88mr41317427wmb.18.1674830851600;
        Fri, 27 Jan 2023 06:47:31 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id q9-20020a05600c330900b003dc1763da37sm4656118wmp.17.2023.01.27.06.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 06:47:30 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] soc: qcom: llcc: Fix slice configuration values for SC8280XP
Date:   Fri, 27 Jan 2023 16:47:24 +0200
Message-Id: <20230127144724.1292580-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
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

These new values are now based on the latest LLCC SC table.

Fixes: ec69dfbdc426 ("soc: qcom: llcc: Add sc8180x and sc8280xp configurations")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

The v1 is here:
https://lore.kernel.org/all/20230126171636.2319496-1-abel.vesa@linaro.org/

Changes since v1:
 * dropped the LLCC_GPU and LLCC_WRCACHE max_cap changes
 * took the new values from documentatio this time rather than
   downstream kernel

 drivers/soc/qcom/llcc-qcom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 23ce2f78c4ed..26efe12012a0 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -191,9 +191,9 @@ static const struct llcc_slice_config sc8280xp_data[] = {
 	{ LLCC_CVP,      28, 512,  3, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
 	{ LLCC_APTCM,    30, 1024, 3, 1, 0x0,   0x1, 1, 0, 0, 1, 0, 0 },
 	{ LLCC_WRCACHE,  31, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },
-	{ LLCC_CVPFW,    32, 512,  1, 0, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
-	{ LLCC_CPUSS1,   33, 2048, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
-	{ LLCC_CPUHWT,   36, 512,  1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },
+	{ LLCC_CVPFW,    17, 512,  1, 0, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
+	{ LLCC_CPUSS1,   3, 2048, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
+	{ LLCC_CPUHWT,   5, 512,  1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },
 };
 
 static const struct llcc_slice_config sdm845_data[] =  {
-- 
2.34.1

