Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F57C6A8F47
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 03:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjCCCfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 21:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCCCfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 21:35:09 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7543B3D6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 18:35:07 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id j11so1774100lfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 18:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677810905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jLRvX/I7uLgP1lL5sZgRZ4/1Xfsiyoty5CreDeDfcFQ=;
        b=CCG58myAHYYt0rheTGVmmZ8w/u/CvaQKetINiA1lSjLDfe62iXWW/PF+3AV6/qysQL
         meP02uIifxyypHpn4IwUeasomdIoWov5Zr82Cz0DUA8VabXsFrPTnPh6HxzKQ1cg2Cq0
         b6oEXfBso/ZIHt0ckSs260XR2pZbjDpA0TkCONxi7cGePpRyE83pqn+k68bMPvaEXgDS
         RG07N04jYizbe+I/2lJLvMpim69cCvPblH4NgwkN5bFySG/MrTff/Wj2rR3W8PJqAA/h
         bpD6yW2uKHrsMNKYZvo4IXjBvdJnhWmW/30IDrr2ysOsf5vRWLdSq0imNsR8GxHkUJuB
         Motw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677810905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jLRvX/I7uLgP1lL5sZgRZ4/1Xfsiyoty5CreDeDfcFQ=;
        b=ckRlBNlCQRdBQMtJS1isvh8ePBpF0wyPp2vMpH6nALEaCesMwCBtxEj5THgaihXQ11
         VoeV+CnI4M409DnbQaYZW7vKjfmsh3e21S12IFXCL6FFPqMBx7WSQmXEPkKB5IlkVVXe
         4hXfXs7urCpAOBo0N55ncBc42ZyCdyhvL0f/dz+9jllzTxCWy/V/5oSKSfy4xW5RPqO/
         J/emu01vqdFYOWtbjyMBLbymo3ZSDzf2uLCCwvsF4UsCGrgRhdm4KdIphZKlB4Bqzcp8
         8/shPMm4vr61//rmRTjK9DtzmZrc/C/yQBXdUXNzNsThIaOgZwCpW19qYxuO9BkyGrbP
         mYtw==
X-Gm-Message-State: AO0yUKWQm3VOFLnKyjg0N6B1lN1hxPPgBC5b6GzhUOTo42aEmaT/96Yo
        eToMvn4UV4OkBVEaVGVwaZMaEA==
X-Google-Smtp-Source: AK7set+oWAL6rgxFSwGFJyVSYXvBQK1354nZaYISAHAEPq3wJIWfZHpZZLgIdZ7j34TkAur//5ifFg==
X-Received: by 2002:ac2:508f:0:b0:4dd:a5aa:accb with SMTP id f15-20020ac2508f000000b004dda5aaaccbmr98125lfm.44.1677810905658;
        Thu, 02 Mar 2023 18:35:05 -0800 (PST)
Received: from localhost.localdomain (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id d20-20020ac241d4000000b004d856fe5121sm180218lfi.194.2023.03.02.18.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 18:35:05 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] interconnect: qcom: icc-rpm: Don't call __qcom_icc_set twice on the same node
Date:   Fri,  3 Mar 2023 03:35:00 +0100
Message-Id: <20230303023500.2173137-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when sync_state calls set(n, n) all the paths for setting
parameters on an icc node are called twice. Avoid that.

Fixes: 751f4d14cdb4 ("interconnect: icc-rpm: Set destination bandwidth as well as source bandwidth")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
RFC comes from the fact that I *believe* this should be correct, but I'm
not entirely sure about it..


 drivers/interconnect/qcom/icc-rpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index a6e0de03f46b..d35db1af9b08 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -387,7 +387,7 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 	ret = __qcom_icc_set(src, src_qn, sum_bw);
 	if (ret)
 		return ret;
-	if (dst_qn) {
+	if (dst_qn && src_qn != dst_qn) {
 		ret = __qcom_icc_set(dst, dst_qn, sum_bw);
 		if (ret)
 			return ret;
-- 
2.39.2

